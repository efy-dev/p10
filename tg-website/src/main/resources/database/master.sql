CREATE TABLE `member` (
`id`  char(16) NOT NULL ,
`user_id`  char(16) NULL ,
`level`  char(4) NULL ,
`sup_member_id`  char(16) NULL ,
`status`  char(8) NULL ,
PRIMARY KEY (`id`)
)
;

CREATE TABLE `group_product` (
`id`  char(16) NOT NULL ,
`member_amount`  int(8) NULL ,
`group_price`  DECIMAL(8) NULL ,
`create_datetime`  DATETIME NULL ,
`bonus`  DECIMAL(10) NULL ,
`group_purchase_time `  DATETIME NULL,
`product_id `  char(16) NULL,
`status `  char(16) NOT NULL,
PRIMARY KEY (`id`)
)
;
