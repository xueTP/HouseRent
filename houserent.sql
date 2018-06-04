-- 建库
create Database houserent;
-- 楼房表
CREATE TABLE IF NOT EXISTS hr_build(
	b_id int unsigned NOT NULL AUTO_INCREMENT COMMENT '楼房Id',
	b_name varchar(50) CHARACTER SET utf8 NOT NULL COMMENT '楼房名',
	b_master int unsigned NOT NULL COMMENT '楼房主',
	b_describe varchar(100) CHARACTER SET utf8 DEFAULT NULL COMMENT '楼房描述',
	b_imgs varchar(250) CHARACTER SET utf8 DEFAULT NULL COMMENT '楼房图片集，使用`,`隔开',
	b_province varchar(20) CHARACTER SET utf8 NOT NULL COMMENT '楼房所在省',
	b_city varchar(24) CHARACTER SET utf8 NOT NULL COMMENT '楼房所在市',
	b_district varchar(20) CHARACTER SET utf8 NOT NULL COMMENT '楼房所在区',
	b_area varchar(50) CHARACTER SET utf8 NOT NULL COMMENT '楼房详细地址',
	b_status tinyint DEFAULT '1' COMMENT '楼房状态,1.正常、2.关闭', 
	PRIMARY KEY (b_id),
	foreign key (b_master) references hr_admin(a_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;