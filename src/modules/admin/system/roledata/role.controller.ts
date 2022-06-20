import { Body, Controller, Get, Post, Query } from '@nestjs/common';
import {
  ApiOperation,
  ApiOkResponse,
  ApiSecurity,
  ApiTags,
} from '@nestjs/swagger';
import { ADMIN_PREFIX } from 'src/modules/admin/admin.constants';
import { PageOptionsDto } from 'src/common/dto/page.dto';
import { PageResult } from 'src/common/class/res.class';
import SysRoleData from 'src/entities/admin/sys-roledata.entity';
import { SysRoleDataService } from './role.service';
import {
  CreateRoleDataDto,
  DeleteRoleDataDto,
  InfoRoleDataDto,
  UpdateRoleDataDto,
} from './role.dto';
import { ApiException } from 'src/common/exceptions/api.exception';
import { AdminUser } from '../../core/decorators/admin-user.decorator';
import { IAdminUser } from '../../admin.interface';
import { RoleDataInfo } from './role.class';
import { SysMenuService } from '../menu/menu.service';

@ApiSecurity(ADMIN_PREFIX)
@ApiTags('角色模块')
@Controller('roledata')
export class SysRoleDataController {
  constructor(
    private roleDataService: SysRoleDataService,
    private menuService: SysMenuService,
  ) {}

  @ApiOperation({ summary: '获取角色列表' })
  @ApiOkResponse({ type: [SysRoleData] })
  @Get('list')
  async list(): Promise<SysRoleData[]> {
    return await this.roleDataService.list();
  }

  @ApiOperation({ summary: '分页查询角色信息' })
  @ApiOkResponse({ type: [SysRoleData] })
  @Get('page')
  async page(@Query() dto: PageOptionsDto): Promise<PageResult<SysRoleData>> {
    const list = await this.roleDataService.page(dto.page - 1, dto.limit);
    const count = await this.roleDataService.count();
    return {
      list,
      pagination: {
        size: dto.limit,
        page: dto.page,
        total: count,
      },
    };
  }

  @ApiOperation({ summary: '删除角色' })
  @Post('delete')
  async delete(@Body() dto: DeleteRoleDataDto): Promise<void> {
    const count = await this.roleDataService.countUserIdByRole(dto.roleIds);
    if (count > 0) {
      throw new ApiException(10008);
    }
    await this.roleDataService.delete(dto.roleIds);
    await this.menuService.refreshOnlineUserPerms();
  }

  @ApiOperation({ summary: '新增角色' })
  @Post('add')
  async add(
    @Body() dto: CreateRoleDataDto,
    @AdminUser() user: IAdminUser,
  ): Promise<void> {
    await this.roleDataService.add(dto, user.uid);
  }

  @ApiOperation({ summary: '更新角色' })
  @Post('update')
  async update(@Body() dto: UpdateRoleDataDto): Promise<void> {
    await this.roleDataService.update(dto);
    await this.menuService.refreshOnlineUserPerms();
  }

  @ApiOperation({ summary: '获取角色信息' })
  @ApiOkResponse({ type: RoleDataInfo })
  @Get('info')
  async info(@Query() dto: InfoRoleDataDto): Promise<RoleDataInfo> {
    return await this.roleDataService.info(dto.roleId);
  }
}
