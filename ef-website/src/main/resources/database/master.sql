
#---------------已经执行----------------
ALTER TABLE `purchase_cart_product`
ADD COLUMN `status`  char(8) NULL AFTER `product_id`;

ALTER TABLE `purchase_order`
ADD COLUMN `status`  char(8) NULL AFTER `user_address_id`;


ALTER TABLE `purchase_order`
ADD COLUMN `total`  decimal NULL AFTER `status`;

ALTER TABLE `purchase_order`
ADD COLUMN `order_status`  char(255) NULL AFTER `total`;

ALTER TABLE `purchase_order_payment`
ADD COLUMN `payment_amount`  decimal NULL AFTER `status`;

CREATE TABLE `product_favorite` (
  `id`  char(16) NOT NULL ,
  `product_id`  char(16) NULL ,
  `user_id`  char(16) NULL ,
  `status`  char(8) NULL ,
  PRIMARY KEY (`id`)
);

ALTER TABLE `product_favorite`
ADD COLUMN `create_datetime`  datetime NULL AFTER `status`;


ALTER TABLE `organization_consumer_address`
ADD COLUMN `address_district_id`  char(16) NULL AFTER `email`;

ALTER TABLE `organization_consumer_address`
ADD COLUMN `consumer_id`  char(16) NULL AFTER `address_district_id`;
2015-8-5 efc
ALTER TABLE `organization_consumer_address`
ADD COLUMN `status`  varchar(2) NULL AFTER `consumer_id`;



CREATE TABLE `product_property_value` (
  `id`  char(16) NOT NULL ,
  `product_model_id`  char(16) NULL ,
  `project_property_id`  char(16) NULL ,
  `project_property_value_id`  char(16) NULL ,
  PRIMARY KEY (`id`)
);

CREATE TABLE `NewTable` (
  `id`  char(16) NOT NULL ,
  `serial`  char(32) NULL ,
  `price`  decimal NULL ,
  `product_id`  char(16) NULL ,
  `amount`  int(8) NULL ,
  `status`  char(4) NULL ,
  PRIMARY KEY (`id`)
);

ALTER TABLE `purchase_order_payment`
ADD COLUMN `transaction_number`  varchar(16) NULL AFTER `transaction_number`;


ALTER TABLE `organization_consumer`
ADD COLUMN `unionid`  char(64) NULL AFTER `id`;


#-------------------------------未执行----------------------------------
ALTER TABLE `purchase_order`
ADD COLUMN `original_price`  decimal NULL AFTER `order_status`;

CREATE TABLE `master` (
  `id` char(16) NOT NULL DEFAULT '',
  `name` varchar(16) DEFAULT NULL,
  `status` varchar(1) DEFAULT NULL,
  `origin_province_id` char(16) DEFAULT NULL,
  `create_datetime` datetime DEFAULT NULL,
  `full_name` varchar(16) DEFAULT NULL,
  `brief` varchar(255) DEFAULT NULL,
  `title` varchar(20) DEFAULT NULL,
  `favicon` varchar(64) DEFAULT NULL,
  `sex` varchar(20) DEFAULT NULL,
  `present_address` varchar(64) DEFAULT NULL,
  `level` varchar(64) DEFAULT NULL,
  `content` varchar(255) DEFAULT NULL,
  `background_url` varchar(255) DEFAULT NULL,
  `province_name` varchar(255) DEFAULT NULL,
  `birthday` varchar(32) DEFAULT NULL,
  `logo_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE `purchase_order`
ADD COLUMN `original_price`  decimal NULL AFTER `order_status`;

CREATE TABLE `tenant_master` (
  `id`  char(16) NOT NULL ,
  `tenant_id`  char(16) NULL ,
  `master_id`  char(16) NULL ,
  `status`  char(4) NULL ,
  PRIMARY KEY (`id`)
);

ALTER TABLE `product_model`
ADD COLUMN `recommend_index`  int(11) NULL AFTER `status`;

ALTER TABLE `product`
ADD COLUMN `master_id`  char(16) NULL AFTER `recommended_index`;

ALTER TABLE `organization_consumer_address`
DROP COLUMN `consignee`,
ADD COLUMN `consignee`  varchar(20) NOT NULL AFTER `status`;

#
# ALTER TABLE `product_model`
# ADD COLUMN `name`  varchar(255) NULL AFTER `recommend_index`;


ALTER TABLE `purchase_cart_product`
ADD COLUMN `is_choose`  char(4) NULL AFTER `status`;

ALTER TABLE `purchase_cart`
ADD COLUMN `total_price`  decimal NULL AFTER `user_id`;



ALTER TABLE `purchase_order_delivery`
	ADD COLUMN `serial` varchar(16) NULL AFTER `status`;

ALTER TABLE `purchase_order`
ADD COLUMN `tenant_id`  char(16) NULL AFTER `original_price`;

ALTER TABLE `purchase_order`
ADD COLUMN `father_purchase_order_id`  char(16) NULL AFTER `tenant_id`;

ALTER TABLE `purchase_order`
ADD COLUMN `message`  varchar(128) NULL AFTER `father_purchase_order_id`;





