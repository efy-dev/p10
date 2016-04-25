CREATE TABLE `gift_industry_solution_request` (
`id`  char(16) NOT NULL ,
`username`  varchar(16) NULL ,
`tel`  varchar(16) NULL ,
`description`  varchar(1024) NULL ,
`number`  varchar(8) NULL ,
`status`  varchar(1) NULL ,
PRIMARY KEY (`id`)
)
;

CREATE TABLE `gift_industry_solution` (
`id`  char(16) NOT NULL ,
`solution_name`  varchar(16) NULL ,
`introduction`  varchar(1024) NULL ,
`status`  varchar(1) NULL ,
PRIMARY KEY (`id`)
)
;

CREATE TABLE `gift_product_gift` (
`id`  char(16) NOT NULL ,
`name`  varchar(16) NULL ,
`product_id`  char(16) NULL ,
`project_id`  char(16) NULL ,
`project_category_id`  char(16) NULL ,
`status`  varchar(1) NULL ,
PRIMARY KEY (`id`)
)
;

CREATE TABLE `gift_product_gift_industry_solution` (
`id`  char(16) NOT NULL ,
`industry_solution_id`  char(16) NULL ,
`product_gift_id`  char(16) NULL ,
`status`  varchar(1) NULL ,
PRIMARY KEY (`id`)
)
;

CREATE TABLE `gift_product_gift_tag` (
`id`  char(16) NOT NULL ,
`product_gift_id`  char(16) NULL ,
`product_gift_tag_value_id`  char(16) NULL ,
`status`  varchar(1) NULL ,
PRIMARY KEY (`id`)
)
;

CREATE TABLE `gift_product_gift_tag_value` (
`id`  char(16) NOT NULL ,
`type`  varchar(4) NULL ,
`tag_group`  varchar(4) NULL ,
`value`  varchar(32) NULL ,
`status`  varchar(1) NULL ,
PRIMARY KEY (`id`)
)
;

ALTER TABLE `gift_industry_solution_request`
CHANGE COLUMN `username` `industry_name`  char(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL AFTER `id`,
MODIFY COLUMN `tel`  char(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL AFTER `industry_name`,
MODIFY COLUMN `description`  char(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL AFTER `tel`,
MODIFY COLUMN `number`  int(11) NOT NULL AFTER `description`,
MODIFY COLUMN `status`  char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL AFTER `number`;





