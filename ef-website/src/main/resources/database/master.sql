#---------------已经执行----------------
ALTER TABLE `purchase_cart_product`
ADD COLUMN `status` CHAR(8) NULL
AFTER `product_id`;

ALTER TABLE `purchase_order`
ADD COLUMN `status` CHAR(8) NULL
AFTER `user_address_id`;


ALTER TABLE `purchase_order`
ADD COLUMN `total` DECIMAL NULL
AFTER `status`;

ALTER TABLE `purchase_order`
ADD COLUMN `order_status` CHAR(255) NULL
AFTER `total`;

ALTER TABLE `purchase_order_payment`
ADD COLUMN `payment_amount` DECIMAL NULL
AFTER `status`;

CREATE TABLE `product_favorite` (
  `id`         CHAR(16) NOT NULL,
  `product_model_id` CHAR(16) NULL,
  `user_id`    CHAR(16) NULL,
  `status`     CHAR(8)  NULL,
  PRIMARY KEY (`id`)
);

ALTER TABLE `product_favorite`
ADD COLUMN `create_datetime` DATETIME NULL
AFTER `status`;


ALTER TABLE `organization_consumer_address`
ADD COLUMN `address_district_id` CHAR(16) NULL
AFTER `email`;

ALTER TABLE `organization_consumer_address`
ADD COLUMN `consumer_id` CHAR(16) NULL
AFTER `address_district_id`;

ALTER TABLE `organization_consumer_address`
ADD COLUMN `status` VARCHAR(2) NULL
AFTER `consumer_id`;


