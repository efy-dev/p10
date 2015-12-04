
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

CREATE TABLE `group_buy` (
`id`  char(16) NOT NULL ,
`group_product_id`  char(16) NULL ,
`status`  char(2) NULL ,
`create_datetime`  datetime NULL ,
`manmember_id`  char(16) NULL ,
PRIMARY KEY (`id`)
)
;


ALTER TABLE `group_buy`
CHANGE COLUMN `manmember_id` `man_user_id`  char(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `create_datetime`;

ALTER TABLE `organization_user`
ADD COLUMN `red_packet`  decimal(10,2) NULL AFTER `tenant_type`;


CREATE TABLE `purchase_order_group` (
`id`  char(16) NOT NULL ,
`purchase_order_id`  char(16) NULL ,
`group_id`  char(16) NULL ,
`member_id`  char(16) NULL ,
`status`  varchar(2) NULL ,
PRIMARY KEY (`id`)
)
;


ALTER TABLE `member`
ADD COLUMN `red_packet`  decimal(10,2) NULL AFTER `group_id`;
ALTER TABLE `group_product`
MODIFY COLUMN `group_price`  decimal(10,2) NULL DEFAULT NULL AFTER `member_amount`;

ALTER TABLE `group_product`
MODIFY COLUMN `bonus`  decimal(10,2) NULL DEFAULT NULL AFTER `create_datetime`;


ALTER TABLE `activity_member`
ADD COLUMN `create_datetime`  date NULL AFTER `red_packet`;

