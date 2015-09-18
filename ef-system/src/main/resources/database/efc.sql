
// tenant_attachmemt  ---> master_attachmemt
// tenant_banner  ---> master_banner
// tenant_honor  ---> master_honor
// tenant_introduction  ---> master_introduction
// tenant_news  ---> master_news
// tenant_news_tag  ---> master_news_tag
// tenant_recommended  ---> master_recommended
// tenant_work_recommended  ---> master__work_recommended
// tenant_work_shop  ---> master_work_shop
// tenant_work_tag   ---> master_work_tag

ALTER TABLE `basic_recommended`
CHANGE COLUMN `group` `group_name`  varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `id`;

ALTER TABLE `basic_recommended`
MODIFY COLUMN `sort`  integer(16) NULL DEFAULT NULL AFTER `recommend_id`;


ALTER TABLE `master_attachment`
ADD COLUMN `master_news_id`  varchar(16) NULL AFTER `title`;

ALTER TABLE `master_attachment`
CHANGE COLUMN `tenant_introduction_id` `master_introduction_id`  char(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `id`;


ALTER TABLE `product`
ADD COLUMN `sort`  int(16) NULL AFTER `create_datetime`;

ALTER TABLE `master_recommended`
ADD COLUMN `status`  varchar(20) NULL AFTER `sort`;

ALTER TABLE `master_work_recommended`
ADD COLUMN `master_work_id`  char(16) NULL AFTER `status`;


ALTER TABLE `master_news_tag`
CHANGE COLUMN `tenant_news_id` `master_news_id`  char(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `id`;


ALTER TABLE `master_work_tag`
CHANGE COLUMN `tenant_work_id` `master_work_id`  char(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `status`;

//2015 08 05
ALTER TABLE `basic_banner`
CHANGE COLUMN `group_id` `group_name`  varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `direct_url`;

ALTER TABLE `basic_document`
CHANGE COLUMN `group_id` `group_name`  varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `title`;

//basic_word_value -->  tag
//basic_banner --> base_banner
//basic_document -->base_document
//basic_document_attachment -->   base_document_attachment
// basic_document_content -- >base_document_content
// basic_recommended --> base_recommended

ALTER TABLE `tag`
CHANGE COLUMN `group_id` `group_name`  varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字典键' AFTER `id`;

DROP TABLE IF EXISTS `master_introduction_attachment`;
CREATE TABLE `master_introduction_attachment` (
  `id` char(16) NOT NULL,
  `master_introduction_id` char(16) DEFAULT NULL,
  `url` varchar(64) NOT NULL,
  `status` varchar(20) NOT NULL,
  `title` varchar(64) NOT NULL,
  `master_news_id` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



//master_attachment ---> master_news_attachment

---------------------------------------------------
------2015/8/11 修改user表thestatus成status 创建表coupon 和couponBatch
---------------------------------------------------
ALTER TABLE organization_user CHANGE COLUMN thestatus status SMALLINT(2);


DROP TABLE IF EXISTS `coupon`;
CREATE TABLE `coupon` (
  `id` varchar(16) NOT NULL,
  `coupon_batch_id` varchar(16) DEFAULT NULL,
  `status` varchar(1) DEFAULT NULL,
  `serial` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `coupon_batch`;
CREATE TABLE `coupon_batch` (
  `id` varchar(16) NOT NULL,
  `name` varchar(16) DEFAULT NULL,
  `amount` int(5) DEFAULT NULL,
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `price` float(5,0) DEFAULT NULL,
  `status` varchar(1) DEFAULT NULL,
  `is_created_coupon` smallint(1) DEFAULT NULL,
  `price_limit` float DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/********20150813******/
ALTER TABLE `master_news`
DROP COLUMN `brief`,
ADD COLUMN `brief`  varchar(255) NULL AFTER `content`;


/*******20150818**************/


ALTER TABLE tenant RENAME TO master


CREATE TABLE `tenant` (
`id`  char(16) NOT NULL ,
PRIMARY KEY (`id`)
)
;
ALTER TABLE `product`
CHANGE COLUMN `tenant_id` `master_id`  char(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `picture_url`;

ALTER TABLE `master_work_shop`
CHANGE COLUMN `tenant_id` `master_id`  char(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `name`;

ALTER TABLE `master_news`
CHANGE COLUMN `tenant_id` `master_id`  char(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `user_id`;

ALTER TABLE `master_introduction`
CHANGE COLUMN `tenant_id` `master_id`  char(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `id`;

ALTER TABLE `master_work_recommended`
CHANGE COLUMN `tenant_id` `master_id`  varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `id`;

ALTER TABLE tenant_project RENAME TO master_project

ALTER TABLE `master_project`
CHANGE COLUMN `tenant_id` `master_id`  varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `id`;





alter TABLE purchase_order_delivery add COLUMN status SMALLINT(1)

alter TABLE product add COLUMN recommended_index INTEGER(5);
/////20150820
ALTER TABLE `master_banner`
CHANGE COLUMN `tenant_id` `master_id`  varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `the_status`;

ALTER TABLE `master_honor`
CHANGE COLUMN `tenant_id` `master_id`  char(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `memo`;

ALTER TABLE `master_recommended`
CHANGE COLUMN `tenant_id` `master_id`  char(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL AFTER `id`;


ALTER TABLE `product`
ADD COLUMN `recommended_index`  int(5) NULL AFTER `sort`;

ALTER TABLE `product`
ADD COLUMN `tenant_id`  char(16) NULL AFTER `recommended_index`;

CREATE TABLE `product_model` (
	`recommend_index` int(11) NULL,
	`status` char(4) NULL,
	`amount` char(8) NULL,
	`product_id` char(16) NULL,
	`price` decimal(10) NULL,
	`serial` char(32) NULL,
	`id` char(16) NOT NULL,
	PRIMARY KEY (`id`)
) ENGINE=InnoDB;



CREATE TABLE `core_base_choose` (
`id`  char(16) NOT NULL ,
`model_id`  char(16) NULL ,
PRIMARY KEY (`id`)
)
;

DROP TABLE IF EXISTS `projectFollowed`;
CREATE TABLE `projectFollowed` (
  `id` char(16) NOT NULL,
  `project_id` char(16) DEFAULT NULL,
  `status` varchar(1) DEFAULT NULL,
  `createDatetime` datetime DEFAULT NULL,
  `consumer_id` char(16) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of projectFollowed
-- ----------------------------
INSERT INTO `projectFollowed` VALUES ('1', 'ichld4520000i9y0', '1', '2015-09-09 15:16:18', 'icwz67p000009mnr');

------------aliyun/efc----------
------------masterNews-----------
ALTER TABLE `master_news`
	ADD COLUMN `project_id` char(16) NULL AFTER `brief`;
------------end---------------

