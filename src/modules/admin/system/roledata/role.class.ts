import { ApiProperty } from '@nestjs/swagger';
import SysRoleDataDepartment from 'src/entities/admin/sys-role-departmentdata.entity';
import SysRoleDataMenu from 'src/entities/admin/sys-role-menudata.entity';
import SysRoleData from 'src/entities/admin/sys-roledata.entity';

export class RoleDataInfo {
  @ApiProperty({
    type: SysRoleData,
  })
  roleInfo: SysRoleData;

  @ApiProperty({
    type: [SysRoleDataMenu],
  })
  menus: SysRoleDataMenu[];

  @ApiProperty({
    type: [SysRoleDataDepartment],
  })
  depts: SysRoleDataDepartment[];
}

export class CreatedRoleDataId {
  roleId: number;
}
