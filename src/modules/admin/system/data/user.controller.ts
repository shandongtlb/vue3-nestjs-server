import { Body, Controller, Get, Post, Query } from '@nestjs/common';
import {
  ApiOkResponse,
  ApiOperation,
  ApiSecurity,
  ApiTags,
} from '@nestjs/swagger';
import { PageResult } from 'src/common/class/res.class';
import { ADMIN_PREFIX } from '../../admin.constants';
import { IAdminUser } from '../../admin.interface';
import { AdminUser } from '../../core/decorators/admin-user.decorator';
import {
  CreateDataDto,
  DeleteDataDto,
  InfoDataDto,
  PageSearchDataDto,
  PasswordDataDto,
  UpdateDataDto,
} from './user.dto';
import { PageSearchDataInfo, DataDetailInfo } from './user.class';
import { SysDataService } from './user.service';
import { SysMenuService } from '../menu/menu.service';

@ApiSecurity(ADMIN_PREFIX)
@ApiTags('管理员模块')
@Controller('data')
export class SysDataController {
  constructor(
    private DataService: SysDataService,
    private menuService: SysMenuService,
  ) {}

  @ApiOperation({
    summary: '新增管理员',
  })
  @Post('add')
  async add(@Body() dto: CreateDataDto): Promise<void> {
    await this.DataService.add(dto);
  }

  @ApiOperation({
    summary: '查询管理员信息',
  })
  @ApiOkResponse({ type: DataDetailInfo })
  @Get('info')
  async info(@Query() dto: InfoDataDto): Promise<DataDetailInfo> {
    return await this.DataService.info(dto.userId);
  }

  @ApiOperation({
    summary: '根据ID列表删除管理员',
  })
  @Post('delete')
  async delete(@Body() dto: DeleteDataDto): Promise<void> {
    await this.DataService.delete(dto.userIds);
    await this.DataService.multiForbidden(dto.userIds);
  }
  @ApiOperation({
    summary: '分页获取管理员列表',
  })
  @ApiOkResponse({ type: [PageSearchDataInfo] })
  @Post('page')
  async page(
    @Body() dto: PageSearchDataDto,
    @AdminUser() user: IAdminUser,
  ): Promise<PageResult<PageSearchDataInfo>> {
    const list = await this.DataService.page(
      user.uid,
      dto.departmentIds,
      dto.page - 1,
      dto.limit,
    );
    const total = await this.DataService.count(user.uid, dto.departmentIds);
    return {
      list,
      pagination: {
        total,
        page: dto.page,
        size: dto.limit,
      },
    };
  }
  @ApiOperation({
    summary: '更新管理员信息',
  })
  @Post('update')
  async update(@Body() dto: UpdateDataDto): Promise<void> {
    await this.DataService.update(dto);
    await this.menuService.refreshPerms(dto.id);
  }

  @ApiOperation({
    summary: '更改指定管理员密码',
  })
  @Post('password')
  async password(@Body() dto: PasswordDataDto): Promise<void> {
    await this.DataService.forceUpdatePassword(dto.userId, dto.password);
  }
}
