-- 建库
create Database houserent;
-- 使用houserent库
use houserent;

-- 权限表
CREATE TABLE IF NOT EXISTS hr_roles(
	r_id int unsigned NOT NULL AUTO_INCREMENT COMMENT '权限id',
	r_name varchar(20) CHARACTER SET utf8 NOT NULL COMMENT '权限名',
	r_describe varchar(100) CHARACTER SET utf8 COMMENT '权限描述',
	r_parentId int unsigned DEFAULT '0' COMMENT '权限父Id,本表自外键，0为顶级权限',
	r_mod varchar(20) CHARACTER SET utf8 NOT NULL COMMENT '权限的模块名',
	r_ctrl varchar(20) CHARACTER SET utf8 NOT NULL COMMENT '权限控制器名',
	r_act varchar(20) CHARACTER SET utf8 NOT NULL COMMENT '权限方法名',
	r_type tinyint unsigned DEFAULT '1' COMMENT '前后台类型,1:前台,2:后台',
	r_show tinyint unsigned DEFAULT '1' COMMENT '是否显示,1:显示,2:隐藏',
	r_creatTime bigint(10) unsigned NOT NULL COMMENT '创建的时间',
	r_updateTime bigint(10) unsigned DEFAULT '0' COMMENT '修改时间',
	r_status tinyint unsigned DEFAULT '1' COMMENT '权限状态,1:正常,2:关闭',
	PRIMARY KEY (r_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- 用户组表
CREATE TABLE IF NOT EXISTS hr_group(
	g_id int unsigned NOT NULL AUTO_INCREMENT COMMENT '用户组id',
	g_name varchar(20) CHARACTER SET utf8 NOT NULL COMMENT '用户组名',
	g_describe varchar(100) CHARACTER SET utf8 COMMENT '分组描述',
	g_creatTime bigint(10) unsigned NOT NULL COMMENT '分组创建时间',
	g_updateTime bigint(10) unsigned DEFAULT '0' COMMENT '分组修改时间',
	g_status tinyint unsigned DEFAULT '1' COMMENT '分组状态,1:正常,2:关闭',
	PRIMARY KEY (g_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- 权限分组中间表
CREATE TABLE IF NOT EXISTS hr_roles_group(
	rg_roleId int unsigned NOT NULL COMMENT '权限Id',
	rg_groupId int unsigned NOT NULL COMMENT '分组Id',
	PRIMARY KEY (rg_groupId, rg_roleId),
	foreign key (rg_roleId) references hr_roles(r_id),
	foreign key (rg_groupId) references hr_group(g_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- 管理表
CREATE TABLE IF NOT EXISTS hr_admin(
	a_id int unsigned NOT NULL AUTO_INCREMENT COMMENT '管理Id',
	a_name varchar(20) CHARACTER SET utf8 NOT NULL COMMENT '管理名',
	a_pwd varchar(32) CHARACTER SET utf8 NOT NULL COMMENT '管理密码',
	a_headImg varchar(40) CHARACTER SET utf8 COMMENT '管理头像,使用逗号分隔',
	a_groupId int unsigned NOT NULL COMMENT '分组Id',
	a_tel bigint(11) unsigned DEFAULT '0' COMMENT '管理电话',
	a_email varchar(40) CHARACTER SET utf8 COMMENT '管理邮箱',
	a_ip varchar(15) CHARACTER SET utf8 NOT NULL COMMENT '管理登陆Ip',
	a_lastLoginTime bigint(10) unsigned COMMENT '最后登录时间',
	a_creatTime bigint(10) unsigned NOT NULL COMMENT '创建时间',
	a_updateTime bigint(10) unsigned DEFAULT '0' COMMENT '修改时间',
	a_status tinyint unsigned DEFAULT '1' COMMENT '状态,1:正常,2:关闭',
	PRIMARY KEY (a_id),
	foreign key (a_groupId) references hr_group(g_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- 楼房表
CREATE TABLE IF NOT EXISTS hr_build(
	b_id int unsigned NOT NULL AUTO_INCREMENT COMMENT '楼房Id',
	b_name varchar(50) CHARACTER SET utf8 NOT NULL COMMENT '楼房名',
	b_master int unsigned NOT NULL COMMENT '楼房所有人',
	b_describe varchar(100) CHARACTER SET utf8 COMMENT '楼房描述',
	b_imgs varchar(250) CHARACTER SET utf8 COMMENT '楼房图片集，使用`,`隔开',
	b_province varchar(20) CHARACTER SET utf8 NOT NULL COMMENT '楼房所在省',
	b_city varchar(24) CHARACTER SET utf8 NOT NULL COMMENT '楼房所在市',
	b_district varchar(20) CHARACTER SET utf8 NOT NULL COMMENT '楼房所在区',
	b_area varchar(50) CHARACTER SET utf8 NOT NULL COMMENT '楼房详细地址',
	b_status tinyint unsigned DEFAULT '1' COMMENT '楼房状态,1.正常、2.关闭', 
	PRIMARY KEY (b_id),
	foreign key (b_master) references hr_admin(a_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- 房间表
CREATE TABLE IF NOT EXISTS hr_house(
	h_id int unsigned NOT NULL AUTO_INCREMENT COMMENT '房间Id',
	h_code mediumint unsigned NOT NULL COMMENT '房间号',
	h_in int unsigned NOT NULL COMMENT '楼房Id',
	h_price float NOT NULL COMMENT '房间价格',
	h_describe varchar(100) CHARACTER SET utf8 COMMENT '房间描述',
	h_imgs varchar(250) CHARACTER SET utf8 COMMENT '房间图片,使用`,`隔开',
	h_status tinyint unsigned DEFAULT '1' COMMENT '状态,1:空房,2:出租,3:预定',
	PRIMARY KEY (h_id),
	foreign key (h_in) references hr_build(b_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- 房客表
CREATE TABLE IF NOT EXISTS hr_tenant(
	t_id int unsigned NOT NULL AUTO_INCREMENT COMMENT '房客Id',
	t_name varchar(20) CHARACTER SET utf8 NOT NULL COMMENT '房客昵称',
	t_pwd varchar(32) CHARACTER SET utf8 NOT NULL COMMENT '房客密码',
	t_groupId int unsigned NOT NULL COMMENT '分组Id',
	t_headImg varchar(40) CHARACTER SET utf8 COMMENT '房客头像',
	t_tel bigint(11) unsigned DEFAULT '0' COMMENT '电话',
	t_email varchar(40) CHARACTER SET utf8 COMMENT '邮箱',
	t_ip varchar(15) CHARACTER SET utf8 NOT NULL COMMENT '登陆Ip',
	t_lastLoginTime bigint(10) unsigned COMMENT '最后登录时间',
	t_creatTime bigint(10) unsigned NOT NULL COMMENT '创建时间',
	t_updateTime bigint(10) unsigned DEFAULT '0' COMMENT '修改时间',
	t_status tinyint unsigned DEFAULT '1' COMMENT '状态,1:正常,2:删除',
	PRIMARY KEY (t_id),
	foreign key (t_groupId) references hr_group(g_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- 房客附表
CREATE TABLE IF NOT EXISTS hr_tenantOther(
	to_id int unsigned NOT NULL AUTO_INCREMENT COMMENT '附表id',
	to_tenantId	int unsigned NOT NULL COMMENT '房客Id',
	to_realName	varchar(10)	CHARACTER SET utf8 COMMENT '房客真实姓名',
	to_idCard char(18) CHARACTER SET utf8 COMMENT '房客身份证号',
	to_idCardImg varchar(100) CHARACTER SET utf8 COMMENT '房客身份证照片',
	PRIMARY KEY (to_id),
	foreign key (to_tenantId) references hr_tenant(t_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;