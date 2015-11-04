/-----------------团员表生成-----------------/
CREATE TABLE `member` (
`id`  char(16) NOT NULL ,
`user_id`  char(16) NULL ,
`level`  char(4) NULL ,
`sup_member_id`  char(16) NULL ,
`status`  char(8) NULL ,
`group_id`  char(16) NULL ,
PRIMARY KEY (`id`)
)
;
/-------------------团员表生成-----------------------/

CREATE TABLE `group_product` (
`id`  char(16) NOT NULL ,
`member_amount`  int(8) NULL ,
`group_price`  DECIMAL(8) NULL ,
`create_datetime`  DATETIME NULL ,
`bonus`  DECIMAL(10) NULL ,
`group_purchase_time`  int(8) NULL,
`product_id`  char(16) NULL,
`status`  char(16) NOT NULL,
PRIMARY KEY (`id`)
)
;
/----------------------团表生成---------------------------/
CREATE TABLE `group_buy` (
`id`  char(16) NOT NULL ,
`group_product_id`  char(16) NULL ,
`status`  char(2) NULL ,
`create_datetime`  datetime NULL ,
`manmember_id`  char(16) NULL ,
PRIMARY KEY (`id`)
)
;


/----------------------团表生成------------------------/

/-----------------------团表团长字段修改为关联biguser---------------------------/
ALTER TABLE `group_buy`
CHANGE COLUMN `manmember_id` `man_user_id`  char(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `create_datetime`;

/-------------------------团表团长字段修改为关联biguser---------------------------/


/-------------------biguser添加红包字段----------------------------/
ALTER TABLE `organization_user`
ADD COLUMN `red_packet`  decimal(10,2) NULL AFTER `tenant_type`;

/-----------------------biguser添加红包字段-------------------------/

/-----------------------purchase_order_group表生成（团购订单表）--------------------------------------/
CREATE TABLE `purchase_order_group` (
`id`  char(16) NOT NULL ,
`purchase_order_id`  char(16) NULL ,
`group_id`  char(16) NULL ,
`member_id`  char(16) NULL ,
`status`  varchar(2) NULL ,
PRIMARY KEY (`id`)
)
;

/-----------------------purchase_order_group表生成（团购订单表）--------------------------------------/