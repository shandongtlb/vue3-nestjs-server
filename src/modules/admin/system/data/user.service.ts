import { Inject, Injectable } from '@nestjs/common';
import { InjectEntityManager, InjectRepository } from '@nestjs/typeorm';
import { findIndex, isEmpty } from 'lodash';
import { ApiException } from 'src/common/exceptions/api.exception';
import SysDepartmentData from 'src/entities/admin/sys-departmentdata.entity';
import SysDataRole from 'src/entities/admin/sys-data-role.entity';
import SysData from 'src/entities/admin/sys-data.entity';
import { UtilService } from 'src/shared/services/util.service';
import { EntityManager, In, Not, Repository } from 'typeorm';
import {
  CreateDataDto,
  UpdatePasswordDataDto,
  UpdateDataDto,
  UpdateDataInfoDto,
} from './user.dto';
import { AccountInfoData, PageSearchDataInfo } from './user.class';
import { ROOT_ROLE_ID } from 'src/modules/admin/admin.constants';
import { RedisService } from 'src/shared/services/redis.service';
import { SysParamConfigService } from '../param-config/param-config.service';
import { SYS_USER_INITPASSWORD } from 'src/common/contants/param-config.contants';

@Injectable()
export class SysDataService {
  constructor(
    @InjectRepository(SysData) private userRepository: Repository<SysData>,
    @InjectRepository(SysDepartmentData)
    private departmentRepository: Repository<SysDepartmentData>,
    @InjectRepository(SysDataRole)
    private userRoleRepository: Repository<SysDataRole>,
    private redisService: RedisService,
    private paramConfigService: SysParamConfigService,
    @InjectEntityManager() private entityManager: EntityManager,
    @Inject(ROOT_ROLE_ID) private rootRoleId: number,
    private util: UtilService,
  ) {}

  /**
   * 根据用户名查找已经启用的用户
   */
  async findDataByUserName(username: string): Promise<SysData | undefined> {
    return await this.userRepository.findOne({
      username: username,
      status: 1,
    });
  }

  /**
   * 获取用户信息
   * @param uid user id
   * @param ip login ip
   */
  async getAccountDataInfo(uid: number, ip?: string): Promise<AccountInfoData> {
    const user: SysData = await this.userRepository.findOne({ id: uid });
    if (isEmpty(user)) {
      throw new ApiException(10017);
    }
    return {
      name: user.name,
      nickName: user.nickName,
      email: user.email,
      phone: user.phone,
      remark: user.remark,
      headImg: user.headImg,
      loginIp: ip,
    };
  }

  /**
   * 更新个人信息
   */
  async updatePersonDataInfo(
    uid: number,
    info: UpdateDataInfoDto,
  ): Promise<void> {
    await this.userRepository.update(uid, info);
  }

  /**
   * 更改管理员密码
   */
  async updateDataPassword(
    uid: number,
    dto: UpdatePasswordDataDto,
  ): Promise<void> {
    const user = await this.userRepository.findOne({ id: uid });
    if (isEmpty(user)) {
      throw new ApiException(10017);
    }
    const comparePassword = this.util.md5(`${dto.originPassword}${user.psalt}`);
    // 原密码不一致，不允许更改
    if (user.password !== comparePassword) {
      throw new ApiException(10011);
    }
    const password = this.util.md5(`${dto.newPassword}${user.psalt}`);
    await this.userRepository.update({ id: uid }, { password });
    await this.upgradePasswordVData(user.id);
  }

  /**
   * 直接更改管理员密码
   */
  async forceUpdateDataPassword(uid: number, password: string): Promise<void> {
    const user = await this.userRepository.findOne({ id: uid });
    if (isEmpty(user)) {
      throw new ApiException(10017);
    }
    const newPassword = this.util.md5(`${password}${user.psalt}`);
    await this.userRepository.update({ id: uid }, { password: newPassword });
    await this.upgradePasswordVData(user.id);
  }

  /**
   * 增加系统用户，如果返回false则表示已存在该用户
   * @param param Object 对应SysUser实体类
   */
  async addData(param: CreateDataDto): Promise<void> {
    // const insertData: any = { ...CreateUserDto };
    const exists = await this.userRepository.findOne({
      username: param.username,
    });
    if (!isEmpty(exists)) {
      throw new ApiException(10001);
    }
    // 所有用户初始密码为123456
    await this.entityManager.transaction(async (manager) => {
      const salt = this.util.generateRandomValue(32);

      // 查找配置的初始密码
      const initPassword = await this.paramConfigService.findValueByKey(
        SYS_USER_INITPASSWORD,
      );

      const password = this.util.md5(`${initPassword ?? '123456'}${salt}`);
      const u = manager.create(SysData, {
        departmentId: param.departmentId,
        username: param.username,
        password,
        name: param.name,
        nickName: param.nickName,
        email: param.email,
        phone: param.phone,
        remark: param.remark,
        status: param.status,
        psalt: salt,
      });
      const result = await manager.save(u);
      const { roles } = param;
      const insertRoles = roles.map((e) => {
        return {
          roleId: e,
          userId: result.id,
        };
      });
      // 分配角色
      await manager.insert(SysDataRole, insertRoles);
    });
  }

  /**
   * 更新用户信息
   */
  async updateData(param: UpdateDataDto): Promise<void> {
    await this.entityManager.transaction(async (manager) => {
      await manager.update(SysData, param.id, {
        departmentId: param.departmentId,
        username: param.username,
        name: param.name,
        nickName: param.nickName,
        email: param.email,
        phone: param.phone,
        remark: param.remark,
        status: param.status,
      });
      // 先删除原来的角色关系
      await manager.delete(SysDataRole, { userId: param.id });
      const insertRoles = param.roles.map((e) => {
        return {
          roleId: e,
          userId: param.id,
        };
      });
      // 重新分配角色
      await manager.insert(SysDataRole, insertRoles);
      if (param.status === 0) {
        // 禁用状态
        await this.forbiddenData(param.id);
      }
    });
  }