CREATE TABLE `product_property_value` (
  `id`                        CHAR(16) NOT NULL,
  `product_model_id`          CHAR(16) NULL,
  `project_property_id`       CHAR(16) NULL,
  `project_property_value_id` CHAR(16) NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE `product_model` (
  `id`         CHAR(16) NOT NULL,
  `serial`     CHAR(32) NULL,
  `price`      DECIMAL  NULL,
  `product_id` CHAR(16) NULL,
  `amount`     INT(8)   NULL,
  `status`     CHAR(4)  NULL,
  PRIMARY KEY (`id`)
);

ALTER TABLE `purchase_order_payment`
ADD COLUMN `transaction_number` VARCHAR(16) NULL
AFTER `transaction_number`;


ALTER TABLE `organization_consumer`
ADD COLUMN `unionid` CHAR(64) NULL
AFTER `id`;


ALTER TABLE `purchase_order`
ADD COLUMN `original_price` DECIMAL NULL
AFTER `order_status`;

CREATE TABLE `master` (
  `id`                 CHAR(16) NOT NULL DEFAULT '',
  `name`               VARCHAR(16)       DEFAULT NULL,
  `status`             VARCHAR(1)        DEFAULT NULL,
  `origin_province_id` CHAR(16)          DEFAULT NULL,
  `create_datetime`    DATETIME          DEFAULT NULL,
  `full_name`          VARCHAR(16)       DEFAULT NULL,
  `brief`              VARCHAR(255)      DEFAULT NULL,
  `title`              VARCHAR(20)       DEFAULT NULL,
  `favicon`            VARCHAR(64)       DEFAULT NULL,
  `sex`                VARCHAR(20)       DEFAULT NULL,
  `present_address`    VARCHAR(64)       DEFAULT NULL,
  `level`              VARCHAR(64)       DEFAULT NULL,
  `content`            VARCHAR(255)      DEFAULT NULL,
  `background_url`     VARCHAR(255)      DEFAULT NULL,
  `province_name`      VARCHAR(255)      DEFAULT NULL,
  `birthday`           VARCHAR(32)       DEFAULT NULL,
  `logo_url`           VARCHAR(255)      DEFAULT NULL,
  PRIMARY KEY (`id`)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

ALTER TABLE `purchase_order`
ADD COLUMN `original_price` DECIMAL NULL
AFTER `order_status`;

CREATE TABLE `tenant_master` (
  `id`        CHAR(16) NOT NULL,
  `tenant_id` CHAR(16) NULL,
  `master_id` CHAR(16) NULL,
  `status`    CHAR(4)  NULL,
  PRIMARY KEY (`id`)
);

ALTER TABLE `product_model`
ADD COLUMN `recommend_index` INT(11) NULL
AFTER `status`;

ALTER TABLE `product`
ADD COLUMN `master_id` CHAR(16) NULL
AFTER `recommended_index`;

ALTER TABLE `organization_consumer_address`
DROP COLUMN `consignee`,
ADD COLUMN `consignee` VARCHAR(20) NOT NULL
AFTER `status`;

#
# ALTER TABLE `product_model`
# ADD COLUMN `name`  varchar(255) NULL AFTER `recommend_index`;


ALTER TABLE `purchase_cart_product`
ADD COLUMN `is_choose` CHAR(4) NULL
AFTER `status`;

ALTER TABLE `purchase_cart`
ADD COLUMN `total_price` DECIMAL NULL
AFTER `user_id`;


ALTER TABLE `purchase_order_delivery`
ADD COLUMN `serial` VARCHAR(16) NULL
AFTER `status`;

ALTER TABLE `purchase_order`
ADD COLUMN `tenant_id` CHAR(16) NULL
AFTER `original_price`;

ALTER TABLE `purchase_order`
ADD COLUMN `father_purchase_order_id` CHAR(16) NULL
AFTER `tenant_id`;

ALTER TABLE `purchase_order`
ADD COLUMN `message` VARCHAR(128) NULL
AFTER `father_purchase_order_id`;

ALTER TABLE `organization_consumer_address`
MODIFY COLUMN `details` VARCHAR(64)
CHARACTER SET utf8
COLLATE utf8_general_ci NULL DEFAULT NULL
AFTER `address_city_id`,
MODIFY COLUMN `email` VARCHAR(64)
CHARACTER SET utf8
COLLATE utf8_general_ci NULL DEFAULT NULL
AFTER `phone`;

ALTER TABLE `purchase_order_delivery`
ADD COLUMN `logistics_company` VARCHAR(64) NOT NULL
AFTER `status`;

ALTER TABLE `project_category`
ADD COLUMN `picture_url` VARCHAR(255) NULL
AFTER `type`;


ALTER TABLE `product_model`
ADD COLUMN `product_description_id` CHAR(16) NULL
AFTER `name`;

CREATE TABLE `product_model_description` (
  `id`               CHAR(16) NOT NULL,
  `content`          TEXT     NULL,
  `product_model_id` CHAR(16) NULL,
  PRIMARY KEY (`id`)
);


ALTER TABLE `purchase_coupon`
MODIFY COLUMN `id` CHAR(16)
CHARACTER SET utf8
COLLATE utf8_general_ci NOT NULL
FIRST,
MODIFY COLUMN `coupon_batch_id` CHAR(16)
CHARACTER SET utf8
COLLATE utf8_general_ci NULL DEFAULT NULL
AFTER `id`,
MODIFY COLUMN `status` CHAR(1)
CHARACTER SET utf8
COLLATE utf8_general_ci NULL DEFAULT NULL
AFTER `coupon_batch_id`,
MODIFY COLUMN `serial` CHAR(16)
CHARACTER SET utf8
COLLATE utf8_general_ci NULL DEFAULT NULL
AFTER `status`,
ADD COLUMN `consumer_id` CHAR(16) NULL
AFTER `serial`;




ALTER TABLE `purchase_order`
ADD COLUMN `coupon_id`  char(16) NULL AFTER `message`;

CREATE TABLE `subject` (
  `id`  char(16) NOT NULL ,
  `picture_url`  varchar(255) NULL ,
  `subject_discription_id`  char(16) NULL ,
  `status`  char(8) NULL ,
  PRIMARY KEY (`id`)
)
;



CREATE TABLE `subject_description` (
  `id`  char(16) NOT NULL ,
  `content`  text NULL ,
  PRIMARY KEY (`id`)
)
;

CREATE TABLE `subject_picture` (
  `id`  char(16) NOT NULL ,
  `picture_url`  varchar(255) NULL ,
  `subject_id`  char(16) NULL ,
  PRIMARY KEY (`id`)
)
;

CREATE TABLE `subject_product_model` (
  `id`  char(16) NOT NULL ,
  `subject_id`  char(16) NULL ,
  `product_model_id`  char(16) NULL ,
  `status`  char(8) NULL ,
  PRIMARY KEY (`id`)
)
;

ALTER TABLE `subject`
ADD COLUMN `index`  int(11) NULL AFTER `status`;


CREATE TABLE `purchase_order_payment_details` (
  `id`  char(16) NOT NULL ,
  `payway`  char(8) NULL ,
  `money`  decimal NULL ,
  `coupon_id`  char(16) NULL ,
  `purchase_order_payment_id`  char(16) NULL ,
  PRIMARY KEY (`id`)
)
;


ALTER TABLE `purchase_order_product`
ADD COLUMN `purchase_order_comment_id`  char(16) NULL AFTER `purchase_price`;




ALTER TABLE `purchase_order_payment_details`
ADD COLUMN `transaction_number`  char(128) NULL AFTER `purchase_order_payment_id`;
/----------评价新建表----------------------/
用户评价表
CREATE TABLE purchase_order_comment (
`id`  char(16) NOT NULL ,
`starts`  varchar(16) NULL ,
`status`  char(8) NULL ,
`content`  varchar(1024) NULL ,
`purchase_order_product_id`  varchar(16) NULL ,
`sub_purchase_order_comment_id`  varchar(16) NULL ,
PRIMARY KEY (`id`)
)
;
用户晒单表
CREATE TABLE purchase_order_comment_picture (
`id`  char(16) NOT NULL ,
`picture_url`  varchar(256) NULL ,
`status`  char(8) NULL ,
`purchase_order_comment_id`  char(16) NULL ,
PRIMARY KEY (`id`)
)
;
卖家回复表
CREATE TABLE purchase_order_business_reply (
`id`  char(16) NOT NULL ,
`reply`  varchar(1024) NULL ,
`purchase_order_comment_id`  char(16) NULL ,
PRIMARY KEY (`id`)
)
;
/-----------------优惠券批次表增加图片字段------------------/
ALTER TABLE `purchase_coupon_batch`
ADD COLUMN `picture_url`  varchar(255) NULL AFTER `price_limit`;
/-----------------优惠券批次表增加图片字段------------------/

/---------------评价新建表-----------------------/
/---------PurchaseOrderPoduct表添加评价状态字段----------/
ALTER TABLE `purchase_order_product`
ADD COLUMN `status`  char(8) NULL AFTER `purchase_order_comment_id`;
#-------------------------------未执行----------------------------------

ALTER TABLE `purchase_order`
ADD COLUMN `purchase_order_address`  varchar(255) NULL AFTER `coupon_id`;


ALTER TABLE `purchase_order_gift`
ADD COLUMN `gift_gaver_name`  varchar(50) NULL AFTER `gift_picture_url`;


