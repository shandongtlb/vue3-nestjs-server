import { Inject, Injectable } from '@nestjs/common';
import { InjectEntityManager, InjectRepository } from '@nestjs/typeorm';
import { includes, isEmpty } from 'lodash';
import { ROOT_ROLE_ID } from 'src/modules/admin/admin.constants';
import { ApiException } from 'src/common/exceptions/api.exception';
import SysDataDepartment from 'src/entities/admin/sys-departmentdata.entity';
import SysRoleDataDepartment from 'src/entities/admin/sys-role-departmentdata.entity';
import SysData from 'src/entities/admin/sys-data.entity';
import { EntityManager, In, Repository } from 'typeorm';
import { SysRoleDataService } from '../roledata/role.service';
import { DeptDataDetailInfo } from './dept.class';
import { MoveDeptData, UpdateDeptDataDto } from './dept.dto';

@Injectable()
export class SysDeptDataService {
  constructor(
    @InjectRepository(SysData) private userRepositoty: Repository<SysData>,
    @InjectRepository(SysDataDepartment)
    private deptRepositoty: Repository<SysDataDepartment>,
    @InjectRepository(SysRoleDataDepartment)
    private roleDeptRepositoty: Repository<SysData>,
    @InjectEntityManager() private entityManager: EntityManager,
    @Inject(ROOT_ROLE_ID) private rootRoleId: number,
    private roleService: SysRoleDataService,
  ) {}

  /**
   * 获取所有部门
   */
  async list(): Promise<SysDataDepartment[]> {
    return await this.deptRepositoty.find({ order: { orderNum: 'DESC' } });
  }

  /**
   * 根据ID查找部门信息
   */
  async info(id: number): Promise<DeptDataDetailInfo> {
    const department = await this.deptRepositoty.findOne({ id });
    if (isEmpty(department)) {
      throw new ApiException(10019);
    }
    let parentDepartment = null;
    if (department.parentId) {
      parentDepartment = await this.deptRepositoty.findOne({
        id: department.parentId,
      });
    }
    return { department, parentDepartment };
  }

  /**
   * 更新部门信息
   */
  async update(param: UpdateDeptDataDto): Promise<void> {
    await this.deptRepositoty.update(param.id, {
      parentId: param.parentId === -1 ? undefined : param.parentId,
      name: param.name,
      orderNum: param.orderNum,
    });
  }

  /**
   * 转移部门
   */
  async transfer(userIds: number[], deptId: number): Promise<void> {
    await this.userRepositoty.update(
      { id: In(userIds) },
      { departmentId: deptId },
    );
  }

  /**
   * 新增部门
   */
  async add(deptName: string, parentDeptId: number): Promise<void> {
    await this.deptRepositoty.insert({
      name: deptName,
      parentId: parentDeptId === -1 ? null : parentDeptId,
    });
  }

  /**
   * 移动排序
   */
  async move(depts: MoveDeptData[]): Promise<void> {
    await this.entityManager.transaction(async (manager) => {
      for (let i = 0; i < depts.length; i++) {
        await manager.update(
          SysDataDepartment,
          { id: depts[i].id },
          { parentId: depts[i].parentId },
        );
      }
    });
  }

  /**
   * 根据ID删除部门
   */
  async delete(departmentId: number): Promise<void> {
    await this.deptRepositoty.delete(departmentId);
  }

  /**
   * 根据部门查询关联的用户数量
   */
  async countUserByDeptId(id: number): Promise<number> {
    return await this.userRepositoty.count({ departmentId: id });
  }

  /**
   * 根据部门查询关联的角色数量
   */
  async countRoleByDeptId(id: number): Promise<number> {
    return await this.roleDeptRepositoty.count({ departmentId: id });
  }

  /**
   * 查找当前部门下的子部门数量
   */
  async countChildDept(id: number): Promise<number> {
    return await this.deptRepositoty.count({ parentId: id });
  }

  /**
   * 根据当前角色id获取部门列表
   */
  async getDepts(uid: number): Promise<SysDataDepartment[]> {
    const roleIds = await this.roleService.getRoleIdByData(uid);
    let depts: any = [];
    if (includes(roleIds, this.rootRoleId)) {
      // root find all
      depts = await this.deptRepositoty.find();
    } else {
      // [ 1, 2, 3 ] role find
      depts = await this.deptRepositoty
        .createQueryBuilder('dept')
        .innerJoinAndSelect(
          'sys_role_departmentdata',
          'role_dept',
          'dept.id = role_dept.department_id',
        )
        .andWhere('role_dept.role_id IN (:...roldIds)', { roldIds: roleIds })
        .orderBy('dept.order_num', 'ASC')
        .getMany();
    }
    return depts;
  }
}