  /**
   * 查找用户信息
   * @param id 用户id
   */
  async infoData(
    id: number,
  ): Promise<SysData & { roles: number[]; departmentName: string }> {
    const user: any = await this.userRepository.findOne(id);
    if (isEmpty(user)) {
      throw new ApiException(10017);
    }
    const departmentRow = await this.departmentRepository.findOne({
      id: user.departmentId,
    });
    if (isEmpty(departmentRow)) {
      throw new ApiException(10018);
    }
    const roleRows = await this.userRoleRepository.find({ userId: user.id });
    const roles = roleRows.map((e) => {
      return e.roleId;
    });
    delete user.password;
    return { ...user, roles, departmentName: departmentRow.name };
  }

  /**
   * 查找列表里的信息
   */
  async infoDataList(ids: number[]): Promise<SysData[]> {
    const users = await this.userRepository.findByIds(ids);
    return users;
  }

  /**
   * 根据ID列表删除用户
   */
  async deleteData(userIds: number[]): Promise<void | never> {
    const rootUserId = await this.findRootDataId();
    if (userIds.includes(rootUserId)) {
      throw new Error('can not delete root user!');
    }
    await this.userRepository.delete(userIds);
    await this.userRoleRepository.delete({ userId: In(userIds) });
  }

  /**
   * 根据部门ID列举用户条数：除去超级管理员
   */
  async countData(uid: number, deptIds: number[]): Promise<number> {
    const queryAll: boolean = isEmpty(deptIds);
    const rootUserId = await this.findRootDataId();
    if (queryAll) {
      return await this.userRepository.count({
        id: Not(In([rootUserId, uid])),
      });
    }
    return await this.userRepository.count({
      id: Not(In([rootUserId, uid])),
      departmentId: In(deptIds),
    });
  }

  /**
   * 查找超管的用户ID
   */
  async findRootDataId(): Promise<number> {
    const result = await this.userRoleRepository.findOne({
      id: this.rootRoleId,
    });
    return result.userId;
  }

  /**
   * 根据部门ID进行分页查询用户列表
   * deptId = -1 时查询全部
   */
  async pageData(
    uid: number,
    deptIds: number[],
    page: number,
    count: number,
  ): Promise<PageSearchDataInfo[]> {
    const queryAll: boolean = isEmpty(deptIds);
    const rootUserId = await this.findRootDataId();
    const result = await this.userRepository
      .createQueryBuilder('user')
      .innerJoinAndSelect(
        'sys_departmentdata',
        'dept',
        'dept.id = user.departmentId',
      )
      .innerJoinAndSelect(
        'sys_data_role',
        'user_role',
        'user_role.user_id = user.id',
      )
      .innerJoinAndSelect(
        'sys_role_data',
        'role',
        'role.id = user_role.role_id',
      )
      .where('user.id NOT IN (:...ids)', { ids: [rootUserId, uid] })
      .andWhere(queryAll ? '1 = 1' : 'user.departmentId IN (:...deptIds)', {
        deptIds,
      })
      .offset(page * count)
      .limit(count)
      .getRawMany();
    const dealResult: PageSearchDataInfo[] = [];
    // 过滤去重
    result.forEach((e) => {
      const index = findIndex(dealResult, (e2) => e2.id === e.user_id);
      if (index < 0) {
        // 当前元素不存在则插入
        dealResult.push({
          createdAt: e.user_created_at,
          departmentId: e.user_department_id,
          email: e.user_email,
          headImg: e.user_head_img,
          id: e.user_id,
          name: e.user_name,
          nickName: e.user_nick_name,
          phone: e.user_phone,
          remark: e.user_remark,
          status: e.user_status,
          updatedAt: e.user_updated_at,
          username: e.user_username,
          departmentName: e.dept_name,
          roleNames: [e.role_name],
        });
      } else {
        // 已存在
        dealResult[index].roleNames.push(e.role_name);
      }
    });
    return dealResult;
  }

  /**
   * 禁用用户
   */
  async forbiddenData(uid: number): Promise<void> {
    await this.redisService.getRedis().del(`admin:passwordVersion:${uid}`);
    await this.redisService.getRedis().del(`admin:token:${uid}`);
    await this.redisService.getRedis().del(`admin:perms:${uid}`);
  }

  /**
   * 禁用多个用户
   */
  async multiDataForbidden(uids: number[]): Promise<void> {
    if (uids) {
      const pvs: string[] = [];
      const ts: string[] = [];
      const ps: string[] = [];
      uids.forEach((e) => {
        pvs.push(`admin:passwordVersion:${e}`);
        ts.push(`admin:token:${e}`);
        ps.push(`admin:perms:${e}`);
      });
      await this.redisService.getRedis().del(pvs);
      await this.redisService.getRedis().del(ts);
      await this.redisService.getRedis().del(ps);
    }
  }

  /**
   * 升级用户版本密码
   */
  async upgradePasswordVData(id: number): Promise<void> {
    // admin:passwordVersion:${param.id}
    const v = await this.redisService
      .getRedis()
      .get(`admin:passwordVersion:${id}`);
    if (!isEmpty(v)) {
      await this.redisService
        .getRedis()
        .set(`admin:passwordVersion:${id}`, parseInt(v) + 1);
    }
  }
}
