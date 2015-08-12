
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
  `price` double(5,0) DEFAULT NULL,
  `status` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
