import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import {
  ROOT_ROLE_ID,
  SYS_TASK_QUEUE_NAME,
  SYS_TASK_QUEUE_PREFIX,
} from 'src/modules/admin/admin.constants';
import SysDepartment from 'src/entities/admin/sys-department.entity';
import SysDepartmentdata from 'src/entities/admin/sys-departmentdata.entity';
import SysLoginLog from 'src/entities/admin/sys-login-log.entity';
import SysMenu from 'src/entities/admin/sys-menu.entity';
import SysRoleDepartment from 'src/entities/admin/sys-role-department.entity';
import SysRoleDepartmentdata from 'src/entities/admin/sys-role-departmentdata.entity';
import SysRoleMenu from 'src/entities/admin/sys-role-menu.entity';
import SysRole from 'src/entities/admin/sys-role.entity';
import SysRoleMenuData from 'src/entities/admin/sys-role-menudata.entity';
import SysRoleData from 'src/entities/admin/sys-roledata.entity';
import SysTaskLog from 'src/entities/admin/sys-task-log.entity';
import SysTask from 'src/entities/admin/sys-task.entity';
import SysUserRole from 'src/entities/admin/sys-user-role.entity';
import SysUser from 'src/entities/admin/sys-user.entity';
import SysDataRole from 'src/entities/admin/sys-data-role.entity';
import SysData from 'src/entities/admin/sys-data.entity';
import { rootRoleIdProvider } from '../core/provider/root-role-id.provider';
import { SysDeptController } from './dept/dept.controller';
import { SysDeptService } from './dept/dept.service';
import { SysDeptDataController } from './deptdata/dept.controller';
import { SysDeptDataService } from './deptdata/dept.service';
import { SysLogController } from './log/log.controller';
import { SysLogService } from './log/log.service';
import { SysMenuController } from './menu/menu.controller';
import { SysMenuService } from './menu/menu.service';
import { SysRoleController } from './role/role.controller';
import { SysRoleService } from './role/role.service';
import { SysRoleDataController } from './roledata/role.controller';
import { SysRoleDataService } from './roledata/role.service';
import { SysUserController } from './user/user.controller';
import { SysUserService } from './user/user.service';
import { SysDataController } from './data/user.controller';
import { SysDataService } from './data/user.service';
import { BullModule } from '@nestjs/bull';
import { SysTaskController } from './task/task.controller';
import { SysTaskService } from './task/task.service';
import { ConfigModule, ConfigService } from '@nestjs/config';
import { SysTaskConsumer } from './task/task.processor';
import { SysOnlineController } from './online/online.controller';
import { SysOnlineService } from './online/online.service';
import { WSModule } from 'src/modules/ws/ws.module';
import SysConfig from 'src/entities/admin/sys-config.entity';
import { SysParamConfigController } from './param-config/param-config.controller';
import { SysParamConfigService } from './param-config/param-config.service';
import { SysServeController } from './serve/serve.controller';
import { SysServeService } from './serve/serve.service';

@Module({
  imports: [
    TypeOrmModule.forFeature([
      SysUser,
      SysDepartment,
      SysUserRole,
      SysDepartmentdata,
      SysRoleDepartmentdata,
      SysMenu,
      SysRoleMenu,
      SysRoleMenuData,
      SysDataRole,
      SysData,
      SysRole,
      SysRoleData,
      SysRoleDepartment,
      SysUserRole,
      SysLoginLog,
      SysTask,
      SysTaskLog,
      SysConfig,
    ]),
    BullModule.registerQueueAsync({
      name: SYS_TASK_QUEUE_NAME,
      imports: [ConfigModule],
      useFactory: (configService: ConfigService) => ({
        redis: {
          host: configService.get<string>('redis.host'),
          port: configService.get<number>('redis.port'),
          password: configService.get<string>('redis.password'),
          db: configService.get<number>('redis.db'),
        },
        prefix: SYS_TASK_QUEUE_PREFIX,
      }),
      inject: [ConfigService],
    }),
    WSModule,
  ],
  controllers: [
    SysUserController,
    SysDataController,
    SysRoleController,
    SysMenuController,
    SysDeptController,
    SysRoleDataController,
    SysDeptDataController,
    SysLogController,
    SysTaskController,
    SysOnlineController,
    SysParamConfigController,
    SysServeController,
  ],
  providers: [
    rootRoleIdProvider(),
    SysUserService,
    SysDataService,
    SysRoleService,
    SysMenuService,
    SysRoleDataService,
    SysDeptService,
    SysDeptDataService,
    SysLogService,
    SysTaskService,
    SysTaskConsumer,
    SysOnlineService,
    SysParamConfigService,
    SysServeService,
  ],
  exports: [
    ROOT_ROLE_ID,
    TypeOrmModule,
    SysUserService,
    SysDataService,
    SysMenuService,
    SysLogService,
    SysOnlineService,
  ],
})
export class SystemModule {}
