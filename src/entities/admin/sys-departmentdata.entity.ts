import { PrimaryGeneratedColumn, Column, Entity } from 'typeorm';
import { ApiProperty } from '@nestjs/swagger';
import { BaseEntity } from '../base.entity';

@Entity({ name: 'sys_departmentdata' })
export default class SysDepartmentData extends BaseEntity {
  @PrimaryGeneratedColumn()
  @ApiProperty()
  id: number;

  @Column({ name: 'parent_id', nullable: true })
  @ApiProperty()
  parentId: number;

  @Column()
  @ApiProperty()
  name: string;

  @Column({ name: 'order_num', type: 'int', nullable: true, default: 0 })
  @ApiProperty()
  orderNum: number;
}
