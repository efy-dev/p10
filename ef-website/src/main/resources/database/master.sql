
#---------------未执行----------------
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


#-------------------------------未执行----------------------------------

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


