import { PrimaryGeneratedColumn, Column, Entity } from 'typeorm';
import { ApiProperty } from '@nestjs/swagger';
import { BaseEntity } from '../base.entity';

@Entity({ name: 'sys_data_role' })
export default class SysDataRole extends BaseEntity {
  @PrimaryGeneratedColumn()
  @ApiProperty()
  id: number;

  @Column({ name: 'user_id' })
  @ApiProperty()
  userId: number;

  @Column({ name: 'role_id' })
  @ApiProperty()
  roleId: number;
}
