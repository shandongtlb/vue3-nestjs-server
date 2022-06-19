import { Body, Controller, Get, Post, Query } from '@nestjs/common';
import {
  ApiOkResponse,
  ApiOperation,
  ApiSecurity,
  ApiTags,
} from '@nestjs/swagger';
import { ADMIN_PREFIX } from 'src/modules/admin/admin.constants';
import { ApiException } from 'src/common/exceptions/api.exception';
import SysDepartmentData from 'src/entities/admin/sys-departmentdata.entity';
import { AdminUser } from '../../core/decorators/admin-user.decorator';
import { DeptDataDetailInfo } from './dept.class';
import {
  CreateDeptDataDto,
  DeleteDeptDataDto,
  InfoDeptDataDto,
  MoveDeptDataDto,
  TransferDeptDataDto,
  UpdateDeptDataDto,
} from './dept.dto';
import { SysDeptDataService } from './dept.service';

@ApiSecurity(ADMIN_PREFIX)
@ApiTags('部门模块')
@Controller('deptdata')
export class SysDeptDataController {
  constructor(private deptService: SysDeptDataService) {}

  @ApiOperation({ summary: '获取系统部门列表' })
  @ApiOkResponse({ type: [SysDepartmentData] })
  @Get('list')
  async list(@AdminUser('uid') uid: number): Promise<SysDepartmentData[]> {
    return await this.deptService.getDepts(uid);
  }

  @ApiOperation({ summary: '创建系统部门' })
  @Post('add')
  async add(@Body() createDeptDto: CreateDeptDataDto): Promise<void> {
    await this.deptService.add(createDeptDto.name, createDeptDto.parentId);
  }

  @ApiOperation({ summary: '删除系统部门' })
  @Post('delete')
  async delete(@Body() deleteDeptDto: DeleteDeptDataDto): Promise<void> {
    // 查询是否有关联用户或者部门，如果含有则无法删除
    const count = await this.deptService.countUserByDeptId(
      deleteDeptDto.departmentId,
    );
    if (count > 0) {
      throw new ApiException(10009);
    }
    const count2 = await this.deptService.countRoleByDeptId(
      deleteDeptDto.departmentId,
    );
    if (count2 > 0) {
      throw new ApiException(10010);
    }
    const count3 = await this.deptService.countChildDept(
      deleteDeptDto.departmentId,
    );
    if (count3 > 0) {
      throw new ApiException(10015);
    }
    await this.deptService.delete(deleteDeptDto.departmentId);
  }

  @ApiOperation({ summary: '查询单个系统部门信息' })
  @ApiOkResponse({ type: DeptDataDetailInfo })
  @Get('info')
  async info(@Query() infoDeptDto: InfoDeptDataDto): Promise<DeptDataDetailInfo> {
    return await this.deptService.info(infoDeptDto.departmentId);
  }

  @ApiOperation({ summary: '更新系统部门' })
  @Post('update')
  async update(@Body() updateDeptDto: UpdateDeptDataDto): Promise<void> {
    await this.deptService.update(updateDeptDto);
  }

  @ApiOperation({ summary: '管理员部门转移' })
  @Post('transfer')
  async transfer(@Body() transferDeptDto: TransferDeptDataDto): Promise<void> {
    await this.deptService.transfer(
      transferDeptDto.userIds,
      transferDeptDto.departmentId,
    );
  }

  @ApiOperation({ summary: '部门移动排序' })
  @Post('move')
  async move(@Body() dto: MoveDeptDataDto): Promise<void> {
    await this.deptService.move(dto.depts);
  }
}
