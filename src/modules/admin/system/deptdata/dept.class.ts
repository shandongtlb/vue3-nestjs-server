import { ApiProperty } from '@nestjs/swagger';
import SysDepartment from 'src/entities/admin/sys-departmentdata.entity';

export class DeptDataDetailInfo {
  @ApiProperty({ description: '当前查询的部门' })
  department?: SysDepartment;

  @ApiProperty({ description: '所属父级部门' })
  parentDepartment?: SysDepartment;
}
