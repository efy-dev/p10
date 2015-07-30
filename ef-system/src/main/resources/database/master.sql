/*
Navicat MySQL Data Transfer

Source Server         : ypl
Source Server Version : 50622
Source Host           : 192.168.0.188:3306
Source Database       : yuepaila

Target Server Type    : MYSQL
Target Server Version : 50622
File Encoding         : 65001

Date: 2015-01-08 11:38:22
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `basic_banner`
-- ----------------------------
DROP TABLE IF EXISTS `basic_banner`;
CREATE TABLE `basic_banner` (
  `id` char(16) NOT NULL,
  `title` varchar(32) NOT NULL,
  `create_user_id` char(16) NOT NULL,
  `banner_order` smallint(6) DEFAULT NULL,
  `url` varchar(128) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `channel` tinyint(4) DEFAULT NULL,
  `city_id` char(16) DEFAULT NULL,
  `jump_url` char(128) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of basic_banner
-- ----------------------------
INSERT INTO `basic_banner` VALUES ('i3sfdvcv0000g6qs', 'asdasd', 'ztgdh45682sjhngl', '2', 'image/banner/i3sfduz22mzm201411071325486.jpg', '0', '1', null, null);
INSERT INTO `basic_banner` VALUES ('i3sfzjto0000a8no', 'kjjkjk', 'i2vpugci00005ns6', '55', 'image/banner/i3sfzjcygk7p2.jpg', '1', '1', '1236547891159753', null);
INSERT INTO `basic_banner` VALUES ('i3sfzydz0000bsxu', 'kjjkjk', 'i2vpugci00005ns6', '12312', 'image/banner/i3sfzy8gburz1.jpg', '1', '2', '1236547891159753', null);
INSERT INTO `basic_banner` VALUES ('i3sg0cvd0000h4oj', 'kjjkjk', 'i2vpugci00005ns6', '12312', 'image/banner/i3sg09f5ilcd5.jpg', '1', '2', '1236547891159753', null);
INSERT INTO `basic_banner` VALUES ('i3sg3f8m00008foz', 'banner01', 'i3juelfi0000ek21', '553', 'image/banner/u=3464521770,2862421689&fm=23&gp=0.jpg', '1', '3', '1236547891159753', null);
INSERT INTO `basic_banner` VALUES ('i43u7aci0000amz9', 'ssaasa', 'yhsnjhg452874plo', '553', 'image/banner/u=2172490134,3410589357&fm=23&gp=0.jpg', '1', '3', '1236547891159753', null);
INSERT INTO `basic_banner` VALUES ('i43ufjgw00008o2d', 'cvcvc', 'yhsnjhg452874plo', '553', 'image/banner/u=582472113,2301912914&fm=23&gp=0.jpg', '1', '2', '1236547891159753', null);
INSERT INTO `basic_banner` VALUES ('i4f6s0830000dq71', 'bannertitle', 'i4c5lhd900006hor', '6', 'image/banner/dress0001.jpg', '1', '-1', '1236547891159753', 'http://www.baidu.com');
INSERT INTO `basic_banner` VALUES ('i4f741eu0000jfld', 'gghh', 'i4c2mye30000b4dd', '5', 'image/banner/dress0001.jpg', '1', '-1', '1236547891159753', 'http://www.baidu.com');
INSERT INTO `basic_banner` VALUES ('xsd15424sd421fg4', 'sss', 'i2d30lym00008w6i', '1000', 'http://sp.yuepaila.com/i3bctgfz00000hvu/201411071325486.jpg', '0', null, null, null);
INSERT INTO `basic_banner` VALUES ('xsd15424sd421fg5', 'ttt', 'i2d30lym00008w6i', '2000', 'http://sp.yuepaila.com/i3bctgfz00000hvu/2014110713253689.jpg', '0', null, null, null);

-- ----------------------------
-- Table structure for `core_base_relation`
-- ----------------------------
DROP TABLE IF EXISTS `core_base_relation`;
CREATE TABLE `core_base_relation` (
  `id` char(16) CHARACTER SET utf8 NOT NULL,
  `entity_name` varchar(64) NOT NULL,
  `object_id` char(16) NOT NULL,
  `entity1_name` varchar(64) NOT NULL,
  `object1_id` char(16) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of core_base_relation
-- ----------------------------

-- ----------------------------
-- Table structure for `core_bi_grid_report`
-- ----------------------------
DROP TABLE IF EXISTS `core_bi_grid_report`;
CREATE TABLE `core_bi_grid_report` (
  `id` char(16) CHARACTER SET utf8 NOT NULL,
  `name` varchar(60) DEFAULT NULL,
  `conditions` varchar(400) DEFAULT NULL,
  `update_datetime` datetime DEFAULT NULL,
  `create_datetime` datetime DEFAULT NULL,
  `creator_id` char(16) DEFAULT NULL,
  `branch_id` char(16) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of core_bi_grid_report
-- ----------------------------

-- ----------------------------
-- Table structure for `core_bi_grid_report_data`
-- ----------------------------
DROP TABLE IF EXISTS `core_bi_grid_report_data`;
CREATE TABLE `core_bi_grid_report_data` (
  `id` char(16) CHARACTER SET utf8 NOT NULL,
  `name` varchar(30) DEFAULT NULL,
  `row_index` tinyint(4) DEFAULT NULL,
  `column_index` tinyint(4) DEFAULT NULL,
  `goal_value` varchar(30) DEFAULT NULL,
  `execute_value` varchar(30) DEFAULT NULL,
  `input_value` varchar(30) DEFAULT NULL,
  `grid_report_id` char(16) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of core_bi_grid_report_data
-- ----------------------------

-- ----------------------------
-- Table structure for `core_bi_grid_report_head`
-- ----------------------------
DROP TABLE IF EXISTS `core_bi_grid_report_head`;
CREATE TABLE `core_bi_grid_report_head` (
  `id` char(16) CHARACTER SET utf8 NOT NULL,
  `name` varchar(30) DEFAULT NULL,
  `label` varchar(30) DEFAULT NULL,
  `type` tinyint(4) DEFAULT NULL,
  `the_index` tinyint(4) DEFAULT NULL,
  `grid_report_id` char(16) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of core_bi_grid_report_head
-- ----------------------------

-- ----------------------------
-- Table structure for `core_do_db`
-- ----------------------------
DROP TABLE IF EXISTS `core_do_db`;
CREATE TABLE `core_do_db` (
  `id` char(16) CHARACTER SET utf8 NOT NULL,
  `type` varchar(12) DEFAULT NULL,
  `name` varchar(16) DEFAULT NULL,
  `label` varchar(16) DEFAULT NULL,
  `the_type` varchar(12) DEFAULT NULL,
  `do_execute` varchar(32) DEFAULT NULL,
  `do_entity` varchar(32) DEFAULT NULL,
  `result` varchar(128) DEFAULT NULL,
  `theDatetime` datetime DEFAULT NULL,
  `branch_id` char(16) DEFAULT NULL,
  `the_data` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of core_do_db
-- ----------------------------

-- ----------------------------
-- Table structure for `core_do_groupby_db`
-- ----------------------------
DROP TABLE IF EXISTS `core_do_groupby_db`;
CREATE TABLE `core_do_groupby_db` (
  `id` char(16) NOT NULL,
  `property_name` varchar(32) DEFAULT NULL,
  `property_value` varchar(32) DEFAULT NULL,
  `property_type` varchar(32) DEFAULT NULL,
  `do_query_db_id` char(16) DEFAULT NULL,
  `extendName` varchar(32) DEFAULT NULL,
  `group_expression` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of core_do_groupby_db
-- ----------------------------

-- ----------------------------
-- Table structure for `core_do_page_db`
-- ----------------------------
DROP TABLE IF EXISTS `core_do_page_db`;
CREATE TABLE `core_do_page_db` (
  `id` char(16) CHARACTER SET utf8 NOT NULL,
  `name` varchar(64) DEFAULT NULL,
  `page_type` varchar(64) DEFAULT NULL,
  `do_db_id` char(16) DEFAULT NULL,
  `father_page_db_id` char(16) DEFAULT NULL,
  `commands` varchar(128) DEFAULT NULL,
  `fields` varchar(256) DEFAULT NULL,
  `operations` varchar(128) DEFAULT NULL,
  `thestatus` tinyint(4) DEFAULT NULL,
  `page_url` varchar(64) DEFAULT NULL,
  `label` varchar(64) DEFAULT NULL,
  `page_total` varchar(32) DEFAULT NULL,
  `do_result_id` char(16) DEFAULT NULL,
  `sortName` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `do_db_id_fk` (`do_db_id`) USING BTREE,
  KEY `father_page_db_id_fk` (`father_page_db_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of core_do_page_db
-- ----------------------------

-- ----------------------------
-- Table structure for `core_do_query_condition_db`
-- ----------------------------
DROP TABLE IF EXISTS `core_do_query_condition_db`;
CREATE TABLE `core_do_query_condition_db` (
  `id` char(16) CHARACTER SET utf8 NOT NULL,
  `property_name` varchar(32) DEFAULT NULL,
  `property_value` varchar(32) DEFAULT NULL,
  `operation` varchar(16) DEFAULT NULL,
  `label` varchar(16) DEFAULT NULL,
  `type` varchar(16) DEFAULT NULL,
  `data_type` varchar(16) DEFAULT NULL,
  `do_query_db_id` char(16) NOT NULL,
  `input_key` varchar(32) DEFAULT NULL,
  `qc_required` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `do_query_db_id_fk` (`do_query_db_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of core_do_query_condition_db
-- ----------------------------

-- ----------------------------
-- Table structure for `core_do_query_db`
-- ----------------------------
DROP TABLE IF EXISTS `core_do_query_db`;
CREATE TABLE `core_do_query_db` (
  `id` char(16) CHARACTER SET utf8 NOT NULL,
  `name` varchar(64) DEFAULT NULL,
  `label` varchar(64) DEFAULT NULL,
  `order_by` varchar(128) DEFAULT NULL,
  `do_data_id` char(16) NOT NULL,
  `the_type` varchar(32) DEFAULT NULL,
  `group_by` varchar(64) DEFAULT NULL,
  `query_hql` varchar(32) DEFAULT NULL,
  `query_express` varchar(128) DEFAULT NULL,
  `query_execute` varchar(400) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `do_data_id_fk` (`do_data_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of core_do_query_db
-- ----------------------------

-- ----------------------------
-- Table structure for `core_do_result`
-- ----------------------------
DROP TABLE IF EXISTS `core_do_result`;
CREATE TABLE `core_do_result` (
  `id` char(16) CHARACTER SET utf8 NOT NULL,
  `label` varchar(32) DEFAULT NULL,
  `conditions` varchar(512) NOT NULL,
  `user_id` char(16) NOT NULL,
  `qm` varchar(64) NOT NULL,
  `thedatetime` datetime DEFAULT NULL,
  `model` varchar(64) DEFAULT NULL,
  `thestatus` tinyint(4) DEFAULT NULL,
  `qm_label` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of core_do_result
-- ----------------------------

-- ----------------------------
-- Table structure for `core_p_attachment`
-- ----------------------------
DROP TABLE IF EXISTS `core_p_attachment`;
CREATE TABLE `core_p_attachment` (
  `id` char(16) CHARACTER SET utf8 NOT NULL,
  `store_type` char(12) NOT NULL,
  `file_name` varchar(32) NOT NULL,
  `file_type` tinyint(4) NOT NULL,
  `data_id` char(16) NOT NULL,
  `path` varchar(32) NOT NULL,
  `branch_id` char(16) NOT NULL,
  `model_id` char(16) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of core_p_attachment
-- ----------------------------

-- ----------------------------
-- Table structure for `core_p_auto_serial`
-- ----------------------------
DROP TABLE IF EXISTS `core_p_auto_serial`;
CREATE TABLE `core_p_auto_serial` (
  `id` char(16) CHARACTER SET utf8 NOT NULL,
  `serial` char(15) NOT NULL,
  `model` char(15) NOT NULL,
  `branch_id` char(16) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `branch_id_fk` (`branch_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of core_p_auto_serial
-- ----------------------------

-- ----------------------------
-- Table structure for `core_p_dictionary_data`
-- ----------------------------
DROP TABLE IF EXISTS `core_p_dictionary_data`;
CREATE TABLE `core_p_dictionary_data` (
  `id` char(16) CHARACTER SET utf8 NOT NULL,
  `thestatus` tinyint(4) DEFAULT NULL,
  `dictionary_id` char(30) NOT NULL,
  `data` varchar(16) NOT NULL,
  `branch_id` char(16) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `dictionary_id_fk` (`dictionary_id`) USING BTREE,
  KEY `branch_id_fk` (`branch_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of core_p_dictionary_data
-- ----------------------------

-- ----------------------------
-- Table structure for `core_p_document`
-- ----------------------------
DROP TABLE IF EXISTS `core_p_document`;
CREATE TABLE `core_p_document` (
  `id` char(16) CHARACTER SET utf8 NOT NULL,
  `name` varchar(64) NOT NULL,
  `keywords` varchar(128) NOT NULL,
  `the_date_time` datetime NOT NULL,
  `user_id` char(16) NOT NULL,
  `type` tinyint(4) NOT NULL,
  `document_order` tinyint(4) DEFAULT NULL,
  `document_content_id` char(16) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of core_p_document
-- ----------------------------
INSERT INTO `core_p_document` VALUES ('is4125dsac451xhb', 'sa', 's', '2014-12-15 15:25:13', 'i2d30lym00008w6i', '-1', null, null);

-- ----------------------------
-- Table structure for `core_p_document_category`
-- ----------------------------
DROP TABLE IF EXISTS `core_p_document_category`;
CREATE TABLE `core_p_document_category` (
  `id` char(16) CHARACTER SET utf8 NOT NULL,
  `name` varchar(64) NOT NULL,
  `setting` varchar(32) DEFAULT NULL,
  `memo` varchar(128) DEFAULT NULL,
  `fatherCategory_id` char(16) DEFAULT NULL,
  `branch_id` char(16) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of core_p_document_category
-- ----------------------------

-- ----------------------------
-- Table structure for `core_p_file_data`
-- ----------------------------
DROP TABLE IF EXISTS `core_p_file_data`;
CREATE TABLE `core_p_file_data` (
  `id` char(16) CHARACTER SET utf8 NOT NULL,
  `path` varchar(32) NOT NULL,
  `data` varchar(32) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of core_p_file_data
-- ----------------------------

-- ----------------------------
-- Table structure for `core_p_file_upload_record`
-- ----------------------------
DROP TABLE IF EXISTS `core_p_file_upload_record`;
CREATE TABLE `core_p_file_upload_record` (
  `id` char(16) CHARACTER SET utf8 NOT NULL,
  `name` varchar(30) DEFAULT NULL,
  `url` varchar(400) DEFAULT NULL,
  `branch_id` char(16) DEFAULT NULL,
  `object_id` char(16) DEFAULT NULL,
  `type` varchar(20) DEFAULT NULL,
  `object_type` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of core_p_file_upload_record
-- ----------------------------
INSERT INTO `core_p_file_upload_record` VALUES ('i3b9z8tj0000krds', 'secondarytile.png', null, null, null, 'jpg', null);
INSERT INTO `core_p_file_upload_record` VALUES ('i3clyumt0000gsbr', 'secondarytile.png', 'dress/i3clyubhi31jsecondarytile.png', null, null, 'jpg', 'dress');
INSERT INTO `core_p_file_upload_record` VALUES ('i3cm6we100009dc4', 'secondarytile.png', 'dress/sdferdcvg1025yhj/i3cm6vzgjfb2secondarytile.png', null, null, 'jpg', 'dress');
INSERT INTO `core_p_file_upload_record` VALUES ('i3cmot8h00008xt0', 'secondarytile.png', 'dress/1234asdf1234asdf/i3cmoszoc7axsecondarytile.png', null, null, 'jpg', 'dress');
INSERT INTO `core_p_file_upload_record` VALUES ('i3cmqz1p0000eg7n', 'secondarytile.png', 'frame/1234asdf1234asdf/i3cmqyqre5ensecondarytile.png', null, null, 'jpg', 'frame');
INSERT INTO `core_p_file_upload_record` VALUES ('i3fa5w8b00000yax', 'secondarytile.png', 'dress/shgfbjnk457plok/i3fa5vy2euirsecondarytile.png', null, null, 'jpg', 'dress');
INSERT INTO `core_p_file_upload_record` VALUES ('i3fa660b0000hmd5', 'secondarytile.png', 'dress/shgfbjnk457plok/i3fa65xdfausecondarytile.png', null, null, 'jpg', 'dress');
INSERT INTO `core_p_file_upload_record` VALUES ('i3fa66730000c9a3', 'widevinecdmadapter.dll', 'dress/shgfbjnk457plok/i3fa6624krizwidevinecdmadapter.dll', null, null, 'other', 'dress');
INSERT INTO `core_p_file_upload_record` VALUES ('i3faiynx0000iscg', 'secondarytile.png', 'dress/shgfbjnk457plok/i3faiyexfqs0secondarytile.png', null, null, 'jpg', 'dress');

-- ----------------------------
-- Table structure for `core_p_operation_log`
-- ----------------------------
DROP TABLE IF EXISTS `core_p_operation_log`;
CREATE TABLE `core_p_operation_log` (
  `id` char(16) CHARACTER SET utf8 NOT NULL,
  `content` varchar(4000) DEFAULT NULL,
  `entity_name` varchar(30) DEFAULT NULL,
  `entity_label` varchar(30) DEFAULT NULL,
  `the_datetime` datetime DEFAULT NULL,
  `user_id` char(16) NOT NULL,
  `operation_type` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `the_datetime_index` (`the_datetime`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of core_p_operation_log
-- ----------------------------

-- ----------------------------
-- Table structure for `core_p_print_template`
-- ----------------------------
DROP TABLE IF EXISTS `core_p_print_template`;
CREATE TABLE `core_p_print_template` (
  `id` char(16) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `name` varchar(20) NOT NULL,
  `content` text NOT NULL,
  `thetype` varchar(32) NOT NULL,
  `branch_id` char(16) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `branch_id_fk` (`branch_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of core_p_print_template
-- ----------------------------

-- ----------------------------
-- Table structure for `core_p_system_log`
-- ----------------------------
DROP TABLE IF EXISTS `core_p_system_log`;
CREATE TABLE `core_p_system_log` (
  `id` char(16) CHARACTER SET utf8 NOT NULL,
  `content` varchar(4000) NOT NULL,
  `thetype` tinyint(4) DEFAULT NULL,
  `ip` varchar(30) DEFAULT NULL,
  `thedatetime` datetime DEFAULT NULL,
  `user_id` char(16) DEFAULT NULL,
  `branch_id` char(16) DEFAULT NULL,
  `teach_area_id` char(16) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id_fk` (`user_id`) USING BTREE,
  KEY `branch_id_fk` (`branch_id`) USING BTREE,
  KEY `teach_area_id_fk` (`teach_area_id`) USING BTREE,
  KEY `thedatetime_index` (`thedatetime`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of core_p_system_log
-- ----------------------------

-- ----------------------------
-- Table structure for `core_p_user_defined_portlet`
-- ----------------------------
DROP TABLE IF EXISTS `core_p_user_defined_portlet`;
CREATE TABLE `core_p_user_defined_portlet` (
  `id` char(16) NOT NULL,
  `thestatus` tinyint(2) NOT NULL,
  `portlet_name` varchar(50) NOT NULL,
  `url` varchar(100) NOT NULL,
  `row_size` tinyint(3) DEFAULT NULL,
  `row_index` tinyint(2) NOT NULL,
  `height` smallint(4) DEFAULT NULL,
  `colume_index` tinyint(2) NOT NULL,
  `user_id` char(16) NOT NULL,
  `portlet_label` varchar(50) DEFAULT NULL,
  `role` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id_fk` (`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of core_p_user_defined_portlet
-- ----------------------------

-- ----------------------------
-- Table structure for `info_sms`
-- ----------------------------
DROP TABLE IF EXISTS `info_sms`;
CREATE TABLE `info_sms` (
  `id` char(16) NOT NULL,
  `content` varchar(255) DEFAULT NULL,
  `target` text,
  `the_date_time` datetime DEFAULT NULL,
  `result` varchar(255) DEFAULT NULL,
  `user_id` char(16) DEFAULT NULL,
  `serial_number` varchar(16) DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of info_sms
-- ----------------------------
INSERT INTO `info_sms` VALUES ('iseshfngjes41524', '测试', '15236425864', '2015-01-06 14:21:22', '成功了', 'i2d30lym00008w6i', '2015010521243625', '2');

-- ----------------------------
-- Table structure for `info_sms_check_code`
-- ----------------------------
DROP TABLE IF EXISTS `info_sms_check_code`;
CREATE TABLE `info_sms_check_code` (
  `id` char(255) NOT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `the_date_time` datetime DEFAULT NULL,
  `result_msg` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of info_sms_check_code
-- ----------------------------
INSERT INTO `info_sms_check_code` VALUES ('402880e44a9a3cee014a9a5285a80000', '15828645383', '466154', '2014-12-30 16:31:47', '发送成功！');
INSERT INTO `info_sms_check_code` VALUES ('402880e44a9a3cee014a9a5812290001', '18800116542', '831862', '2014-12-30 16:37:50', '发送成功！');
INSERT INTO `info_sms_check_code` VALUES ('402880e44a9a3cee014a9a5ceb130002', '13999405777', '811736', '2014-12-30 16:43:08', '发送成功！');
INSERT INTO `info_sms_check_code` VALUES ('402880e44a9a3cee014a9a5e62120003', '13999996227', '604407', '2014-12-30 16:44:44', '发送成功！');
INSERT INTO `info_sms_check_code` VALUES ('402880e44abdfeaa014abe0070e60000', '13354264106', '046148', '2015-01-06 14:48:27', '发送成功！');
INSERT INTO `info_sms_check_code` VALUES ('402880e44abdfeaa014abe00d5b40001', '18624361671', '300621', '2015-01-06 14:48:53', '发送成功！');
INSERT INTO `info_sms_check_code` VALUES ('402880e44abdfeaa014abe021b330002', '17701087089', '963656', '2015-01-06 14:50:16', '发送成功！');
INSERT INTO `info_sms_check_code` VALUES ('402880e44abdfeaa014abe0241360003', '17701087089', '303737', '2015-01-06 14:50:26', '发送成功！');

-- ----------------------------
-- Table structure for `main_consumer_photo`
-- ----------------------------
DROP TABLE IF EXISTS `main_consumer_photo`;
CREATE TABLE `main_consumer_photo` (
  `id` char(16) NOT NULL,
  `name` varchar(128) NOT NULL,
  `photo_type` char(2) NOT NULL,
  `version` smallint(6) NOT NULL,
  `purchase_order_id` char(16) NOT NULL,
  `consumer_photo_group_id` char(16) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of main_consumer_photo
-- ----------------------------
INSERT INTO `main_consumer_photo` VALUES ('2014110713253689', 'te3', '11', '0', 'i2qvktl600006wt3', '1');
INSERT INTO `main_consumer_photo` VALUES ('2014110713254045', 'te4', '11', '1', 'i2qvktl600006wt3', '1');
INSERT INTO `main_consumer_photo` VALUES ('2014110713254446', 'te5', '11', '2', 'i2qvktl600006wt3', '1');
INSERT INTO `main_consumer_photo` VALUES ('201411071325486', 'test2', '11', '0', 'i2qvktl600006wt3', '2');
INSERT INTO `main_consumer_photo` VALUES ('2014110713255118', 'te6', '11', '0', 'i2qvktl600006wt3', '3');
INSERT INTO `main_consumer_photo` VALUES ('2014110713255674', 'te7', '11', '1', 'i2qvktl600006wt3', '2');
INSERT INTO `main_consumer_photo` VALUES ('2014110713260042', 'te8', '11', '2', 'i2qvktl600006wt3', '2');
INSERT INTO `main_consumer_photo` VALUES ('2014110713260314', 'te9', '11', '1', 'i2qvktl600006wt3', '3');
INSERT INTO `main_consumer_photo` VALUES ('2014110713260898', 'te10', '11', '2', 'i2qvktl600006wt3', '3');
INSERT INTO `main_consumer_photo` VALUES ('2014527455552421', 'photo', '1', '0', 'i2qvktl600006wt3', 'i31425452632145s');
INSERT INTO `main_consumer_photo` VALUES ('i3o512mz0000d07x', '201411071325486.jpg', '11', '0', 'i2qvkk6c0000c1ee', 'i3o1zhga00003lp0');
INSERT INTO `main_consumer_photo` VALUES ('i3o51a100000i4jd', '2014110713255674.jpg', '11', '0', 'i2qvkk6c0000c1ee', 'i3o1zhga00003lp0');
INSERT INTO `main_consumer_photo` VALUES ('i3o57dv60000esyx', '201411071325486.jpg', '11', '0', 'i3o55m9b000033k9', 'i3o574zl000045pa');
INSERT INTO `main_consumer_photo` VALUES ('i3o57e2s0000jixz', '2014110713253689.jpg', '11', '0', 'i3o55m9b000033k9', 'i3o574zl000045pa');
INSERT INTO `main_consumer_photo` VALUES ('i3o57ea500002a9o', '2014110713254045.jpg', '11', '0', 'i3o55m9b000033k9', 'i3o574zl000045pa');
INSERT INTO `main_consumer_photo` VALUES ('i3o57egr00008d6n', '2014110713254446.jpg', '11', '0', 'i3o55m9b000033k9', 'i3o574zl000045pa');
INSERT INTO `main_consumer_photo` VALUES ('i3o5b2ru0000di7y', '201411071325486.jpg', '1', '0', 'i3o5afgs0000bkfp', 'i3o5azbh0000hkwz');
INSERT INTO `main_consumer_photo` VALUES ('i3o5b2xp00003pt6', '2014110713253689.jpg', '1', '0', 'i3o5afgs0000bkfp', 'i3o5azbh0000hkwz');
INSERT INTO `main_consumer_photo` VALUES ('i3o5b33v0000277i', '2014110713254045.jpg', '11', '0', 'i3o5afgs0000bkfp', 'i3o5azbh0000hkwz');
INSERT INTO `main_consumer_photo` VALUES ('i3o5b3c7000028a1', '2014110713254446.jpg', '11', '0', 'i3o5afgs0000bkfp', 'i3o5azbh0000hkwz');
INSERT INTO `main_consumer_photo` VALUES ('i3r755no0000d613', 'Photo_2013-07-05_19_23_13.png', '1', '0', 'i3qok3c0000090oi', 'i3r74va50000ew8b');
INSERT INTO `main_consumer_photo` VALUES ('i3r756s10000fdql', 'Photo_2013-09-17_19_52_35.jpg', '1', '0', 'i3qok3c0000090oi', 'i3r74va50000ew8b');
INSERT INTO `main_consumer_photo` VALUES ('i3r7570f0000fbxr', 'Photo_2013-10-29_20_34_49.jpg', '1', '0', 'i3qok3c0000090oi', 'i3r74va50000ew8b');
INSERT INTO `main_consumer_photo` VALUES ('i3r75cjd0000h65i', 'Photo_2014-01-03_19_52_00.jpg', '1', '0', 'i3qok3c0000090oi', 'i3r74va50000ew8b');
INSERT INTO `main_consumer_photo` VALUES ('i3r76ean0000c652', 'Photo_2013-07-05_19_23_13.png', '1', '0', 'i3qok3c0000090oi', 'i3r766az0000k2q2');
INSERT INTO `main_consumer_photo` VALUES ('i3r76fuv00009r21', 'Photo_2014-01-03_19_52_00.jpg', '1', '0', 'i3qok3c0000090oi', 'i3r766az0000k2q2');
INSERT INTO `main_consumer_photo` VALUES ('i3r76hcy0000gho0', 'Photo_2014-01-03_19_52_10.jpg', '1', '0', 'i3qok3c0000090oi', 'i3r766az0000k2q2');
INSERT INTO `main_consumer_photo` VALUES ('i3trw74c0000kugj', 'Photo_2014-01-06_11_48_35.jpg', '1', '0', 'i3trt9ay0000hcfc', 'i3trtrsv000064dw');
INSERT INTO `main_consumer_photo` VALUES ('i3trw7gv00007x6b', 'Photo_2014-01-06_11_48_47.jpg', '1', '0', 'i3trt9ay0000hcfc', 'i3trtrsv000064dw');
INSERT INTO `main_consumer_photo` VALUES ('i3uyb18g00009sny', 'Photo_2013-10-29_20_34_49.jpg', '1', '0', 'i3trt9ay0000hcfc', 'i3truepo00009wi9');
INSERT INTO `main_consumer_photo` VALUES ('i3uyb1e20000bvi9', 'Photo_2013-12-26_18_26_33.jpg', '1', '0', 'i3trt9ay0000hcfc', 'i3truepo00009wi9');
INSERT INTO `main_consumer_photo` VALUES ('i3zthayf00003w2m', 'BaiduShurufa_2014-12-20_16-57-26.png', '1', '0', 'i3trt9ay0000hcfc', 'i3wod4yv00003y63');
INSERT INTO `main_consumer_photo` VALUES ('i4gqv2fj0000542v', '2014110713255118 - 副本.jpg', '11', '0', 'i47abcke0000fghk', 'i4gqt32700008b76');
INSERT INTO `main_consumer_photo` VALUES ('i4gqv2tc00004ig4', '2014110713255118.jpg', '11', '0', 'i47abcke0000fghk', 'i4gqt32700008b76');
INSERT INTO `main_consumer_photo` VALUES ('i4gqv3ee0000eu8v', '2014110713255674.jpg', '11', '0', 'i47abcke0000fghk', 'i4gqt32700008b76');
INSERT INTO `main_consumer_photo` VALUES ('i4htwvd200005zvv', '2014110713254045.jpg', '11', '0', 'i47abcke0000fghk', 'i4gqt32700008b76');
INSERT INTO `main_consumer_photo` VALUES ('i4hur1n000006yja', '2014110713254446.jpg', '11', '0', 'i47abcke0000fghk', 'i4gqt32700008b76');
INSERT INTO `main_consumer_photo` VALUES ('i4jqh2w700002fxe', '2014110713260898.jpg', '11', '0', 'i47abcke0000fghk', 'i4gqt32700008b76');
INSERT INTO `main_consumer_photo` VALUES ('i4jqpfap0000jbx5', '2014110713260042.jpg', '11', '0', 'i47abcke0000fghk', 'i4gqt32700008b76');
INSERT INTO `main_consumer_photo` VALUES ('i4kq6c7h00006jnv', 'JS (1).jpg', '1', '0', 'i47abcke0000fghk', 'i4gqt32700008b76');
INSERT INTO `main_consumer_photo` VALUES ('i4kq6mzi00006qhk', 'JS (2).jpg', '1', '0', 'i47abcke0000fghk', 'i4gqt32700008b76');
INSERT INTO `main_consumer_photo` VALUES ('i4kq6xxw00003kxu', 'JS (3).jpg', '1', '0', 'i47abcke0000fghk', 'i4gqt32700008b76');
INSERT INTO `main_consumer_photo` VALUES ('i4kq77760000fme0', 'JS (4).jpg', '1', '0', 'i47abcke0000fghk', 'i4gqt32700008b76');
INSERT INTO `main_consumer_photo` VALUES ('i4kq7ahb0000iszu', 'JS (5).jpg', '1', '0', 'i47abcke0000fghk', 'i4gqt32700008b76');
INSERT INTO `main_consumer_photo` VALUES ('i4kq7irz0000l1fi', 'JS (6).jpg', '1', '0', 'i47abcke0000fghk', 'i4gqt32700008b76');
INSERT INTO `main_consumer_photo` VALUES ('i4kq7mlq00004bw4', 'JS (7).jpg', '1', '0', 'i47abcke0000fghk', 'i4gqt32700008b76');
INSERT INTO `main_consumer_photo` VALUES ('i4kq7usa00008mje', 'JS (8).jpg', '1', '0', 'i47abcke0000fghk', 'i4gqt32700008b76');
INSERT INTO `main_consumer_photo` VALUES ('i4kq81q200003osp', 'JS (9).jpg', '1', '0', 'i47abcke0000fghk', 'i4gqt32700008b76');
INSERT INTO `main_consumer_photo` VALUES ('i4kq84ut00001elb', 'JS (10).jpg', '1', '0', 'i47abcke0000fghk', 'i4gqt32700008b76');
INSERT INTO `main_consumer_photo` VALUES ('i4kq8cah0000eo6h', 'JS (11).jpg', '1', '0', 'i47abcke0000fghk', 'i4gqt32700008b76');
INSERT INTO `main_consumer_photo` VALUES ('i4kq8m550000algx', 'JS (12).jpg', '1', '0', 'i47abcke0000fghk', 'i4gqt32700008b76');
INSERT INTO `main_consumer_photo` VALUES ('i4kq8ubm0000j9tw', 'JS（13）.jpg', '1', '0', 'i47abcke0000fghk', 'i4gqt32700008b76');
INSERT INTO `main_consumer_photo` VALUES ('i4kv3kbk00003uei', 'HT (1).jpg', '1', '0', 'i4gr48db0000dmwo', 'i4kv31j200004tym');
INSERT INTO `main_consumer_photo` VALUES ('i4kv3qyc0000k1ak', 'HT (2).jpg', '1', '0', 'i4gr48db0000dmwo', 'i4kv31j200004tym');
INSERT INTO `main_consumer_photo` VALUES ('i4kv3ywi000083jh', 'HT (3).jpg', '1', '0', 'i4gr48db0000dmwo', 'i4kv31j200004tym');
INSERT INTO `main_consumer_photo` VALUES ('i4kv475t0000g3fx', 'HT (4).jpg', '1', '0', 'i4gr48db0000dmwo', 'i4kv31j200004tym');
INSERT INTO `main_consumer_photo` VALUES ('i4kv4gg6000090jq', 'HT (5).jpg', '1', '0', 'i4gr48db0000dmwo', 'i4kv31j200004tym');
INSERT INTO `main_consumer_photo` VALUES ('i4kv4o45000015em', 'HT (6).jpg', '1', '0', 'i4gr48db0000dmwo', 'i4kv31j200004tym');
INSERT INTO `main_consumer_photo` VALUES ('i4kv4zor0000e920', 'HT (7).jpg', '1', '0', 'i4gr48db0000dmwo', 'i4kv31j200004tym');
INSERT INTO `main_consumer_photo` VALUES ('i4kv56dw0000eyha', 'HT (8).jpg', '1', '0', 'i4gr48db0000dmwo', 'i4kv31j200004tym');
INSERT INTO `main_consumer_photo` VALUES ('i4kv5b660000ixfs', 'HT (9).jpg', '1', '0', 'i4gr48db0000dmwo', 'i4kv31j200004tym');
INSERT INTO `main_consumer_photo` VALUES ('i4kvg9400000kw6m', 'HT (1).jpg', '1', '0', 'i4gr48db0000dmwo', 'i4kv8b2n0000cmrf');
INSERT INTO `main_consumer_photo` VALUES ('i4kvgeup000036ub', 'HT (2).jpg', '1', '0', 'i4gr48db0000dmwo', 'i4kv8b2n0000cmrf');
INSERT INTO `main_consumer_photo` VALUES ('i4kvgljb00004z2t', 'HT (3).jpg', '1', '0', 'i4gr48db0000dmwo', 'i4kv8b2n0000cmrf');
INSERT INTO `main_consumer_photo` VALUES ('i4kvgsxg0000he21', 'HT (4).jpg', '1', '0', 'i4gr48db0000dmwo', 'i4kv8b2n0000cmrf');
INSERT INTO `main_consumer_photo` VALUES ('i4kvh1pb0000j42f', 'HT (5).jpg', '1', '0', 'i4gr48db0000dmwo', 'i4kv8b2n0000cmrf');
INSERT INTO `main_consumer_photo` VALUES ('i4kvh9xk0000eacx', 'HT (6).jpg', '1', '0', 'i4gr48db0000dmwo', 'i4kv8b2n0000cmrf');
INSERT INTO `main_consumer_photo` VALUES ('i4kvhkr5000026qa', 'HT (7).jpg', '1', '0', 'i4gr48db0000dmwo', 'i4kv8b2n0000cmrf');
INSERT INTO `main_consumer_photo` VALUES ('i4kvhtnt0000g1o2', 'HT (8).jpg', '1', '0', 'i4gr48db0000dmwo', 'i4kv8b2n0000cmrf');
INSERT INTO `main_consumer_photo` VALUES ('i4kvhxm600001u0r', 'HT (9).jpg', '1', '0', 'i4gr48db0000dmwo', 'i4kv8b2n0000cmrf');
INSERT INTO `main_consumer_photo` VALUES ('i4kw7ocy0000do1a', 'HT (1).jpg', '1', '0', 'i47abcke0000fghk', 'i4kw7dlp0000jrft');
INSERT INTO `main_consumer_photo` VALUES ('i4kw7tgz00004cg5', 'HT (2).jpg', '1', '0', 'i47abcke0000fghk', 'i4kw7dlp0000jrft');
INSERT INTO `main_consumer_photo` VALUES ('i4kw7zer00005c5w', 'HT (3).jpg', '1', '0', 'i47abcke0000fghk', 'i4kw7dlp0000jrft');
INSERT INTO `main_consumer_photo` VALUES ('i4kw868o00000871', 'HT (4).jpg', '1', '0', 'i47abcke0000fghk', 'i4kw7dlp0000jrft');
INSERT INTO `main_consumer_photo` VALUES ('i4kw8e6p0000cqe7', 'HT (5).jpg', '1', '0', 'i47abcke0000fghk', 'i4kw7dlp0000jrft');
INSERT INTO `main_consumer_photo` VALUES ('i4kw8nw200009s7j', 'HT (6).jpg', '1', '0', 'i47abcke0000fghk', 'i4kw7dlp0000jrft');
INSERT INTO `main_consumer_photo` VALUES ('i4kw8y760000fbpw', 'HT (7).jpg', '1', '0', 'i47abcke0000fghk', 'i4kw7dlp0000jrft');
INSERT INTO `main_consumer_photo` VALUES ('i4kw95uu0000dej7', 'HT (8).jpg', '1', '0', 'i47abcke0000fghk', 'i4kw7dlp0000jrft');
INSERT INTO `main_consumer_photo` VALUES ('i4kw9a3y00003v3y', 'HT (9).jpg', '1', '0', 'i47abcke0000fghk', 'i4kw7dlp0000jrft');
INSERT INTO `main_consumer_photo` VALUES ('i4ky851q00001ut1', 'HT (1).jpg', '1', '0', 'i45eolvl00009q20', 'i4ky6v9600004l6l');
INSERT INTO `main_consumer_photo` VALUES ('i4ky8b1v0000gjpj', 'HT (2).jpg', '1', '0', 'i45eolvl00009q20', 'i4ky6v9600004l6l');
INSERT INTO `main_consumer_photo` VALUES ('i4ky8ht400008rpa', 'HT (3).jpg', '1', '0', 'i45eolvl00009q20', 'i4ky6v9600004l6l');
INSERT INTO `main_consumer_photo` VALUES ('i4ky8rd500002lk8', 'HT (4).jpg', '1', '0', 'i45eolvl00009q20', 'i4ky6v9600004l6l');
INSERT INTO `main_consumer_photo` VALUES ('i4ky95s400009dz6', 'HT (5).jpg', '1', '0', 'i45eolvl00009q20', 'i4ky6v9600004l6l');
INSERT INTO `main_consumer_photo` VALUES ('i4ky9egu0000bn92', 'HT (6).jpg', '1', '0', 'i45eolvl00009q20', 'i4ky6v9600004l6l');
INSERT INTO `main_consumer_photo` VALUES ('i4ky9p1100006rsj', 'HT (7).jpg', '1', '0', 'i45eolvl00009q20', 'i4ky6v9600004l6l');
INSERT INTO `main_consumer_photo` VALUES ('i4ky9wty0000byqg', 'HT (8).jpg', '1', '0', 'i45eolvl00009q20', 'i4ky6v9600004l6l');
INSERT INTO `main_consumer_photo` VALUES ('i4kya1q50000d7nv', 'HT (9).jpg', '1', '0', 'i45eolvl00009q20', 'i4ky6v9600004l6l');
INSERT INTO `main_consumer_photo` VALUES ('i4kyf5jm0000g76m', '11 (144)1.jpg', '1', '0', 'i45eolvl00009q20', 'i4kyefk10000itaj');
INSERT INTO `main_consumer_photo` VALUES ('i4kyfewx00004bi5', '11 (145).jpg', '1', '0', 'i45eolvl00009q20', 'i4kyefk10000itaj');
INSERT INTO `main_consumer_photo` VALUES ('i4kyffmw0000kuud', 'IMG_5992_调整大小.JPG', '1', '0', 'i45eolvl00009q20', 'i4kyefk10000itaj');
INSERT INTO `main_consumer_photo` VALUES ('i4kyffz60000jbtw', 'IMG_6086_调整大小.JPG', '1', '0', 'i45eolvl00009q20', 'i4kyefk10000itaj');
INSERT INTO `main_consumer_photo` VALUES ('i4kyfg9e00004gkb', 'IMG_6115_调整大小.JPG', '1', '0', 'i45eolvl00009q20', 'i4kyefk10000itaj');
INSERT INTO `main_consumer_photo` VALUES ('i4kyfgoh00002nk2', 'IMG_7449.jpg', '1', '0', 'i45eolvl00009q20', 'i4kyefk10000itaj');
INSERT INTO `main_consumer_photo` VALUES ('i4kyrugg000039ko', 'HT (1).jpg', '1', '0', 'i45eolvl00009q20', 'i4kyefk10000itaj');
INSERT INTO `main_consumer_photo` VALUES ('i4kys0jm0000ilue', 'HT (2).jpg', '1', '0', 'i45eolvl00009q20', 'i4kyefk10000itaj');
INSERT INTO `main_consumer_photo` VALUES ('i4kys7uw0000kqxs', 'HT (3).jpg', '1', '0', 'i45eolvl00009q20', 'i4kyefk10000itaj');
INSERT INTO `main_consumer_photo` VALUES ('i4kyshvw0000iyg5', 'HT (4).jpg', '1', '0', 'i45eolvl00009q20', 'i4kyefk10000itaj');
INSERT INTO `main_consumer_photo` VALUES ('i4kysrwo0000cezr', 'HT (5).jpg', '1', '0', 'i45eolvl00009q20', 'i4kyefk10000itaj');
INSERT INTO `main_consumer_photo` VALUES ('i4kyt0ui0000enzj', 'HT (6).jpg', '1', '0', 'i45eolvl00009q20', 'i4kyefk10000itaj');
INSERT INTO `main_consumer_photo` VALUES ('i4kyteh200008yfz', 'HT (7).jpg', '1', '0', 'i45eolvl00009q20', 'i4kyefk10000itaj');
INSERT INTO `main_consumer_photo` VALUES ('i4kytlux00004z53', 'HT (8).jpg', '1', '0', 'i45eolvl00009q20', 'i4kyefk10000itaj');
INSERT INTO `main_consumer_photo` VALUES ('i4kytrsq00002ik8', 'HT (9).jpg', '1', '0', 'i45eolvl00009q20', 'i4kyefk10000itaj');
INSERT INTO `main_consumer_photo` VALUES ('i4l20mi80000iqa5', '201411071325486.jpg', '1', '0', 'i47abcke0000fghk', 'i4kw7dlp0000jrft');
INSERT INTO `main_consumer_photo` VALUES ('i4l20mvy0000jd8j', '2014110713253689.jpg', '1', '0', 'i47abcke0000fghk', 'i4kw7dlp0000jrft');
INSERT INTO `main_consumer_photo` VALUES ('i4l20n780000e1p6', '2014110713254045.jpg', '1', '0', 'i47abcke0000fghk', 'i4kw7dlp0000jrft');
INSERT INTO `main_consumer_photo` VALUES ('i4l20nhm0000kmh9', '2014110713254446.jpg', '1', '0', 'i47abcke0000fghk', 'i4kw7dlp0000jrft');
INSERT INTO `main_consumer_photo` VALUES ('i4lxiaoliang6666', 'http://sp.yuepaila.com/photographer/i39pzafo0000jckl/head_2014110713254446.jpg@400w_400h|105-14-170-150a', '11', '0', 'i4lxiaoxiang8886', 'i4lxiaoliang8886');
INSERT INTO `main_consumer_photo` VALUES ('i4lxiaoxiang6667', 'http://sp.yuepaila.com/i3bacadfa0000alk/1.jpg', '11', '0', 'i4lxiaoxiang8887', 'i4lxiaoliang8887');
INSERT INTO `main_consumer_photo` VALUES ('i4lxiaoxiang6668', 'http://sp.yuepaila.com/i3bacadfa0000alk/1.jpg', '11', '0', 'i4lxiaoxiang8888', 'i4lxiaoliang8888');
INSERT INTO `main_consumer_photo` VALUES ('i4lxiaoxiang6669', 'http://sp.yuepaila.com/i3bacadfa0000alk/1.jpg', '11', '0', 'i4lxiaoxiang8889', 'i4lxiaoliang8889');
INSERT INTO `main_consumer_photo` VALUES ('i4lxiaoxiang6670', 'http://sp.yuepaila.com/i3bacadfa0000alk/1.jpg', '12', '0', 'i4lxiaoxiang8886', 'i4lxiaoliang8890');
INSERT INTO `main_consumer_photo` VALUES ('i4lxiaoxiang6671', 'http://sp.yuepaila.com/i3bacadfa0000alk/1.jpg', '12', '0', 'i4lxiaoxiang8887', 'i4lxiaoliang8891');
INSERT INTO `main_consumer_photo` VALUES ('i4lxiaoxiang6672', 'http://sp.yuepaila.com/i3bacadfa0000alk/1.jpg', '12', '0', 'i4lxiaoxiang8888', 'i4lxiaoliang8892');
INSERT INTO `main_consumer_photo` VALUES ('i4lxiaoxiang6673', 'http://sp.yuepaila.com/i3bacadfa0000alk/1.jpg', '12', '0', 'i4lxiaoxiang8889', 'i4lxiaoliang8893');
INSERT INTO `main_consumer_photo` VALUES ('i4m4lbq200009w2c', 'HT (1).jpg', '1', '0', 'i4gr48db0000dmwo', 'i4kwfmuo0000bzxt');
INSERT INTO `main_consumer_photo` VALUES ('i4m4lmb70000knr8', 'HT (2).jpg', '1', '0', 'i4gr48db0000dmwo', 'i4kwfmuo0000bzxt');

-- ----------------------------
-- Table structure for `main_consumer_photo_edit_comment`
-- ----------------------------
DROP TABLE IF EXISTS `main_consumer_photo_edit_comment`;
CREATE TABLE `main_consumer_photo_edit_comment` (
  `id` char(16) NOT NULL,
  `photo_id` char(16) NOT NULL,
  `version` smallint(6) NOT NULL,
  `content` varchar(128) NOT NULL,
  `user_id` char(16) NOT NULL,
  `create_datetime` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of main_consumer_photo_edit_comment
-- ----------------------------
INSERT INTO `main_consumer_photo_edit_comment` VALUES ('i3498fmo0000gioc', '2014110713260314', '111', '111', 'i2pxp7tx0000dkib', '2014-11-30 18:17:55');
INSERT INTO `main_consumer_photo_edit_comment` VALUES ('i3498gt1000017oe', '2014110713260314', '111', '111', 'i2pxp7tx0000dkib', '2014-11-30 18:17:56');
INSERT INTO `main_consumer_photo_edit_comment` VALUES ('i3498h6g0000amwp', '2014110713260314', '111', '111', 'i2pxp7tx0000dkib', '2014-11-30 18:17:57');
INSERT INTO `main_consumer_photo_edit_comment` VALUES ('i3498has0000e16p', '2014110713260314', '111', '111', 'i2pxp7tx0000dkib', '2014-11-30 18:17:57');
INSERT INTO `main_consumer_photo_edit_comment` VALUES ('i3498hfq0000g5md', '2014110713260314', '111', '111', 'i2pxp7tx0000dkib', '2014-11-30 18:17:57');
INSERT INTO `main_consumer_photo_edit_comment` VALUES ('i3498ht50000713z', '2014110713260314', '111', '111', 'i2pxp7tx0000dkib', '2014-11-30 18:17:58');
INSERT INTO `main_consumer_photo_edit_comment` VALUES ('i3499j4x00000258', '2014110713260314', '111', '把脸P白点，下巴P尖点', 'i2pxp7tx0000dkib', '2014-11-30 18:18:46');
INSERT INTO `main_consumer_photo_edit_comment` VALUES ('i349g6ts00009579', '201411071325486', '111', '123123123', 'i2pxp7tx0000dkib', '2014-11-30 18:23:57');
INSERT INTO `main_consumer_photo_edit_comment` VALUES ('i349ga3000007475', '2014110713254446', '111', '123123213', 'i2pxp7tx0000dkib', '2014-11-30 18:24:01');
INSERT INTO `main_consumer_photo_edit_comment` VALUES ('i349h08d0000bqfk', '2014110713254045', '111', 'Beatiful', 'i2pxp7tx0000dkib', '2014-11-30 18:24:35');
INSERT INTO `main_consumer_photo_edit_comment` VALUES ('i349hiio0000fo7y', '2014110713254045', '111', 'bushi ma', 'i2pxp7tx0000dkib', '2014-11-30 18:24:59');
INSERT INTO `main_consumer_photo_edit_comment` VALUES ('i349i4zk00004q3j', '2014110713255118', '111', 'Look at ME', 'i2pxp7tx0000dkib', '2014-11-30 18:25:28');
INSERT INTO `main_consumer_photo_edit_comment` VALUES ('i359lc1r0000hkj1', '201411071325486', '111', '12313', 'i2pxp7tx0000dkib', '2014-12-01 11:15:43');
INSERT INTO `main_consumer_photo_edit_comment` VALUES ('i35aq0dc0000159i', '2014110713254446', '111', 'Hello你好', 'i2pxp7tx0000dkib', '2014-12-01 11:47:21');
INSERT INTO `main_consumer_photo_edit_comment` VALUES ('i35g0pmo0000849b', '201411071325486', '111', '123123', 'i2pxp7tx0000dkib', '2014-12-01 14:15:00');
INSERT INTO `main_consumer_photo_edit_comment` VALUES ('i35g13e90000f9hx', '201411071325486', '111', '123123adfawuhdfawf', 'i2pxp7tx0000dkib', '2014-12-01 14:15:56');
INSERT INTO `main_consumer_photo_edit_comment` VALUES ('i35g171h0000bau0', '201411071325486', '111', '123123adfawuhdfaasdasdsadwf', 'i2pxp7tx0000dkib', '2014-12-01 14:16:01');
INSERT INTO `main_consumer_photo_edit_comment` VALUES ('i35g3hpe0000c99k', '201411071325486', '111', 'eqwewqe', 'i2pxp7tx0000dkib', '2014-12-01 14:17:48');
INSERT INTO `main_consumer_photo_edit_comment` VALUES ('i35g3kol0000klv9', '201411071325486', '111', 'eqwewqeqwewqe', 'i2pxp7tx0000dkib', '2014-12-01 14:17:52');
INSERT INTO `main_consumer_photo_edit_comment` VALUES ('i35g3qut0000etqd', '201411071325486', '111', 'qweqw', 'i2pxp7tx0000dkib', '2014-12-01 14:17:59');
INSERT INTO `main_consumer_photo_edit_comment` VALUES ('i35g3u90000054rb', '201411071325486', '111', 'qweqwqwe', 'i2pxp7tx0000dkib', '2014-12-01 14:18:04');
INSERT INTO `main_consumer_photo_edit_comment` VALUES ('i35gbpcq0000gmrb', '201411071325486', '111', 'qwewq', 'i2pxp7tx0000dkib', '2014-12-01 14:24:11');
INSERT INTO `main_consumer_photo_edit_comment` VALUES ('i35gbscw000049kz', '201411071325486', '111', 'qweqe', 'i2pxp7tx0000dkib', '2014-12-01 14:24:15');
INSERT INTO `main_consumer_photo_edit_comment` VALUES ('i35gbuzb0000d3av', '201411071325486', '111', 'qweqeqe', 'i2pxp7tx0000dkib', '2014-12-01 14:24:18');
INSERT INTO `main_consumer_photo_edit_comment` VALUES ('i35gfdi000000f2k', '201411071325486', '111', 'asdasdasd', 'i2pxp7tx0000dkib', '2014-12-01 14:27:02');
INSERT INTO `main_consumer_photo_edit_comment` VALUES ('i35ggmqj0000eoe5', '201411071325486', '111', '再美白一下，OK？\n', 'i2pxp7tx0000dkib', '2014-12-01 14:28:01');
INSERT INTO `main_consumer_photo_edit_comment` VALUES ('i35ghbkv00005uno', '201411071325486', '111', '光线在调亮一点', 'i2pxp7tx0000dkib', '2014-12-01 14:28:33');
INSERT INTO `main_consumer_photo_edit_comment` VALUES ('i35ieia800005ffa', '2014110713254045', '111', '去问去问', 'i2pxp7tx0000dkib', '2014-12-01 15:22:21');
INSERT INTO `main_consumer_photo_edit_comment` VALUES ('i35ii0hq00008ci3', '2014110713254045', '111', 'Hello World！', 'i2pxp7tx0000dkib', '2014-12-01 15:25:05');
INSERT INTO `main_consumer_photo_edit_comment` VALUES ('i35ii64x00007p6n', '2014110713254045', '111', '阿斯达我得', 'i2pxp7tx0000dkib', '2014-12-01 15:25:12');
INSERT INTO `main_consumer_photo_edit_comment` VALUES ('i371dx5p0000l5hf', '2014110713253689', '111', 'qwewqe', 'i2pxp7tx0000dkib', '2014-12-02 17:01:33');
INSERT INTO `main_consumer_photo_edit_comment` VALUES ('i371e07100007f3c', '2014110713253689', '111', 'qweqweweqwe', 'i2pxp7tx0000dkib', '2014-12-02 17:01:37');
INSERT INTO `main_consumer_photo_edit_comment` VALUES ('i381tzfc0000ddcf', '2014110713253689', '111', '1qeqwe', 'i2pxp7tx0000dkib', '2014-12-03 10:01:48');
INSERT INTO `main_consumer_photo_edit_comment` VALUES ('i382vas30000j7c2', '2014110713260898', '111', 'qqqq', 'i2pxp7tx0000dkib', '2014-12-03 10:30:49');
INSERT INTO `main_consumer_photo_edit_comment` VALUES ('i39ql8lv0000hi27', '2014110713260898', '111', '意见', 'i2pxp7tx0000dkib', '2014-12-04 14:22:37');
INSERT INTO `main_consumer_photo_edit_comment` VALUES ('i3bcr9gl00007b1a', '2014110713260042', '111', 'qweqwe', 'i2pxp7tx0000dkib', '2014-12-05 17:30:56');
INSERT INTO `main_consumer_photo_edit_comment` VALUES ('i3im1re10000ahen', '2014110713260898', '111', 'qweqwe', 'i2pxp7tx0000dkib', '2014-12-10 19:25:25');
INSERT INTO `main_consumer_photo_edit_comment` VALUES ('i3o688pm00004rcw', 'i3o5b3c7000028a1', '111', '花样年华吖', 'i2pxp7tx0000dkib', '2014-12-14 16:49:11');
INSERT INTO `main_consumer_photo_edit_comment` VALUES ('i3o68dd80000h1cv', 'i3o5b3c7000028a1', '111', '阿斯顿', 'i2pxp7tx0000dkib', '2014-12-14 16:49:17');
INSERT INTO `main_consumer_photo_edit_comment` VALUES ('i3ve62cf0000hdql', 'i3uyb1e20000bvi9', '111', '...', 'i3juelfi0000ek21', '2014-12-19 18:05:49');
INSERT INTO `main_consumer_photo_edit_comment` VALUES ('i4gtr3rg00005f92', 'i4gqv3ee0000eu8v', '111', '必看十万个冷笑话', 'i49as8kv00000fiv', '2015-01-03 18:05:15');
INSERT INTO `main_consumer_photo_edit_comment` VALUES ('i4gtrbxo00008wse', 'i4gqv3ee0000eu8v', '111', '真的好看吗', 'i49as8kv00000fiv', '2015-01-03 18:05:25');
INSERT INTO `main_consumer_photo_edit_comment` VALUES ('i4gtrh6r0000fc4j', 'i4gqv3ee0000eu8v', '111', '那是当然啦', 'i49as8kv00000fiv', '2015-01-03 18:05:32');

-- ----------------------------
-- Table structure for `main_consumer_photo_group`
-- ----------------------------
DROP TABLE IF EXISTS `main_consumer_photo_group`;
CREATE TABLE `main_consumer_photo_group` (
  `id` char(16) NOT NULL,
  `title` varchar(16) NOT NULL,
  `photographer_id` char(16) NOT NULL,
  `cover_consumer_photo_id` char(16) DEFAULT NULL,
  `purchase_order_id` char(16) NOT NULL,
  `ptype` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of main_consumer_photo_group
-- ----------------------------
INSERT INTO `main_consumer_photo_group` VALUES ('1', '青春', 'i3p82wnn0000ai54', '2014110713253689', 'i2qvktl600006wt3', '0');
INSERT INTO `main_consumer_photo_group` VALUES ('2', '校园', 'i3p82wnn0000ai54', '201411071325486', 'i2qvktl600006wt3', '0');
INSERT INTO `main_consumer_photo_group` VALUES ('3', '回忆', 'i3p82wnn0000ai54', 'dress/sdferdcvg1', '11111', '0');
INSERT INTO `main_consumer_photo_group` VALUES ('i31425452632145s', 'photo', 'i3450btg0000763y', '2014110713260314', 'i2pkh4wt0000du4p', '1');
INSERT INTO `main_consumer_photo_group` VALUES ('i3o1yw4u00008wxh', '二次方', 'i39pzafo0000jckl', null, 'i2qvktl600006wt3', '0');
INSERT INTO `main_consumer_photo_group` VALUES ('i3o1zhga00003lp0', '阿斯顿', 'i39pzafo0000jckl', null, 'i2qvkk6c0000c1ee', '0');
INSERT INTO `main_consumer_photo_group` VALUES ('i3o574zl000045pa', '花样年华', 'i39pzafo0000jckl', null, 'i3o55m9b000033k9', '1');
INSERT INTO `main_consumer_photo_group` VALUES ('i3o5azbh0000hkwz', '花样年华', 'i39pzafo0000jckl', null, 'i3o5afgs0000bkfp', '1');
INSERT INTO `main_consumer_photo_group` VALUES ('i3r74va50000ew8b', 'aaa', 'i3jxkwv40000hcdm', null, 'i3qok3c0000090oi', '2');
INSERT INTO `main_consumer_photo_group` VALUES ('i3r766az0000k2q2', 'vvvvv', 'i3jxkwv40000hcdm', null, 'i3qok3c0000090oi', '2');
INSERT INTO `main_consumer_photo_group` VALUES ('i3trtrsv000064dw', 'aaa', 'i3jxkwv40000hcdm', null, 'i3trt9ay0000hcfc', '2');
INSERT INTO `main_consumer_photo_group` VALUES ('i3trtup90000hi65', 'aaa', 'i3jxkwv40000hcdm', null, 'i3trt9ay0000hcfc', '2');
INSERT INTO `main_consumer_photo_group` VALUES ('i3tru3qj0000dl6f', 'aaa', 'i3jxkwv40000hcdm', null, 'i3trt9ay0000hcfc', '2');
INSERT INTO `main_consumer_photo_group` VALUES ('i3truepo00009wi9', 'bbb', 'i3jxkwv40000hcdm', null, 'i3trt9ay0000hcfc', '2');
INSERT INTO `main_consumer_photo_group` VALUES ('i3wocfs20000722i', 'aaaa', 'i3jxkwv40000hcdm', null, 'i3trt9ay0000hcfc', '2');
INSERT INTO `main_consumer_photo_group` VALUES ('i3wod4yv00003y63', 'vvvvv', 'i3jxkwv40000hcdm', null, 'i3trt9ay0000hcfc', '2');
INSERT INTO `main_consumer_photo_group` VALUES ('i4gpueco00004n9o', '匹诺曹', 'i39pzafo0000jckl', null, 'i47abcke0000fghk', '1');
INSERT INTO `main_consumer_photo_group` VALUES ('i4gqt32700008b76', '阿斯顿', 'i39pzafo0000jckl', null, 'i47abcke0000fghk', '1');
INSERT INTO `main_consumer_photo_group` VALUES ('i4kv2h930000g21z', 'www', 'i39pzafo0000jckl', null, 'i4gr48db0000dmwo', '2');
INSERT INTO `main_consumer_photo_group` VALUES ('i4kv31j200004tym', 'www', 'i39pzafo0000jckl', null, 'i4gr48db0000dmwo', '2');
INSERT INTO `main_consumer_photo_group` VALUES ('i4kv85ia00009pvg', 'www', 'i39pzafo0000jckl', null, 'i4gr48db0000dmwo', '2');
INSERT INTO `main_consumer_photo_group` VALUES ('i4kv8b2n0000cmrf', 'www', 'i39pzafo0000jckl', null, 'i4gr48db0000dmwo', '2');
INSERT INTO `main_consumer_photo_group` VALUES ('i4kvlgj500000cz4', 'www', 'i39pzafo0000jckl', null, 'i4gr48db0000dmwo', '2');
INSERT INTO `main_consumer_photo_group` VALUES ('i4kw7dlp0000jrft', 'www', 'i39pzafo0000jckl', null, 'i47abcke0000fghk', '1');
INSERT INTO `main_consumer_photo_group` VALUES ('i4kwbgmj0000guua', 'www', 'i39pzafo0000jckl', null, 'i47abcke0000fghk', '1');
INSERT INTO `main_consumer_photo_group` VALUES ('i4kwelvz0000cez4', 'www', 'i39pzafo0000jckl', null, 'i4gr48db0000dmwo', '2');
INSERT INTO `main_consumer_photo_group` VALUES ('i4kwestf0000cowr', 'www', 'i39pzafo0000jckl', null, 'i4gr48db0000dmwo', '2');
INSERT INTO `main_consumer_photo_group` VALUES ('i4kwfmuo0000bzxt', 'www', 'i39pzafo0000jckl', null, 'i4gr48db0000dmwo', '2');
INSERT INTO `main_consumer_photo_group` VALUES ('i4ky6v9600004l6l', 'www', 'i3jxkwv40000hcdm', null, 'i45eolvl00009q20', '2');
INSERT INTO `main_consumer_photo_group` VALUES ('i4kyefk10000itaj', 'www', 'i3jxkwv40000hcdm', null, 'i45eolvl00009q20', '2');
INSERT INTO `main_consumer_photo_group` VALUES ('i4lxiaoliang8886', '天', 'i2d30lym00008w6l', null, 'i47abcke0000fghj', '11');
INSERT INTO `main_consumer_photo_group` VALUES ('i4lxiaoliang8887', '地', 'i2d30lym00008w6l', null, 'i47abcke0000fghj', '11');
INSERT INTO `main_consumer_photo_group` VALUES ('i4lxiaoliang8888', '玄', 'i2d30lym00008w6l', null, 'i4lxiaoxiang8887', '11');
INSERT INTO `main_consumer_photo_group` VALUES ('i4lxiaoliang8889', '黄', 'i2d30lym00008w6l', null, 'i4lxiaoxiang8887', '11');
INSERT INTO `main_consumer_photo_group` VALUES ('i4lxiaoliang8890', '魑', 'i2d30lym00008w6l', null, 'i4lxiaoxiang8888', '12');
INSERT INTO `main_consumer_photo_group` VALUES ('i4lxiaoliang8891', '魅', 'i2d30lym00008w6l', null, 'i4lxiaoxiang8888', '12');
INSERT INTO `main_consumer_photo_group` VALUES ('i4lxiaoliang8892', '魍', 'i2d30lym00008w6l', null, 'i4lxiaoxiang8889', '12');
INSERT INTO `main_consumer_photo_group` VALUES ('i4lxiaoliang8893', '魉', 'i2d30lym00008w6l', null, 'i4lxiaoxiang8889', '12');

-- ----------------------------
-- Table structure for `main_customization`
-- ----------------------------
DROP TABLE IF EXISTS `main_customization`;
CREATE TABLE `main_customization` (
  `id` char(16) NOT NULL,
  `budget` int(255) DEFAULT NULL,
  `shot_time` date DEFAULT NULL,
  `scene_addresses` text,
  `person_amount` varchar(255) DEFAULT NULL,
  `style` int(10) DEFAULT NULL,
  `dress_amount` int(10) DEFAULT NULL,
  `is_need_dresser` tinyint(4) DEFAULT NULL,
  `is_need_cosmetics` tinyint(4) DEFAULT NULL,
  `is_need_tool` tinyint(4) DEFAULT NULL,
  `shot_tools` varchar(255) DEFAULT NULL,
  `requirement` text,
  `purchase_order` char(16) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of main_customization
-- ----------------------------
INSERT INTO `main_customization` VALUES ('i46r4ewz00001u7n', '111', '2011-10-10', '', '1-2人', '1', '22', '0', '0', '0', '请输入内容', 'dasdsa', null);
INSERT INTO `main_customization` VALUES ('i4kzodxd0000l3tz', '1111', null, '', '1-2人', '1', '2', '0', '0', '0', '111', ' 1111', null);
INSERT INTO `main_customization` VALUES ('i4ml47fk00008xcv', '111', null, 'NaN', '1-2人', '1', '0', '0', '0', '0', '', ' ', null);
INSERT INTO `main_customization` VALUES ('i4mlgval0000cbw4', '111', null, '1111', '1-2人', '1', '0', '0', '0', '0', '', ' ', null);

-- ----------------------------
-- Table structure for `main_document_content`
-- ----------------------------
DROP TABLE IF EXISTS `main_document_content`;
CREATE TABLE `main_document_content` (
  `id` char(16) NOT NULL,
  `document_id` char(16) NOT NULL,
  `content` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of main_document_content
-- ----------------------------

-- ----------------------------
-- Table structure for `main_dress`
-- ----------------------------
DROP TABLE IF EXISTS `main_dress`;
CREATE TABLE `main_dress` (
  `id` char(16) CHARACTER SET utf8 NOT NULL,
  `name` varchar(16) CHARACTER SET utf8 NOT NULL,
  `gender` tinyint(4) NOT NULL,
  `dress_type` tinyint(4) NOT NULL DEFAULT '1',
  `price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `color_type` char(16) DEFAULT NULL,
  `brand_id` char(16) DEFAULT NULL,
  `status` tinyint(4) NOT NULL,
  `main_dress_picture_id` char(16) DEFAULT '1',
  `city_id` char(16) DEFAULT NULL,
  `multi_type` tinyint(4) DEFAULT NULL,
  `home_page_index` smallint(6) DEFAULT NULL,
  `channel_index` smallint(6) DEFAULT NULL,
  `sex` tinyint(4) DEFAULT NULL,
  `collar_type` tinyint(4) DEFAULT NULL,
  `peplum_type` tinyint(4) DEFAULT NULL,
  `shop_id` char(16) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of main_dress
-- ----------------------------
INSERT INTO `main_dress` VALUES ('i2y3o4ci00002ujx', 'dress', '1', '2', '55.00', null, 'asdefrgt2514hjk1', '1', 'i43tuf360000822c', '1234567891111113', null, null, null, null, '1', '1', null);
INSERT INTO `main_dress` VALUES ('i31ifsbr0000g0sy', 'dress001', '2', '3', '3.00', null, 'asdefrgt2514hjk1', '1', 'i43tuf360000822c', '1234567891111113', null, null, null, null, '2', '2', null);
INSERT INTO `main_dress` VALUES ('i3tjf8a7000033is', 'agent', '1', '2', '3.00', null, 'i2l6e51k0000bnr5', '1', 'i43tuf360000822c', '1236547891159753', null, '0', '0', null, '3', '3', null);
INSERT INTO `main_dress` VALUES ('i3tk0ev100003wbr', 'dress002', '1', '1', '333.00', null, 'i2l6e51k0000bnr5', '1', 'i43tuf360000822c', '1236547891159753', null, '0', '0', null, '4', '4', null);
INSERT INTO `main_dress` VALUES ('i46qadqb0000kprs', '小西服', '1', '3', '299.00', null, 'i2l6k6qx0000b7y9', '1', 'i46qaqm40000j8n9', '1236547891159753', null, '0', '0', null, '5', '5', 'i46ov3b20000dmt7');
INSERT INTO `main_dress` VALUES ('i4mopxbl0000fm2h', '浪漫旅程', '2', '2', '800.00', null, 'i31ijibw00006dly', '1', 'i4moqrhs0000clr3', '1236547891159753', null, '0', '0', null, '3', '3', 'i46ov3b20000dmt7');
INSERT INTO `main_dress` VALUES ('kjhnughfkmnbl451', 'kok', '1', '1', '4.00', 'sa', 'sad', '1', 'i43tuf360000822c', '1234567891111112', null, null, null, null, '6', '6', null);
INSERT INTO `main_dress` VALUES ('sadjhg458rlj14jh', 'rgh', '2', '2', '3.00', 'sas', 'dsa', '1', 'i43tuf360000822c', '1234567891111112', null, null, null, null, '4', '4', null);
INSERT INTO `main_dress` VALUES ('sdferdcvg1025yhj', 'jka', '2', '1', '2.00', 'sa', 'asdefrgt2514hjk1', '0', 'i43tuf360000822c', '1236547891159753', null, null, null, null, '2', '2', null);
INSERT INTO `main_dress` VALUES ('shgfbjnk457plok', 'dsssf', '1', '2', '2.00', 'asa', 'asdefrgt2514hjk1', '1', 'i43tuf360000822c', '1236547891159753', null, null, null, null, '1', '1', null);

-- ----------------------------
-- Table structure for `main_dress_brand`
-- ----------------------------
DROP TABLE IF EXISTS `main_dress_brand`;
CREATE TABLE `main_dress_brand` (
  `status` tinyint(4) NOT NULL DEFAULT '1',
  `id` char(16) NOT NULL,
  `name` varchar(16) NOT NULL,
  `logo_url` char(64) NOT NULL,
  `description` varchar(256) NOT NULL,
  `address` varchar(128) NOT NULL,
  `header` varchar(16) NOT NULL,
  `phone` char(16) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of main_dress_brand
-- ----------------------------
INSERT INTO `main_dress_brand` VALUES ('1', 'asdefrgt2514hjk1', 'anta', 'neite', 'asasas', '', '', '');
INSERT INTO `main_dress_brand` VALUES ('1', 'i2l6e51k0000bnr5', 'lining', 'qizi', 'yundong', '', '', '');
INSERT INTO `main_dress_brand` VALUES ('1', 'i2l6k6qx0000b7y9', 'nike', 'duigou', 'chacha', '', '', '');
INSERT INTO `main_dress_brand` VALUES ('0', 'i2l769w30000a4e6', 'KAMA', 'maoxian', 'KKMM', '', '', '');
INSERT INTO `main_dress_brand` VALUES ('0', 'i31ijibw00006dly', 'lala', 'alal', 'aall', '', '', '');

-- ----------------------------
-- Table structure for `main_dress_main_package`
-- ----------------------------
DROP TABLE IF EXISTS `main_dress_main_package`;
CREATE TABLE `main_dress_main_package` (
  `dress_id` char(16) NOT NULL,
  `order_id` char(16) NOT NULL,
  PRIMARY KEY (`dress_id`,`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of main_dress_main_package
-- ----------------------------

-- ----------------------------
-- Table structure for `main_dress_order_purchase_order`
-- ----------------------------
DROP TABLE IF EXISTS `main_dress_order_purchase_order`;
CREATE TABLE `main_dress_order_purchase_order` (
  `dress_id` char(16) NOT NULL,
  `order_id` char(16) NOT NULL,
  PRIMARY KEY (`dress_id`,`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of main_dress_order_purchase_order
-- ----------------------------
INSERT INTO `main_dress_order_purchase_order` VALUES ('i2y3o4ci00002ujx', 'i2d4b43f00005ikh');
INSERT INTO `main_dress_order_purchase_order` VALUES ('i2zkwmg60000hwjz', 'i2pkh4wt0000du4p');
INSERT INTO `main_dress_order_purchase_order` VALUES ('i2zkwmg60000hwjz', 'i2pwy9lk00000s2j');
INSERT INTO `main_dress_order_purchase_order` VALUES ('i2zot7if0000gr7c', 'i2px39v600004odt');
INSERT INTO `main_dress_order_purchase_order` VALUES ('i2zp2f5v00006v38', 'i2px41l90000b8ac');
INSERT INTO `main_dress_order_purchase_order` VALUES ('i2zpb6dv0000b7yb', 'i2px73w30000jcp7');
INSERT INTO `main_dress_order_purchase_order` VALUES ('i2zpb6dv0000b7yb', 'i2pxzba30000e5hs');
INSERT INTO `main_dress_order_purchase_order` VALUES ('i2zpgstr00002hsi', 'i2py9rzh00008s82');
INSERT INTO `main_dress_order_purchase_order` VALUES ('i2zrhrom00006pa5', 'i2pye7ej0000119q');
INSERT INTO `main_dress_order_purchase_order` VALUES ('i2zt71kz000025of', 'i2pynj0q0000gq7w');
INSERT INTO `main_dress_order_purchase_order` VALUES ('i2zt71kz000025of', 'i2pyyy1c0000dov9');
INSERT INTO `main_dress_order_purchase_order` VALUES ('i300nfqb00005xzn', 'i2pzgfrc000062a7');
INSERT INTO `main_dress_order_purchase_order` VALUES ('i3l0615t0000b9b2', 'i2pzilaz0000hw09');
INSERT INTO `main_dress_order_purchase_order` VALUES ('i3l06d630000lc9f', 'i2q0xrbh000076sf');
INSERT INTO `main_dress_order_purchase_order` VALUES ('i3l06f1z0000gdo3', 'i2q10zvs0000lbx1');
INSERT INTO `main_dress_order_purchase_order` VALUES ('i3l06fo700005rfq', 'i2q23cin00006bf1');
INSERT INTO `main_dress_order_purchase_order` VALUES ('i3l06g400000guaa', 'i2q3ejjs0000go51');
INSERT INTO `main_dress_order_purchase_order` VALUES ('i3l06gmz0000kwb5', 'i2q3fem40000a5yy');
INSERT INTO `main_dress_order_purchase_order` VALUES ('i3l06gvy000011c8', 'i2q3hcmz0000di68');
INSERT INTO `main_dress_order_purchase_order` VALUES ('i3l06h6n0000bbdf', 'i2q3hw4k00000c8i');
INSERT INTO `main_dress_order_purchase_order` VALUES ('i3l06hdr0000apbf', 'i2q41a1d0000cwry');
INSERT INTO `main_dress_order_purchase_order` VALUES ('i3l06hpv0000ikdj', 'i2q42d6y0000eqb8');
INSERT INTO `main_dress_order_purchase_order` VALUES ('i3l06i2500009rkv', 'i2pkh4wt0000du4p');
INSERT INTO `main_dress_order_purchase_order` VALUES ('i3l06i7f0000axn5', 'i2pwy9lk00000s2j');
INSERT INTO `main_dress_order_purchase_order` VALUES ('i3l06idh00000vdk', 'i2px39v600004odt');
INSERT INTO `main_dress_order_purchase_order` VALUES ('i3l06iup00001h7c', 'i2q3fem40000a5yy');
INSERT INTO `main_dress_order_purchase_order` VALUES ('i3l06j85000038bj', 'i2q3hcmz0000di68');
INSERT INTO `main_dress_order_purchase_order` VALUES ('i3l06js200005gux', 'i2q3hw4k00000c8i');
INSERT INTO `main_dress_order_purchase_order` VALUES ('i3l06kid000054of', 'i2py9rzh00008s82');
INSERT INTO `main_dress_order_purchase_order` VALUES ('i3l06l0g0000ix6b', 'i2pye7ej0000119q');
INSERT INTO `main_dress_order_purchase_order` VALUES ('i3l06std0000cc10', 'i2pynj0q0000gq7w');
INSERT INTO `main_dress_order_purchase_order` VALUES ('i3l06td60000ex1m', 'i2pyyy1c0000dov9');
INSERT INTO `main_dress_order_purchase_order` VALUES ('i3l06tqp0000co71', 'i2pzgfrc000062a7');
INSERT INTO `main_dress_order_purchase_order` VALUES ('i3l06u2b0000l8yl', 'i2pzilaz0000hw09');
INSERT INTO `main_dress_order_purchase_order` VALUES ('i3l06udj00007f14', 'i2q0xrbh000076sf');
INSERT INTO `main_dress_order_purchase_order` VALUES ('i3l06ujc00002dlk', 'i2q10zvs0000lbx1');
INSERT INTO `main_dress_order_purchase_order` VALUES ('i3l06uty00009j67', 'i2q23cin00006bf1');
INSERT INTO `main_dress_order_purchase_order` VALUES ('i3qok3c0000090oi', 'shgfbjnk457plok');
INSERT INTO `main_dress_order_purchase_order` VALUES ('i3qtsb3l0000i1nc', 'sdferdcvg1025yhj');
INSERT INTO `main_dress_order_purchase_order` VALUES ('i3qtsb3l0000i1nc', 'shgfbjnk457plok');
INSERT INTO `main_dress_order_purchase_order` VALUES ('i3tjf8a7000033is', '11111');
INSERT INTO `main_dress_order_purchase_order` VALUES ('i3tjf8a7000033is', 'i2pkh4wt0000du4p');
INSERT INTO `main_dress_order_purchase_order` VALUES ('i3tk0ev100003wbr', '11111');
INSERT INTO `main_dress_order_purchase_order` VALUES ('i3tk0ev100003wbr', 'i2pkh4wt0000du4p');
INSERT INTO `main_dress_order_purchase_order` VALUES ('i3toj7i30000ihp6', 'shgfbjnk457plok');
INSERT INTO `main_dress_order_purchase_order` VALUES ('i3trt9ay0000hcfc', 'sdferdcvg1025yhj');
INSERT INTO `main_dress_order_purchase_order` VALUES ('i3trt9ay0000hcfc', 'shgfbjnk457plok');
INSERT INTO `main_dress_order_purchase_order` VALUES ('i3za1k4s0000hch7', 'i3tk0ev100003wbr');
INSERT INTO `main_dress_order_purchase_order` VALUES ('i45eolvl00009q20', 'i3tjf8a7000033is');
INSERT INTO `main_dress_order_purchase_order` VALUES ('i45eolvl00009q20', 'i3tk0ev100003wbr');
INSERT INTO `main_dress_order_purchase_order` VALUES ('i45eolvl00009q20', 'sdferdcvg1025yhj');
INSERT INTO `main_dress_order_purchase_order` VALUES ('i45eolvl00009q20', 'shgfbjnk457plok');
INSERT INTO `main_dress_order_purchase_order` VALUES ('i4gr48db0000dmwo', 'i3tjf8a7000033is');
INSERT INTO `main_dress_order_purchase_order` VALUES ('i4gr48db0000dmwo', 'i46qadqb0000kprs');
INSERT INTO `main_dress_order_purchase_order` VALUES ('i4gr48db0000dmwo', 'sdferdcvg1025yhj');
INSERT INTO `main_dress_order_purchase_order` VALUES ('i4gr48db0000dmwo', 'shgfbjnk457plok');

-- ----------------------------
-- Table structure for `main_dress_picture`
-- ----------------------------
DROP TABLE IF EXISTS `main_dress_picture`;
CREATE TABLE `main_dress_picture` (
  `id` char(16) NOT NULL,
  `dress_id` char(16) NOT NULL,
  `url` varchar(128) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of main_dress_picture
-- ----------------------------
INSERT INTO `main_dress_picture` VALUES ('i43tuf360000822c', 'shgfbjnk457plok', 'dress/shgfbjnk457plok/u=582472113,2301912914&fm=23&gp=0.jpg');
INSERT INTO `main_dress_picture` VALUES ('i43txhmr00000lpw', 'shgfbjnk457plok', 'dress/shgfbjnk457plok/u=3106963979,3281159148&fm=23&gp=0.jpg');
INSERT INTO `main_dress_picture` VALUES ('i43u1ga7000078sd', 'shgfbjnk457plok', 'dress/shgfbjnk457plok/Filedata');
INSERT INTO `main_dress_picture` VALUES ('i43ug06c0000e5dl', 'shgfbjnk457plok', 'dress/shgfbjnk457plok/Filedata');
INSERT INTO `main_dress_picture` VALUES ('i43uoid50000dqdv', 'shgfbjnk457plok', 'dress/shgfbjnk457plok/Filedata');
INSERT INTO `main_dress_picture` VALUES ('i43uu6dq0000ep7m', 'shgfbjnk457plok', 'dress/shgfbjnk457plok/Filedata');
INSERT INTO `main_dress_picture` VALUES ('i43uus9z000052d1', 'shgfbjnk457plok', 'dress/shgfbjnk457plok/Filedata');
INSERT INTO `main_dress_picture` VALUES ('i4551yvf00003raq', 'shgfbjnk457plok', 'dress/shgfbjnk457plok/i4551ykzl46mdress0001.jpg');
INSERT INTO `main_dress_picture` VALUES ('i46qaqm40000j8n9', 'i46qadqb0000kprs', 'dress/i46qadqb0000kprs/i46qaqbmh12pdress0001.jpg');
INSERT INTO `main_dress_picture` VALUES ('i4jqof8b0000kkx9', 'i3tjf8a7000033is', 'dress/i3tjf8a7000033is/i4jqoexmih37dress0001.jpg');
INSERT INTO `main_dress_picture` VALUES ('i4moqrhs0000clr3', 'i4mopxbl0000fm2h', 'dress/i4mopxbl0000fm2h/i4moqqxr15tf11.jpg');

-- ----------------------------
-- Table structure for `main_group_shot`
-- ----------------------------
DROP TABLE IF EXISTS `main_group_shot`;
CREATE TABLE `main_group_shot` (
  `id` char(16) NOT NULL,
  `group_shot_template_id` char(16) NOT NULL,
  `address_type` tinyint(4) DEFAULT NULL,
  `city_id` char(16) NOT NULL,
  `area` varchar(64) NOT NULL,
  `address` varchar(64) NOT NULL,
  `create_date_time` datetime NOT NULL,
  `time` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of main_group_shot
-- ----------------------------
INSERT INTO `main_group_shot` VALUES ('i45dxy9c0000iuve', 'i42bxhw30000dxpl', '1', '1236547891159753', 'soho', '三里屯街道', '2014-12-26 17:57:12', '2014-12-09');
INSERT INTO `main_group_shot` VALUES ('i46df7dr00002inf', 'i42bxhw30000dxpl', '1', '1236547891159753', '随便填', '随便填', '2014-12-27 10:30:24', '2014-12-30');
INSERT INTO `main_group_shot` VALUES ('i46dik500000ibz3', 'i42bxhw30000dxpl', '2', '1236547891159753', '随便填', '三里屯街道', '2014-12-27 10:33:01', '2014-12-31');

-- ----------------------------
-- Table structure for `main_group_shot_template`
-- ----------------------------
DROP TABLE IF EXISTS `main_group_shot_template`;
CREATE TABLE `main_group_shot_template` (
  `id` char(16) NOT NULL,
  `name` varchar(32) DEFAULT NULL,
  `type` tinyint(4) DEFAULT NULL,
  `amount_limit` tinyint(4) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of main_group_shot_template
-- ----------------------------
INSERT INTO `main_group_shot_template` VALUES ('i42bxhw30000dxpl', '半身证件照开拍了', '1', '30', '21.00', '1');

-- ----------------------------
-- Table structure for `main_package`
-- ----------------------------
DROP TABLE IF EXISTS `main_package`;
CREATE TABLE `main_package` (
  `id` char(16) NOT NULL,
  `name` varchar(16) CHARACTER SET utf8 NOT NULL,
  `price` int(11) NOT NULL,
  `home_page_index` smallint(6) DEFAULT NULL,
  `channel_index` smallint(6) DEFAULT NULL,
  `ptype` tinyint(4) NOT NULL,
  `description` text CHARACTER SET utf8,
  `grade` tinyint(4) DEFAULT NULL,
  `scene_number` smallint(6) DEFAULT NULL,
  `dress_number` smallint(6) DEFAULT NULL,
  `style` tinyint(4) DEFAULT NULL,
  `cityId` char(16) DEFAULT NULL,
  `url` text CHARACTER SET utf8,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of main_package
-- ----------------------------
INSERT INTO `main_package` VALUES ('i3zh1l4g0000at89', '邂逅浪漫', '4999', '0', '0', '2', '浪漫是爱人不经意的爱抚，浪漫是历久弥新的情感进程，约拍啦高级摄影师带你回味爱情中的浪漫与温馨，无论你喜欢哪种stlye，约拍啦都会让你与浪漫邂逅。', '2', '5', '5', '1', '1236547891159753', null);
INSERT INTO `main_package` VALUES ('i40octoe000018wy', '一生挚爱', '7999', '1', '1', '2', '当决定与你携手共度人生的时候，你就是我的一生挚爱。约拍啦资深摄影师与造型师全程跟拍，多种造型随意选择，最好的服务，给挚爱的你。', '3', '10', '6', '1', '1236547891159753', null);
INSERT INTO `main_package` VALUES ('i40oewon00009um2', '在水一方', '2999', '1', '1', '2', '蒹葭苍苍，白露为霜，所谓伊人，在水一方。约拍啦签约摄影师创意掌镜，让你在快乐中享受爱的美好。', '2', '4', '4', '1', '1236547891159753', null);
INSERT INTO `main_package` VALUES ('i4nkpfk700006s66', '天长地久', '15999', null, null, '2', '最浪漫的表白是陪伴，最珍贵的礼物是岁月。愿得一心人，白首不相离，约拍啦懂你们的挚爱与欢乐，金牌总监团队携手打造最奢华完美套餐，海量内容金牌服务，一生相伴之旅从约拍啦开始，天长地久。', '5', '15', '8', null, null, null);
INSERT INTO `main_package` VALUES ('i4nkuh1c0000f85t', '匆匆那年', '988', null, null, '1', '时光易老，韶华易逝，匆匆那年，我们褪去了青涩，换上了红妆。时间带走了我们的稚气，约拍啦用相册和影像，记录那些年我们美好的年华。', '2', '4', '3', null, null, null);
INSERT INTO `main_package` VALUES ('i4nkx3e700004bt2', '光影年华', '1688', null, null, '1', '年轻，最无法忍受的就是一成不变。美丽的风格那么多，我们总想换一换。无论是小清新还是复古范儿，你的style都能在这里找到。光影年华，属于你的摄影衣橱。', '3', '6', '4', null, null, null);
INSERT INTO `main_package` VALUES ('i4nl0g0t0000hs7n', '时尚嘉人', '2288', null, null, '1', '不从众，不妥协，这是我的要求，也是我的范儿。如果人生是一场戏剧，我一定要最独特的美丽。约拍啦摄影造型团队，为你打造专属美丽。', '3', '6', '5', null, null, null);
INSERT INTO `main_package` VALUES ('i4nl2hz40000g8xk', '魅力无限', '3988', null, null, '1', '魅力源于自信，更源于专业发现美的团队！首席摄影师倾力拍摄，时尚造型师全程跟妆，让你每一刻都自信满满，魅力无限！', '3', '8', '6', null, null, null);
INSERT INTO `main_package` VALUES ('i4nl401n00000g96', '金色年华', '8988', null, null, '1', '闪耀的人生离不开美丽，属于你的金色年华中，有约拍啦摄影总监诚意掌镜拍摄，特级造型师跟妆打造，让你的年华从此闪耀！', '4', '9', '6', null, null, null);
INSERT INTO `main_package` VALUES ('i4nl5uzf00008qr4', '奢华人生', '12988', null, null, '1', '奢华，不是堆砌，而是美的极致。约拍啦致力于让拍摄成为艺术，2个工作日的定制拍摄，无数个美丽瞬间全部把握，顶级拍摄团队全方位服务，打造极致完美写真套餐！', '5', '15', '10', null, null, null);
INSERT INTO `main_package` VALUES ('s', '让爱永恒', '10999', '0', '0', '2', '我欲与君相知，长命无绝衰。如果爱是一种信仰，约拍啦就是这种信仰虔诚的教徒，首席摄影师团队倾力打造，让你们的爱在镜头下永恒。', '4', '12', '7', '1', '1236547891159753', null);

-- ----------------------------
-- Table structure for `main_package_picture`
-- ----------------------------
DROP TABLE IF EXISTS `main_package_picture`;
CREATE TABLE `main_package_picture` (
  `id` char(16) NOT NULL,
  `package_id` char(16) DEFAULT NULL,
  `url` char(64) DEFAULT NULL,
  `order_number` int(6) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of main_package_picture
-- ----------------------------
INSERT INTO `main_package_picture` VALUES ('i4jlh7mj0000bixm', 'i40oewon00009um2', 'image/package/i40oewon00009um2/i4jlh7by9ajiscene01.jpg', '2');
INSERT INTO `main_package_picture` VALUES ('i4jllxbe0000f7yl', 'i3zh1l4g0000at89', 'image/package/i3zh1l4g0000at89/i4jllx34eh6iscene01.jpg', '1');
INSERT INTO `main_package_picture` VALUES ('i4kxilcc000017lo', 's', 'image/package/s/i4kxil09hyuhdress0001.jpg', '1');

-- ----------------------------
-- Table structure for `main_photo_frame`
-- ----------------------------
DROP TABLE IF EXISTS `main_photo_frame`;
CREATE TABLE `main_photo_frame` (
  `id` char(16) NOT NULL,
  `name` varchar(16) NOT NULL,
  `price` smallint(6) NOT NULL,
  `cover_picture_url` varchar(128) NOT NULL,
  `useful` varchar(16) NOT NULL,
  `size` char(16) NOT NULL,
  `photo_number` char(16) NOT NULL,
  `craft` varchar(256) NOT NULL,
  `material` char(16) NOT NULL,
  `photo_frame_provider_id` varchar(32) NOT NULL,
  `frame_type` tinyint(4) DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of main_photo_frame
-- ----------------------------
INSERT INTO `main_photo_frame` VALUES ('1', 'test', '11', 'scene/i3l62nl9000054yq/i3o80zxw5yx8u=876908222,2146973101&fm=21&gp=0.jpg', '', '', '', '', '', 'i2d30lym00008w6i', '1', null);
INSERT INTO `main_photo_frame` VALUES ('2', 'test2', '13', 'scene/i3l62nl9000054yq/i3o80zxw5yx8u=876908222,2146973101&fm=21&gp=0.jpg', '', '', '', '', '', 'i2d30lym00008w6i', '1', '0');

-- ----------------------------
-- Table structure for `main_photo_frame_main_package`
-- ----------------------------
DROP TABLE IF EXISTS `main_photo_frame_main_package`;
CREATE TABLE `main_photo_frame_main_package` (
  `frame_id` char(16) NOT NULL,
  `order_id` char(16) NOT NULL,
  PRIMARY KEY (`frame_id`,`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of main_photo_frame_main_package
-- ----------------------------

-- ----------------------------
-- Table structure for `main_photo_frame_order_purchase_order`
-- ----------------------------
DROP TABLE IF EXISTS `main_photo_frame_order_purchase_order`;
CREATE TABLE `main_photo_frame_order_purchase_order` (
  `frame_id` char(16) NOT NULL,
  `order_id` char(16) NOT NULL,
  PRIMARY KEY (`frame_id`,`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of main_photo_frame_order_purchase_order
-- ----------------------------

-- ----------------------------
-- Table structure for `main_photo_frame_picture`
-- ----------------------------
DROP TABLE IF EXISTS `main_photo_frame_picture`;
CREATE TABLE `main_photo_frame_picture` (
  `id` char(16) NOT NULL,
  `photo_frame_id` char(16) NOT NULL,
  `url` char(32) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of main_photo_frame_picture
-- ----------------------------

-- ----------------------------
-- Table structure for `main_photographer_arrangement`
-- ----------------------------
DROP TABLE IF EXISTS `main_photographer_arrangement`;
CREATE TABLE `main_photographer_arrangement` (
  `id` char(16) NOT NULL,
  `user_id` char(16) NOT NULL,
  `schedule_date` date NOT NULL,
  `date_status` int(11) NOT NULL,
  `date_type` int(11) DEFAULT NULL,
  `order_id` char(16) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of main_photographer_arrangement
-- ----------------------------
INSERT INTO `main_photographer_arrangement` VALUES ('i35mcw2m0000gik2', 'i39pzafo0000jckl', '2014-12-25', '0', null, null);
INSERT INTO `main_photographer_arrangement` VALUES ('i35md0e9000033dp', 'i39pzafo0000jckl', '2015-01-04', '1', null, null);
INSERT INTO `main_photographer_arrangement` VALUES ('i49bk1ts0000fw9l', 'i39pzafo0000jckl', '2014-12-01', '0', null, null);
INSERT INTO `main_photographer_arrangement` VALUES ('i49bk2ni0000j0ay', 'i39pzafo0000jckl', '2014-12-02', '0', null, null);
INSERT INTO `main_photographer_arrangement` VALUES ('i49bk5oy000016l0', 'i39pzafo0000jckl', '2014-12-29', '1', null, null);
INSERT INTO `main_photographer_arrangement` VALUES ('i49bk69z0000eywj', 'i39pzafo0000jckl', '2014-12-30', '0', null, null);
INSERT INTO `main_photographer_arrangement` VALUES ('i49bkfwu00009wh5', 'i39pzafo0000jckl', '2015-01-26', '1', null, null);
INSERT INTO `main_photographer_arrangement` VALUES ('i49bkhax00009181', 'i39pzafo0000jckl', '2015-01-27', '1', null, null);
INSERT INTO `main_photographer_arrangement` VALUES ('i49bkmtz0000awye', 'i39pzafo0000jckl', '2015-02-23', '0', null, null);
INSERT INTO `main_photographer_arrangement` VALUES ('i49bkori0000hrdf', 'i39pzafo0000jckl', '2015-03-02', '0', null, null);
INSERT INTO `main_photographer_arrangement` VALUES ('i49fdonq00003ss4', 'i39pzafo0000jckl', '2014-12-22', '1', null, null);
INSERT INTO `main_photographer_arrangement` VALUES ('i49nb6ps00004olz', 'i39pzafo0000jckl', '2014-08-21', '0', null, null);
INSERT INTO `main_photographer_arrangement` VALUES ('i4ax2qlg00007bob', 'i3jxkwv40000hcdm', '2014-12-29', '1', null, null);
INSERT INTO `main_photographer_arrangement` VALUES ('i4ax2rjj000039t8', 'i3jxkwv40000hcdm', '2014-12-30', '1', null, null);
INSERT INTO `main_photographer_arrangement` VALUES ('i4ax7bl90000b5b5', 'i3jxkwv40000hcdm', '2015-02-08', '0', null, null);
INSERT INTO `main_photographer_arrangement` VALUES ('i4ax7cy30000gjri', 'i3jxkwv40000hcdm', '2015-01-24', '1', null, null);
INSERT INTO `main_photographer_arrangement` VALUES ('i4ax7hgu00008nny', 'i3jxkwv40000hcdm', '2014-12-31', '0', null, null);
INSERT INTO `main_photographer_arrangement` VALUES ('i4ax7i1f00001o01', 'i3jxkwv40000hcdm', '2015-01-01', '0', null, null);
INSERT INTO `main_photographer_arrangement` VALUES ('i4ax7rpk00001g0e', 'i3jxkwv40000hcdm', '2015-02-07', '1', null, null);
INSERT INTO `main_photographer_arrangement` VALUES ('i4ax7sby00003gqa', 'i3jxkwv40000hcdm', '2015-01-23', '0', null, null);
INSERT INTO `main_photographer_arrangement` VALUES ('i4ax7ter0000it7e', 'i3jxkwv40000hcdm', '2015-01-25', '1', null, null);
INSERT INTO `main_photographer_arrangement` VALUES ('i4ax7tt800001z8x', 'i3jxkwv40000hcdm', '2015-01-26', '1', null, null);
INSERT INTO `main_photographer_arrangement` VALUES ('i4ax7u8u0000b5wj', 'i3jxkwv40000hcdm', '2015-01-27', '0', null, null);
INSERT INTO `main_photographer_arrangement` VALUES ('i4ax7usq0000hlez', 'i3jxkwv40000hcdm', '2015-01-28', '0', null, null);
INSERT INTO `main_photographer_arrangement` VALUES ('i4ax7v7s00000q6f', 'i3jxkwv40000hcdm', '2015-01-29', '0', null, null);
INSERT INTO `main_photographer_arrangement` VALUES ('i4ax7w7j0000lc04', 'i3jxkwv40000hcdm', '2015-01-31', '0', null, null);
INSERT INTO `main_photographer_arrangement` VALUES ('i4ax7wi800000u2o', 'i3jxkwv40000hcdm', '2015-01-30', '0', null, null);
INSERT INTO `main_photographer_arrangement` VALUES ('i4gr1ogi00006m6z', 'i3juelfi0000ek21', '2015-01-03', '2', null, 'i4gr1oer00009cr7');
INSERT INTO `main_photographer_arrangement` VALUES ('i4j9qw5h000041ar', 'i39pzafo0000jckl', '2015-01-01', '1', null, null);
INSERT INTO `main_photographer_arrangement` VALUES ('i4j9qwqv0000k2zx', 'i39pzafo0000jckl', '2014-12-31', '0', null, null);
INSERT INTO `main_photographer_arrangement` VALUES ('i4kq1oip0000gqxf', 'i39pzafo0000jckl', '2015-02-08', '1', null, null);
INSERT INTO `main_photographer_arrangement` VALUES ('i4kqd4wg0000570t', 'i3jxkwv40000hcdm', '2015-01-22', '0', null, null);
INSERT INTO `main_photographer_arrangement` VALUES ('i4kqd68l0000d77p', 'i3jxkwv40000hcdm', '2015-01-21', '1', null, null);
INSERT INTO `main_photographer_arrangement` VALUES ('i4kx24vh0000kuem', 'i39pzafo0000jckl', '2015-01-16', '0', null, null);
INSERT INTO `main_photographer_arrangement` VALUES ('i4mbx9630000d4eo', 'i3juelfi0000ek21', '2015-01-07', '2', null, 'i4mbx93t0000i1qc');

-- ----------------------------
-- Table structure for `main_photographer_style_type`
-- ----------------------------
DROP TABLE IF EXISTS `main_photographer_style_type`;
CREATE TABLE `main_photographer_style_type` (
  `id` char(16) NOT NULL,
  `style` tinyint(4) NOT NULL,
  `ptype` tinyint(4) NOT NULL,
  `photographer_id` char(16) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `grade` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of main_photographer_style_type
-- ----------------------------
INSERT INTO `main_photographer_style_type` VALUES ('1234567890123456', '11', '1', 'i2qymm8r00003hau', '3231.00', '0');
INSERT INTO `main_photographer_style_type` VALUES ('i3gnrqh20000kx9n', '1', '1', 'i3450btg0000763x', '21.00', '0');
INSERT INTO `main_photographer_style_type` VALUES ('i3gnseln000012dk', '1', '1', 'i3450btg0000763x', '11.00', '0');
INSERT INTO `main_photographer_style_type` VALUES ('i3jx684v0000g5dl', '2', '1', 'i3450btg0000763x', '11.00', '0');
INSERT INTO `main_photographer_style_type` VALUES ('i3kyyl3r0000btas', '2', '2', 'i3jxkwv40000hcdm', '123456.00', '0');
INSERT INTO `main_photographer_style_type` VALUES ('i3l506l200008dzi', '1', '1', 'i3jxkwv40000hcdm', '123456.00', '0');
INSERT INTO `main_photographer_style_type` VALUES ('i3l7gcaz0000jp4b', '1', '2', 'i3jxkwv40000hcdm', '123456.00', '0');

-- ----------------------------
-- Table structure for `main_photographer_type_price`
-- ----------------------------
DROP TABLE IF EXISTS `main_photographer_type_price`;
CREATE TABLE `main_photographer_type_price` (
  `id` char(16) NOT NULL,
  `photographer_id` char(16) DEFAULT NULL,
  `ptype` tinyint(4) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `grade` tinyint(4) DEFAULT NULL,
  `home_page_index` smallint(8) DEFAULT NULL,
  `channel_index` smallint(8) DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of main_photographer_type_price
-- ----------------------------
INSERT INTO `main_photographer_type_price` VALUES ('0987654321123456', 'i2d4b43f00005ikh', '1', '0.01', '1', '88', '2', '1');
INSERT INTO `main_photographer_type_price` VALUES ('i39k2gkt00009jha', 'i2d30lym00008w6i', '1', '1111.00', '1', '111', '8', '1');
INSERT INTO `main_photographer_type_price` VALUES ('i39kh9pu000042r9', 'i2d4b43f00005ikh', '2', '1112.00', '4', null, null, '1');
INSERT INTO `main_photographer_type_price` VALUES ('i39lb5mn00004a9g', 'i2d4redz00003y5i', '2', '111.00', '1', null, null, '1');
INSERT INTO `main_photographer_type_price` VALUES ('i39lfkmo0000l4dj', 'i2d50ukz0000e98n', '2', '111.00', '1', '95', '3', '1');
INSERT INTO `main_photographer_type_price` VALUES ('i39pqjcf00006956', 'i2ffpja5000088bj', '2', '120.00', '1', '92', '85', '1');
INSERT INTO `main_photographer_type_price` VALUES ('i39q51kn0000ik8s', 'i2ffui540000fzk9', '2', '111.00', '1', '113', '6', '1');
INSERT INTO `main_photographer_type_price` VALUES ('i3awwrmg0000gmiy', 'i2fv3h0x0000di0q', '2', '120.00', '1', null, null, '1');
INSERT INTO `main_photographer_type_price` VALUES ('i3ax0ozg0000a8me', 'i2fzvrim00000wgt', '2', '1111.00', '1', null, null, '1');
INSERT INTO `main_photographer_type_price` VALUES ('i3ax0uwr0000dr5g', 'i2h76wnq00006fi9', '2', '10000.00', '0', null, null, '1');
INSERT INTO `main_photographer_type_price` VALUES ('i3ax1nga0000j30b', 'i2jzlwvr00001ru4', '2', '500.00', '7', null, null, '1');
INSERT INTO `main_photographer_type_price` VALUES ('i3b7rzqh0000dlwq', 'i3jxkwv40000hcdm', '2', '1000.00', '0', null, null, '1');
INSERT INTO `main_photographer_type_price` VALUES ('i3ba4g950000a56l', 'i2l7zvs500009pr1', '2', '554.00', '1', null, null, '1');
INSERT INTO `main_photographer_type_price` VALUES ('i3ba4of90000b7km', 'i2ledkkc00006ky2', '2', '78.00', '1', null, null, '1');
INSERT INTO `main_photographer_type_price` VALUES ('i3cx5l6800004s54', 'i3jxkwv40000hcdm', '1', '1000.00', '1', null, null, '1');
INSERT INTO `main_photographer_type_price` VALUES ('i3cx5y040000khh2', 'i3jxkwv40000hcdm', '13', '1001.00', '1', null, null, '0');
INSERT INTO `main_photographer_type_price` VALUES ('i3d2tcnm00000exq', 'i3jxkwv40000hcdm', '11', '1100.00', '1', null, null, '1');
INSERT INTO `main_photographer_type_price` VALUES ('i3fapau8000014ma', 'i2px44kk0000916n', '2', '1111.00', '1', null, null, '1');
INSERT INTO `main_photographer_type_price` VALUES ('i3fapf8t0000de4o', 'i2qymm8r00003hau', '1', '3231.00', '0', '1135', null, '1');
INSERT INTO `main_photographer_type_price` VALUES ('i3fapj0a0000e1s4', 'i2vpugci00005ns5', '2', '3213.00', '1', null, null, '1');
INSERT INTO `main_photographer_type_price` VALUES ('i3fapnbi0000gjdy', 'i3450btg0000763y', '1', '321321.00', '1', '1136', null, '1');
INSERT INTO `main_photographer_type_price` VALUES ('i3faprup00008q4q', 'i39pzafo0000jckl', '2', '1200.00', '0', '116', '5', '1');
INSERT INTO `main_photographer_type_price` VALUES ('i3fapvhx0000gxtk', 'i3fa7rjt00008xph', '2', '222.00', '1', '1126', null, '1');
INSERT INTO `main_photographer_type_price` VALUES ('i3faq0090000cp12', 'i3fa8rw80000egx4', '1', '321.00', '0', '1139', null, '1');
INSERT INTO `main_photographer_type_price` VALUES ('i3faq3kk0000ijrn', 'i3fa8zbk0000cggs', '2', '333.00', '1', null, null, '1');
INSERT INTO `main_photographer_type_price` VALUES ('i3faq77y0000hf3v', 'i3fa96fw0000e7us', '1', '222.00', '0', '1145', null, '1');
INSERT INTO `main_photographer_type_price` VALUES ('i3fibmud0000hl1j', 'i3fa96fw0000e7us', '2', '12000.00', '5', null, null, '1');
INSERT INTO `main_photographer_type_price` VALUES ('i3imx6ev0000a6fi', 'i3fa96fw0000e7us', '2', '7878.00', '7', '1149', null, '1');
INSERT INTO `main_photographer_type_price` VALUES ('i3jx62l200001gns', 'i3fa96fw0000e7us', '1', '11.00', '0', null, null, '1');
INSERT INTO `main_photographer_type_price` VALUES ('i49hj0tt0000glth', 'i39pzafo0000jckl', '1', '1200.00', '0', null, '5', '1');
INSERT INTO `main_photographer_type_price` VALUES ('i49hj0v00000cnq3', 'i39pzafo0000jckl', '11', '1200.00', '0', '117', '4', '0');
INSERT INTO `main_photographer_type_price` VALUES ('i4jp78bo0000ex9m', 'i39pzafo0000jckl', '13', '1000.00', null, null, null, '1');

-- ----------------------------
-- Table structure for `main_photographer_work`
-- ----------------------------
DROP TABLE IF EXISTS `main_photographer_work`;
CREATE TABLE `main_photographer_work` (
  `id` char(16) NOT NULL,
  `photographer_id` char(16) NOT NULL,
  `works` varchar(500) NOT NULL,
  `content` text NOT NULL,
  `cover` varchar(32) NOT NULL,
  `photographer_type_price_id` char(16) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of main_photographer_work
-- ----------------------------
INSERT INTO `main_photographer_work` VALUES ('asdfb12345asdfga', 'sassdf5241lpok25', 'work1', 'asdfb12345asdfgl', '/images/work1.jpg', 'asdfb12345asdfgl');
INSERT INTO `main_photographer_work` VALUES ('asdfb12345asdfgl', 'sassdf5241lpok25', 'work1', 'asdfb12345asdfgl', '/images/work1.jpg', 'asdfb12345asdfgl');

-- ----------------------------
-- Table structure for `main_place`
-- ----------------------------
DROP TABLE IF EXISTS `main_place`;
CREATE TABLE `main_place` (
  `id` char(16) NOT NULL,
  `memo` varchar(32) DEFAULT NULL,
  `name` varchar(16) NOT NULL,
  `city_id` char(16) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `cover_picture_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of main_place
-- ----------------------------
INSERT INTO `main_place` VALUES ('sdfr2541hjug41li', 'good place', 'place one', '1236547891159753', '1', null);

-- ----------------------------
-- Table structure for `main_sample_photo`
-- ----------------------------
DROP TABLE IF EXISTS `main_sample_photo`;
CREATE TABLE `main_sample_photo` (
  `id` char(16) NOT NULL,
  `name` varchar(128) CHARACTER SET utf8 NOT NULL,
  `photo_type` char(6) NOT NULL,
  `version` smallint(6) NOT NULL,
  `praise_count` int(11) NOT NULL,
  `url` char(128) CHARACTER SET utf8 NOT NULL,
  `sample_photo_group_id` char(16) NOT NULL,
  `status` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of main_sample_photo
-- ----------------------------
INSERT INTO `main_sample_photo` VALUES ('i3co1h7x000078ha', '201411071325486.jpg', 'aa', '1', '0', 'http://sp.yuepaila.com/i3bctgfz00000hvu/201411071325486.jpg', 'i3bctgfz00000hvu', '1');
INSERT INTO `main_sample_photo` VALUES ('i3co1hgj0000frq5', '2014110713253689.jpg', 'aa', '1', '0', 'http://sp.yuepaila.com/i3bctgfz00000hvu/2014110713253689.jpg', 'i3bctgfz00000hvu', '1');
INSERT INTO `main_sample_photo` VALUES ('i3cog4lv000053je', '2014110713255674.jpg', 'aa', '1', '0', 'http://sp.yuepaila.com/i39sd5kt000032d6/2014110713255674.jpg', 'i39sd5kt000032d6', '1');
INSERT INTO `main_sample_photo` VALUES ('i3coi87f00002x81', '2014110713260042.jpg', 'aa', '1', '0', 'http://sp.yuepaila.com/i39rjgje0000d3c8/2014110713260042.jpg', 'i39rjgje0000d3c8', '1');
INSERT INTO `main_sample_photo` VALUES ('i3cpd85r0000hcnr', '2014110713260314.jpg', 'aa', '1', '0', 'http://sp.yuepaila.com/i39r0pva0000iffw/2014110713260314.jpg', 'i39r0pva0000iffw', '1');
INSERT INTO `main_sample_photo` VALUES ('i3cpeegg0000d9lf', '2014110713260898.jpg', 'aa', '1', '0', 'http://sp.yuepaila.com/i39r0pva0000iffw/2014110713260898.jpg', 'i39r0pva0000iffw', '1');
INSERT INTO `main_sample_photo` VALUES ('i3crn9x00000his9', '2014110713254045.jpg', 'aa', '1', '0', 'http://sp.yuepaila.com/i3bctgfz00000hvu/2014110713254045.jpg', 'i3bctgfz00000hvu', '1');
INSERT INTO `main_sample_photo` VALUES ('i3cry9j600002s2o', '2014110713260314.jpg', 'aa', '1', '0', 'http://sp.yuepaila.com/i3bctgfz00000hvu/2014110713260314.jpg', 'i3bctgfz00000hvu', '1');
INSERT INTO `main_sample_photo` VALUES ('i3cs3vjl0000exrv', '201411071325486.jpg', 'aa', '1', '0', 'http://sp.yuepaila.com/i39rjgje0000d3c8/201411071325486.jpg', 'i39rjgje0000d3c8', '1');
INSERT INTO `main_sample_photo` VALUES ('i3csdz7z00009lzi', '2014110713254446.jpg', 'aa', '1', '0', 'http://sp.yuepaila.com/i39rjgje0000d3c8/2014110713254446.jpg', 'i39rjgje0000d3c8', '1');
INSERT INTO `main_sample_photo` VALUES ('i3ct6mt50000397r', '201411071325486.jpg', 'aa', '1', '0', 'http://sp.yuepaila.com/i39r0pva0000iffw/201411071325486.jpg', 'i39r0pva0000iffw', '1');
INSERT INTO `main_sample_photo` VALUES ('i3ct7ehl0000e65r', '2014110713254446.jpg', 'aa', '1', '0', 'http://sp.yuepaila.com/i39r0pva0000iffw/2014110713254446.jpg', 'i39r0pva0000iffw', '1');
INSERT INTO `main_sample_photo` VALUES ('i3ctam8j00004c6m', '2014110713255674.jpg', 'aa', '1', '0', 'http://sp.yuepaila.com/i39rjgje0000d3c8/2014110713255674.jpg', 'i39rjgje0000d3c8', '1');
INSERT INTO `main_sample_photo` VALUES ('i3ctcj4a0000hois', '2014110713260314.jpg', 'aa', '1', '0', 'http://sp.yuepaila.com/i39rjgje0000d3c8/2014110713260314.jpg', 'i39rjgje0000d3c8', '1');
INSERT INTO `main_sample_photo` VALUES ('i3cth9sl0000f8g7', '201411071325486.jpg', 'aa', '1', '0', 'http://sp.yuepaila.com/i3ctgson0000gat8/201411071325486.jpg', 'i3ctgson0000gat8', '1');
INSERT INTO `main_sample_photo` VALUES ('i3cthdi00000izod', '2014110713253689.jpg', 'aa', '1', '0', 'http://sp.yuepaila.com/i3ctgson0000gat8/2014110713253689.jpg', 'i3ctgson0000gat8', '1');
INSERT INTO `main_sample_photo` VALUES ('i3ctk5w60000cxfk', '2014110713255118.jpg', 'aa', '1', '0', 'http://sp.yuepaila.com/i3ctgson0000gat8/2014110713255118.jpg', 'i3ctgson0000gat8', '1');
INSERT INTO `main_sample_photo` VALUES ('i3ctk67u00005ald', '2014110713255674.jpg', 'aa', '1', '0', 'http://sp.yuepaila.com/i3ctgson0000gat8/2014110713255674.jpg', 'i3ctgson0000gat8', '1');
INSERT INTO `main_sample_photo` VALUES ('i3ctk6i30000b9sz', '2014110713260042.jpg', 'aa', '1', '0', 'http://sp.yuepaila.com/i3ctgson0000gat8/2014110713260042.jpg', 'i3ctgson0000gat8', '1');
INSERT INTO `main_sample_photo` VALUES ('i3ctk6pn0000kzeo', '2014110713260314.jpg', 'aa', '1', '0', 'http://sp.yuepaila.com/i3ctgson0000gat8/2014110713260314.jpg', 'i3ctgson0000gat8', '1');
INSERT INTO `main_sample_photo` VALUES ('i3cu2dnc000041zo', '2014110713255674.jpg', 'aa', '1', '0', 'http://sp.yuepaila.com/i3bctgfz00000hvu/2014110713255674.jpg', 'i3bctgfz00000hvu', '1');
INSERT INTO `main_sample_photo` VALUES ('i3cu2dwl00001ggd', '2014110713260898.jpg', 'aa', '1', '0', 'http://sp.yuepaila.com/i3bctgfz00000hvu/2014110713260898.jpg', 'i3bctgfz00000hvu', '1');
INSERT INTO `main_sample_photo` VALUES ('i3f9735e00003xvi', '201411071325486.jpg', 'aa', '1', '0', 'http://sp.yuepaila.com/i3f96x3l0000lb7v/201411071325486.jpg', 'i3f96x3l0000lb7v', '1');
INSERT INTO `main_sample_photo` VALUES ('i3f973dz0000aara', '2014110713253689.jpg', 'aa', '1', '0', 'http://sp.yuepaila.com/i3f96x3l0000lb7v/2014110713253689.jpg', 'i3f96x3l0000lb7v', '1');
INSERT INTO `main_sample_photo` VALUES ('i3f973nb0000e3ki', '2014110713254045.jpg', 'aa', '1', '0', 'http://sp.yuepaila.com/i3f96x3l0000lb7v/2014110713254045.jpg', 'i3f96x3l0000lb7v', '1');
INSERT INTO `main_sample_photo` VALUES ('i3f9y7fv0000j39a', '201411071325486.jpg', 'aa', '1', '0', 'http://sp.yuepaila.com/i3f9xwiy0000bsg5/201411071325486.jpg', 'i3f9xwiy0000bsg5', '1');
INSERT INTO `main_sample_photo` VALUES ('i3f9y7rq000030vj', '2014110713255118.jpg', 'aa', '1', '0', 'http://sp.yuepaila.com/i3f9xwiy0000bsg5/2014110713255118.jpg', 'i3f9xwiy0000bsg5', '1');
INSERT INTO `main_sample_photo` VALUES ('i3flk93o000013lr', '201411071325486.jpg', 'aa', '1', '0', 'http://sp.yuepaila.com/i3flhe6m00006n74/201411071325486.jpg', 'i3flhe6m00006n74', '1');
INSERT INTO `main_sample_photo` VALUES ('i3fmg5x70000hn2w', '2014110713255674.jpg', 'aa', '1', '0', 'http://sp.yuepaila.com/i3f96x3l0000lb7v/2014110713255674.jpg', 'i3f96x3l0000lb7v', '1');
INSERT INTO `main_sample_photo` VALUES ('i3fmi2vk0000idue', '2014110713260042.jpg', 'aa', '1', '0', 'http://sp.yuepaila.com/i3f96x3l0000lb7v/2014110713260042.jpg', 'i3f96x3l0000lb7v', '1');
INSERT INTO `main_sample_photo` VALUES ('i3fnxjbb0000ios8', '2014110713260314.jpg', 'aa', '1', '0', 'http://sp.yuepaila.com/i3f9xwiy0000bsg5/2014110713260314.jpg', 'i3f9xwiy0000bsg5', '1');
INSERT INTO `main_sample_photo` VALUES ('i3fobjh600000kkr', 'G56A8889 - 副本 (4).JPG', 'aa', '1', '0', 'http://sp.yuepaila.com/i3flhe6m00006n74/G56A8889 - 副本 (4).JPG', 'i3flhe6m00006n74', '1');
INSERT INTO `main_sample_photo` VALUES ('i3fobrbz00007zgr', 'G56A8889 - 副本 (5).JPG', 'aa', '1', '0', 'http://sp.yuepaila.com/i3flhe6m00006n74/G56A8889 - 副本 (5).JPG', 'i3flhe6m00006n74', '1');
INSERT INTO `main_sample_photo` VALUES ('i3fobyy400002ogz', 'G56A8889 - 副本 (6).JPG', 'aa', '1', '0', 'http://sp.yuepaila.com/i3flhe6m00006n74/G56A8889 - 副本 (6).JPG', 'i3flhe6m00006n74', '1');
INSERT INTO `main_sample_photo` VALUES ('i3fodiho00007lya', 'G56A8889 - 副本 (6).JPG', 'aa', '1', '0', 'http://sp.yuepaila.com/i3flhe6m00006n74/G56A8889 - 副本 (6).JPG', 'i3flhe6m00006n74', '1');
INSERT INTO `main_sample_photo` VALUES ('i3foe9gm00009c91', 'G56A8889 - 副本 (2).JPG', 'aa', '1', '0', 'http://sp.yuepaila.com/i3flhe6m00006n74/G56A8889 - 副本 (2).JPG', 'i3flhe6m00006n74', '1');
INSERT INTO `main_sample_photo` VALUES ('i3foemlr000016yh', 'G56A8889 - 副本 (3).JPG', 'aa', '1', '0', 'http://sp.yuepaila.com/i3flhe6m00006n74/G56A8889 - 副本 (3).JPG', 'i3flhe6m00006n74', '1');
INSERT INTO `main_sample_photo` VALUES ('i3im35fy0000hpts', '201411071325486.jpg', 'aa', '1', '0', 'http://sp.yuepaila.com/i3ha07h400007x8p/201411071325486.jpg', 'i3ha07h400007x8p', '1');
INSERT INTO `main_sample_photo` VALUES ('i3in950v0000fjqf', '201411071325486.jpg', 'aa', '1', '0', 'http://sp.yuepaila.com/i39sd5kt000032d6/201411071325486.jpg', 'i39sd5kt000032d6', '1');
INSERT INTO `main_sample_photo` VALUES ('i3ioukun0000bxfn', '201411071325486.jpg', 'aa', '1', '0', 'http://sp.yuepaila.com/i3iouhhm0000213e/201411071325486.jpg', 'i3iouhhm0000213e', '1');
INSERT INTO `main_sample_photo` VALUES ('i3ioulmn8888abcd', '201411071325486.jpg', 'aa', '1', '0', 'http://sp.yuepaila.com/i3r5l01300002fjt/20141110184528_591.jpg', 'i3bacadfa0000alk', '1');
INSERT INTO `main_sample_photo` VALUES ('i3ioulmn8888efgh', '201411071325486.jpg', 'aa', '1', '0', 'http://sp.yuepaila.com/i3f96x3l0000lb7v/2014110713255674.jpg', 'i3bctatga9999aeg', '1');
INSERT INTO `main_sample_photo` VALUES ('i3ioulmn8888ijkl', '201411071325486.jpg', 'aa', '1', '0', 'http://sp.yuepaila.com/i3f9xwiy0000bsg5/2014110713260314.jpg', 'i3bctgfz00000adf', '1');
INSERT INTO `main_sample_photo` VALUES ('i3l4bcxs0000eswm', '201411071325486.jpg', 'aa', '1', '0', 'http://sp.yuepaila.com/i3l4b8ot00003zaw/201411071325486.jpg', 'i3l4b8ot00003zaw', '1');
INSERT INTO `main_sample_photo` VALUES ('i3l4bd6u0000al5f', '2014110713253689.jpg', 'aa', '1', '0', 'http://sp.yuepaila.com/i3l4b8ot00003zaw/2014110713253689.jpg', 'i3l4b8ot00003zaw', '1');
INSERT INTO `main_sample_photo` VALUES ('i3l4bdhe0000gu3e', '2014110713254045.jpg', 'aa', '1', '0', 'http://sp.yuepaila.com/i3l4b8ot00003zaw/2014110713254045.jpg', 'i3l4b8ot00003zaw', '1');
INSERT INTO `main_sample_photo` VALUES ('i3l57kzx0000epwu', '201411071325486.jpg', 'aa', '1', '0', 'http://sp.yuepaila.com/i3l57g630000fzal/201411071325486.jpg', 'i3l57g630000fzal', '1');
INSERT INTO `main_sample_photo` VALUES ('i3l57l6q000090ji', '2014110713255674.jpg', 'aa', '1', '0', 'http://sp.yuepaila.com/i3l57g630000fzal/2014110713255674.jpg', 'i3l57g630000fzal', '1');
INSERT INTO `main_sample_photo` VALUES ('i3l5uyc400003vjd', '211150wb74fmzl3c3ccex5.jpg', 'aa', '1', '0', 'http://sp.yuepaila.com/i3l5uq1h0000134u/211150wb74fmzl3c3ccex5.jpg', 'i3l5uq1h0000134u', '1');
INSERT INTO `main_sample_photo` VALUES ('i3l5v0vq00008opg', '211149s0nklh38lavkibc8.jpg', 'aa', '1', '0', 'http://sp.yuepaila.com/i3l5uq1h0000134u/211149s0nklh38lavkibc8.jpg', 'i3l5uq1h0000134u', '1');
INSERT INTO `main_sample_photo` VALUES ('i3l5y2dx0000kqye', '211150wb74fmzl3c3ccex5.jpg', 'aa', '1', '0', 'http://sp.yuepaila.com/i3l5nmxs000041k5/211150wb74fmzl3c3ccex5.jpg', 'i3l5nmxs000041k5', '1');
INSERT INTO `main_sample_photo` VALUES ('i3l5yy8900005ay9', '211150wb74fmzl3c3ccex5.jpg', 'aa', '1', '0', 'http://sp.yuepaila.com/i3l5nmxs000041k5/211150wb74fmzl3c3ccex5.jpg', 'i3l5nmxs000041k5', '1');
INSERT INTO `main_sample_photo` VALUES ('i3l6on690000i6f0', '201411071325486.jpg', 'aa', '1', '0', 'http://sp.yuepaila.com/i3l6ojog0000dgo9/201411071325486.jpg', 'i3l6ojog0000dgo9', '1');
INSERT INTO `main_sample_photo` VALUES ('i3l6onf1000062sg', '2014110713255118.jpg', 'aa', '1', '0', 'http://sp.yuepaila.com/i3l6ojog0000dgo9/2014110713255118.jpg', 'i3l6ojog0000dgo9', '1');
INSERT INTO `main_sample_photo` VALUES ('i3l6r29b00001ne5', '2014110713260042.jpg', 'aa', '1', '0', 'http://sp.yuepaila.com/i3l6ojog0000dgo9/2014110713260042.jpg', 'i3l6ojog0000dgo9', '1');
INSERT INTO `main_sample_photo` VALUES ('i3l6r2f90000lda8', '2014110713260314.jpg', 'aa', '1', '0', 'http://sp.yuepaila.com/i3l6ojog0000dgo9/2014110713260314.jpg', 'i3l6ojog0000dgo9', '1');
INSERT INTO `main_sample_photo` VALUES ('i3l7kr6a0000iwig', 'Photo_2014-01-03_19_53_34.jpg', 'aa', '1', '0', 'http://sp.yuepaila.com/i3l7jk5j00007alj/Photo_2014-01-03_19_53_34.jpg', 'i3l7jk5j00007alj', '1');
INSERT INTO `main_sample_photo` VALUES ('i3l7ks310000lfdt', 'Photo_2014-01-03_19_53_44.jpg', 'aa', '1', '0', 'http://sp.yuepaila.com/i3l7jk5j00007alj/Photo_2014-01-03_19_53_44.jpg', 'i3l7jk5j00007alj', '1');
INSERT INTO `main_sample_photo` VALUES ('i3ld9r6q00004c68', '201411071325486.jpg', 'aa', '1', '0', 'http://sp.yuepaila.com/i3ld9mir0000c96j/201411071325486.jpg', 'i3ld9mir0000c96j', '1');
INSERT INTO `main_sample_photo` VALUES ('i3ld9re500003f4p', '2014110713255118.jpg', 'aa', '1', '0', 'http://sp.yuepaila.com/i3ld9mir0000c96j/2014110713255118.jpg', 'i3ld9mir0000c96j', '1');
INSERT INTO `main_sample_photo` VALUES ('i3pu7p6200007a60', '211149s0nklh38lavkibc8.jpg', 'aa', '1', '0', 'http://sp.yuepaila.com/i3pu7kli0000kvsn/211149s0nklh38lavkibc8.jpg', 'i3pu7kli0000kvsn', '1');
INSERT INTO `main_sample_photo` VALUES ('i3pu7s5v00008a4n', '211150wb74fmzl3c3ccex5.jpg', 'aa', '1', '0', 'http://sp.yuepaila.com/i3pu7kli0000kvsn/211150wb74fmzl3c3ccex5.jpg', 'i3pu7kli0000kvsn', '1');
INSERT INTO `main_sample_photo` VALUES ('i3pu7thf00000bvu', 'b8389b504fc2d56261e045e3e51190ef77c66cd0.jpg', 'aa', '1', '0', 'http://sp.yuepaila.com/i3pu7kli0000kvsn/b8389b504fc2d56261e045e3e51190ef77c66cd0.jpg', 'i3pu7kli0000kvsn', '1');
INSERT INTO `main_sample_photo` VALUES ('i3pu8eu70000altr', '211149s0nklh38lavkibc8.jpg', 'aa', '1', '0', 'http://sp.yuepaila.com/i3pu87lo0000f2tk/211149s0nklh38lavkibc8.jpg', 'i3pu87lo0000f2tk', '1');
INSERT INTO `main_sample_photo` VALUES ('i3pu8hbd00002str', '211150wb74fmzl3c3ccex5.jpg', 'aa', '1', '0', 'http://sp.yuepaila.com/i3pu87lo0000f2tk/211150wb74fmzl3c3ccex5.jpg', 'i3pu87lo0000f2tk', '1');
INSERT INTO `main_sample_photo` VALUES ('i3pu8jb00000agzb', 'b8389b504fc2d56261e045e3e51190ef77c66cd0.jpg', 'aa', '1', '0', 'http://sp.yuepaila.com/i3pu87lo0000f2tk/b8389b504fc2d56261e045e3e51190ef77c66cd0.jpg', 'i3pu87lo0000f2tk', '1');
INSERT INTO `main_sample_photo` VALUES ('i3pu8qrq00008ott', '211149s0nklh38lavkibc8.jpg', 'aa', '1', '0', 'http://sp.yuepaila.com/i3pu83nj000031si/211149s0nklh38lavkibc8.jpg', 'i3pu83nj000031si', '1');
INSERT INTO `main_sample_photo` VALUES ('i3pu8sko00003gln', '211150wb74fmzl3c3ccex5.jpg', 'aa', '1', '0', 'http://sp.yuepaila.com/i3pu83nj000031si/211150wb74fmzl3c3ccex5.jpg', 'i3pu83nj000031si', '1');
INSERT INTO `main_sample_photo` VALUES ('i3pu8uf80000kfkb', 'b8389b504fc2d56261e045e3e51190ef77c66cd0.jpg', 'aa', '1', '0', 'http://sp.yuepaila.com/i3pu83nj000031si/b8389b504fc2d56261e045e3e51190ef77c66cd0.jpg', 'i3pu83nj000031si', '1');
INSERT INTO `main_sample_photo` VALUES ('i3pua8p20000adta', '211149s0nklh38lavkibc8.jpg', 'aa', '1', '0', 'http://sp.yuepaila.com/1234asdf1234asdf/211149s0nklh38lavkibc8.jpg', '1234asdf1234asdf', '1');
INSERT INTO `main_sample_photo` VALUES ('i3puaarh0000la7i', '211150wb74fmzl3c3ccex5.jpg', 'aa', '1', '0', 'http://sp.yuepaila.com/1234asdf1234asdf/211150wb74fmzl3c3ccex5.jpg', '1234asdf1234asdf', '1');
INSERT INTO `main_sample_photo` VALUES ('i3puacwu0000i4vo', 'b8389b504fc2d56261e045e3e51190ef77c66cd0.jpg', 'aa', '1', '0', 'http://sp.yuepaila.com/1234asdf1234asdf/b8389b504fc2d56261e045e3e51190ef77c66cd0.jpg', '1234asdf1234asdf', '1');
INSERT INTO `main_sample_photo` VALUES ('i3puahra0000b1v5', 'b8389b504fc2d56261e045e3e51190ef77c66cd0.jpg', 'aa', '1', '0', 'http://sp.yuepaila.com/1234asdf1234asda/b8389b504fc2d56261e045e3e51190ef77c66cd0.jpg', '1234asdf1234asda', '1');
INSERT INTO `main_sample_photo` VALUES ('i3puajxm00002f6a', '211150wb74fmzl3c3ccex5.jpg', 'aa', '1', '0', 'http://sp.yuepaila.com/1234asdf1234asda/211150wb74fmzl3c3ccex5.jpg', '1234asdf1234asda', '1');
INSERT INTO `main_sample_photo` VALUES ('i3pualkf00001gas', '211149s0nklh38lavkibc8.jpg', 'aa', '1', '0', 'http://sp.yuepaila.com/1234asdf1234asda/211149s0nklh38lavkibc8.jpg', '1234asdf1234asda', '1');
INSERT INTO `main_sample_photo` VALUES ('i3qo7zk20000jh4g', 'Photo_2013-07-05_19_23_13.png', 'aa', '1', '0', 'http://sp.yuepaila.com/i3qo7pcy0000gl4p/Photo_2013-07-05_19_23_13.png', 'i3qo7pcy0000gl4p', '1');
INSERT INTO `main_sample_photo` VALUES ('i3qo804h00008ole', 'Photo_2013-09-17_19_52_35.jpg', 'aa', '1', '0', 'http://sp.yuepaila.com/i3qo7pcy0000gl4p/Photo_2013-09-17_19_52_35.jpg', 'i3qo7pcy0000gl4p', '1');
INSERT INTO `main_sample_photo` VALUES ('i3r5kjbq0000heph', 'Photo_2013-09-17_19_52_35.jpg', 'aa', '1', '0', 'http://sp.yuepaila.com/i3r5kbxl000098ry/Photo_2013-09-17_19_52_35.jpg', 'i3r5kbxl000098ry', '1');
INSERT INTO `main_sample_photo` VALUES ('i3r5kjh20000bmww', 'Photo_2013-10-29_20_34_49.jpg', 'aa', '1', '0', 'http://sp.yuepaila.com/i3r5kbxl000098ry/Photo_2013-10-29_20_34_49.jpg', 'i3r5kbxl000098ry', '1');
INSERT INTO `main_sample_photo` VALUES ('i3r5kjlv0000jzd1', 'Photo_2013-12-26_18_26_33.jpg', 'aa', '1', '0', 'http://sp.yuepaila.com/i3r5kbxl000098ry/Photo_2013-12-26_18_26_33.jpg', 'i3r5kbxl000098ry', '1');
INSERT INTO `main_sample_photo` VALUES ('i3r5kl1w0000f9cg', 'Photo_2014-01-03_19_52_00.jpg', 'aa', '1', '0', 'http://sp.yuepaila.com/i3r5kbxl000098ry/Photo_2014-01-03_19_52_00.jpg', 'i3r5kbxl000098ry', '1');
INSERT INTO `main_sample_photo` VALUES ('i3r5ltv40000g449', '20141110174809_715.jpg', 'aa', '1', '0', 'http://sp.yuepaila.com/i3r5l01300002fjt/20141110174809_715.jpg', 'i3r5l01300002fjt', '1');
INSERT INTO `main_sample_photo` VALUES ('i3r5m3vu000036bu', '20141110180934_19.jpg', 'aa', '1', '0', 'http://sp.yuepaila.com/i3r5l01300002fjt/20141110180934_19.jpg', 'i3r5l01300002fjt', '1');
INSERT INTO `main_sample_photo` VALUES ('i3r5m42k0000729o', '20141110180958_742.jpg', 'aa', '1', '0', 'http://sp.yuepaila.com/i3r5l01300002fjt/20141110180958_742.jpg', 'i3r5l01300002fjt', '1');
INSERT INTO `main_sample_photo` VALUES ('i3r5m49u0000h33g', '20141110180959_837.jpg', 'aa', '1', '0', 'http://sp.yuepaila.com/i3r5l01300002fjt/20141110180959_837.jpg', 'i3r5l01300002fjt', '1');
INSERT INTO `main_sample_photo` VALUES ('i3r5m4f200003mfs', '20141110181007_876.jpg', 'aa', '1', '0', 'http://sp.yuepaila.com/i3r5l01300002fjt/20141110181007_876.jpg', 'i3r5l01300002fjt', '1');
INSERT INTO `main_sample_photo` VALUES ('i3r5m4k20000ab40', '20141110181008_8.jpg', 'aa', '1', '0', 'http://sp.yuepaila.com/i3r5l01300002fjt/20141110181008_8.jpg', 'i3r5l01300002fjt', '1');
INSERT INTO `main_sample_photo` VALUES ('i3r5m4ps00000pxy', '20141110184528_591.jpg', 'aa', '1', '0', 'http://sp.yuepaila.com/i3r5l01300002fjt/20141110184528_591.jpg', 'i3r5l01300002fjt', '1');
INSERT INTO `main_sample_photo` VALUES ('i3ve7poz0000j5aq', 'C360_2014-12-15-15-19-25-762.jpg', 'aa', '1', '0', 'http://sp.yuepaila.com/i3r5l01300002fjt/C360_2014-12-15-15-19-25-762.jpg', 'i3r5l01300002fjt', '1');
INSERT INTO `main_sample_photo` VALUES ('i3ve7pul0000jsrw', 'C360_2014-12-15-15-20-51-635.jpg', 'aa', '1', '0', 'http://sp.yuepaila.com/i3r5l01300002fjt/C360_2014-12-15-15-20-51-635.jpg', 'i3r5l01300002fjt', '0');
INSERT INTO `main_sample_photo` VALUES ('i3zhed4a00002rcs', '1.jpg', 'aa', '1', '0', 'http://sp.yuepaila.com/i3bacadfa0000alk/1.jpg', 'i3bacadfa0000alk', '1');
INSERT INTO `main_sample_photo` VALUES ('i3ztern900006vyj', '花田.png', 'aa', '1', '0', 'http://sp.yuepaila.com/i3zteevq0000ks2y/花田.png', 'i3zteevq0000ks2y', '1');
INSERT INTO `main_sample_photo` VALUES ('i3ztf7xz0000fd3y', 'BaiduShurufa_2014-12-20_16-57-26.png', 'aa', '1', '0', 'http://sp.yuepaila.com/i3zteevq0000ks2y/BaiduShurufa_2014-12-20_16-57-26.png', 'i3zteevq0000ks2y', '1');
INSERT INTO `main_sample_photo` VALUES ('i40u605300006qt4', '1.png', 'aa', '1', '0', 'http://sp.yuepaila.com/i3ztfnps00003ak0/1.png', 'i3ztfnps00003ak0', '1');
INSERT INTO `main_sample_photo` VALUES ('i40u60ps00004ly5', 'BaiduShurufa_2014-12-20_16-57-26.png', 'aa', '1', '0', 'http://sp.yuepaila.com/i3ztfnps00003ak0/BaiduShurufa_2014-12-20_16-57-26.png', 'i3ztfnps00003ak0', '1');
INSERT INTO `main_sample_photo` VALUES ('i4ayyywj000037vz', '2014110713255118.jpg', 'aa', '1', '0', 'http://sp.yuepaila.com/i4ayysku00008ihr/2014110713255118.jpg', 'i4ayysku00008ihr', '1');
INSERT INTO `main_sample_photo` VALUES ('i4b2ni9i0000ara1', '2014110713255674.jpg', 'aa', '1', '0', 'http://sp.yuepaila.com/i4ayysku00008ihr/2014110713255674.jpg', 'i4ayysku00008ihr', '1');
INSERT INTO `main_sample_photo` VALUES ('i4b8xica000083ms', '201411071325486.jpg', '2', '1', '0', 'http://sp.yuepaila.com/i4ayysku00008ihr/201411071325486.jpg', 'i4ayysku00008ihr', '1');
INSERT INTO `main_sample_photo` VALUES ('i4ex5gyt00009bj5', '201411071325486.jpg', '2', '1', '0', 'http://sp.yuepaila.com/i4ayysku00008ihr/201411071325486.jpg', 'i4ayysku00008ihr', '1');
INSERT INTO `main_sample_photo` VALUES ('i4f0yqe400000c48', '2014110713255118.jpg', '0', '1', '0', 'http://sp.yuepaila.com/i4ey5fzh0000cm5g/2014110713255118.jpg', 'i4ey5fzh0000cm5g', '1');
INSERT INTO `main_sample_photo` VALUES ('i4f0yqs100009lt9', '2014110713255674.jpg', '0', '1', '0', 'http://sp.yuepaila.com/i4ey5fzh0000cm5g/2014110713255674.jpg', 'i4ey5fzh0000cm5g', '1');
INSERT INTO `main_sample_photo` VALUES ('i4f10bmv000013t1', '2014110713260314.jpg', '2', '1', '0', 'http://sp.yuepaila.com/i4ez1fwx0000im67/2014110713260314.jpg', 'i4ez1fwx0000im67', '1');
INSERT INTO `main_sample_photo` VALUES ('i4fdwd1w0000f0lg', '2014110713255118.jpg', '2', '1', '0', 'http://sp.yuepaila.com/i4fdw8xt0000jd35/2014110713255118.jpg', 'i4fdw8xt0000jd35', '1');
INSERT INTO `main_sample_photo` VALUES ('i4fdwdeg00003xca', '2014110713255674.jpg', '2', '1', '0', 'http://sp.yuepaila.com/i4fdw8xt0000jd35/2014110713255674.jpg', 'i4fdw8xt0000jd35', '1');
INSERT INTO `main_sample_photo` VALUES ('i4fdwdtl00002syd', '2014110713260042.jpg', '2', '1', '0', 'http://sp.yuepaila.com/i4fdw8xt0000jd35/2014110713260042.jpg', 'i4fdw8xt0000jd35', '1');
INSERT INTO `main_sample_photo` VALUES ('i4fdwe610000i6oz', '2014110713260314.jpg', '2', '1', '0', 'http://sp.yuepaila.com/i4fdw8xt0000jd35/2014110713260314.jpg', 'i4fdw8xt0000jd35', '1');
INSERT INTO `main_sample_photo` VALUES ('i4fdwvfi0000deq5', '201411071325486.jpg', '2', '1', '0', 'http://sp.yuepaila.com/i4fdwrtc0000in6c/201411071325486.jpg', 'i4fdwrtc0000in6c', '1');
INSERT INTO `main_sample_photo` VALUES ('i4fdwvtf00002lhw', '2014110713253689.jpg', '2', '1', '0', 'http://sp.yuepaila.com/i4fdwrtc0000in6c/2014110713253689.jpg', 'i4fdwrtc0000in6c', '1');
INSERT INTO `main_sample_photo` VALUES ('i4fdww7s0000d2u6', '2014110713254045.jpg', '2', '1', '0', 'http://sp.yuepaila.com/i4fdwrtc0000in6c/2014110713254045.jpg', 'i4fdwrtc0000in6c', '1');
INSERT INTO `main_sample_photo` VALUES ('i4fdwwk40000i29v', '2014110713254446.jpg', '2', '1', '0', 'http://sp.yuepaila.com/i4fdwrtc0000in6c/2014110713254446.jpg', 'i4fdwrtc0000in6c', '1');
INSERT INTO `main_sample_photo` VALUES ('i4fe3zsk0000b8p3', '2014110713253689.jpg', '3', '1', '0', 'http://sp.yuepaila.com/i4fe3upv00001jm9/2014110713253689.jpg', 'i4fe3upv00001jm9', '1');
INSERT INTO `main_sample_photo` VALUES ('i4fe405p0000jbpm', '2014110713254446.jpg', '3', '1', '0', 'http://sp.yuepaila.com/i4fe3upv00001jm9/2014110713254446.jpg', 'i4fe3upv00001jm9', '1');
INSERT INTO `main_sample_photo` VALUES ('i4fe71wa0000l799', '201411071325486.jpg', '1', '1', '0', 'http://sp.yuepaila.com/i4fe6xvk00005ggj/201411071325486.jpg', 'i4fe6xvk00005ggj', '1');
INSERT INTO `main_sample_photo` VALUES ('i4fe72co0000k3o2', '2014110713253689.jpg', '1', '1', '0', 'http://sp.yuepaila.com/i4fe6xvk00005ggj/2014110713253689.jpg', 'i4fe6xvk00005ggj', '1');
INSERT INTO `main_sample_photo` VALUES ('i4fe7jpv00001yni', '201411071325486.jpg', '2', '1', '0', 'http://sp.yuepaila.com/i4fe7dyi0000gts1/201411071325486.jpg', 'i4fe7dyi0000gts1', '1');
INSERT INTO `main_sample_photo` VALUES ('i4fe7k4800002d1h', '2014110713253689.jpg', '2', '1', '0', 'http://sp.yuepaila.com/i4fe7dyi0000gts1/2014110713253689.jpg', 'i4fe7dyi0000gts1', '1');
INSERT INTO `main_sample_photo` VALUES ('i4fe7kfy00005rld', '2014110713254045.jpg', '2', '1', '0', 'http://sp.yuepaila.com/i4fe7dyi0000gts1/2014110713254045.jpg', 'i4fe7dyi0000gts1', '1');
INSERT INTO `main_sample_photo` VALUES ('i4fe7ksr0000kxbu', '2014110713254446.jpg', '2', '1', '0', 'http://sp.yuepaila.com/i4fe7dyi0000gts1/2014110713254446.jpg', 'i4fe7dyi0000gts1', '1');
INSERT INTO `main_sample_photo` VALUES ('i4fe9yk80000c7ld', '201411071325486.jpg', '3', '1', '0', 'http://sp.yuepaila.com/i4fe9uxb0000id8s/201411071325486.jpg', 'i4fe9uxb0000id8s', '0');
INSERT INTO `main_sample_photo` VALUES ('i4fe9yyq0000flpj', '2014110713253689.jpg', '3', '1', '0', 'http://sp.yuepaila.com/i4fe9uxb0000id8s/2014110713253689.jpg', 'i4fe9uxb0000id8s', '0');
INSERT INTO `main_sample_photo` VALUES ('i4fe9zh10000byi5', '2014110713254045.jpg', '3', '1', '0', 'http://sp.yuepaila.com/i4fe9uxb0000id8s/2014110713254045.jpg', 'i4fe9uxb0000id8s', '0');
INSERT INTO `main_sample_photo` VALUES ('i4feav7h0000fu0x', '2014110713255118 - 副本.jpg', '3', '1', '0', 'http://sp.yuepaila.com/i4feaoj100003pxy/2014110713255118 - 副本.jpg', 'i4feaoj100003pxy', '1');
INSERT INTO `main_sample_photo` VALUES ('i4feavjb00006rmq', '2014110713255118.jpg', '3', '1', '0', 'http://sp.yuepaila.com/i4feaoj100003pxy/2014110713255118.jpg', 'i4feaoj100003pxy', '1');
INSERT INTO `main_sample_photo` VALUES ('i4feaw1m0000cg7d', '2014110713255674.jpg', '3', '1', '0', 'http://sp.yuepaila.com/i4feaoj100003pxy/2014110713255674.jpg', 'i4feaoj100003pxy', '1');
INSERT INTO `main_sample_photo` VALUES ('i4feawi000002n0c', '2014110713260042.jpg', '3', '1', '0', 'http://sp.yuepaila.com/i4feaoj100003pxy/2014110713260042.jpg', 'i4feaoj100003pxy', '0');
INSERT INTO `main_sample_photo` VALUES ('i4gkcy0c00009jcd', '2014110713254446.jpg', '3', '1', '0', 'http://sp.yuepaila.com/i4fe9uxb0000id8s/2014110713254446.jpg', 'i4fe9uxb0000id8s', '0');
INSERT INTO `main_sample_photo` VALUES ('i4gkwirx0000ez62', '2014110713260042.jpg', '3', '1', '0', 'http://sp.yuepaila.com/i4fe9uxb0000id8s/2014110713260042.jpg', 'i4fe9uxb0000id8s', '0');
INSERT INTO `main_sample_photo` VALUES ('i4gl3yz400002bj9', '2014110713260042.jpg', '3', '1', '0', 'http://sp.yuepaila.com/i4fe9uxb0000id8s/2014110713260042.jpg', 'i4fe9uxb0000id8s', '0');
INSERT INTO `main_sample_photo` VALUES ('i4gnaoi200009efl', '2014110713255118 - 副本.jpg', '3', '1', '0', 'http://sp.yuepaila.com/i4fe9uxb0000id8s/2014110713255118 - 副本.jpg', 'i4fe9uxb0000id8s', '0');
INSERT INTO `main_sample_photo` VALUES ('i4gow61f0000hel5', '2014110713260898.jpg', '3', '1', '0', 'http://sp.yuepaila.com/i4fe9uxb0000id8s/2014110713260898.jpg', 'i4fe9uxb0000id8s', '0');
INSERT INTO `main_sample_photo` VALUES ('i4gowrin0000kw80', '2014110713254446.jpg', '3', '1', '0', 'http://sp.yuepaila.com/i4fe9uxb0000id8s/2014110713254446.jpg', 'i4fe9uxb0000id8s', '1');
INSERT INTO `main_sample_photo` VALUES ('i4htyqh200000hii', '201411071325486.jpg', '3', '1', '0', 'http://sp.yuepaila.com/i4fe9uxb0000id8s/201411071325486.jpg', 'i4fe9uxb0000id8s', '0');
INSERT INTO `main_sample_photo` VALUES ('i4hu71k60000bri7', '2014110713260042.jpg', '3', '1', '0', 'http://sp.yuepaila.com/i4fe9uxb0000id8s/2014110713260042.jpg', 'i4fe9uxb0000id8s', '1');
INSERT INTO `main_sample_photo` VALUES ('i4hu7ijx00000xs6', '2014110713253689.jpg', '3', '1', '0', 'http://sp.yuepaila.com/i4fe9uxb0000id8s/2014110713253689.jpg', 'i4fe9uxb0000id8s', '1');
INSERT INTO `main_sample_photo` VALUES ('i4hunu5l0000d57k', '2014110713255674.jpg', '3', '1', '0', 'http://sp.yuepaila.com/i4fe9uxb0000id8s/2014110713255674.jpg', 'i4fe9uxb0000id8s', '0');
INSERT INTO `main_sample_photo` VALUES ('i4jqdil00000ay5b', '201411071325486.jpg', '3', '1', '0', 'http://sp.yuepaila.com/i4fe9uxb0000id8s/201411071325486.jpg', 'i4fe9uxb0000id8s', '0');
INSERT INTO `main_sample_photo` VALUES ('i4jqe4yj00003qek', '2014110713255674.jpg', '3', '1', '0', 'http://sp.yuepaila.com/i4fe9uxb0000id8s/2014110713255674.jpg', 'i4fe9uxb0000id8s', '1');
INSERT INTO `main_sample_photo` VALUES ('i4kvuxue00009orn', 'HT (1).jpg', '1', '1', '0', 'http://sp.yuepaila.com/i4kvuksl0000ekxf/HT (1).jpg', 'i4kvuksl0000ekxf', '1');
INSERT INTO `main_sample_photo` VALUES ('i4kvv3ml0000datw', 'HT (2).jpg', '1', '1', '0', 'http://sp.yuepaila.com/i4kvuksl0000ekxf/HT (2).jpg', 'i4kvuksl0000ekxf', '1');
INSERT INTO `main_sample_photo` VALUES ('i4kvva2r0000jfvj', 'HT (3).jpg', '1', '1', '0', 'http://sp.yuepaila.com/i4kvuksl0000ekxf/HT (3).jpg', 'i4kvuksl0000ekxf', '1');
INSERT INTO `main_sample_photo` VALUES ('i4kvvi24000080u7', 'HT (4).jpg', '1', '1', '0', 'http://sp.yuepaila.com/i4kvuksl0000ekxf/HT (4).jpg', 'i4kvuksl0000ekxf', '1');
INSERT INTO `main_sample_photo` VALUES ('i4kvvsik00004xgl', 'HT (5).jpg', '1', '1', '0', 'http://sp.yuepaila.com/i4kvuksl0000ekxf/HT (5).jpg', 'i4kvuksl0000ekxf', '1');
INSERT INTO `main_sample_photo` VALUES ('i4kvvz7q0000l2bf', 'HT (6).jpg', '1', '1', '0', 'http://sp.yuepaila.com/i4kvuksl0000ekxf/HT (6).jpg', 'i4kvuksl0000ekxf', '1');
INSERT INTO `main_sample_photo` VALUES ('i4kvw9qn000008lc', 'HT (7).jpg', '1', '1', '0', 'http://sp.yuepaila.com/i4kvuksl0000ekxf/HT (7).jpg', 'i4kvuksl0000ekxf', '1');
INSERT INTO `main_sample_photo` VALUES ('i4kvwg9j0000gjkk', 'HT (8).jpg', '1', '1', '0', 'http://sp.yuepaila.com/i4kvuksl0000ekxf/HT (8).jpg', 'i4kvuksl0000ekxf', '1');
INSERT INTO `main_sample_photo` VALUES ('i4kvwkdr0000ekvj', 'HT (9).jpg', '1', '1', '0', 'http://sp.yuepaila.com/i4kvuksl0000ekxf/HT (9).jpg', 'i4kvuksl0000ekxf', '1');
INSERT INTO `main_sample_photo` VALUES ('i4kwikb900008ien', 'HT (1).jpg', '5', '1', '0', 'http://sp.yuepaila.com/i4kwi9bu0000itmw/HT (1).jpg', 'i4kwi9bu0000itmw', '0');
INSERT INTO `main_sample_photo` VALUES ('i4kwiq950000gotp', 'HT (2).jpg', '5', '1', '0', 'http://sp.yuepaila.com/i4kwi9bu0000itmw/HT (2).jpg', 'i4kwi9bu0000itmw', '0');
INSERT INTO `main_sample_photo` VALUES ('i4kwixhz000017ub', 'HT (3).jpg', '5', '1', '0', 'http://sp.yuepaila.com/i4kwi9bu0000itmw/HT (3).jpg', 'i4kwi9bu0000itmw', '1');
INSERT INTO `main_sample_photo` VALUES ('i4kwj6a40000efuc', 'HT (4).jpg', '5', '1', '0', 'http://sp.yuepaila.com/i4kwi9bu0000itmw/HT (4).jpg', 'i4kwi9bu0000itmw', '1');
INSERT INTO `main_sample_photo` VALUES ('i4kwjg9s000074at', 'HT (5).jpg', '5', '1', '0', 'http://sp.yuepaila.com/i4kwi9bu0000itmw/HT (5).jpg', 'i4kwi9bu0000itmw', '1');
INSERT INTO `main_sample_photo` VALUES ('i4kwjov800007ev4', 'HT (6).jpg', '5', '1', '0', 'http://sp.yuepaila.com/i4kwi9bu0000itmw/HT (6).jpg', 'i4kwi9bu0000itmw', '1');
INSERT INTO `main_sample_photo` VALUES ('i4kwjxc70000d0jf', 'HT (7).jpg', '5', '1', '0', 'http://sp.yuepaila.com/i4kwi9bu0000itmw/HT (7).jpg', 'i4kwi9bu0000itmw', '1');
INSERT INTO `main_sample_photo` VALUES ('i4kwk3jm0000f55j', 'HT (8).jpg', '5', '1', '0', 'http://sp.yuepaila.com/i4kwi9bu0000itmw/HT (8).jpg', 'i4kwi9bu0000itmw', '1');
INSERT INTO `main_sample_photo` VALUES ('i4kwk6xp0000fyz4', 'HT (9).jpg', '5', '1', '0', 'http://sp.yuepaila.com/i4kwi9bu0000itmw/HT (9).jpg', 'i4kwi9bu0000itmw', '0');
INSERT INTO `main_sample_photo` VALUES ('i4l9idns00004l48', '201411071325486.jpg', '3', '1', '0', 'http://sp.yuepaila.com/i39pzafo0000jckl/i4fe9uxb0000id8s/201411071325486.jpg', 'i4fe9uxb0000id8s', '1');
INSERT INTO `main_sample_photo` VALUES ('i4mb98gt00007lem', '2014110713260898.jpg', '3', '1', '0', 'http://sp.yuepaila.com/i39pzafo0000jckl/i4fe9uxb0000id8s/2014110713260898.jpg', 'i4fe9uxb0000id8s', '1');
INSERT INTO `main_sample_photo` VALUES ('i4mdknh000001t3u', 'HT (1).jpg', '0', '1', '0', 'http://sp.yuepaila.com/i39pzafo0000jckl/i4mdkc420000kgpr/HT (1).jpg', 'i4mdkc420000kgpr', '1');
INSERT INTO `main_sample_photo` VALUES ('i4mdkw0s0000jqu8', 'HT (2).jpg', '0', '1', '0', 'http://sp.yuepaila.com/i39pzafo0000jckl/i4mdkc420000kgpr/HT (2).jpg', 'i4mdkc420000kgpr', '1');
INSERT INTO `main_sample_photo` VALUES ('i4mdligm0000g4qa', 'HT (3).jpg', '0', '1', '0', 'http://sp.yuepaila.com/i39pzafo0000jckl/i4mdkc420000kgpr/HT (3).jpg', 'i4mdkc420000kgpr', '1');
INSERT INTO `main_sample_photo` VALUES ('i4mdls5t00004d4w', 'HT (4).jpg', '0', '1', '0', 'http://sp.yuepaila.com/i39pzafo0000jckl/i4mdkc420000kgpr/HT (4).jpg', 'i4mdkc420000kgpr', '1');
INSERT INTO `main_sample_photo` VALUES ('i4mdm27q0000j968', 'HT (5).jpg', '0', '1', '0', 'http://sp.yuepaila.com/i39pzafo0000jckl/i4mdkc420000kgpr/HT (5).jpg', 'i4mdkc420000kgpr', '1');
INSERT INTO `main_sample_photo` VALUES ('i4mdm9vl0000c2t6', 'HT (6).jpg', '0', '1', '0', 'http://sp.yuepaila.com/i39pzafo0000jckl/i4mdkc420000kgpr/HT (6).jpg', 'i4mdkc420000kgpr', '1');
INSERT INTO `main_sample_photo` VALUES ('i4mdmlrd0000jp33', 'HT (7).jpg', '0', '1', '0', 'http://sp.yuepaila.com/i39pzafo0000jckl/i4mdkc420000kgpr/HT (7).jpg', 'i4mdkc420000kgpr', '1');
INSERT INTO `main_sample_photo` VALUES ('i4mdmu7o0000bs06', 'HT (8).jpg', '0', '1', '0', 'http://sp.yuepaila.com/i39pzafo0000jckl/i4mdkc420000kgpr/HT (8).jpg', 'i4mdkc420000kgpr', '1');
INSERT INTO `main_sample_photo` VALUES ('i4mdmyhx0000c2x7', 'HT (9).jpg', '0', '1', '0', 'http://sp.yuepaila.com/i39pzafo0000jckl/i4mdkc420000kgpr/HT (9).jpg', 'i4mdkc420000kgpr', '1');
INSERT INTO `main_sample_photo` VALUES ('i4mgwa4g0000108l', 'HT (1).jpg', '0', '1', '0', 'http://sp.yuepaila.com/i39pzafo0000jckl/i4mdkc420000kgpr/HT (1).jpg', 'i4mdkc420000kgpr', '1');
INSERT INTO `main_sample_photo` VALUES ('i4mgyegw00001i1k', 'HT (1).jpg', '0', '1', '0', 'http://sp.yuepaila.com/i39pzafo0000jckl/i4mgxr2f0000k8tr/HT (1).jpg', 'i4mgxr2f0000k8tr', '1');
INSERT INTO `main_sample_photo` VALUES ('i4mgykvq000076z0', 'HT (2).jpg', '0', '1', '0', 'http://sp.yuepaila.com/i39pzafo0000jckl/i4mgxr2f0000k8tr/HT (2).jpg', 'i4mgxr2f0000k8tr', '1');
INSERT INTO `main_sample_photo` VALUES ('i4mgyrdw00009ped', 'HT (3).jpg', '0', '1', '0', 'http://sp.yuepaila.com/i39pzafo0000jckl/i4mgxr2f0000k8tr/HT (3).jpg', 'i4mgxr2f0000k8tr', '1');
INSERT INTO `main_sample_photo` VALUES ('i4mgz1em000081ft', 'HT (4).jpg', '0', '1', '0', 'http://sp.yuepaila.com/i39pzafo0000jckl/i4mgxr2f0000k8tr/HT (4).jpg', 'i4mgxr2f0000k8tr', '1');
INSERT INTO `main_sample_photo` VALUES ('i4mgzeaa00004w4t', 'HT (5).jpg', '0', '1', '0', 'http://sp.yuepaila.com/i39pzafo0000jckl/i4mgxr2f0000k8tr/HT (5).jpg', 'i4mgxr2f0000k8tr', '0');
INSERT INTO `main_sample_photo` VALUES ('i4mgzphz0000a3i3', 'HT (6).jpg', '0', '1', '0', 'http://sp.yuepaila.com/i39pzafo0000jckl/i4mgxr2f0000k8tr/HT (6).jpg', 'i4mgxr2f0000k8tr', '1');
INSERT INTO `main_sample_photo` VALUES ('i4mh00co00006w0w', 'HT (7).jpg', '0', '1', '0', 'http://sp.yuepaila.com/i39pzafo0000jckl/i4mgxr2f0000k8tr/HT (7).jpg', 'i4mgxr2f0000k8tr', '1');
INSERT INTO `main_sample_photo` VALUES ('i4mh08oh00007vwu', 'HT (8).jpg', '0', '1', '0', 'http://sp.yuepaila.com/i39pzafo0000jckl/i4mgxr2f0000k8tr/HT (8).jpg', 'i4mgxr2f0000k8tr', '1');
INSERT INTO `main_sample_photo` VALUES ('i4mh0cau0000kmi3', 'HT (9).jpg', '0', '1', '0', 'http://sp.yuepaila.com/i39pzafo0000jckl/i4mgxr2f0000k8tr/HT (9).jpg', 'i4mgxr2f0000k8tr', '1');
INSERT INTO `main_sample_photo` VALUES ('i4mqajdv0000d2u2', '2014110713255674.jpg', '0', '1', '0', 'http://sp.yuepaila.com/i39pzafo0000jckl/i4mhc2d20000bomn/2014110713255674.jpg', 'i4mhc2d20000bomn', '0');
INSERT INTO `main_sample_photo` VALUES ('i4njguka00006jgo', 'HT (1).jpg', '1', '1', '0', 'http://sp.yuepaila.com/i39r0pva0000iffw/HT (1).jpg', 'i39r0pva0000iffw', '1');
INSERT INTO `main_sample_photo` VALUES ('i4njh0u40000er1e', 'HT (2).jpg', '1', '1', '0', 'http://sp.yuepaila.com/i39r0pva0000iffw/HT (2).jpg', 'i39r0pva0000iffw', '1');
INSERT INTO `main_sample_photo` VALUES ('i4njhdjv0000f5yi', 'HT (3).jpg', '1', '1', '0', 'http://sp.yuepaila.com/i39r0pva0000iffw/HT (3).jpg', 'i39r0pva0000iffw', '1');
INSERT INTO `main_sample_photo` VALUES ('i4njho9r00006v2g', 'HT (4).jpg', '1', '1', '0', 'http://sp.yuepaila.com/i39r0pva0000iffw/HT (4).jpg', 'i39r0pva0000iffw', '1');
INSERT INTO `main_sample_photo` VALUES ('i4njhya500002owl', 'HT (5).jpg', '1', '1', '0', 'http://sp.yuepaila.com/i39r0pva0000iffw/HT (5).jpg', 'i39r0pva0000iffw', '1');
INSERT INTO `main_sample_photo` VALUES ('i4njivgz00002v5o', 'HT (6).jpg', '1', '1', '0', 'http://sp.yuepaila.com/i39r0pva0000iffw/HT (6).jpg', 'i39r0pva0000iffw', '1');
INSERT INTO `main_sample_photo` VALUES ('i4njj5m00000c01d', 'HT (7).jpg', '1', '1', '0', 'http://sp.yuepaila.com/i39r0pva0000iffw/HT (7).jpg', 'i39r0pva0000iffw', '1');
INSERT INTO `main_sample_photo` VALUES ('i4njjc9f00008ltb', 'HT (8).jpg', '1', '1', '0', 'http://sp.yuepaila.com/i39r0pva0000iffw/HT (8).jpg', 'i39r0pva0000iffw', '0');
INSERT INTO `main_sample_photo` VALUES ('i4njjg360000db8s', 'HT (9).jpg', '1', '1', '0', 'http://sp.yuepaila.com/i39r0pva0000iffw/HT (9).jpg', 'i39r0pva0000iffw', '0');

-- ----------------------------
-- Table structure for `main_sample_photo_group`
-- ----------------------------
DROP TABLE IF EXISTS `main_sample_photo_group`;
CREATE TABLE `main_sample_photo_group` (
  `id` char(16) NOT NULL,
  `title` varchar(32) NOT NULL,
  `photographer_id` char(16) NOT NULL,
  `memo` varchar(128) DEFAULT NULL,
  `cover_sample_photo_id` char(16) DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '1',
  `ptype` tinyint(4) NOT NULL,
  `home_page_index` smallint(6) DEFAULT NULL,
  `channel_index` smallint(6) DEFAULT NULL,
  `reason` varchar(64) DEFAULT NULL,
  `type_price_id` char(16) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of main_sample_photo_group
-- ----------------------------
INSERT INTO `main_sample_photo_group` VALUES ('i39r0pva0000iffw', 'king', 'i3jxkwv40000hcdm', '11111111111111111111111111', 'i3cpeegg0000d9lf', '0', '1', '60', '8', '长得太丑！', '');
INSERT INTO `main_sample_photo_group` VALUES ('i39rjgje0000d3c8', '校园', 'i3jxkwv40000hcdm', '毕业照的那年', 'i3ctcj4a0000hois', '1', '2', null, '1', '长得太丑！', '');
INSERT INTO `main_sample_photo_group` VALUES ('i39sd5kt000032d6', '大将', 'i3jxkwv40000hcdm', '红玉', 'i3cog4lv000053je', '1', '2', null, '1', '长得太丑！', '');
INSERT INTO `main_sample_photo_group` VALUES ('i3bctgfz00000hvu', 'asdad', 'i3jxkwv40000hcdm', 'asdasd', 'i3cu2dnc000041zo', '0', '2', null, '1', '长得太丑！', '');
INSERT INTO `main_sample_photo_group` VALUES ('i3ctgson0000gat8', '刺金时代', 'i3jxkwv40000hcdm', '小时代3', 'i3ctk5w60000cxfk', '1', '2', null, '1', '长得太丑！', '');
INSERT INTO `main_sample_photo_group` VALUES ('i3f96x3l0000lb7v', '塞斯奇', 'i3jxkwv40000hcdm', '精选作品', 'i3f9735e00003xvi', '1', '2', null, '1', '长得太丑！', '');
INSERT INTO `main_sample_photo_group` VALUES ('i3f9xwiy0000bsg5', '按时', 'i3jxkwv40000hcdm', '阿斯顿', 'i3f9y7rq000030vj', '1', '2', null, '1', '长得太丑！', '');
INSERT INTO `main_sample_photo_group` VALUES ('i3flhe6m00006n74', '大话西游', 'i3jxkwv40000hcdm', '啊实打实', 'i3flk93o000013lr', '1', '2', null, '1', '长得太丑！', '');
INSERT INTO `main_sample_photo_group` VALUES ('i3ha07h400007x8p', '111', 'i3jxkwv40000hcdm', '111', 'i3im35fy0000hpts', '1', '2', null, '2', '人太挫', '');
INSERT INTO `main_sample_photo_group` VALUES ('i3iouhhm0000213e', '证件照', 'i3jxkwv40000hcdm', '阿斯顿', 'i3ioukun0000bxfn', '1', '4', null, '1', '人太挫', '');
INSERT INTO `main_sample_photo_group` VALUES ('i3l4b8ot00003zaw', '啊啊啊', 'i3jxkwv40000hcdm', '按时', 'i3l4bd6u0000al5f', '1', '4', null, '1', '人太挫', '');
INSERT INTO `main_sample_photo_group` VALUES ('i3l57g630000fzal', '按时啊', 'i3jxkwv40000hcdm', '阿斯顿', 'i3l57kzx0000epwu', '1', '3', null, null, '人太挫', '');
INSERT INTO `main_sample_photo_group` VALUES ('i3l5nmxs000041k5', 'kjjkjk', 'i3jxkwv40000hcdm', 'dfg', 'i3l5y2dx0000kqye', '1', '1', null, '1', '矮穷丑', '');
INSERT INTO `main_sample_photo_group` VALUES ('i3l5uq1h0000134u', 'kjjkjkasd', 'i3jxkwv40000hcdm', 'l;', 'i3l5v0vq00008opg', '1', '2', null, null, '矮穷丑', '');
INSERT INTO `main_sample_photo_group` VALUES ('i3l6ojog0000dgo9', 'asd ', 'i3jxkwv40000hcdm', 'asd ', 'i3l6onf1000062sg', '1', '4', null, '1', '矮穷丑', '');
INSERT INTO `main_sample_photo_group` VALUES ('i3l7jk5j00007alj', '2223', 'i3jxkwv40000hcdm', '', 'i3l7ks310000lfdt', '1', '3', null, null, '矮穷丑', '');
INSERT INTO `main_sample_photo_group` VALUES ('i3ld9mir0000c96j', 'dfa', 'i3jxkwv40000hcdm', 'add', 'i3ld9r6q00004c68', '1', '3', null, '1', '矮穷丑', '');
INSERT INTO `main_sample_photo_group` VALUES ('i3pu7kli0000kvsn', 'test', 'i3jxkwv40000hcdm', '12312', 'i3pu7thf00000bvu', '1', '5', null, '1', '人太挫', '');
INSERT INTO `main_sample_photo_group` VALUES ('i3pu83nj000031si', '123', 'i3jxkwv40000hcdm', '123', 'i3pu8sko00003gln', '1', '5', null, null, '人太挫', '');
INSERT INTO `main_sample_photo_group` VALUES ('i3pu87lo0000f2tk', '123', 'i3jxkwv40000hcdm', '123', 'i3pu8hbd00002str', '1', '5', null, '1', '人太挫', '');
INSERT INTO `main_sample_photo_group` VALUES ('i3qo7pcy0000gl4p', '66', 'i3jxkwv40000hcdm', '66', 'i3qo7zk20000jh4g', '1', '0', null, '1', '人太挫', '');
INSERT INTO `main_sample_photo_group` VALUES ('i3r5kbxl000098ry', 'AAAA', 'i3jxkwv40000hcdm', 'AAA', 'i3r5kjbq0000heph', '1', '3', null, null, '人太挫', '');
INSERT INTO `main_sample_photo_group` VALUES ('i3r5l01300002fjt', '43243', 'i3jxkwv40000hcdm', '434', 'i3r5m3vu000036bu', '1', '3', null, '1', '人太挫', '');
INSERT INTO `main_sample_photo_group` VALUES ('i3zteevq0000ks2y', 'demo', 'i2d30lym00008w6i', '顶顶顶顶顶顶顶顶', 'i3ztf7xz0000fd3y', '2', '1', '5', '1', '长得太帅！', '');
INSERT INTO `main_sample_photo_group` VALUES ('i4ayysku00008ihr', '春丽', 'i39pzafo0000jckl', '阿斯顿啊', 'i4ayyywj000037vz', '0', '2', null, null, null, '');
INSERT INTO `main_sample_photo_group` VALUES ('i4ey5fzh0000cm5g', '', 'i39pzafo0000jckl', '', 'i4f0yqe400000c48', '0', '0', null, null, null, '');
INSERT INTO `main_sample_photo_group` VALUES ('i4ez1fwx0000im67', '十万个冷笑话', 'i39pzafo0000jckl', '十万个冷笑话，笑话，话，哗哗哗', 'i4f10bmv000013t1', '0', '2', null, null, null, '');
INSERT INTO `main_sample_photo_group` VALUES ('i4fdrhoh0000cnsc', '时光鸡', 'i39pzafo0000jckl', '阿斯顿', null, '0', '3', null, null, null, '');
INSERT INTO `main_sample_photo_group` VALUES ('i4fdw8xt0000jd35', '阿斯顿', 'i39pzafo0000jckl', '阿斯顿', 'i4fdwd1w0000f0lg', '0', '2', null, null, null, '');
INSERT INTO `main_sample_photo_group` VALUES ('i4fdwrtc0000in6c', '阿斯顿啊啊', 'i39pzafo0000jckl', '按时', 'i4fdwvfi0000deq5', '0', '2', null, null, null, '');
INSERT INTO `main_sample_photo_group` VALUES ('i4fe3upv00001jm9', '阿斯顿撒旦', 'i39pzafo0000jckl', '阿斯达', 'i4fe405p0000jbpm', '0', '3', null, null, null, '');
INSERT INTO `main_sample_photo_group` VALUES ('i4fe6xvk00005ggj', '阿斯达', 'i39pzafo0000jckl', '啊实打实', 'i4fe71wa0000l799', '0', '1', null, null, null, '');
INSERT INTO `main_sample_photo_group` VALUES ('i4fe7dyi0000gts1', '存储', 'i39pzafo0000jckl', '阿斯顿撒', 'i4fe7ksr0000kxbu', '2', '2', '2', '0', '图片大小不一致', '');
INSERT INTO `main_sample_photo_group` VALUES ('i4fe9uxb0000id8s', '阿大声道', 'i39pzafo0000jckl', '啊实打实', 'i4gowrin0000kw80', '1', '3', null, null, null, '');
INSERT INTO `main_sample_photo_group` VALUES ('i4feaoj100003pxy', '321321', 'i39pzafo0000jckl', '阿斯顿撒', 'i4feavjb00006rmq', '2', '3', '52', '0', '居然跳转成功', '');
INSERT INTO `main_sample_photo_group` VALUES ('i4feb6w3000013ag', '啊实打实', 'i39pzafo0000jckl', '阿斯达', null, '2', '2', '2', '0', '长的太磕碜！', '');
INSERT INTO `main_sample_photo_group` VALUES ('i4jqn8ny00003zet', 'www', 'i3jxkwv40000hcdm', 'www', null, '0', '1', '0', '0', null, '');
INSERT INTO `main_sample_photo_group` VALUES ('i4kvttzw00008mni', 'www', 'i39pzafo0000jckl', '', null, '0', '1', null, null, null, '');
INSERT INTO `main_sample_photo_group` VALUES ('i4kvuksl0000ekxf', 'www', 'i39pzafo0000jckl', '', 'i4kvuxue00009orn', '0', '1', null, null, null, '');
INSERT INTO `main_sample_photo_group` VALUES ('i4kwi4i10000clsn', 'www', 'i39pzafo0000jckl', '...      ....    ....    ......  .....              ........      .......    ......    ......    ......', null, '0', '5', null, null, null, '');
INSERT INTO `main_sample_photo_group` VALUES ('i4kwi9bu0000itmw', 'www', 'i39pzafo0000jckl', '...      ....    ....    ......  .....              ........      .......    ......    ......    ......', 'i4kwk6xp0000fyz4', '1', '5', null, null, null, '');
INSERT INTO `main_sample_photo_group` VALUES ('i4mb5t7n00002ylw', '321321', 'i39pzafo0000jckl', '', null, '0', '0', null, null, null, 'i4jp78bo0000ex9m');
INSERT INTO `main_sample_photo_group` VALUES ('i4mdkc420000kgpr', 'www', 'i39pzafo0000jckl', '1111111111111111111111111111111', null, '0', '0', null, null, null, 'i49hj0tt0000glth');
INSERT INTO `main_sample_photo_group` VALUES ('i4mgxk1a0000imq6', 'www', 'i39pzafo0000jckl', '111  22  33  44  55  66  77  ', null, '0', '0', null, null, null, 'i3faprup00008q4q');
INSERT INTO `main_sample_photo_group` VALUES ('i4mgxr2f0000k8tr', 'www', 'i39pzafo0000jckl', '111  22  33  44  55  66  77  ', 'i4mgyegw00001i1k', '1', '0', null, null, null, 'i3faprup00008q4q');
INSERT INTO `main_sample_photo_group` VALUES ('i4mhc2d20000bomn', 'www', 'i39pzafo0000jckl', '1', 'i4mqajdv0000d2u2', '0', '0', null, null, null, 'i4jp78bo0000ex9m');

-- ----------------------------
-- Table structure for `main_sample_photo_group_praise`
-- ----------------------------
DROP TABLE IF EXISTS `main_sample_photo_group_praise`;
CREATE TABLE `main_sample_photo_group_praise` (
  `id` char(16) NOT NULL,
  `sample_photo_group_id` char(16) NOT NULL,
  `user_id` char(16) NOT NULL,
  `create_datetime` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of main_sample_photo_group_praise
-- ----------------------------

-- ----------------------------
-- Table structure for `main_sample_photo_group_style`
-- ----------------------------
DROP TABLE IF EXISTS `main_sample_photo_group_style`;
CREATE TABLE `main_sample_photo_group_style` (
  `id` char(16) NOT NULL,
  `sample_photo_group_id` char(16) NOT NULL,
  `style` tinyint(4) NOT NULL,
  `ptype` tinyint(4) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of main_sample_photo_group_style
-- ----------------------------
INSERT INTO `main_sample_photo_group_style` VALUES ('1234567890123456', '1234asdf1234asda', '11', '1', '123.00');

-- ----------------------------
-- Table structure for `main_scene`
-- ----------------------------
DROP TABLE IF EXISTS `main_scene`;
CREATE TABLE `main_scene` (
  `id` char(16) NOT NULL,
  `name` varchar(16) CHARACTER SET utf8 NOT NULL,
  `scene_type` tinyint(4) NOT NULL,
  `price` smallint(6) NOT NULL,
  `cover_picture_url` char(128) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '1',
  `profits` int(11) DEFAULT NULL,
  `visit_amount` int(11) DEFAULT NULL,
  `is_recommended` tinyint(4) DEFAULT NULL,
  `place_id` char(16) DEFAULT NULL,
  `praise_amount` int(11) DEFAULT NULL,
  `order_amount` int(11) DEFAULT NULL,
  `haopingnum` int(10) DEFAULT NULL,
  `city_id` char(16) DEFAULT NULL,
  `home_page_index` smallint(6) DEFAULT NULL,
  `channel_index` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of main_scene
-- ----------------------------
INSERT INTO `main_scene` VALUES ('asasasa12551ssss', '场景1', '2', '45', 'scene/asasasa12551ssss/i4jjmu3m1h07scene01.jpg', '0', '0', '0', '1', 'sdfr2541hjug41li', '0', '0', '0', '1236547891159753', null, null);
INSERT INTO `main_scene` VALUES ('asasasasdas54545', 'dress', '1', '55', 'scene/i3l62nl9000054yq/i3o80zxw5yx8u=876908222,2146973101&fm=21&gp=0.jpg', '1', '1000', '0', '1', 'sdfr2541hjug41li', '0', '0', '0', '1236547891159753', null, null);
INSERT INTO `main_scene` VALUES ('i2n6hesr00003clc', 'dress', '1', '212', 'scene/i3l62nl9000054yq/i3o80zxw5yx8u=876908222,2146973101&fm=21&gp=0.jpg', '0', '555', '0', '1', 'sdfr2541hjug41li', '21', '0', '0', '1236547891159753', null, null);
INSERT INTO `main_scene` VALUES ('i2n6jfhp0000fyl6', 'scene', '1', '21', 'scene/i3l62nl9000054yq/i3o80zxw5yx8u=876908222,2146973101&fm=21&gp=0.jpg', '0', '2', '0', '1', 'sdfr2541hjug41li', '21', '0', '0', '1236547891159753', null, null);
INSERT INTO `main_scene` VALUES ('i2n803b60000aoho', 'scene', '2', '333', 'scene/i3l62nl9000054yq/i3o80zxw5yx8u=876908222,2146973101&fm=21&gp=0.jpg', '1', '33', '0', '1', 'sdfr2541hjug41li', '43', '0', '0', '1236547891159753', null, null);
INSERT INTO `main_scene` VALUES ('i2o2t4j900009mn7', 'scene2', '2', '100', 'scene/i3l62nl9000054yq/i3o80zxw5yx8u=876908222,2146973101&fm=21&gp=0.jpg', '0', '50', '0', '1', 'sdfr2541hjug41li', '800', '0', '0', '1236547891159753', null, null);
INSERT INTO `main_scene` VALUES ('i3l62nl9000054y1', 'scene', '2', '45', 'scene/i3l62nl9000054yq/i3o80zxw5yx8u=876908222,2146973101&fm=21&gp=0.jpg', '1', '555', '0', '1', null, '0', '0', '0', null, null, null);
INSERT INTO `main_scene` VALUES ('i3l62nl9000054y2', 'scene', '2', '55', 'scene/i3l62nl9000054yq/i3o80zxw5yx8u=876908222,2146973101&fm=21&gp=0.jpg', '1', '1000', '0', '1', null, '0', '0', '0', null, null, null);
INSERT INTO `main_scene` VALUES ('i3l62nl9000054y3', 'scene', '2', '212', 'scene/i3l62nl9000054yq/i3o80zxw5yx8u=876908222,2146973101&fm=21&gp=0.jpg', '1', '0', '0', '1', null, '0', '0', '0', null, null, null);
INSERT INTO `main_scene` VALUES ('i3l62nl9000054y4', 'scene', '1', '21', 'scene/i3l62nl9000054yq/i3o80zxw5yx8u=876908222,2146973101&fm=21&gp=0.jpg', '1', '2', '0', '1', null, '0', '0', '0', null, null, null);
INSERT INTO `main_scene` VALUES ('i3l62nl9000054y5', 'scene', '1', '333', 'scene/i3l62nl9000054yq/i3o80zxw5yx8u=876908222,2146973101&fm=21&gp=0.jpg', '1', '33', '0', '1', null, '0', '0', '0', null, null, null);
INSERT INTO `main_scene` VALUES ('i3l62nl9000054y6', 'scene', '1', '100', 'scene/i3l62nl9000054yq/i3o80zxw5yx8u=876908222,2146973101&fm=21&gp=0.jpg', '1', '21', '0', '1', null, '0', '0', '0', null, null, null);
INSERT INTO `main_scene` VALUES ('i3l62nl9000054y7', 'scene', '1', '22', 'scene/i3l62nl9000054yq/i3o80zxw5yx8u=876908222,2146973101&fm=21&gp=0.jpg', '1', '21', '0', '1', null, '0', '0', '0', null, null, null);
INSERT INTO `main_scene` VALUES ('i3l62nl9000054yq', 'scene', '2', '2', 'scene/i3l62nl9000054yq/i3o80zxw5yx8u=876908222,2146973101&fm=21&gp=0.jpg', '1', '0', '0', '1', null, '0', '0', '0', null, null, null);
INSERT INTO `main_scene` VALUES ('i3p7esh700008380', 'agent', '1', '21', 'scene/i3l62nl9000054yq/i3o80zxw5yx8u=876908222,2146973101&fm=21&gp=0.jpg', '1', '21', '0', '1', null, '0', '0', '0', null, null, null);
INSERT INTO `main_scene` VALUES ('i3p7j7p80000gy73', 'dress1', '2', '21', 'scene/i3l62nl9000054yq/i3o80zxw5yx8u=876908222,2146973101&fm=21&gp=0.jpg', '1', '21', '0', '1', null, '0', '0', '0', null, null, null);
INSERT INTO `main_scene` VALUES ('i3p7jgcr0000c9aj', 'zhou', '2', '55', 'scene/i3l62nl9000054yq/i3o80zxw5yx8u=876908222,2146973101&fm=21&gp=0.jpg', '1', '33', '0', '1', null, '0', '0', '0', null, null, null);
INSERT INTO `main_scene` VALUES ('i3p7k5y90000fwed', 'zhou', '2', '3', 'scene/i3l62nl9000054yq/i3o80zxw5yx8u=876908222,2146973101&fm=21&gp=0.jpg', '1', '2', '0', '1', null, '0', '0', '0', null, null, null);
INSERT INTO `main_scene` VALUES ('i3p7lxec0000kuwh', 'zhou', '2', '55', 'scene/i3l62nl9000054yq/i3o80zxw5yx8u=876908222,2146973101&fm=21&gp=0.jpg', '1', '0', '0', '1', null, '0', '0', '0', null, null, null);
INSERT INTO `main_scene` VALUES ('i3p7nvyp0000ey10', 'scene', '1', '22', 'scene/i3l62nl9000054yq/i3o80zxw5yx8u=876908222,2146973101&fm=21&gp=0.jpg', '1', '21', '0', '1', null, null, '0', '0', null, null, null);
INSERT INTO `main_scene` VALUES ('i3p7nvyp0000eyp2', 'dress1', '2', '3', 'scene/i3l62nl9000054yq/i3o80zxw5yx8u=876908222,2146973101&fm=21&gp=0.jpg', '1', '1000', '0', '1', null, '0', '0', '0', null, null, null);
INSERT INTO `main_scene` VALUES ('i3p7nvyp0000eyp3', 's1', '2', '3', 'scene/i3l62nl9000054yq/i3o80zxw5yx8u=876908222,2146973101&fm=21&gp=0.jpg', '1', '555', '0', '1', null, '0', '0', '0', null, null, null);
INSERT INTO `main_scene` VALUES ('i3p7nvyp0000eyp4', 'scene', '1', '45', 'scene/i3l62nl9000054yq/i3o80zxw5yx8u=876908222,2146973101&fm=21&gp=0.jpg', '1', '21', '0', '1', null, '0', '0', '0', null, null, null);
INSERT INTO `main_scene` VALUES ('i3p7nvyp0000eyp5', 'scene', '1', '55', 'scene/i3l62nl9000054yq/i3o80zxw5yx8u=876908222,2146973101&fm=21&gp=0.jpg', '1', '21', '0', '1', null, '0', '0', '0', null, null, null);
INSERT INTO `main_scene` VALUES ('i3p7nvyp0000eyp6', 'scene', '1', '212', 'scene/i3l62nl9000054yq/i3o80zxw5yx8u=876908222,2146973101&fm=21&gp=0.jpg', '1', '33', '0', '1', null, '0', '0', '0', null, null, null);
INSERT INTO `main_scene` VALUES ('i3p7nvyp0000eyp7', 'scene', '1', '21', 'scene/i3l62nl9000054yq/i3o80zxw5yx8u=876908222,2146973101&fm=21&gp=0.jpg', '1', '2', '0', '1', null, null, '0', '0', null, null, null);
INSERT INTO `main_scene` VALUES ('i3p7nvyp0000eyp8', 'scene', '1', '333', 'scene/i3l62nl9000054yq/i3o80zxw5yx8u=876908222,2146973101&fm=21&gp=0.jpg', '1', '33', '0', '1', null, null, '0', '0', null, null, null);
INSERT INTO `main_scene` VALUES ('i3p7nvyp0000eyp9', 'scene', '1', '100', 'scene/i3l62nl9000054yq/i3o80zxw5yx8u=876908222,2146973101&fm=21&gp=0.jpg', '1', '21', '0', '1', null, '0', '0', '0', null, null, null);
INSERT INTO `main_scene` VALUES ('i3p7o8ua00006md0', 'scene', '2', '45', 'scene/i3l62nl9000054yq/i3o80zxw5yx8u=876908222,2146973101&fm=21&gp=0.jpg', '1', '0', '0', '1', null, '0', '0', '0', null, null, null);
INSERT INTO `main_scene` VALUES ('i3p7o8ua00006md1', 'scene', '2', '55', 'scene/i3l62nl9000054yq/i3o80zxw5yx8u=876908222,2146973101&fm=21&gp=0.jpg', '1', '2', '0', '1', null, '0', '0', '0', null, null, null);
INSERT INTO `main_scene` VALUES ('i3p7o8ua00006md2', 'scene', '2', '212', 'scene/i3l62nl9000054yq/i3o80zxw5yx8u=876908222,2146973101&fm=21&gp=0.jpg', '1', '33', '0', '1', null, '0', '0', '0', null, null, null);
INSERT INTO `main_scene` VALUES ('i3p7o8ua00006md3', 'scene', '1', '21', 'scene/i3l62nl9000054yq/i3o80zxw5yx8u=876908222,2146973101&fm=21&gp=0.jpg', '1', '21', '0', '1', null, '0', '0', '0', null, null, null);
INSERT INTO `main_scene` VALUES ('i3p7o8ua00006md4', 'scene', '2', '333', 'scene/i3p7o8ua00006md4/i3pntkdycc97u=1107240171,1485576461&fm=21&gp=0.jpg', '1', '1000', '0', '1', null, '0', '0', '0', null, null, null);
INSERT INTO `main_scene` VALUES ('i3p7o8ua00006md5', 'scene', '1', '100', 'scene/i3l62nl9000054yq/i3o80zxw5yx8u=876908222,2146973101&fm=21&gp=0.jpg', '1', '21', '0', '1', null, '0', '0', '0', null, null, null);
INSERT INTO `main_scene` VALUES ('i3p7o8ua00006md6', 'scene', '1', '45', 'scene/i3l62nl9000054yq/i3o80zxw5yx8u=876908222,2146973101&fm=21&gp=0.jpg', '1', '555', '0', '1', null, '0', '0', '0', null, null, null);
INSERT INTO `main_scene` VALUES ('i3p7o8ua00006md7', 'scene', '1', '55', 'scene/i3l62nl9000054yq/i3o80zxw5yx8u=876908222,2146973101&fm=21&gp=0.jpg', '1', '1000', '0', '1', null, '0', '0', '0', null, null, null);
INSERT INTO `main_scene` VALUES ('i3p7o8ua00006md8', 'scene', '2', '212', 'scene/i3p7o8ua00006md8/i3pns07j7ajou=2153165915,502884333&fm=21&gp=0.jpg', '1', '0', '0', '1', null, '0', '0', '0', null, null, null);
INSERT INTO `main_scene` VALUES ('i3p7o8ua00006md9', 'scene', '1', '21', 'scene/i3p7o8ua00006md9/i3pnsomcc48ju=2858664285,579685857&fm=21&gp=0.jpg', '1', '2', '0', '1', null, '0', '0', '0', null, null, null);

-- ----------------------------
-- Table structure for `main_scene_main_package`
-- ----------------------------
DROP TABLE IF EXISTS `main_scene_main_package`;
CREATE TABLE `main_scene_main_package` (
  `scene_id` char(16) NOT NULL,
  `order_id` char(16) NOT NULL,
  PRIMARY KEY (`scene_id`,`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of main_scene_main_package
-- ----------------------------

-- ----------------------------
-- Table structure for `main_scene_order_purchase_order`
-- ----------------------------
DROP TABLE IF EXISTS `main_scene_order_purchase_order`;
CREATE TABLE `main_scene_order_purchase_order` (
  `scene_id` char(16) NOT NULL,
  `order_id` char(16) NOT NULL,
  PRIMARY KEY (`scene_id`,`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of main_scene_order_purchase_order
-- ----------------------------
INSERT INTO `main_scene_order_purchase_order` VALUES ('i2zot7if0000gr7c', 'asasasa12551ssss');
INSERT INTO `main_scene_order_purchase_order` VALUES ('i2zpb6dv0000b7yb', 'asasasa12551ssss');
INSERT INTO `main_scene_order_purchase_order` VALUES ('i2zph0oj00003b9x', 'asasasa12551ssss');
INSERT INTO `main_scene_order_purchase_order` VALUES ('i2zrhrom00006pa5', 'asasasa12551ssss');
INSERT INTO `main_scene_order_purchase_order` VALUES ('i3l0615t0000b9b2', 'asasasa12551ssss');
INSERT INTO `main_scene_order_purchase_order` VALUES ('i3l06d630000lc9f', 'asasasa12551ssss');
INSERT INTO `main_scene_order_purchase_order` VALUES ('i3l06f1z0000gdo3', 'asasasa12551ssss');
INSERT INTO `main_scene_order_purchase_order` VALUES ('i3l06fo700005rfq', 'asasasa12551ssss');
INSERT INTO `main_scene_order_purchase_order` VALUES ('i3l06g400000guaa', 'asasasa12551ssss');
INSERT INTO `main_scene_order_purchase_order` VALUES ('i3l06gmz0000kwb5', 'asasasa12551ssss');
INSERT INTO `main_scene_order_purchase_order` VALUES ('i3l06gvy000011c8', 'asasasa12551ssss');
INSERT INTO `main_scene_order_purchase_order` VALUES ('i3l06h6n0000bbdf', 'asasasa12551ssss');
INSERT INTO `main_scene_order_purchase_order` VALUES ('i3l06hdr0000apbf', 'asasasa12551ssss');
INSERT INTO `main_scene_order_purchase_order` VALUES ('i3l06hpv0000ikdj', 'asasasa12551ssss');
INSERT INTO `main_scene_order_purchase_order` VALUES ('i3l06i2500009rkv', 'asasasa12551ssss');
INSERT INTO `main_scene_order_purchase_order` VALUES ('i3l06i7f0000axn5', 'asasasa12551ssss');
INSERT INTO `main_scene_order_purchase_order` VALUES ('i3l06idh00000vdk', 'asasasa12551ssss');
INSERT INTO `main_scene_order_purchase_order` VALUES ('i3l06iup00001h7c', 'asasasa12551ssss');
INSERT INTO `main_scene_order_purchase_order` VALUES ('i3l06j85000038bj', 'asasasa12551ssss');
INSERT INTO `main_scene_order_purchase_order` VALUES ('i3l06js200005gux', 'asasasa12551ssss');
INSERT INTO `main_scene_order_purchase_order` VALUES ('i3l06kid000054of', 'asasasa12551ssss');
INSERT INTO `main_scene_order_purchase_order` VALUES ('i3l06l0g0000ix6b', 'asasasa12551ssss');
INSERT INTO `main_scene_order_purchase_order` VALUES ('i3l06std0000cc10', 'asasasa12551ssss');
INSERT INTO `main_scene_order_purchase_order` VALUES ('i3l06td60000ex1m', 'asasasa12551ssss');
INSERT INTO `main_scene_order_purchase_order` VALUES ('i3l06tqp0000co71', 'asasasa12551ssss');
INSERT INTO `main_scene_order_purchase_order` VALUES ('i3l06u2b0000l8yl', 'asasasa12551ssss');
INSERT INTO `main_scene_order_purchase_order` VALUES ('i3l06udj00007f14', 'asasasa12551ssss');
INSERT INTO `main_scene_order_purchase_order` VALUES ('i3l06ujc00002dlk', 'asasasa12551ssss');
INSERT INTO `main_scene_order_purchase_order` VALUES ('i3l06uty00009j67', 'asasasa12551ssss');
INSERT INTO `main_scene_order_purchase_order` VALUES ('i3qok3c0000090oi', 'asasasasdas54545');
INSERT INTO `main_scene_order_purchase_order` VALUES ('i3qtsb3l0000i1nc', 'i2o2t4j900009mn7');
INSERT INTO `main_scene_order_purchase_order` VALUES ('i3toj7i30000ihp6', 'i2n6jfhp0000fyl6');
INSERT INTO `main_scene_order_purchase_order` VALUES ('i3trt9ay0000hcfc', 'i2n6hesr00003clc');
INSERT INTO `main_scene_order_purchase_order` VALUES ('i3za1k4s0000hch7', 'asasasasdas54545');
INSERT INTO `main_scene_order_purchase_order` VALUES ('i45eolvl00009q20', 'i2n6hesr00003clc');
INSERT INTO `main_scene_order_purchase_order` VALUES ('i45eolvl00009q20', 'i2n6jfhp0000fyl6');

-- ----------------------------
-- Table structure for `main_scene_picture`
-- ----------------------------
DROP TABLE IF EXISTS `main_scene_picture`;
CREATE TABLE `main_scene_picture` (
  `id` char(16) NOT NULL,
  `scene_id` char(16) NOT NULL,
  `url` char(128) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of main_scene_picture
-- ----------------------------
INSERT INTO `main_scene_picture` VALUES ('i3o8101a00003cb5', 'i3l62nl9000054yq', 'scene/i3l62nl9000054yq/i3o80zxw5yx8u=876908222,2146973101&fm=21&gp=0.jpg');
INSERT INTO `main_scene_picture` VALUES ('i3o8108600005yml', 'i3l62nl9000054yq', 'scene/i3l62nl9000054yq/i3o8104j5wh3u=1107240171,1485576461&fm=21&gp=0.jpg');
INSERT INTO `main_scene_picture` VALUES ('i3o810ed00003yqg', 'i3l62nl9000054yq', 'scene/i3l62nl9000054yq/i3o810as115nu=1783222470,2023300927&fm=21&gp=0.jpg');
INSERT INTO `main_scene_picture` VALUES ('i3o810j20000kriy', 'i3l62nl9000054yq', 'scene/i3l62nl9000054yq/i3o810g93wowu=2153165915,502884333&fm=21&gp=0.jpg');
INSERT INTO `main_scene_picture` VALUES ('i3o810ns000099s7', 'i3l62nl9000054yq', 'scene/i3l62nl9000054yq/i3o810kxc2fuu=2825025891,368624220&fm=90&gp=0.jpg');
INSERT INTO `main_scene_picture` VALUES ('i3o810t800001qz3', 'i3l62nl9000054yq', 'scene/i3l62nl9000054yq/i3o810pqauvvu=2858664285,579685857&fm=21&gp=0.jpg');
INSERT INTO `main_scene_picture` VALUES ('i3o810z60000eisk', 'i3l62nl9000054yq', 'scene/i3l62nl9000054yq/i3o810vg80mgu=3464521770,2862421689&fm=23&gp=0.jpg');
INSERT INTO `main_scene_picture` VALUES ('i3o811340000f0k8', 'i3l62nl9000054yq', 'scene/i3l62nl9000054yq/i3o81113kxtsu=3724796653,80119491&fm=23&gp=0.jpg');
INSERT INTO `main_scene_picture` VALUES ('i3o811750000dsye', 'i3l62nl9000054yq', 'scene/i3l62nl9000054yq/i3o8114w63wbu=4054265897,659890193&fm=21&gp=0.jpg');
INSERT INTO `main_scene_picture` VALUES ('i3o81jlf0000cics', 'i2n803b60000aoho', 'scene/i2n803b60000aoho/i3o81jim7uvbu=876908222,2146973101&fm=21&gp=0.jpg');
INSERT INTO `main_scene_picture` VALUES ('i3o81jou000015ke', 'i2n803b60000aoho', 'scene/i2n803b60000aoho/i3o81jn58z19u=1107240171,1485576461&fm=21&gp=0.jpg');
INSERT INTO `main_scene_picture` VALUES ('i3o81jsk0000kex0', 'i2n803b60000aoho', 'scene/i2n803b60000aoho/i3o81jqtfe45u=1783222470,2023300927&fm=21&gp=0.jpg');
INSERT INTO `main_scene_picture` VALUES ('i3o81jxe000032sv', 'i2n803b60000aoho', 'scene/i2n803b60000aoho/i3o81jvm9157u=2153165915,502884333&fm=21&gp=0.jpg');
INSERT INTO `main_scene_picture` VALUES ('i3o81k2p0000495y', 'i2n803b60000aoho', 'scene/i2n803b60000aoho/i3o81jzx3pg9u=2825025891,368624220&fm=90&gp=0.jpg');
INSERT INTO `main_scene_picture` VALUES ('i3o81k7i0000algg', 'i2n803b60000aoho', 'scene/i2n803b60000aoho/i3o81k4v6omnu=2858664285,579685857&fm=21&gp=0.jpg');
INSERT INTO `main_scene_picture` VALUES ('i3o81kcr0000gn00', 'i2n803b60000aoho', 'scene/i2n803b60000aoho/i3o81k9i41heu=3464521770,2862421689&fm=23&gp=0.jpg');
INSERT INTO `main_scene_picture` VALUES ('i3o81kgv0000aooo', 'i2n803b60000aoho', 'scene/i2n803b60000aoho/i3o81kes7n00u=3724796653,80119491&fm=23&gp=0.jpg');
INSERT INTO `main_scene_picture` VALUES ('i3o81kl1000090fe', 'i2n803b60000aoho', 'scene/i2n803b60000aoho/i3o81kijc7egu=4054265897,659890193&fm=21&gp=0.jpg');
INSERT INTO `main_scene_picture` VALUES ('i3pnrzig0000la3l', 'i3p7o8ua00006md8', 'scene/i3p7o8ua00006md8/i3pnrz7e412vu=876908222,2146973101&fm=21&gp=0.jpg');
INSERT INTO `main_scene_picture` VALUES ('i3pnrznd00001z28', 'i3p7o8ua00006md8', 'scene/i3p7o8ua00006md8/i3pnrzlmeuyau=1107240171,1485576461&fm=21&gp=0.jpg');
INSERT INTO `main_scene_picture` VALUES ('i3pns00000006uud', 'i3p7o8ua00006md8', 'scene/i3p7o8ua00006md8/i3pnrzx590uru=1783222470,2023300927&fm=21&gp=0.jpg');
INSERT INTO `main_scene_picture` VALUES ('i3pns0a70000czru', 'i3p7o8ua00006md8', 'scene/i3p7o8ua00006md8/i3pns07j7ajou=2153165915,502884333&fm=21&gp=0.jpg');
INSERT INTO `main_scene_picture` VALUES ('i3pns0f700003q0f', 'i3p7o8ua00006md8', 'scene/i3p7o8ua00006md8/i3pns0dagkhtu=2825025891,368624220&fm=90&gp=0.jpg');
INSERT INTO `main_scene_picture` VALUES ('i3pns0jz000031dy', 'i3p7o8ua00006md8', 'scene/i3p7o8ua00006md8/i3pns0i8b6tzu=2858664285,579685857&fm=21&gp=0.jpg');
INSERT INTO `main_scene_picture` VALUES ('i3pns0p200009ya5', 'i3p7o8ua00006md8', 'scene/i3p7o8ua00006md8/i3pns0mkl5epu=3464521770,2862421689&fm=23&gp=0.jpg');
INSERT INTO `main_scene_picture` VALUES ('i3pns0v300008rzm', 'i3p7o8ua00006md8', 'scene/i3p7o8ua00006md8/i3pns0s63i99u=3724796653,80119491&fm=23&gp=0.jpg');
INSERT INTO `main_scene_picture` VALUES ('i3pns0z400006q52', 'i3p7o8ua00006md8', 'scene/i3p7o8ua00006md8/i3pns0wu218wu=4054265897,659890193&fm=21&gp=0.jpg');
INSERT INTO `main_scene_picture` VALUES ('i3pnso140000bkfa', 'i3p7o8ua00006md9', 'scene/i3p7o8ua00006md9/i3pnsnxqcwk9u=876908222,2146973101&fm=21&gp=0.jpg');
INSERT INTO `main_scene_picture` VALUES ('i3pnso5u0000ekou', 'i3p7o8ua00006md9', 'scene/i3p7o8ua00006md9/i3pnso3w3ucru=1107240171,1485576461&fm=21&gp=0.jpg');
INSERT INTO `main_scene_picture` VALUES ('i3pnsoar0000j970', 'i3p7o8ua00006md9', 'scene/i3p7o8ua00006md9/i3pnso7p7o43u=1783222470,2023300927&fm=21&gp=0.jpg');
INSERT INTO `main_scene_picture` VALUES ('i3pnsoen0000b4r0', 'i3p7o8ua00006md9', 'scene/i3p7o8ua00006md9/i3pnsod77wt7u=2153165915,502884333&fm=21&gp=0.jpg');
INSERT INTO `main_scene_picture` VALUES ('i3pnsok900006lxa', 'i3p7o8ua00006md9', 'scene/i3p7o8ua00006md9/i3pnsogv2y18u=2825025891,368624220&fm=90&gp=0.jpg');
INSERT INTO `main_scene_picture` VALUES ('i3pnsooa00007qqd', 'i3p7o8ua00006md9', 'scene/i3p7o8ua00006md9/i3pnsomcc48ju=2858664285,579685857&fm=21&gp=0.jpg');
INSERT INTO `main_scene_picture` VALUES ('i3pnsosh0000gvl5', 'i3p7o8ua00006md9', 'scene/i3p7o8ua00006md9/i3pnsoqbakwou=3464521770,2862421689&fm=23&gp=0.jpg');
INSERT INTO `main_scene_picture` VALUES ('i3pnsowl0000iqnq', 'i3p7o8ua00006md9', 'scene/i3p7o8ua00006md9/i3pnsoutcbpzu=3724796653,80119491&fm=23&gp=0.jpg');
INSERT INTO `main_scene_picture` VALUES ('i3pnsp080000f3op', 'i3p7o8ua00006md9', 'scene/i3p7o8ua00006md9/i3pnsoy18sq3u=4054265897,659890193&fm=21&gp=0.jpg');
INSERT INTO `main_scene_picture` VALUES ('i3pntkbg00002lly', 'i3p7o8ua00006md4', 'scene/i3p7o8ua00006md4/i3pntk81ge04u=876908222,2146973101&fm=21&gp=0.jpg');
INSERT INTO `main_scene_picture` VALUES ('i3pntkg20000k9uj', 'i3p7o8ua00006md4', 'scene/i3p7o8ua00006md4/i3pntkdycc97u=1107240171,1485576461&fm=21&gp=0.jpg');
INSERT INTO `main_scene_picture` VALUES ('i3pntkjv0000fcoo', 'i3p7o8ua00006md4', 'scene/i3p7o8ua00006md4/i3pntkhp6qwru=1783222470,2023300927&fm=21&gp=0.jpg');
INSERT INTO `main_scene_picture` VALUES ('i3pntkp4000060kc', 'i3p7o8ua00006md4', 'scene/i3p7o8ua00006md4/i3pntkma5k9cu=2153165915,502884333&fm=21&gp=0.jpg');
INSERT INTO `main_scene_picture` VALUES ('i3pntkt600000m3v', 'i3p7o8ua00006md4', 'scene/i3p7o8ua00006md4/i3pntkr5j8ifu=2825025891,368624220&fm=90&gp=0.jpg');
INSERT INTO `main_scene_picture` VALUES ('i3pntkxt0000ddyy', 'i3p7o8ua00006md4', 'scene/i3p7o8ua00006md4/i3pntkvmb8j7u=2858664285,579685857&fm=21&gp=0.jpg');
INSERT INTO `main_scene_picture` VALUES ('i3pntl2g0000jgqe', 'i3p7o8ua00006md4', 'scene/i3p7o8ua00006md4/i3pntl098xxxu=3464521770,2862421689&fm=23&gp=0.jpg');
INSERT INTO `main_scene_picture` VALUES ('i3pntl7700006jte', 'i3p7o8ua00006md4', 'scene/i3p7o8ua00006md4/i3pntl4zkkhou=3724796653,80119491&fm=23&gp=0.jpg');
INSERT INTO `main_scene_picture` VALUES ('i3pntlbc000034o8', 'i3p7o8ua00006md4', 'scene/i3p7o8ua00006md4/i3pntl9e3x3ju=4054265897,659890193&fm=21&gp=0.jpg');
INSERT INTO `main_scene_picture` VALUES ('i4jjkuiz0000inas', 'asasasa12551ssss', 'scene/asasasa12551ssss/i4jjkc4x8t6tscene01.jpg');
INSERT INTO `main_scene_picture` VALUES ('i4jjmubo00000o8i', 'asasasa12551ssss', 'scene/asasasa12551ssss/i4jjmu3m1h07scene01.jpg');

-- ----------------------------
-- Table structure for `main_shop`
-- ----------------------------
DROP TABLE IF EXISTS `main_shop`;
CREATE TABLE `main_shop` (
  `id` char(16) NOT NULL,
  `name` varchar(16) CHARACTER SET utf8 NOT NULL,
  `phone` char(12) NOT NULL,
  `header` varchar(12) CHARACTER SET utf8 NOT NULL,
  `city_id` char(16) NOT NULL,
  `province_id` char(16) DEFAULT NULL,
  `description` text CHARACTER SET utf8 NOT NULL,
  `address` varchar(128) CHARACTER SET utf8 NOT NULL,
  `status` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of main_shop
-- ----------------------------
INSERT INTO `main_shop` VALUES ('i46ov3b20000dmt7', '约拍啦北京体验店', '1523645859', '吴阳', '1236547891159753', null, '我不知道地址', '三里屯街道', '0');

-- ----------------------------
-- Table structure for `order_coupon`
-- ----------------------------
DROP TABLE IF EXISTS `order_coupon`;
CREATE TABLE `order_coupon` (
  `id` char(16) NOT NULL,
  `serial` char(8) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `coupon_record_id` char(16) NOT NULL,
  `consumer_id` char(16) DEFAULT NULL,
  `consume_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `serial` (`serial`) USING HASH
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of order_coupon
-- ----------------------------
INSERT INTO `order_coupon` VALUES ('i3vd99i60000i7m7', '10000467', '2', 'i3vd99qm0000j4eq', '142544sdsadsa', null);
INSERT INTO `order_coupon` VALUES ('i3vd99ik00002iux', '10000240', '2', 'i3vgy0bs00007en6', '142544sdsadsa', null);
INSERT INTO `order_coupon` VALUES ('i3vd99ik00008zvk', '10000713', '2', 'i3vgy0bs00007en6', 'i2d30lym00008w6i', null);
INSERT INTO `order_coupon` VALUES ('i3vd99ik00009eg9', '10000225', '2', 'i3vgy0bs00007en6', null, null);
INSERT INTO `order_coupon` VALUES ('i3vd99ik0000dql0', '10000746', '2', 'i3vhimsb00005cp5', 'i2d30lym00008w6i', null);
INSERT INTO `order_coupon` VALUES ('i3vd99ik0000hnrz', '10000203', '2', 'i3vhimsb00005cp5', null, null);
INSERT INTO `order_coupon` VALUES ('i3vd99ik0000ivus', '10000725', '1', 'i3wezkym00001a8f', null, null);
INSERT INTO `order_coupon` VALUES ('i3vd99ik0000j8p6', '10000634', '1', 'i3wezkym00001a8f', null, null);
INSERT INTO `order_coupon` VALUES ('i3vd99il000030gu', '10000271', '1', 'i3wezkym00001a8f', null, null);
INSERT INTO `order_coupon` VALUES ('i3vd99il00003dnn', '10000236', '2', 'i3vgy0bs00007en6', null, null);
INSERT INTO `order_coupon` VALUES ('i3vd99il000082p6', '10000200', '2', 'i3vgy0bs00007en6', 'i46klrti00000m0u', null);
INSERT INTO `order_coupon` VALUES ('i3vd99il0000f076', '10000564', '2', 'i3vgy0bs00007en6', '142544sdsadsa', null);
INSERT INTO `order_coupon` VALUES ('i3vd99il0000i97g', '10000123', '2', 'i3vhimsb00005cp5', 'i2d30lym00008w6i', null);
INSERT INTO `order_coupon` VALUES ('i3vd99im00009an6', '10000611', '2', 'i3vhimsb00005cp5', null, null);
INSERT INTO `order_coupon` VALUES ('i3vd99im0000fy68', '10000822', '1', 'i3wezkym00001a8f', null, null);
INSERT INTO `order_coupon` VALUES ('i3vd99im0000kwl1', '10000417', '1', 'i3wezkym00001a8f', null, null);
INSERT INTO `order_coupon` VALUES ('i3vd99in0000gv4c', '10000612', '1', 'i3wezkym00001a8f', null, null);
INSERT INTO `order_coupon` VALUES ('i3vd99in0000jwgb', '10000742', '2', 'i3vgy0bs00007en6', 'i2d30lym00008w6i', null);
INSERT INTO `order_coupon` VALUES ('i3vd99io00000ab2', '10000920', '2', 'i3vgy0bs00007en6', 'i2d30lym00008w6i', null);
INSERT INTO `order_coupon` VALUES ('i3vd99io00001k7m', '10000141', '2', 'i3vgy0bs00007en6', 'i4c2h4h70000l6po', null);
INSERT INTO `order_coupon` VALUES ('i3vd99io00001rz8', '10000160', '2', 'i3vhimsb00005cp5', 'i4982kd400006jlx', null);
INSERT INTO `order_coupon` VALUES ('i3vd99io00008v3n', '10000140', '2', 'i3vhimsb00005cp5', 'i2d30lym00008w6i', null);
INSERT INTO `order_coupon` VALUES ('i3vd99io0000jeno', '10000361', '1', 'i3wezkym00001a8f', null, null);
INSERT INTO `order_coupon` VALUES ('i3vd99io0000k60d', '10000508', '1', 'i3wezkym00001a8f', null, null);
INSERT INTO `order_coupon` VALUES ('i3vd99io0000legb', '10000732', '1', 'i3wezkym00001a8f', null, null);
INSERT INTO `order_coupon` VALUES ('i3vd99ip0000bv71', '10000307', '2', 'i3vgy0bs00007en6', '142544sdsadsa', null);
INSERT INTO `order_coupon` VALUES ('i3vd99ip0000cooe', '10000409', '2', 'i3vgy0bs00007en6', '142544sdsadsa', null);
INSERT INTO `order_coupon` VALUES ('i3vd99ip0000e0c5', '10000110', '2', 'i3vgy0bs00007en6', 'i4c2mye30000b4dd', null);
INSERT INTO `order_coupon` VALUES ('i3vd99ip0000f6th', '10000132', '2', 'i3vhimsb00005cp5', 'i2d30lym00008w6i', null);
INSERT INTO `order_coupon` VALUES ('i3vd99ip0000kuvu', '10000819', '2', 'i3vhimsb00005cp5', 'i2d30lym00008w6i', null);
INSERT INTO `order_coupon` VALUES ('i3vda8xq00002wdt', '20000557', '2', 'i3wezkym00001a8f', null, null);
INSERT INTO `order_coupon` VALUES ('i3vda8xr00006owc', '20000542', '1', 'i3wezkym00001a8f', null, null);
INSERT INTO `order_coupon` VALUES ('i3vda8xr0000b311', '20000765', '2', 'i3wezkym00001a8f', null, null);
INSERT INTO `order_coupon` VALUES ('i3vda8xr0000bbtk', '20000482', '1', 'i3wezkym00001a8f', null, null);
INSERT INTO `order_coupon` VALUES ('i3vda8xr0000f5cx', '20000595', '2', 'i3wezkym00001a8f', null, null);
INSERT INTO `order_coupon` VALUES ('i3vda8xr0000f900', '20000481', '1', 'i3wezkym00001a8f', null, null);
INSERT INTO `order_coupon` VALUES ('i3vda8xr0000ho6i', '20000853', '2', 'i3vgy0bs00007en6', null, null);
INSERT INTO `order_coupon` VALUES ('i3vda8xr0000kls3', '20000837', '2', 'i3vgy0bs00007en6', null, null);
INSERT INTO `order_coupon` VALUES ('i3vda8xs00000l8g', '20000396', '1', 'i3vgy0bs00007en6', null, null);
INSERT INTO `order_coupon` VALUES ('i3vda8xs00008m3d', '20000717', '2', 'i3vhimsb00005cp5', null, null);
INSERT INTO `order_coupon` VALUES ('i3vda8xs0000cfh2', '20000794', '2', 'i3vhimsb00005cp5', null, null);
INSERT INTO `order_coupon` VALUES ('i3vda8xs0000gc4a', '20000968', '1', 'i3wezkym00001a8f', null, null);
INSERT INTO `order_coupon` VALUES ('i3vda8xs0000gqvw', '20000537', '1', 'i3wezkym00001a8f', null, null);
INSERT INTO `order_coupon` VALUES ('i3vda8xs0000hl2y', '20000600', '2', 'i3wezkym00001a8f', null, null);
INSERT INTO `order_coupon` VALUES ('i3vda8xs0000jgaw', '20000654', '2', 'i3wezkym00001a8f', null, null);
INSERT INTO `order_coupon` VALUES ('i3vgya6c0000gs2t', '10000974', '2', 'i3vgy0bs00007en6', null, null);
INSERT INTO `order_coupon` VALUES ('i3vgya6o00006q1h', '10000888', '2', 'i3vgy0bs00007en6', 'i2d30lym00008w6i', null);
INSERT INTO `order_coupon` VALUES ('i3vgya6p0000ip0d', '10000309', '2', 'i3vgy0bs00007en6', '142544sdsadsa', null);
INSERT INTO `order_coupon` VALUES ('i3vhimsm00008zl5', '1000936', '2', 'i3vhimsb00005cp5', 'i2d30lym00008w6i', null);
INSERT INTO `order_coupon` VALUES ('i3vhimsy000061h2', '1000778', '2', 'i3vhimsb00005cp5', 'i2d30lym00008w6i', null);
INSERT INTO `order_coupon` VALUES ('i3wezkz10000413k', '10000319', '1', 'i3wezkym00001a8f', null, null);
INSERT INTO `order_coupon` VALUES ('i3wezkza0000e6op', '10001611', '1', 'i3wezkym00001a8f', null, null);
INSERT INTO `order_coupon` VALUES ('i3wezkzb0000cys5', '10002611', '1', 'i3wezkym00001a8f', null, null);
INSERT INTO `order_coupon` VALUES ('i3wq32650000gcll', '10000415', '1', 'i3wq2z6200006ooj', null, null);
INSERT INTO `order_coupon` VALUES ('i3wq326h00005q8r', '10001459', '1', 'i3wq2z6200006ooj', null, null);
INSERT INTO `order_coupon` VALUES ('i3wq326i00005plx', '10004217', '1', 'i3wq2z6200006ooj', null, null);
INSERT INTO `order_coupon` VALUES ('i3wq326i00006ohu', '10005840', '1', 'i3wq2z6200006ooj', null, null);
INSERT INTO `order_coupon` VALUES ('i3wq326i00008n2d', '10003705', '1', 'i3wq2z6200006ooj', null, null);
INSERT INTO `order_coupon` VALUES ('i3wq326i0000e2wq', '10002319', '1', 'i3wq2z6200006ooj', null, null);
INSERT INTO `order_coupon` VALUES ('i3wq326j0000707n', '10007212', '1', 'i3wq2z6200006ooj', null, null);
INSERT INTO `order_coupon` VALUES ('i3wq326j0000cb23', '10006771', '1', 'i3wq2z6200006ooj', null, null);
INSERT INTO `order_coupon` VALUES ('i3wq326j0000gfnu', '10009695', '1', 'i3wq2z6200006ooj', null, null);
INSERT INTO `order_coupon` VALUES ('i3wq326j0000ioiw', '10008184', '1', 'i3wq2z6200006ooj', null, null);
INSERT INTO `order_coupon` VALUES ('i3wq326k00000b3o', '10010575', '1', 'i3wq2z6200006ooj', null, null);
INSERT INTO `order_coupon` VALUES ('i3wq326k00002n2w', '10011149', '1', 'i3wq2z6200006ooj', null, null);
INSERT INTO `order_coupon` VALUES ('i3wq326k0000c0hq', '10012268', '1', 'i3wq2z6200006ooj', null, null);
INSERT INTO `order_coupon` VALUES ('i3z8rwo80000feu7', '10000695', '1', 'i3z8rwnd000057cc', null, null);
INSERT INTO `order_coupon` VALUES ('i3z8rwon00003xvl', '10001666', '1', 'i3z8rwnd000057cc', null, null);
INSERT INTO `order_coupon` VALUES ('i3z8rwoo00002idr', '10002755', '1', 'i3z8rwnd000057cc', null, null);
INSERT INTO `order_coupon` VALUES ('i3z8uwp50000drxb', '10000368', '1', 'i3z8uemr0000jajm', null, null);
INSERT INTO `order_coupon` VALUES ('i3z8uwqx0000hwar', '10001713', '1', 'i3z8uemr0000jajm', null, null);
INSERT INTO `order_coupon` VALUES ('i3z8uwqz0000ajci', '10002529', '1', 'i3z8uemr0000jajm', null, null);

-- ----------------------------
-- Table structure for `order_coupon_record`
-- ----------------------------
DROP TABLE IF EXISTS `order_coupon_record`;
CREATE TABLE `order_coupon_record` (
  `id` char(16) NOT NULL,
  `amount` int(16) DEFAULT NULL,
  `create_date_time` datetime(6) DEFAULT NULL,
  `create_user_id` char(16) DEFAULT NULL,
  `start_number` char(9) DEFAULT NULL,
  `ptype` tinyint(4) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `money` decimal(6,2) DEFAULT NULL,
  `city_id` char(16) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of order_coupon_record
-- ----------------------------
INSERT INTO `order_coupon_record` VALUES ('i3vd99qm0000j4eq', '30', '2014-12-19 17:40:19.000000', null, '10000', '1', '2014-12-02', '2014-12-28', '99.00', '1236547891159753');
INSERT INTO `order_coupon_record` VALUES ('i3vda90f00008xyk', '15', '2014-12-19 17:41:05.000000', null, '20000', '2', '2014-12-02', '2014-12-22', '168.00', '1236547891159753');
INSERT INTO `order_coupon_record` VALUES ('i3vgy0bs00007en6', '3', '2014-12-19 19:23:32.000000', null, '10000', '1', '2014-12-10', '2014-12-25', '4545.00', '1236547891159753');
INSERT INTO `order_coupon_record` VALUES ('i3vhimsb00005cp5', '2', '2014-12-19 19:39:34.000000', null, '1000', '1', '2014-12-11', '2014-12-20', '7.00', '1236547891159753');
INSERT INTO `order_coupon_record` VALUES ('i3wezkym00001a8f', '3', '2014-12-20 11:16:33.000000', null, '10000', '1', '2014-12-02', '2014-12-03', '55.00', 'china');
INSERT INTO `order_coupon_record` VALUES ('i3wq2z6200006ooj', '13', '2014-12-20 16:26:53.000000', 'i2d30lym00008w6i', '10000', '1', '2014-12-10', '2014-12-26', '55.00', '2');
INSERT INTO `order_coupon_record` VALUES ('i3z8rwnd000057cc', '3', '2014-12-22 10:44:07.000000', 'i2d30lym00008w6i', '10000', '-1', '2014-12-04', '2014-12-03', '4545.00', 'china');
INSERT INTO `order_coupon_record` VALUES ('i3z8uemr0000jajm', '3', '2014-12-22 10:47:13.000000', 'i2d30lym00008w6i', '10000', null, '2014-12-19', '2014-12-02', '4545.00', 'china');

-- ----------------------------
-- Table structure for `order_favorite_dress`
-- ----------------------------
DROP TABLE IF EXISTS `order_favorite_dress`;
CREATE TABLE `order_favorite_dress` (
  `id` char(16) NOT NULL,
  `user_id` char(16) DEFAULT NULL,
  `create_date_time` datetime NOT NULL,
  `dress_id` char(16) DEFAULT NULL,
  `ptype` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of order_favorite_dress
-- ----------------------------
INSERT INTO `order_favorite_dress` VALUES ('1', 'i34bbagp0000i1gq', '2014-12-15 11:29:08', 'i2y3o4ci00002ujx', null);
INSERT INTO `order_favorite_dress` VALUES ('2', 'i34bbagp0000i1gq', '2014-12-15 11:29:08', 'i2y3o4ci00002ujx', null);
INSERT INTO `order_favorite_dress` VALUES ('i3s9mwol0000dfbl', 'i3juelfi0000ek21', '2014-12-17 13:35:38', 'shgfbjnk457plok', '1');

-- ----------------------------
-- Table structure for `order_favorite_package`
-- ----------------------------
DROP TABLE IF EXISTS `order_favorite_package`;
CREATE TABLE `order_favorite_package` (
  `id` char(16) NOT NULL,
  `package_id` char(16) NOT NULL,
  `user_id` char(16) NOT NULL,
  `ptype` tinyint(4) NOT NULL,
  `create_date_time` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of order_favorite_package
-- ----------------------------

-- ----------------------------
-- Table structure for `order_favorite_photo_frame`
-- ----------------------------
DROP TABLE IF EXISTS `order_favorite_photo_frame`;
CREATE TABLE `order_favorite_photo_frame` (
  `id` char(16) NOT NULL,
  `user_id` char(16) DEFAULT NULL,
  `create_date_time` datetime NOT NULL,
  `photo_frame_id` char(16) DEFAULT NULL,
  `ptype` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of order_favorite_photo_frame
-- ----------------------------
INSERT INTO `order_favorite_photo_frame` VALUES ('11', 'i34bbagp0000i1gq', '2014-12-01 18:42:57', '1', '1');
INSERT INTO `order_favorite_photo_frame` VALUES ('21', 'i3juelfi0000ek21', '2014-12-02 08:42:57', '2', '2');

-- ----------------------------
-- Table structure for `order_favorite_photographer`
-- ----------------------------
DROP TABLE IF EXISTS `order_favorite_photographer`;
CREATE TABLE `order_favorite_photographer` (
  `id` char(16) NOT NULL,
  `user_id` char(16) NOT NULL,
  `create_date_time` datetime NOT NULL,
  `photographer_id` char(16) NOT NULL,
  `ptype` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of order_favorite_photographer
-- ----------------------------
INSERT INTO `order_favorite_photographer` VALUES ('i38flhcs0000k9zt', 'i34bbagp0000i1gq', '2014-12-03 16:27:06', 'i2d4b43f00005ikh', '1');
INSERT INTO `order_favorite_photographer` VALUES ('i38fp3uq00006nq9', 'i34bbagp0000i1gq', '2014-12-03 16:29:55', 'i2d4b43f00005ikh', '1');
INSERT INTO `order_favorite_photographer` VALUES ('i38fpdj20000azn2', 'i34bbagp0000i1gq', '2014-12-03 16:30:08', 'i2d4b43f00005ikh', '1');
INSERT INTO `order_favorite_photographer` VALUES ('i4mdzpab0000hje3', 'i3juelfi0000ek21', '2015-01-07 15:30:39', 'i3jxkwv40000hcdm', '1');
INSERT INTO `order_favorite_photographer` VALUES ('i4miu6rr0000a8ph', 'i3juelfi0000ek21', '2015-01-07 17:46:20', 'i2d30lym00008w6i', '1');

-- ----------------------------
-- Table structure for `order_favorite_scene`
-- ----------------------------
DROP TABLE IF EXISTS `order_favorite_scene`;
CREATE TABLE `order_favorite_scene` (
  `id` char(16) NOT NULL,
  `user_id` char(16) NOT NULL,
  `create_date_time` datetime NOT NULL,
  `scene_id` char(16) NOT NULL,
  `ptype` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of order_favorite_scene
-- ----------------------------
INSERT INTO `order_favorite_scene` VALUES ('', '', '0000-00-00 00:00:00', '', null);
INSERT INTO `order_favorite_scene` VALUES ('3', 'i34bbagp0000i1gq', '2014-12-02 18:26:07', 'asasasa12551ssss', null);
INSERT INTO `order_favorite_scene` VALUES ('4', 'i34bbagp0000i1gq', '2014-12-02 18:26:07', 'asasasa12551ssss', null);
INSERT INTO `order_favorite_scene` VALUES ('6', 'i34bbagp0000i1gq', '2014-12-02 18:26:07', 'asasasa12551ssss', null);
INSERT INTO `order_favorite_scene` VALUES ('i3sadc4c00003jt2', 'i3juelfi0000ek21', '2014-12-17 13:56:12', 'i2n6hesr00003clc', '1');
INSERT INTO `order_favorite_scene` VALUES ('i3sag6cd00001io4', 'i3juelfi0000ek21', '2014-12-17 13:58:24', 'i2n6hesr00003clc', '1');
INSERT INTO `order_favorite_scene` VALUES ('i3sehg430000igay', 'i3juelfi0000ek21', '2014-12-17 15:51:22', 'i2o2t4j900009mn7', '1');
INSERT INTO `order_favorite_scene` VALUES ('i3sehiww0000atuz', 'i3juelfi0000ek21', '2014-12-17 15:51:25', 'i2o2t4j900009mn7', '1');
INSERT INTO `order_favorite_scene` VALUES ('i3sehjyr00004p98', 'i3juelfi0000ek21', '2014-12-17 15:51:27', 'i2o2t4j900009mn7', '1');
INSERT INTO `order_favorite_scene` VALUES ('i3sehm3j000055l2', 'i3juelfi0000ek21', '2014-12-17 15:51:30', 'i2o2t4j900009mn7', '1');
INSERT INTO `order_favorite_scene` VALUES ('i3sehr4o00000ywg', 'i3juelfi0000ek21', '2014-12-17 15:51:36', 'i2o2t4j900009mn7', '1');

-- ----------------------------
-- Table structure for `order_purchase_order`
-- ----------------------------
DROP TABLE IF EXISTS `order_purchase_order`;
CREATE TABLE `order_purchase_order` (
  `id` char(16) CHARACTER SET latin1 NOT NULL,
  `photographer_id` char(16) CHARACTER SET latin1 NOT NULL,
  `dresser_id` char(16) CHARACTER SET latin1 DEFAULT NULL,
  `fixer_id` char(16) CHARACTER SET latin1 DEFAULT NULL,
  `model_id` char(16) CHARACTER SET latin1 DEFAULT NULL,
  `ptype` tinyint(4) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `process_status` tinyint(4) NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `consumer_id` char(16) CHARACTER SET latin1 NOT NULL,
  `create_datetime` datetime NOT NULL,
  `purchase_order_serial` char(16) COLLATE utf8_unicode_ci NOT NULL,
  `requirement` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `shot_time` tinyint(4) DEFAULT NULL,
  `original_photo_number` tinyint(4) DEFAULT NULL,
  `fixed_photo_number` tinyint(4) DEFAULT NULL,
  `purchase_order_payment_id` char(16) CHARACTER SET latin1 DEFAULT NULL,
  `purchase_order_delivery_id` char(16) CHARACTER SET latin1 DEFAULT NULL,
  `agent_id` char(16) CHARACTER SET latin1 DEFAULT NULL,
  `designer_id` char(16) CHARACTER SET latin1 DEFAULT NULL,
  `group_shot_id` char(16) COLLATE utf8_unicode_ci DEFAULT NULL,
  `father_purchase_order_id` char(16) COLLATE utf8_unicode_ci DEFAULT NULL,
  `customization_id` char(16) CHARACTER SET utf8 DEFAULT NULL,
  `order_type` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of order_purchase_order
-- ----------------------------
INSERT INTO `order_purchase_order` VALUES ('i3fkricf00002vgu', '', null, null, null, '1', '1', '1', '2345.00', 'i3jxkwv40000hcdm', '2014-12-08 16:26:09', '1418027169183', null, null, null, null, null, null, null, null, null, null, 'i3fkric90000k7ti', null);
INSERT INTO `order_purchase_order` VALUES ('i3sj7put0000d3w2', 'i2d4b43f00005ikh', null, null, null, '1', '1', '1', '0.01', 'i3juelfi0000ek21', '2014-12-17 18:03:46', '1418810626466', null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `order_purchase_order` VALUES ('i3sj888n0000jsen', 'i2d4b43f00005ikh', null, null, null, '1', '1', '1', '0.01', 'i3juelfi0000ek21', '2014-12-17 18:04:10', '1418810650294', null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `order_purchase_order` VALUES ('i3sofj0x0000ervt', 'i2pzsfv2000016nx', 'i2pzsfv2000016nx', null, null, '2', '1', '1', '10000.00', 'i2pzsfv2000016nx', '2014-12-17 20:29:48', '1418545373644', '一定要拍好！！！', '1', '0', '0', null, null, 'i2pzsfv2000016nx', null, null, null, null, null);
INSERT INTO `order_purchase_order` VALUES ('i45eolvl00009q20', 'i3jxkwv40000hcdm', null, null, null, '2', '1', '2', '584.00', 'i3juelfi0000ek21', '2014-12-26 18:17:56', '1419589076672', null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `order_purchase_order` VALUES ('i46r4q4h0000eczz', 'i3jxkwv40000hcdm', null, null, null, '1', '1', '2', '2345.00', 'i3juelfi0000ek21', '2014-12-27 16:54:10', '1419670450241', null, null, null, null, null, null, null, null, null, null, 'i46r4ewz00001u7n', null);
INSERT INTO `order_purchase_order` VALUES ('i47abcke0000fghj', 'i2d30lym00008w6l', null, null, null, '1', '1', '1', '212.00', 'i49as8kv00000fiv', '2014-12-29 13:33:22', '1419831202762', null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `order_purchase_order` VALUES ('i4gr1oer00009cr7', 'i39pzafo0000jckl', null, null, null, '1', '1', '1', '0.00', 'i3juelfi0000ek21', '2015-01-03 16:49:29', '1420274969809', null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `order_purchase_order` VALUES ('i4gr48db0000dmwo', 'i39pzafo0000jckl', null, null, null, '2', '1', '1', '4647.00', 'i3juelfi0000ek21', '2015-01-03 16:51:28', '1420275088991', null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `order_purchase_order` VALUES ('i4kzodxj0000cf3g', 'i3jxkwv40000hcdm', null, null, null, '1', '1', '1', '2345.00', 'i3juelfi0000ek21', '2015-01-06 16:02:10', '1420531330951', null, null, null, null, null, null, null, null, null, null, 'i4kzodxd0000l3tz', null);
INSERT INTO `order_purchase_order` VALUES ('i4mbx93t0000i1qc', 'i39pzafo0000jckl', null, null, null, '1', '1', '1', '1200.00', 'i3juelfi0000ek21', '2015-01-07 14:32:46', '1420612366165', null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `order_purchase_order` VALUES ('i4ml47fl000088fb', 'i2d30lym00008w6i', null, null, null, '1', '1', '1', '2345.00', 'i3juelfi0000ek21', '2015-01-07 18:50:07', '1420627807137', null, null, null, null, null, null, null, null, null, null, 'i4ml47fk00008xcv', null);
INSERT INTO `order_purchase_order` VALUES ('i4mlgval0000kagl', 'i2d30lym00008w6i', null, null, null, '1', '0', '1', '2345.00', 'i3juelfi0000ek21', '2015-01-07 18:59:57', '1420628397933', null, null, null, null, null, null, null, null, null, null, 'i4mlgval0000cbw4', null);

-- ----------------------------
-- Table structure for `order_purchase_order_comment`
-- ----------------------------
DROP TABLE IF EXISTS `order_purchase_order_comment`;
CREATE TABLE `order_purchase_order_comment` (
  `id` char(16) NOT NULL,
  `purchase_order_id` char(16) NOT NULL,
  `comment_type` tinyint(4) NOT NULL,
  `mark` tinyint(4) DEFAULT NULL,
  `content` varchar(128) CHARACTER SET utf8 NOT NULL,
  `user_id` char(16) NOT NULL,
  `photographer_id` char(32) CHARACTER SET latin1 COLLATE latin1_german1_ci NOT NULL,
  `create_date_time` datetime NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT 'è®¢å•è¯„ä»· åˆ é™¤çŠ¶æ€',
  `proffional_mark` tinyint(4) DEFAULT NULL,
  `service_mark` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of order_purchase_order_comment
-- ----------------------------
INSERT INTO `order_purchase_order_comment` VALUES ('1111', 'i3sj4ege0000jxif', '1', '2', '非常好！！！给力', 'i2d30lym00008w6i', 'i2d30lym00008w6i', '2014-11-24 11:25:47', '0', '1', '1');
INSERT INTO `order_purchase_order_comment` VALUES ('isjh12548', 'i3sj4ege0000jxif', '1', '2', '摄影技术非常棒！', 'i2d30lym00008w6i', 'i2d30lym00008w6i', '2014-11-10 20:32:12', '0', '1', '1');
INSERT INTO `order_purchase_order_comment` VALUES ('isjh1254822', 'i46r4q4h0000eczz', '1', '2', '摄影技术非常棒！test', 'i2d30lym00008w6i', 'i3jxkwv40000hcdm', '2014-11-10 20:32:12', '0', '1', '1');
INSERT INTO `order_purchase_order_comment` VALUES ('isjh125482200', 'i46r4q4h0000eczz', '1', '2', '摄影技术非常棒！test', 'i2d30lym00008w6i', 'i3jxkwv40000hcdm', '2014-11-10 20:32:12', '1', '1', '1');
INSERT INTO `order_purchase_order_comment` VALUES ('isjh125482221', 'i46r4q4h0000eczz', '1', '2', '摄影技术非常棒！test', 'i2d30lym00008w6i', 'i3jxkwv40000hcdm', '2014-11-10 20:32:12', '1', '3', '1');
INSERT INTO `order_purchase_order_comment` VALUES ('isjh12548754kjhu', 'i46r4q4h0000eczz', '1', '2', 'sss', 'i2d4b43f00005ikh', 'i3450btg0000763x', '2014-11-10 20:32:12', '0', '1', '1');
INSERT INTO `order_purchase_order_comment` VALUES ('ssas145kljkhmnjk', 'i3sj4ege0000jxif', '1', '2', 'sss', 'i34bbagp0000i1gq', 'i3450btg0000763x', '2014-12-10 15:02:09', '1', '1', '1');
INSERT INTO `order_purchase_order_comment` VALUES ('ssssssssssssssss', 'i3sj4ege0000jxif', '1', '2', 'ss', 'i3juelfi0000ek21', 'i2d4b43f00005ikh', '2014-12-17 15:03:24', '1', '1', '1');
INSERT INTO `order_purchase_order_comment` VALUES ('wwwwwwwwwwwwwwww', 'i3sj4ege0000jxif', '1', '2', 'sss', 'i3juelfi0000ek21', 'i2d30lym00008w6i', '2014-12-09 15:03:40', '1', '1', '1');
INSERT INTO `order_purchase_order_comment` VALUES ('zzzzzzzzzzzzzzzz', 'i3sj4ege0000jxif', '1', '2', 's', 'i49as8kv00000fiv', 'i39pzafo0000jckl', '2014-12-10 15:03:09', '2', '1', '1');

-- ----------------------------
-- Table structure for `order_purchase_order_delivery`
-- ----------------------------
DROP TABLE IF EXISTS `order_purchase_order_delivery`;
CREATE TABLE `order_purchase_order_delivery` (
  `id` char(16) NOT NULL,
  `reciver_name` varchar(16) NOT NULL,
  `reciver_phone` char(16) NOT NULL,
  `company` varchar(32) DEFAULT NULL,
  `send_time` datetime DEFAULT NULL,
  `serial` char(16) DEFAULT NULL,
  `purchase_order_id` char(16) NOT NULL,
  `photo_frame_provider_id` char(16) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of order_purchase_order_delivery
-- ----------------------------
INSERT INTO `order_purchase_order_delivery` VALUES ('se1424dfgt1gh1jm', 'ycz', '18039670918', '51yuepai', '2013-11-24 11:25:33', '201412111125', '11111', 'i2d30lym00008w6i');
INSERT INTO `order_purchase_order_delivery` VALUES ('se1424dfgt1gh1ju', 'zyc', '15313060718', 'ypl', '2014-12-11 11:05:38', '201412111105', 'i2pkh4wt0000du4p', 'i2d30lym00008w6i');

-- ----------------------------
-- Table structure for `order_purchase_order_payment`
-- ----------------------------
DROP TABLE IF EXISTS `order_purchase_order_payment`;
CREATE TABLE `order_purchase_order_payment` (
  `id` char(16) NOT NULL DEFAULT '',
  `purchase_order_id` char(16) NOT NULL,
  `payed` decimal(10,2) NOT NULL,
  `gateway` tinyint(4) NOT NULL,
  `user_id` char(16) DEFAULT NULL,
  `create_datetime` datetime NOT NULL,
  `alipay_trade_no` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of order_purchase_order_payment
-- ----------------------------
INSERT INTO `order_purchase_order_payment` VALUES ('assssssssss45201', 'i3sj4ege0000jxif', '111.00', '1', 'i2d30lym00008w6i', '2014-12-09 13:49:14', '20141211102635');
INSERT INTO `order_purchase_order_payment` VALUES ('assssssssss45202', 'i3sj7put0000d3w2', '222.00', '1', 'i2d30lym00008w6i', '2014-11-18 16:18:39', '20141211102655');
INSERT INTO `order_purchase_order_payment` VALUES ('assssssssss45203', 'i3sj7put0000d3w2', '333.00', '1', 'i2d30lym00008w6i', '2014-12-03 11:22:38', '20141211102659');

-- ----------------------------
-- Table structure for `order_receive_address`
-- ----------------------------
DROP TABLE IF EXISTS `order_receive_address`;
CREATE TABLE `order_receive_address` (
  `id` char(16) NOT NULL,
  `user_id` char(16) NOT NULL,
  `default_type` tinyint(1) NOT NULL,
  `province_id` char(16) DEFAULT NULL,
  `city_id` char(16) DEFAULT NULL,
  `details` varchar(255) DEFAULT NULL,
  `postcode` varchar(16) DEFAULT NULL,
  `name` varchar(128) DEFAULT NULL,
  `phone` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of order_receive_address
-- ----------------------------
INSERT INTO `order_receive_address` VALUES ('1', 'i34bbagp0000i1gq', '0', '1', '1', '三里屯soho', '100000', 'xMan', '1300000000');
INSERT INTO `order_receive_address` VALUES ('i3lb70im00000rr8', 'i34bbagp0000i1gq', '1', null, '1', '富东嘉园', '111000', '慢点先生', '123444');
INSERT INTO `order_receive_address` VALUES ('i45cvo4m00007wr8', 'i3juelfi0000ek21', '1', '', '1', 'fdsafsd', '116600', '111', '+8641187316567');
INSERT INTO `order_receive_address` VALUES ('i45cwc4s0000if5b', 'i3juelfi0000ek21', '1', null, '1', 'fdsfsd', '111111', 'ds', '13000000000');
INSERT INTO `order_receive_address` VALUES ('i45cwnm80000kpia', 'i3juelfi0000ek21', '0', null, '1', 'fdsfsd', '111111', 'ds', '13000000000');

-- ----------------------------
-- Table structure for `organization_address_city`
-- ----------------------------
DROP TABLE IF EXISTS `organization_address_city`;
CREATE TABLE `organization_address_city` (
  `id` char(16) NOT NULL,
  `city_name` varchar(16) NOT NULL,
  `province_id` char(16) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of organization_address_city
-- ----------------------------
INSERT INTO `organization_address_city` VALUES ('1', ' 北京', '21');
INSERT INTO `organization_address_city` VALUES ('2', '哈尔滨', '1');

-- ----------------------------
-- Table structure for `organization_address_district`
-- ----------------------------
DROP TABLE IF EXISTS `organization_address_district`;
CREATE TABLE `organization_address_district` (
  `id` char(16) NOT NULL,
  `name` varchar(16) NOT NULL,
  `CITY_ID` char(16) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of organization_address_district
-- ----------------------------

-- ----------------------------
-- Table structure for `organization_address_province`
-- ----------------------------
DROP TABLE IF EXISTS `organization_address_province`;
CREATE TABLE `organization_address_province` (
  `id` char(16) NOT NULL,
  `name` varchar(16) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of organization_address_province
-- ----------------------------
INSERT INTO `organization_address_province` VALUES ('1', '黑龙江');
INSERT INTO `organization_address_province` VALUES ('21', '北京');

-- ----------------------------
-- Table structure for `organization_agent`
-- ----------------------------
DROP TABLE IF EXISTS `organization_agent`;
CREATE TABLE `organization_agent` (
  `id` char(16) NOT NULL,
  `cost` int(11) NOT NULL,
  `introduce` text CHARACTER SET utf8 NOT NULL,
  `grade` tinyint(4) NOT NULL,
  `praise` int(11) DEFAULT NULL,
  `average` int(11) DEFAULT NULL,
  `poor` int(11) DEFAULT NULL,
  `score` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of organization_agent
-- ----------------------------
INSERT INTO `organization_agent` VALUES ('i4an5j3r00006xt8', '212', 'introduce', '1', null, null, null, null);

-- ----------------------------
-- Table structure for `organization_branch`
-- ----------------------------
DROP TABLE IF EXISTS `organization_branch`;
CREATE TABLE `organization_branch` (
  `id` char(16) NOT NULL,
  `name` varchar(16) NOT NULL,
  `school_name` varchar(16) DEFAULT NULL,
  `the_status` tinyint(4) DEFAULT NULL,
  `province_id` char(16) DEFAULT NULL,
  `city_id` char(16) DEFAULT NULL,
  `district_id` char(16) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `attachment_id` char(16) DEFAULT NULL,
  `branch_version` char(16) DEFAULT NULL,
  `setting` char(32) DEFAULT NULL,
  `license` char(128) DEFAULT NULL,
  `mode` int(11) DEFAULT NULL,
  `serial` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of organization_branch
-- ----------------------------
INSERT INTO `organization_branch` VALUES ('ajsjdjlfkajsdf1j', 't_054502', 't_054502', '3', null, null, null, '2014-11-11 17:54:05', null, 'edu', null, 'userLimit:3;teachAreaLimit:1;validate:64255da5ca957997d92f7fbb1eb4b6ca', '0', '054502');
INSERT INTO `organization_branch` VALUES ('i2d30ly60000dile', 't_054502', 't_054502', '3', null, null, null, '2014-11-11 17:54:05', null, 'edu', null, 'userLimit:3;teachAreaLimit:1;validate:64255da5ca957997d92f7fbb1eb4b6ca', '0', '054502');
INSERT INTO `organization_branch` VALUES ('i2d4b43c0000504l', 't_022226', 't_022226', '3', null, null, null, '2014-11-11 18:30:15', null, 'edu', null, 'userLimit:3;teachAreaLimit:1;validate:64255da5ca957997d92f7fbb1eb4b6ca', '0', '022226');
INSERT INTO `organization_branch` VALUES ('i2d4rede0000a4sk', 't_748530', 't_748530', '3', null, null, null, '2014-11-11 18:42:55', null, 'edu', null, 'userLimit:3;teachAreaLimit:1;validate:64255da5ca957997d92f7fbb1eb4b6ca', '0', '748530');
INSERT INTO `organization_branch` VALUES ('i2d50uky00009jhv', 't_707499', 't_707499', '3', null, null, null, '2014-11-11 18:50:16', null, 'edu', null, 'userLimit:3;teachAreaLimit:1;validate:64255da5ca957997d92f7fbb1eb4b6ca', '0', '707499');
INSERT INTO `organization_branch` VALUES ('i2ffpj9l0000chhd', 't_025868', 't_025868', '1', null, null, null, '2014-11-13 09:24:56', null, 'edu', null, 'userLimit:3;teachAreaLimit:1;validate:64255da5ca957997d92f7fbb1eb4b6ca', '0', '025868');
INSERT INTO `organization_branch` VALUES ('i2ffui540000jlwx', 't_176754', 't_176754', '1', null, null, null, '2014-11-13 09:28:48', null, 'edu', null, 'userLimit:3;teachAreaLimit:1;validate:64255da5ca957997d92f7fbb1eb4b6ca', '0', '176754');

-- ----------------------------
-- Table structure for `organization_city`
-- ----------------------------
DROP TABLE IF EXISTS `organization_city`;
CREATE TABLE `organization_city` (
  `id` char(16) NOT NULL,
  `name` varchar(32) NOT NULL,
  `thestatus` tinyint(4) NOT NULL DEFAULT '0',
  `province_id` char(16) NOT NULL,
  `type` tinyint(4) DEFAULT NULL,
  `father_city_id` char(16) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of organization_city
-- ----------------------------
INSERT INTO `organization_city` VALUES ('1236547891159753', '??', '1', 'chainbeijing0002', null, null);
INSERT INTO `organization_city` VALUES ('1236547891159754', '??', '1', 'chainbeijing0001', null, null);
INSERT INTO `organization_city` VALUES ('1472583697456123', '??', '1', 'chainbeijing0001', null, null);
INSERT INTO `organization_city` VALUES ('1597534561123456', '??', '1', 'chainbeijing0001', null, null);
INSERT INTO `organization_city` VALUES ('7894561231789456', '邯郸', '1', 'chainbeijing0001', null, null);

-- ----------------------------
-- Table structure for `organization_consumer`
-- ----------------------------
DROP TABLE IF EXISTS `organization_consumer`;
CREATE TABLE `organization_consumer` (
  `id` char(16) NOT NULL,
  `credit` smallint(6) NOT NULL DEFAULT '0',
  `yuepaibi` smallint(6) NOT NULL DEFAULT '0',
  `school` tinyint(4) DEFAULT NULL,
  `dormitory` varchar(32) DEFAULT NULL,
  `source_type` char(16) DEFAULT NULL,
  `consumer_organization_id` char(16) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of organization_consumer
-- ----------------------------
INSERT INTO `organization_consumer` VALUES ('i34bbagp0000i1gq', '0', '0', null, null, null, null);
INSERT INTO `organization_consumer` VALUES ('i3juelfi0000ek21', '0', '0', null, null, null, null);
INSERT INTO `organization_consumer` VALUES ('i3p7y51u0000ky65', '0', '0', null, null, null, null);
INSERT INTO `organization_consumer` VALUES ('i3u0jn6n00002ma4', '0', '0', null, '', null, null);
INSERT INTO `organization_consumer` VALUES ('i42b099n0000aj2q', '0', '0', null, null, null, null);
INSERT INTO `organization_consumer` VALUES ('i450c1pc0000fhee', '0', '0', null, null, null, null);
INSERT INTO `organization_consumer` VALUES ('i46k1fe90000bt0z', '0', '0', null, null, null, null);
INSERT INTO `organization_consumer` VALUES ('i46k6x6y0000ieae', '0', '0', null, null, null, 'i42irxff0000i99h');
INSERT INTO `organization_consumer` VALUES ('i46ke7xv000029jj', '0', '0', null, null, 'college', 'i42irxff0000i99h');
INSERT INTO `organization_consumer` VALUES ('i46klrti00000m0u', '0', '0', null, null, 'college', 'i42irxff0000i99h');
INSERT INTO `organization_consumer` VALUES ('i4982kd400006jlx', '0', '0', null, null, 'college', 'i42irxff0000i99h');
INSERT INTO `organization_consumer` VALUES ('i49as8kv00000fiv', '0', '0', null, null, null, null);
INSERT INTO `organization_consumer` VALUES ('i4c2h4h70000l6po', '0', '0', null, null, 'college', 'i42irxff0000i99h');
INSERT INTO `organization_consumer` VALUES ('i4c2mye30000b4dd', '0', '0', null, null, 'college', 'i42irxff0000i99h');
INSERT INTO `organization_consumer` VALUES ('i4c5lhd900006hor', '0', '0', null, null, 'company', 'i42jdf8l0000gowx');
INSERT INTO `organization_consumer` VALUES ('i4gfyt5600008yy2', '0', '0', null, null, null, null);
INSERT INTO `organization_consumer` VALUES ('i4gg8lmo0000b8kq', '0', '0', null, null, null, null);
INSERT INTO `organization_consumer` VALUES ('i4ggolqj0000ea0o', '0', '0', null, null, null, null);
INSERT INTO `organization_consumer` VALUES ('i4glg7sg0000cije', '0', '0', null, null, null, null);
INSERT INTO `organization_consumer` VALUES ('jhsgytuhkj451254', '0', '0', null, null, null, null);
INSERT INTO `organization_consumer` VALUES ('sasaasff52gbf12s', '0', '0', null, null, null, null);
INSERT INTO `organization_consumer` VALUES ('sassdf5241lpok25', '0', '0', null, null, null, null);
INSERT INTO `organization_consumer` VALUES ('ssds5247sdjks45s', '0', '0', null, null, null, null);
INSERT INTO `organization_consumer` VALUES ('wqertr5623lokim4', '0', '0', null, null, null, null);
INSERT INTO `organization_consumer` VALUES ('xxssddss556644ss', '0', '0', null, null, null, null);
INSERT INTO `organization_consumer` VALUES ('yhsnjhg452874plo', '0', '0', null, null, null, null);
INSERT INTO `organization_consumer` VALUES ('ztgdh45682sjhngl', '0', '0', null, null, null, null);

-- ----------------------------
-- Table structure for `organization_consumer_organization`
-- ----------------------------
DROP TABLE IF EXISTS `organization_consumer_organization`;
CREATE TABLE `organization_consumer_organization` (
  `id` char(16) NOT NULL,
  `name` varchar(16) NOT NULL,
  `city_id` char(16) DEFAULT NULL,
  `source_type` char(16) DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of organization_consumer_organization
-- ----------------------------
INSERT INTO `organization_consumer_organization` VALUES ('i42irxff0000i99h', '北京大学', '1236547891159753', 'college', '1');
INSERT INTO `organization_consumer_organization` VALUES ('i42jdf8l0000gowx', '约拍啦', '1236547891159753', 'company', '1');

-- ----------------------------
-- Table structure for `organization_designer`
-- ----------------------------
DROP TABLE IF EXISTS `organization_designer`;
CREATE TABLE `organization_designer` (
  `id` char(16) NOT NULL,
  `introduce` char(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of organization_designer
-- ----------------------------
INSERT INTO `organization_designer` VALUES ('jhsgytuhkj451254', 's');

-- ----------------------------
-- Table structure for `organization_dresser`
-- ----------------------------
DROP TABLE IF EXISTS `organization_dresser`;
CREATE TABLE `organization_dresser` (
  `id` char(16) NOT NULL,
  `agent_id` char(16) NOT NULL,
  `work_time` varchar(32) NOT NULL,
  `cost` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of organization_dresser
-- ----------------------------
INSERT INTO `organization_dresser` VALUES ('i2pxp7tx0000dkib', 'i2px44kk0000916m', '3', '541');
INSERT INTO `organization_dresser` VALUES ('i2pzntm70000a0cr', 'i2px44kk0000916m', '3', '454');
INSERT INTO `organization_dresser` VALUES ('i2pzsfv2000016nx', 'i2px44kk0000916m', '5', '545');
INSERT INTO `organization_dresser` VALUES ('i3tto90300003u3r', 'i2ode9kh00008m5l', '0', '233');
INSERT INTO `organization_dresser` VALUES ('i3ttqgy600009ps9', 'ztgdh45682sjhngl', '0', '212');
INSERT INTO `organization_dresser` VALUES ('i43sm9en0000cwmw', 'i2o43kqf0000kmgu', '0', '233');
INSERT INTO `organization_dresser` VALUES ('i45bxqaj00005v1s', 'i2d30lym00008w6i', '0', '3000');

-- ----------------------------
-- Table structure for `organization_fixer`
-- ----------------------------
DROP TABLE IF EXISTS `organization_fixer`;
CREATE TABLE `organization_fixer` (
  `id` char(16) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of organization_fixer
-- ----------------------------

-- ----------------------------
-- Table structure for `organization_introduce`
-- ----------------------------
DROP TABLE IF EXISTS `organization_introduce`;
CREATE TABLE `organization_introduce` (
  `id` char(16) NOT NULL,
  `introduce` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of organization_introduce
-- ----------------------------

-- ----------------------------
-- Table structure for `organization_manager`
-- ----------------------------
DROP TABLE IF EXISTS `organization_manager`;
CREATE TABLE `organization_manager` (
  `id` char(16) NOT NULL,
  `memo` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of organization_manager
-- ----------------------------
INSERT INTO `organization_manager` VALUES ('i2qvpadp0000burd', null);
INSERT INTO `organization_manager` VALUES ('i2qw37q80000jmm9', null);
INSERT INTO `organization_manager` VALUES ('i3sadsa455421sdw', 'market');

-- ----------------------------
-- Table structure for `organization_model`
-- ----------------------------
DROP TABLE IF EXISTS `organization_model`;
CREATE TABLE `organization_model` (
  `id` char(16) NOT NULL,
  `height` tinyint(4) NOT NULL,
  `weight` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of organization_model
-- ----------------------------

-- ----------------------------
-- Table structure for `organization_permission`
-- ----------------------------
DROP TABLE IF EXISTS `organization_permission`;
CREATE TABLE `organization_permission` (
  `id` char(16) NOT NULL,
  `entity_name` char(32) NOT NULL,
  `entity_label` varchar(16) NOT NULL,
  `is_all` tinyint(4) NOT NULL,
  `basic` char(32) DEFAULT NULL,
  `others` char(16) DEFAULT NULL,
  `role_id` char(16) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of organization_permission
-- ----------------------------
INSERT INTO `organization_permission` VALUES ('i425i38z0000f3qf', 'PurchaseOrder', '订单', '1', 'all', null, 'i425i38s0000fv91');
INSERT INTO `organization_permission` VALUES ('i425i39000004mnu', 'PurchaseOrderDelivery', '寄送信息', '1', 'all', null, 'i425i38s0000fv91');
INSERT INTO `organization_permission` VALUES ('i425i3900000ef3b', 'PurchaseOrderPayment', '支付记录', '1', 'all', null, 'i425i38s0000fv91');
INSERT INTO `organization_permission` VALUES ('i425i3900000i8uo', 'PurchaseOrderComment', '评价信息', '1', 'all', null, 'i425i38s0000fv91');
INSERT INTO `organization_permission` VALUES ('i42fw05l00005kl6', 'Consumer', '消费者', '1', 'all', null, 'i42fw05f0000gvoh');
INSERT INTO `organization_permission` VALUES ('i42fw05l00005kl7', 'ConsumerOrganization', 'xxx', '1', 'all', null, 'i42fw05f0000gvoh');
INSERT INTO `organization_permission` VALUES ('i43hbgwo00000s9m', 'PurchaseOrder', '订单', '1', 'all', null, 'i43hbgwk0000a6f6');
INSERT INTO `organization_permission` VALUES ('i43hbgwp000083xx', 'Photographer', '摄影师', '1', 'all', null, 'i43hbgwk0000a6f6');
INSERT INTO `organization_permission` VALUES ('i43rf5uh00007vyv', 'PurchaseOrder', '订单', '1', 'all', null, 'i43rf5uh0000fbei');
INSERT INTO `organization_permission` VALUES ('i43rf5ui00000vne', 'Coupon', '优惠劵', '1', 'all', null, 'i43rf5uh0000fbei');
INSERT INTO `organization_permission` VALUES ('i43rf5ui000037i0', 'SamplePhotoGroup', '样片组', '1', 'all', null, 'i43rf5uh0000fbei');
INSERT INTO `organization_permission` VALUES ('i43rf5ui00003cr4', 'DressPicture', '服装主图', '1', 'all', null, 'i43rf5uh0000fbei');
INSERT INTO `organization_permission` VALUES ('i43rf5ui00003u4g', 'CouponRecord', '优惠劵生成记录', '1', 'all', null, 'i43rf5uh0000fbei');
INSERT INTO `organization_permission` VALUES ('i43rf5ui000069ef', 'Dress', '服装', '1', 'all', null, 'i43rf5uh0000fbei');
INSERT INTO `organization_permission` VALUES ('i43rf5ui000071mi', 'PurchaseOrderPayment', '支付记录', '1', 'all', null, 'i43rf5uh0000fbei');
INSERT INTO `organization_permission` VALUES ('i43rf5ui000089ed', 'SamplePhoto', '样片', '1', 'all', null, 'i43rf5uh0000fbei');
INSERT INTO `organization_permission` VALUES ('i43rf5ui0000aeg5', 'PurchaseOrderComment', '评价信息', '1', 'all', null, 'i43rf5uh0000fbei');
INSERT INTO `organization_permission` VALUES ('i43rf5ui0000amn5', 'ConsumerPhotoGroup', '客片组', '1', 'all', null, 'i43rf5uh0000fbei');
INSERT INTO `organization_permission` VALUES ('i43rf5ui0000emme', 'ConsumerPhoto', '客片', '1', 'all', null, 'i43rf5uh0000fbei');
INSERT INTO `organization_permission` VALUES ('i43rf5ui0000etjp', 'Scene', '场景', '1', 'all', null, 'i43rf5uh0000fbei');
INSERT INTO `organization_permission` VALUES ('i43rf5ui0000kn7e', 'DressBrand', '服装品牌', '1', 'all', null, 'i43rf5uh0000fbei');
INSERT INTO `organization_permission` VALUES ('i43rf5ui0000l1vt', 'PurchaseOrderDelivery', '寄送信息', '1', 'all', null, 'i43rf5uh0000fbei');
INSERT INTO `organization_permission` VALUES ('i43rf5uj00002yhc', 'Package', '套餐', '1', 'all', null, 'i43rf5uh0000fbei');
INSERT INTO `organization_permission` VALUES ('i43rf5uj000030u8', 'Banner', '轮播图', '1', 'all', null, 'i43rf5uh0000fbei');
INSERT INTO `organization_permission` VALUES ('i43rf5uj00004jts', 'ConsumerOrganization', '所属机构', '1', 'all', null, 'i43rf5uh0000fbei');
INSERT INTO `organization_permission` VALUES ('i43rf5uj000077qt', 'GroupShotTemplate', '团购', '1', 'all', null, 'i43rf5uh0000fbei');
INSERT INTO `organization_permission` VALUES ('i43rf5uj00007vpr', 'SamplePhotoPraise', '赞', '1', 'all', null, 'i43rf5uh0000fbei');
INSERT INTO `organization_permission` VALUES ('i43rf5uj0000847b', 'PhotoFrame', '相框', '1', 'all', null, 'i43rf5uh0000fbei');
INSERT INTO `organization_permission` VALUES ('i43rf5uj00008s9v', 'PhotographerTypePrice', '摄影师擅长类型和价格', '1', 'all', null, 'i43rf5uh0000fbei');
INSERT INTO `organization_permission` VALUES ('i43rf5uj0000gsvt', 'Consumer', '消费者', '1', 'all', null, 'i43rf5uh0000fbei');
INSERT INTO `organization_permission` VALUES ('i43rf5uj0000l7nc', 'Photographer', '摄影师', '1', 'all', null, 'i43rf5uh0000fbei');
INSERT INTO `organization_permission` VALUES ('i43rhdgw0000h4f6', 'PurchaseOrder', '订单', '0', 'view', null, 'i43rhdgw000058kk');
INSERT INTO `organization_permission` VALUES ('i43rhdgx0000529y', 'PurchaseOrderPayment', '支付记录', '0', 'view', null, 'i43rhdgw000058kk');
INSERT INTO `organization_permission` VALUES ('i43rhdgx00005jgu', 'PurchaseOrderDelivery', '寄送信息', '0', 'view', null, 'i43rhdgw000058kk');
INSERT INTO `organization_permission` VALUES ('i43rhdgx0000cfow', 'PurchaseOrderComment', '评价信息', '0', 'view', null, 'i43rhdgw000058kk');
INSERT INTO `organization_permission` VALUES ('i43rjij30000ch0u', 'PurchaseOrderPayment', '支付记录', '0', 'view', null, 'i43rjij30000hh17');
INSERT INTO `organization_permission` VALUES ('i43rjij30000dv9y', 'PurchaseOrder', '订单', '0', 'view', null, 'i43rjij30000hh17');
INSERT INTO `organization_permission` VALUES ('i43rjij30000ho2o', 'PurchaseOrderDelivery', '寄送信息', '0', 'view', null, 'i43rjij30000hh17');
INSERT INTO `organization_permission` VALUES ('i43rjij30000iipz', 'PurchaseOrderComment', '评价信息', '0', 'view', null, 'i43rjij30000hh17');
INSERT INTO `organization_permission` VALUES ('i4iao0e20000ixcy', 'PurchaseOrder', '订单', '1', 'all', null, 'i4233pqp00008idi');
INSERT INTO `organization_permission` VALUES ('i4iao0e800001o4z', 'Coupon', '优惠劵', '1', 'all', null, 'i4233pqp00008idi');
INSERT INTO `organization_permission` VALUES ('i4iao0e800004igj', 'DressBrand', '服装品牌', '1', 'all', null, 'i4233pqp00008idi');
INSERT INTO `organization_permission` VALUES ('i4iao0e800005sh8', 'SamplePhoto', '样片', '1', 'all', null, 'i4233pqp00008idi');
INSERT INTO `organization_permission` VALUES ('i4iao0e800005wsh', 'SamplePhotoPraise', '赞', '1', 'all', null, 'i4233pqp00008idi');
INSERT INTO `organization_permission` VALUES ('i4iao0e800006mjl', 'PurchaseOrderComment', '评价信息', '1', 'all', null, 'i4233pqp00008idi');
INSERT INTO `organization_permission` VALUES ('i4iao0e800008scd', 'ConsumerPhotoGroup', '客片组', '1', 'all', null, 'i4233pqp00008idi');
INSERT INTO `organization_permission` VALUES ('i4iao0e80000a0xe', 'Dress', '服装', '1', 'all', null, 'i4233pqp00008idi');
INSERT INTO `organization_permission` VALUES ('i4iao0e80000a9qo', 'ConsumerPhoto', '客片', '1', 'all', null, 'i4233pqp00008idi');
INSERT INTO `organization_permission` VALUES ('i4iao0e80000bvau', 'CouponRecord', '优惠劵生成记录', '1', 'all', null, 'i4233pqp00008idi');
INSERT INTO `organization_permission` VALUES ('i4iao0e80000cefj', 'DressPicture', '服装主图', '1', 'all', null, 'i4233pqp00008idi');
INSERT INTO `organization_permission` VALUES ('i4iao0e80000cpia', 'SamplePhotoGroup', '样片组', '1', 'all', null, 'i4233pqp00008idi');
INSERT INTO `organization_permission` VALUES ('i4iao0e80000dvf0', 'PurchaseOrderPayment', '支付记录', '1', 'all', null, 'i4233pqp00008idi');
INSERT INTO `organization_permission` VALUES ('i4iao0e80000j5cs', 'PurchaseOrderDelivery', '寄送信息', '1', 'all', null, 'i4233pqp00008idi');
INSERT INTO `organization_permission` VALUES ('i4iao0e80000k91j', 'Scene', '场景', '1', 'all', null, 'i4233pqp00008idi');
INSERT INTO `organization_permission` VALUES ('i4iao0e9000012uy', 'Dresser', '化妆师', '1', 'all', null, 'i4233pqp00008idi');
INSERT INTO `organization_permission` VALUES ('i4iao0e900001537', 'PhotoFrame', '相框', '1', 'all', null, 'i4233pqp00008idi');
INSERT INTO `organization_permission` VALUES ('i4iao0e900002u08', 'ConsumerOrganization', '所属机构', '1', 'all', null, 'i4233pqp00008idi');
INSERT INTO `organization_permission` VALUES ('i4iao0e900007m0q', 'Agent', '经纪人', '1', 'all', null, 'i4233pqp00008idi');
INSERT INTO `organization_permission` VALUES ('i4iao0e900008nbi', 'Consumer', '消费者', '1', 'all', null, 'i4233pqp00008idi');
INSERT INTO `organization_permission` VALUES ('i4iao0e9000094yf', 'Customization', '私人定制', '1', 'all', null, 'i4233pqp00008idi');
INSERT INTO `organization_permission` VALUES ('i4iao0e900009ldm', 'Role', '角色', '1', 'all', null, 'i4233pqp00008idi');
INSERT INTO `organization_permission` VALUES ('i4iao0e90000bzgt', 'Manager', '内部用户', '1', 'all', null, 'i4233pqp00008idi');
INSERT INTO `organization_permission` VALUES ('i4iao0e90000ds1k', 'GroupShot', '团购', '1', 'all', null, 'i4233pqp00008idi');
INSERT INTO `organization_permission` VALUES ('i4iao0e90000enfz', 'Shop', '店铺', '1', 'all', null, 'i4233pqp00008idi');
INSERT INTO `organization_permission` VALUES ('i4iao0e90000gork', 'Document', '文章', '1', 'all', null, 'i4233pqp00008idi');
INSERT INTO `organization_permission` VALUES ('i4iao0e90000gurz', 'Photographer', '摄影师', '1', 'all', null, 'i4233pqp00008idi');
INSERT INTO `organization_permission` VALUES ('i4iao0e90000j40y', 'PhotographerTypePrice', '摄影师擅长类型和价格', '1', 'all', null, 'i4233pqp00008idi');
INSERT INTO `organization_permission` VALUES ('i4iao0e90000k5uk', 'GroupShotTemplate', '团购', '1', 'all', null, 'i4233pqp00008idi');
INSERT INTO `organization_permission` VALUES ('i4iao0e90000l7i2', 'Package', '套餐', '1', 'all', null, 'i4233pqp00008idi');
INSERT INTO `organization_permission` VALUES ('i4iao0ea0000dhbo', 'Banner', '轮播图', '1', 'all', null, 'i4233pqp00008idi');

-- ----------------------------
-- Table structure for `organization_photo_frame_provider`
-- ----------------------------
DROP TABLE IF EXISTS `organization_photo_frame_provider`;
CREATE TABLE `organization_photo_frame_provider` (
  `id` char(16) CHARACTER SET latin1 NOT NULL,
  `introduce` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of organization_photo_frame_provider
-- ----------------------------
INSERT INTO `organization_photo_frame_provider` VALUES ('i2d30lym00008w6i', 'He not only is aphotographer');

-- ----------------------------
-- Table structure for `organization_photographer`
-- ----------------------------
DROP TABLE IF EXISTS `organization_photographer`;
CREATE TABLE `organization_photographer` (
  `id` char(16) NOT NULL,
  `introduce` varchar(256) CHARACTER SET utf8 DEFAULT NULL,
  `work_time` varchar(32) DEFAULT NULL,
  `cardphoto` char(32) DEFAULT NULL,
  `grade` tinyint(4) DEFAULT NULL,
  `bargain_amount` int(11) DEFAULT '0',
  `description` text CHARACTER SET utf8,
  `check_status` tinyint(4) DEFAULT NULL,
  `choiceness_amount` int(11) DEFAULT '0',
  `praise` int(11) DEFAULT '0',
  `average` int(11) DEFAULT '0',
  `poor` int(11) DEFAULT '0',
  `is_recommended` tinyint(4) DEFAULT '0',
  `praise_amount` int(11) DEFAULT '0',
  `visit_amount` int(11) DEFAULT '0',
  `score` int(11) DEFAULT '0',
  `order_amount` int(11) DEFAULT '0',
  `hp_amount` int(11) DEFAULT '0',
  `user_id` char(16) DEFAULT NULL,
  `bank_account` char(32) DEFAULT NULL,
  `alipay_account` char(32) DEFAULT NULL,
  `order_limit` tinyint(4) DEFAULT NULL,
  `shot_time_limit` tinyint(4) DEFAULT NULL,
  `consumer_photos_limit` tinyint(4) DEFAULT NULL,
  `fixed_photos_limit` tinyint(4) DEFAULT NULL,
  `identity_pic_url` char(128) DEFAULT NULL,
  `photographer_pic_url` text CHARACTER SET utf8,
  `reason` text CHARACTER SET utf8,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of organization_photographer
-- ----------------------------
INSERT INTO `organization_photographer` VALUES ('i2d30lym00008w6i', 'yyy', '', '', '4', '0', '', '1', '0', '0', '2', '0', '1', '0', '52', '0', '0', '0', 'i4an5j3r00006xt8', 'i2d30lym00008w6l', null, null, null, null, null, '', 'http://sp.yuepaila.com/photographer/i39pzafo0000jckl/head_2014110713254446.jpg', null);
INSERT INTO `organization_photographer` VALUES ('i2d30lym00008w6l', '', '', '', '3', '0', '', '1', '0', '0', '0', '0', '1', '0', '0', '0', '0', '0', 'i4an5j3r00006xt8', 'i2d30lym00008w6i', null, null, null, null, null, '', 'http://sp.yuepaila.com/photographer/i39pzafo0000jckl/head_2014110713254446.jpg', null);
INSERT INTO `organization_photographer` VALUES ('i2d4b43f00005ikh', null, null, null, '2', null, null, '1', null, null, null, null, '1', '0', null, null, null, null, 'i4an5j3r00006xt8', 'i2d30lym00008w6i', null, null, null, null, null, '', 'http://sp.yuepaila.com/photographer/i39pzafo0000jckl/head_2014110713254446.jpg', null);
INSERT INTO `organization_photographer` VALUES ('i2d4redz00003y5i', null, null, null, '2', null, null, '1', null, null, null, null, '2', '0', null, null, null, null, 'i4an5j3r00006xt8', 'i2d30lym00008w6i', null, null, null, null, null, '', 'http://sp.yuepaila.com/photographer/i39pzafo0000jckl/head_2014110713254446.jpg', null);
INSERT INTO `organization_photographer` VALUES ('i2d50ukz0000e98n', null, null, null, '2', null, null, '1', null, null, null, null, '2', '0', null, null, null, null, 'i4an5j3r00006xt8', 'i2d30lym00008w6i', null, null, null, null, null, '', 'http://sp.yuepaila.com/photographer/i39pzafo0000jckl/head_2014110713254446.jpg', null);
INSERT INTO `organization_photographer` VALUES ('i2ffpja5000088bj', null, null, null, '2', null, null, null, null, null, null, null, '2', '0', null, null, null, null, 'i4an5j3r00006xt8', 'i2d30lym00008w6i', null, null, null, null, null, '', 'http://sp.yuepaila.com/photographer/i39pzafo0000jckl/head_2014110713254446.jpg', null);
INSERT INTO `organization_photographer` VALUES ('i2ffui540000fzk9', null, null, null, '2', null, null, '1', null, null, null, null, '2', '0', null, null, null, null, 'i4an5j3r00006xt8', 'i2d30lym00008w6i', null, null, null, null, null, '', 'http://sp.yuepaila.com/photographer/i39pzafo0000jckl/head_2014110713254446.jpg', null);
INSERT INTO `organization_photographer` VALUES ('i2ode9kh00008m5l', null, null, null, '2', null, null, '1', null, null, null, null, '1', '0', null, null, null, null, 'i4an5j3r00006xt8', 'ztgdh45682sjhngl', null, null, null, null, null, '', 'http://sp.yuepaila.com/photographer/i39pzafo0000jckl/head_2014110713254446.jpg', null);
INSERT INTO `organization_photographer` VALUES ('i2sl9m3n0000an7e', null, null, null, '2', null, null, '2', null, null, null, null, '1', '0', null, null, null, null, 'i4an5j3r00006xt8', 'ztgdh45682sjhngl', null, null, null, null, null, '', 'http://sp.yuepaila.com/photographer/i39pzafo0000jckl/head_2014110713254446.jpg', null);
INSERT INTO `organization_photographer` VALUES ('i2vnyt970000744k', null, null, null, '2', '0', null, '2', '0', '0', '0', '0', '1', '0', '0', '0', '0', '0', 'i4an5j3r00006xt8', 'ztgdh45682sjhngl', null, null, null, null, null, '', 'http://sp.yuepaila.com/photographer/i39pzafo0000jckl/head_2014110713254446.jpg', null);
INSERT INTO `organization_photographer` VALUES ('i2vo2jne0000268v', null, null, null, '2', '0', null, null, '0', '0', '0', '0', null, '0', '0', '0', '0', '0', 'i4an5j3r00006xt8', 'ztgdh45682sjhngl', null, null, null, null, null, '', 'http://sp.yuepaila.com/photographer/i39pzafo0000jckl/head_2014110713254446.jpg', null);
INSERT INTO `organization_photographer` VALUES ('i2vo8l2500009dxu', null, null, null, '2', '0', null, '2', '0', '0', '0', '0', null, '0', '0', '0', '0', '0', 'i4an5j3r00006xt8', 'ztgdh45682sjhngl', null, null, null, null, null, '', 'http://sp.yuepaila.com/photographer/i39pzafo0000jckl/head_2014110713254446.jpg', null);
INSERT INTO `organization_photographer` VALUES ('i2vow4x500003ii3', null, null, null, '2', '0', null, null, '0', '0', '0', '0', null, '0', '0', '0', '0', '0', 'i4an5j3r00006xt8', 'i2d30lym00008w6i', null, null, null, null, null, '', 'http://sp.yuepaila.com/photographer/i39pzafo0000jckl/head_2014110713254446.jpg', null);
INSERT INTO `organization_photographer` VALUES ('i2vpugci00005ns6', null, null, null, '1', null, null, '2', null, null, null, null, null, '0', null, null, null, null, 'i4an5j3r00006xt8', 'i2d30lym00008w6i', null, null, null, null, null, '', 'http://sp.yuepaila.com/photographer/i39pzafo0000jckl/head_2014110713254446.jpg', null);
INSERT INTO `organization_photographer` VALUES ('i31ikml80000gr75', null, null, null, '1', null, null, '2', null, null, null, null, null, '0', null, null, null, null, 'i4an5j3r00006xt8', 'i2d30lym00008w6i', null, null, null, null, null, '', 'http://sp.yuepaila.com/photographer/i39pzafo0000jckl/head_2014110713254446.jpg', null);
INSERT INTO `organization_photographer` VALUES ('i34531dq00002wyp', null, null, null, '1', null, null, null, '0', null, null, null, null, '0', null, null, null, null, 'i4an5j3r00006xt8', 'i2d30lym00008w6i', null, null, null, null, null, '', 'http://sp.yuepaila.com/photographer/i39pzafo0000jckl/head_2014110713254446.jpg', null);
INSERT INTO `organization_photographer` VALUES ('i39pzafo0000jckl', '时光鸡', '20', null, '1', '0', '', '2', '0', null, null, null, null, '0', null, null, null, null, 'i4an5j3r00006xt8', 'ztgdh45682sjhngl', '1231231231', null, null, null, null, 'http://sp.yuepaila.com/photographer/i39pzafo0000jckl/id_2014110713255118.jpg', 'http://sp.yuepaila.com/photographer/i39pzafo0000jckl/head_2014110713260042.jpg@76-23-292-292a', null);
INSERT INTO `organization_photographer` VALUES ('i3gq3ig90000gwqs', null, null, null, '1', null, null, null, '0', null, null, null, null, '0', null, null, null, null, 'i4an5j3r00006xt8', 'ztgdh45682sjhngl', null, null, null, null, null, '', 'http://sp.yuepaila.com/photographer/i39pzafo0000jckl/head_2014110713254446.jpg', null);
INSERT INTO `organization_photographer` VALUES ('i3juelfi0000ek21', null, null, null, '1', null, null, '3', '0', null, null, null, null, '0', null, null, null, null, 'i4an5j3r00006xt8', 'ztgdh45682sjhngl', null, null, null, null, null, '', 'http://sp.yuepaila.com/photographer/i39pzafo0000jckl/head_2014110713254446.jpg', '测试一下');
INSERT INTO `organization_photographer` VALUES ('i3jxkwv40000hcdm', '我是摄影师罗斌', '1111', null, '1', '0', null, '2', '0', '0', '0', '0', null, '0', '0', '0', '0', '0', 'i4an5j3r00006xt8', '3333', '222111', null, null, null, null, '', 'http://sp.yuepaila.com/photographer/i3jxkwv40000hcdm/head_b8389b504fc2d56261e045e3e51190ef77c66cd0.jpg', '审核不通过');
INSERT INTO `organization_photographer` VALUES ('i41xiaozi6666zai', 'wo shi xiao zi', '10', '110', '1', '0', 'haha', '0', '0', '0', '2', '0', '1', '0', '0', '20', '0', '0', 'i4an5j3r00006xt8', '333', '110', '110', '20', '4', '3', 'http://sp.yuepaila.com/i3bacadfa0000alk/1.jpg', 'http://sp.yuepaila.com/i3bacadfa0000alk/1.jpg', null);
INSERT INTO `organization_photographer` VALUES ('i4kxksoy0000daiq', '从业三年 ，曾获北京婚纱摄影大赛金奖', null, null, null, null, '123', null, '0', null, null, null, null, '0', null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `organization_photographer` VALUES ('i4kyoaow0000514b', '你好我是一个知名摄影师', null, null, null, null, '非常知名', null, '0', null, null, null, null, '0', null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `organization_photographer` VALUES ('i4m63q0d00005d7o', '美国wppi最高认证摄影师\r\n中国摄影家协会会员\r\n国家认证高级摄影师\r\n明星婚礼摄影师\r\n', null, null, null, '0', '擅长创作拍摄，为你摄制定独一无二的影像拍摄计划，每一张照片都是艺术品。', '3', '0', '0', null, null, null, '0', null, '5', null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `organization_photographer` VALUES ('i4mof8yv0000dcn2', null, null, null, null, '0', null, '1', '0', '0', '0', '0', null, '0', '0', '0', '0', '0', null, null, null, null, null, null, null, null, null, null);

-- ----------------------------
-- Table structure for `organization_photographer_main_package`
-- ----------------------------
DROP TABLE IF EXISTS `organization_photographer_main_package`;
CREATE TABLE `organization_photographer_main_package` (
  `photographer_id` char(16) NOT NULL,
  `order_id` char(16) NOT NULL,
  PRIMARY KEY (`photographer_id`,`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of organization_photographer_main_package
-- ----------------------------

-- ----------------------------
-- Table structure for `organization_role`
-- ----------------------------
DROP TABLE IF EXISTS `organization_role`;
CREATE TABLE `organization_role` (
  `id` char(16) NOT NULL,
  `name` varchar(12) NOT NULL,
  `basic_type` char(16) NOT NULL,
  `is_super` tinyint(4) NOT NULL,
  `thestatus` tinyint(4) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of organization_role
-- ----------------------------
INSERT INTO `organization_role` VALUES ('i4233pqp00008idi', 'admin', 'admin', '1', '1');
INSERT INTO `organization_role` VALUES ('i42fw05f0000gvoh', '市场部', 'manager', '2', '1');
INSERT INTO `organization_role` VALUES ('i43hbgwk0000a6f6', '经纪人', 'agent', '2', null);
INSERT INTO `organization_role` VALUES ('i43rf5uh0000fbei', '内部用户', 'manager', '2', null);
INSERT INTO `organization_role` VALUES ('i43rhdgw000058kk', '摄影师', 'photographer', '2', null);
INSERT INTO `organization_role` VALUES ('i43rjij30000hh17', '化妆师', 'dress', '2', null);
INSERT INTO `organization_role` VALUES ('idajskjadsjakdjs', '普通用户', 'consumer', '2', null);

-- ----------------------------
-- Table structure for `organization_user`
-- ----------------------------
DROP TABLE IF EXISTS `organization_user`;
CREATE TABLE `organization_user` (
  `id` char(16) NOT NULL,
  `username` varchar(32) NOT NULL,
  `truename` varchar(32) NOT NULL,
  `memo` varchar(128) DEFAULT NULL,
  `role_type` varchar(32) DEFAULT NULL,
  `account_enabled` tinyint(4) NOT NULL DEFAULT '1',
  `account_locked` tinyint(4) NOT NULL,
  `credentials_expited` tinyint(4) NOT NULL,
  `serial` varchar(32) DEFAULT NULL,
  `identity` varchar(32) DEFAULT NULL,
  `birth` datetime DEFAULT NULL,
  `truename2` varchar(12) DEFAULT 'yuepaila_001',
  `password` char(128) NOT NULL,
  `sex` tinyint(4) DEFAULT NULL,
  `email` varchar(32) DEFAULT NULL,
  `phone` char(12) NOT NULL,
  `qq` char(16) DEFAULT '',
  `card_number` char(18) DEFAULT NULL,
  `picture` char(128) DEFAULT NULL,
  `credits` int(11) DEFAULT '0',
  `yuepai_coin` int(11) DEFAULT '0',
  `city_id` char(16) DEFAULT '',
  `province_id` char(16) DEFAULT '',
  `region_id` char(16) DEFAULT '',
  `thestatus` tinyint(4) NOT NULL DEFAULT '1',
  `create_datetime` datetime DEFAULT NULL,
  `work_status` tinyint(4) DEFAULT NULL,
  `branch_id` char(16) DEFAULT NULL,
  `utype` tinyint(4) unsigned zerofill DEFAULT '0001',
  `account_expired` tinyint(4) NOT NULL,
  `role_id` char(16) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of organization_user
-- ----------------------------
INSERT INTO `organization_user` VALUES ('i2d30lym00008w6i', 'zyc', 'zhouyongchao', 's', 'admin', '1', '0', '0', null, null, '2014-11-10 19:30:08', 'yuepaila_001', '7c4a8d09ca3762af61e59520943dc26494f8941b', '1', 'zyc_soft@163.com', '15313060719', '', null, '/images/photographer2.jpg', '0', '0', '1236547891159753', '', '', '1', '2014-11-11 17:54:05', '1', 'ajsjdjlfkajsdf1j', '0011', '0', 'i4233pqp00008idi');
INSERT INTO `organization_user` VALUES ('i2d30lym00008w6l', 'liang', 'liang', null, 'user', '1', '0', '0', null, null, null, 'yuepaila_001', '7c4a8d09ca3762af61e59520943dc26494f8941b', null, 'notbad_wangt@126.com', '13693097151', '', null, '', '0', '0', '4', '', '', '1', '2014-12-19 17:17:55', null, 'i2d4b43c0000504l', '0001', '0', null);
INSERT INTO `organization_user` VALUES ('i2d4b43f00005ikh', 'pgwt', 'wangtao', 'ds', 'user', '1', '0', '0', null, null, '2014-11-10 19:30:12', 'yuepaila_001', '7c4a8d09ca3762af61e59520943dc26494f8941b', '1', 'notbad_wangt@126.com', '13693097151', '', null, '/images/photographer1.jpg', '0', '0', '1236547891159753', '', '', '5', '2014-11-11 18:30:15', '1', 'ajsjdjlfkajsdf1j', '0011', '0', null);
INSERT INTO `organization_user` VALUES ('i2d4redz00003y5i', 'jinxu', 'dddd', 'sa', 'admin', '1', '0', '0', null, null, '2014-10-27 19:30:15', 'yuepaila_001', '1d071768e90b65cb858744a2020f4e37ba18d8be', '1', 'zyc_soft@163.com', '15313060718', '', null, '', '0', '0', '1236547891159753', '', '', '1', '2014-11-11 18:42:55', '1', 'i2d4b43c0000504l', '0011', '0', null);
INSERT INTO `organization_user` VALUES ('i2d50ukz0000e98n', 'zhou', 'cccc', 'ds', 'user', '1', '0', '0', null, null, '2014-11-07 19:30:18', 'yuepaila_001', '1d071768e90b65cb858744a2020f4e37ba18d8be', '1', 'zyc_soft@163.com', '15235654289', '', null, '', '0', '0', '1236547891159753', '', '', '1', '2014-11-11 18:50:16', '1', 'i2d4b43c0000504l', '0011', '0', null);
INSERT INTO `organization_user` VALUES ('i2ffpja5000088bj', 'ycz', 'zhouyongchao', null, 'admin', '1', '0', '0', null, null, '2014-11-04 09:31:29', 'yuepaila_001', '1d071768e90b65cb858744a2020f4e37ba18d8be', '1', '5165161@sa3.xz', '15236542856', '', null, '', '0', '0', '1236547891159753', '', '', '1', '2014-11-13 09:24:56', '1', 'i2d4b43c0000504l', '0011', '0', null);
INSERT INTO `organization_user` VALUES ('i2ffui540000fzk9', 'ypl', 'yuepai', null, 'user', '1', '0', '0', null, null, '2014-10-27 16:28:10', 'yuepaila_001', '7c4a8d09ca3762af61e59520943dc26494f8941b', null, 'zyc_soft@163.com', '15313070718', '', null, '', '0', '0', '1236547891159753', '', '', '1', '2014-11-13 09:28:48', null, 'i2d4b43c0000504l', '0011', '0', null);
INSERT INTO `organization_user` VALUES ('i2ode9kh00008m5l', '13333333333', 'king', null, 'user', '1', '0', '0', null, null, null, 'yuepaila_001', '7c4a8d09ca3762af61e59520943dc26494f8941b', null, 'notbad_wangt@126.com', '13333333333', '', null, null, '0', '0', '1236547891159753', '', '', '1', '2014-11-19 15:30:07', null, 'i2d4b43c0000504l', '0021', '0', null);
INSERT INTO `organization_user` VALUES ('i2sl9m3n0000an7e', 'agent1', 'agent', null, null, '1', '0', '0', null, null, null, null, '123456', null, 'sdasdad@sad.cs', '1523645859', '', null, null, '0', '0', '1236547891159753', '', '', '1', null, '2', 'i2d4b43c0000504l', '0002', '0', null);
INSERT INTO `organization_user` VALUES ('i2vnyt970000744k', 'agent1', 'agent', null, null, '1', '1', '1', null, null, null, null, '123', null, 'sdadsa@ssd.s', '1523645859', '', null, null, '0', '0', '1236547891159753', '', '', '1', '2014-11-24 18:00:25', '1', 'i2d4b43c0000504l', '0002', '1', null);
INSERT INTO `organization_user` VALUES ('i2vo2jne0000268v', 'agent02', 'agent', null, null, '1', '1', '1', null, null, null, null, '123', null, 'sdasdad@sad.cs', '1523645859', '', null, null, '0', '0', '1236547891159753', '', '', '1', '2014-11-24 18:03:19', '1', 'i2d4b43c0000504l', '0002', '1', null);
INSERT INTO `organization_user` VALUES ('i2vo8l2500009dxu', 'agent04', 'agent', null, '', '1', '1', '1', null, null, null, null, '123', null, 'sdasdad@sad.cs', '1523645859', '', null, null, '0', '0', '1236547891159753', '', '', '1', '2014-11-24 18:08:01', '1', 'i2d4b43c0000504l', '0002', '1', null);
INSERT INTO `organization_user` VALUES ('i2vow4x500003ii3', 'agent05', 'agent', null, null, '1', '1', '1', null, null, null, null, '123', null, 'sdasdad@sad.cs', '1523645859', '', null, null, '0', '0', '1236547891159753', '', '', '1', '2014-11-24 18:26:20', '1', 'i2d4b43c0000504l', '0002', '1', null);
INSERT INTO `organization_user` VALUES ('i2vpugci00005ns6', 'pg01', 'zyc', null, null, '1', '1', '1', null, null, null, 'pppp', 'yuepaila', null, 'photographer@pg.com', '1523645859', '', null, null, '0', '0', '1236547891159753', '', '', '1', '2014-11-24 18:53:01', '1', 'i2d4b43c0000504l', '0010', '1', null);
INSERT INTO `organization_user` VALUES ('i31ikml80000gr75', '15898165880', 'lucky', null, null, '0', '1', '1', null, null, null, null, '7777777777', null, '9999999@99.99', '55555555', '', null, null, '0', '0', '1236547891159753', '', '', '1', '2014-11-28 20:16:02', '2', 'i2d4b43c0000504l', '0002', '1', null);
INSERT INTO `organization_user` VALUES ('i34531dq00002wyp', '15898165880', '15898165880', null, 'user', '1', '1', '1', null, null, null, null, '7c4a8d09ca3762af61e59520943dc26494f8941b', null, 'szyc@ssda.cs', '15898165880', '', null, null, '0', '0', '1236547891159753', '', '', '1', '2014-11-30 16:21:45', '1', 'i2d4b43c0000504l', '0001', '1', null);
INSERT INTO `organization_user` VALUES ('i39pzafo0000jckl', '15600548206', 'king', null, 'user', '1', '0', '0', null, null, null, 'yuepaila_001', '7c4a8d09ca3762af61e59520943dc26494f8941b', null, 'zyc_soft@163.com', '15600548206', '', null, 'http://sp.yuepaila.com/photographer/i39pzafo0000jckl/head_2014110713255118.jpg@400w_400h|154-26-207-194a', '0', '0', '1236547891159753', '', '', '5', '2014-12-04 14:05:33', null, 'i2d4b43c0000504l', '0011', '0', 'i43rhdgw000058kk');
INSERT INTO `organization_user` VALUES ('i3gq3ig90000gwqs', '15900000000', '王涛', null, 'user', '1', '0', '0', null, null, null, null, '7c4a8d09ca3762af61e59520943dc26494f8941b', null, 'zyc_soft@163.com', '15900000000', '', null, '/images/photographer2.jpg', '0', '0', '1236547891159753', '', '', '3', '2014-12-09 11:43:13', null, 'i2d4b43c0000504l', '0011', '0', null);
INSERT INTO `organization_user` VALUES ('i3juelfi0000ek21', '13693097151', 'ssss', null, 'user', '1', '0', '0', null, null, null, 'ssssssss', '9e7bd4a3f1f0aa702e36812e05d96259d4619059', null, '', '13693097151', '', null, null, '0', '0', '1236547891159753', '', '', '1', '2014-12-11 16:07:07', '1', null, '0001', '0', 'idajskjadsjakdjs');
INSERT INTO `organization_user` VALUES ('i3jxkwv40000hcdm', '15800000000', 'test', null, 'user', '1', '0', '0', null, null, '2014-12-16 09:29:27', '1321', '9e7bd4a3f1f0aa702e36812e05d96259d4619059', '1', '', '15800000000', '', null, '/images/photographer2.jpg', '0', '0', '1236547891159753', '', '', '0', '2014-12-11 17:36:01', '1', null, '0011', '0', 'i43rhdgw000058kk');
INSERT INTO `organization_user` VALUES ('i41xiaozi6666zai', 'xiaozi', 'xiaozi', 's', 'user', '1', '1', '1', '1', 'dress_01', '2014-12-26 17:33:41', 'xiaozi', '123', '1', 'xiaozi@xiaozi.com', '13666666666', '666666666', '1', 'http://sp.yuepaila.com/photographer/i39pzafo0000jckl/head_2014110713254446.jpg@400w_400h|105-14-170-150a', '0', '0', '2', '1', '1', '1', '2014-12-26 17:36:43', '1', 'i2d4b43c0000504l', '0001', '1', 'i43rjij30000hh17');
INSERT INTO `organization_user` VALUES ('i45bxqaj00005v1s', 'dress_01', 'dress_01', '111', null, '1', '1', '1', null, 'dress_01', null, 'dress_01', '666666', '2', '93619442@qq.com', '15810394270', '', null, null, '0', '0', '2', '', '', '1', '2014-12-26 17:01:03', '1', null, '0031', '1', 'i43rjij30000hh17');
INSERT INTO `organization_user` VALUES ('i46k1fe90000bt0z', '15685658585', '123123,15685658585', null, null, '1', '0', '0', null, null, null, null, '601f1889667efaebb33b8c12572835da3f027f78', null, '', '15685658585', '', null, null, '0', '0', '1236547891159753', '', '', '1', '2014-12-27 13:35:39', null, null, '0001', '0', null);
INSERT INTO `organization_user` VALUES ('i46k6x6y0000ieae', '15485954545', '123123,15485954545', null, null, '1', '0', '0', null, null, null, null, '601f1889667efaebb33b8c12572835da3f027f78', null, '', '15485954545', '', null, null, '0', '0', '1236547891159753', '', '', '1', '2014-12-27 13:39:55', null, null, '0001', '0', null);
INSERT INTO `organization_user` VALUES ('i46ke7xv000029jj', '15689454656', '123123,15689454656', null, null, '1', '0', '0', null, null, null, null, '601f1889667efaebb33b8c12572835da3f027f78', null, '', '15689454656', '', null, null, '0', '0', '1236547891159753', '', '', '1', '2014-12-27 13:45:35', null, null, '0001', '0', null);
INSERT INTO `organization_user` VALUES ('i46klrti00000m0u', '15868565655', '123123,15868565655', null, null, '1', '0', '0', null, null, null, null, '601f1889667efaebb33b8c12572835da3f027f78', null, '', '15868565655', '', null, null, '0', '0', '1236547891159753', '', '', '1', '2014-12-27 13:51:28', null, null, '0001', '0', null);
INSERT INTO `organization_user` VALUES ('i4982kd400006jlx', '13685585845', '123123,13685585845', null, null, '1', '0', '0', null, null, null, null, '601f1889667efaebb33b8c12572835da3f027f78', null, '', '13685585845', '', null, null, '0', '0', '1236547891159753', '', '', '1', '2014-12-29 10:23:55', null, null, '0001', '0', null);
INSERT INTO `organization_user` VALUES ('i49as8kv00000fiv', '15600548207', '15600548207', '', 'user', '1', '0', '0', null, 'qweqwewqe', null, null, '7c4a8d09ca3762af61e59520943dc26494f8941b', null, 'sdadsa@ssd.s', '15600548207', '', null, null, '0', '0', '1236547891159753', '', '', '1', '2014-12-29 11:39:52', '1', 'i2d4b43c0000504l', '0031', '0', 'idajskjadsjakdjs');
INSERT INTO `organization_user` VALUES ('i4an5j3r00006xt8', 'pgwt', '001', null, null, '1', '1', '1', null, null, null, 'pt', '666666', null, 'sdadsa@ssd.s', '13693097151', '', null, null, '0', '0', '1236547891159753', '', '', '0', '2014-12-30 10:13:54', '1', null, '0003', '1', null);
INSERT INTO `organization_user` VALUES ('i4c2h4h70000l6po', '15695545555', 'jsdkfj,15695545555', null, null, '1', '0', '0', null, null, null, null, '601f1889667efaebb33b8c12572835da3f027f78', null, '', '15695545555', '', null, null, '0', '0', '1236547891159753', '', '', '1', '2014-12-31 10:10:35', null, null, '0001', '0', null);
INSERT INTO `organization_user` VALUES ('i4c2mye30000b4dd', '15777777777', 'Qwe,15777777777', null, null, '1', '0', '0', null, null, null, null, '601f1889667efaebb33b8c12572835da3f027f78', null, '', '15777777777', '', null, null, '0', '0', '1236547891159753', '', '', '1', '2014-12-31 10:15:07', null, null, '0001', '0', null);
INSERT INTO `organization_user` VALUES ('i4c5lhd900006hor', '13695545454', '123123,13695545454', null, null, '1', '0', '0', null, null, null, null, '601f1889667efaebb33b8c12572835da3f027f78', null, '', '13695545454', '', null, null, '0', '0', '1236547891159753', '', '', '0', '2014-12-31 11:37:57', null, null, '0001', '0', null);
INSERT INTO `organization_user` VALUES ('i4gfyt5600008yy2', '15256548548', '15256548548', null, null, '1', '0', '0', null, null, null, null, '601f1889667efaebb33b8c12572835da3f027f78', null, '', '15256548548', '', null, null, '0', '0', null, '', '', '1', '2015-01-03 11:39:20', null, null, '0001', '0', null);
INSERT INTO `organization_user` VALUES ('i4gg8lmo0000b8kq', '13695454544', '13695454544', null, null, '1', '0', '0', null, null, null, null, '601f1889667efaebb33b8c12572835da3f027f78', null, '', '13695454544', '', null, null, '0', '0', null, '', '', '1', '2015-01-03 11:46:57', null, null, '0001', '0', null);
INSERT INTO `organization_user` VALUES ('i4ggolqj0000ea0o', '15100000000', '15100000000', null, null, '1', '0', '0', null, null, null, null, '601f1889667efaebb33b8c12572835da3f027f78', null, '', '15100000000', '', null, null, '0', '0', null, '', '', '1', '2015-01-03 11:59:23', null, null, '0001', '0', null);
INSERT INTO `organization_user` VALUES ('i4glg7sg0000cije', '15200000000', '15200000000', null, null, '1', '0', '0', null, null, null, null, '601f1889667efaebb33b8c12572835da3f027f78', null, '', '15200000000', '', null, null, '0', '0', null, '', '', '1', '2015-01-03 14:12:50', null, null, '0001', '0', null);
INSERT INTO `organization_user` VALUES ('i4m63q0d00005d7o', '15810394270', '约拍啦', null, null, '1', '0', '0', null, null, null, null, '3b325837ce67fbba2d0f996278511d02eea43a69', null, '254041742@qq.com', '15810394270', '', '130702198209120318', null, '0', '0', null, '', '', '1', '2014-12-22 00:00:00', null, null, null, '0', null);
INSERT INTO `organization_user` VALUES ('i4mof8yv0000dcn2', '13488684878', '13488684878', null, null, '1', '0', '0', null, null, null, null, '14155179c42a7679e52877b9901f971af454d54a', null, '', '13488684878', '', null, null, '0', '0', null, '', '', '3', '2015-01-07 20:22:41', null, null, '0011', '0', null);



---------------------------------
-- 2015-1-13  start  新库待执行
---------------------------------
--作品集界面添加的热门词汇对应表
 CREATE TABLE main_sample_photo_group_words
(
    id CHAR(16) PRIMARY KEY NOT NULL,
    word CHAR(128) NOT NULL,
    sample_photo_group_id CHAR(16) NOT NULL
);

-- 表organization_address_city主键
ALTER TABLE `organization_user`
ADD COLUMN `address_city_id`  char(16) NULL AFTER `city_id`;


-- 系统中cities.xml中配置的城市id
ALTER TABLE `organization_address_city`
ADD COLUMN `opened_city_id`  char(16) NULL AFTER `province_id`;

--此字段没用
ALTER TABLE `main_sample_photo_group_style`
DROP COLUMN `price`;

-- 系统中cities.xml中配置的城市id与表organization_address_city主键建立映射关系。
-- 每次在cities.xml中添加城市，或修改其中城市id都要在此表中配置上映射关系
update `organization_address_city` set opened_city_id = '1236547891159753' where id=1;--北京市


ALTER TABLE main_dress ADD description text NULL;

ALTER TABLE `order_purchase_order`
ADD COLUMN `shot_date`  date NULL AFTER `order_type`;---------------------------------
-- 2015-1-13  end
---------------------------------

ALTER TABLE yuepaila.main_scene ADD description text NULL;
ALTER TABLE yuepaila.main_scene ADD detailaddress text NULL;
ALTER TABLE yuepaila.main_scene ADD collect_amount int NULL;

ALTER TABLE `main_package`
ADD COLUMN `cover_package_picture_id`  char(16) NULL

ALTER TABLE `main_package`
ADD COLUMN `fixed_photo_number`  int(4) NULL AFTER `cover_package_picture_id`,
ADD COLUMN `original_photo_number`  int(4) NULL AFTER `fixed_photo_number`;

-- 下证件照摄影师可以为空
ALTER TABLE `order_purchase_order`
MODIFY COLUMN `photographer_id`  char(16) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL AFTER `id`;

ALTER TABLE `main_photo_frame`
	MODIFY COLUMN `photo_number` tinyint(4) NOT NULL AFTER `size`,
	MODIFY COLUMN `craft` tinyint(4) NOT NULL AFTER `photo_number`,
	MODIFY COLUMN `material` tinyint(4) NOT NULL AFTER `craft`;


	ALTER TABLE `main_group_shot`
	ADD COLUMN `initiator_id` char(16) NULL AFTER `status`;

	ALTER TABLE `core_p_document`
	ADD COLUMN `title` varchar(32) NULL AFTER `document_content_id`;






ALTER TABLE `main_dress_shop`
ADD COLUMN `channel_index`  smallint NULL AFTER `status`;

ALTER TABLE `main_dress_shop`
ADD COLUMN `home_page_index`  smallint NULL AFTER `channel_index`;


ALTER TABLE `main_group_shot_template`
MODIFY COLUMN `type`  int(11) NULL DEFAULT NULL AFTER `name`,
MODIFY COLUMN `amount_limit`  int(11) NULL DEFAULT NULL AFTER `type`;

--2015/01/17增加收藏
ALTER TABLE `organization_photographer`
ADD COLUMN `favoriteAmount`  int(11) NULL AFTER `identity_pic_with_man_url`;


ALTER TABLE `main_photo_frame`
ADD COLUMN `favoriteAmount`  int(11) NULL AFTER `frame_number`;


ALTER TABLE `main_dress`
ADD COLUMN `favoriteAmount`  int(11) NULL AFTER `dress_style`;

ALTER TABLE `main_scene`
ADD COLUMN `favoriteAmount`  int(11) NULL AFTER `collect_amount`;

ALTER TABLE `main_customization`
MODIFY COLUMN `style`  varchar(255) NULL DEFAULT NULL AFTER `person_amount`;





















ALTER TABLE `main_photographer_type_price`
MODIFY COLUMN `ptype`  smallint(4) NULL DEFAULT NULL AFTER `photographer_id`;

ALTER TABLE `main_photographer_style_type`
MODIFY COLUMN `style`  smallint(4) NOT NULL AFTER `id`,
MODIFY COLUMN `ptype`  smallint(4) NOT NULL AFTER `style`,
MODIFY COLUMN `grade`  smallint(4) NOT NULL AFTER `price`;

ALTER TABLE `main_photographer_type_price`
MODIFY COLUMN `grade`  smallint(4) NULL DEFAULT NULL AFTER `price`,
MODIFY COLUMN `status`  smallint(4) NULL DEFAULT NULL AFTER `channel_index`;

ALTER TABLE `main_sample_photo_group`
MODIFY COLUMN `ptype`  smallint(4) NOT NULL AFTER `status`;

ALTER TABLE `main_sample_photo_group_style`
MODIFY COLUMN `style`  smallint(4) NOT NULL AFTER `sample_photo_group_id`,
MODIFY COLUMN `ptype`  smallint(4) NOT NULL AFTER `style`;

ALTER TABLE `order_coupon_record`
MODIFY COLUMN `ptype`  smallint(4) NULL DEFAULT NULL AFTER `start_number`;

ALTER TABLE `order_favorite_dress`
MODIFY COLUMN `ptype`  smallint(4) NULL DEFAULT NULL AFTER `dress_id`;

ALTER TABLE `order_favorite_package`
MODIFY COLUMN `ptype`  smallint(4) NOT NULL AFTER `user_id`;

ALTER TABLE `order_favorite_photo_frame`
MODIFY COLUMN `ptype`  smallint(4) NULL DEFAULT NULL AFTER `photo_frame_id`;

ALTER TABLE `order_favorite_photographer`
MODIFY COLUMN `ptype`  smallint(4) NULL DEFAULT NULL AFTER `photographer_id`;

ALTER TABLE `order_favorite_scene`
MODIFY COLUMN `ptype`  smallint(4) NULL DEFAULT NULL AFTER `scene_id`;

ALTER TABLE `order_purchase_order`
MODIFY COLUMN `ptype`  smallint(11) NOT NULL AFTER `model_id`;




ALTER TABLE `main_dress`
	DROP COLUMN `sex`,
	MODIFY COLUMN `color_type` tinyint(4) NULL AFTER `price`,
	ADD COLUMN `dress_style` tinyint(4) NULL AFTER `serial`;
	
ALTER TABLE `order_purchase_order`
MODIFY COLUMN `ptype`  int(11) NOT NULL AFTER `model_id`;


ALTER TABLE `main_scene`
	MODIFY COLUMN `description` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL AFTER `channel_index`,
	MODIFY COLUMN `detailaddress` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL AFTER `description`;

ALTER TABLE `main_scene`
	DEFAULT CHARACTER SET=utf8,
	COLLATE=utf8_general_ci;

ALTER TABLE `core_base_relation`
	DEFAULT CHARACTER SET=utf8,
	COLLATE=utf8_general_ci;

	ALTER TABLE `core_bi_grid_report`
	DEFAULT CHARACTER SET=utf8,
	COLLATE=utf8_general_ci;

	ALTER TABLE `core_bi_grid_report_data`
	DEFAULT CHARACTER SET=utf8,
	COLLATE=utf8_general_ci;


	ALTER TABLE `main_package`
	ADD COLUMN `shot_number` text NULL AFTER `original_photo_number`,
	ADD COLUMN `produce` text NULL AFTER `shot_number`,
	ADD COLUMN `scene_range` text NULL AFTER `produce`;

ALTER TABLE `main_photo_frame`
	ADD COLUMN `frame_number` char(16) NULL AFTER `status`;

-------------------------------------
-- 2015-1-15 start 样片的url允许空，否则beta库目前无法上传作品
-------------------------------------
ALTER TABLE `main_sample_photo`
MODIFY COLUMN `url`  char(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL AFTER `praise_count`;

-------------------------------------
-- 2015-1-15 end
-----------------------------------------2015-1-15日
	ALTER TABLE `main_group_shot`
ADD COLUMN `city_area_id`  char(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL AFTER `city_id`;

DROP TABLE IF EXISTS `organization_address_district`;
CREATE TABLE `organization_address_district` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `opened_city_id` char(16) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of organization_address_district
-- ----------------------------
INSERT INTO `organization_address_district` VALUES ('1', '东城区', '1236547891159753');
INSERT INTO `organization_address_district` VALUES ('2', '西城区', '1236547891159753');
INSERT INTO `organization_address_district` VALUES ('3', '崇文区', '1236547891159753');
INSERT INTO `organization_address_district` VALUES ('4', '宣武区', '1236547891159753');
INSERT INTO `organization_address_district` VALUES ('5', '朝阳区', '1236547891159753');
INSERT INTO `organization_address_district` VALUES ('6', '丰台区', '1236547891159753');
INSERT INTO `organization_address_district` VALUES ('7', '石景山区', '1236547891159753');
INSERT INTO `organization_address_district` VALUES ('8', '海淀区', '1236547891159753');
INSERT INTO `organization_address_district` VALUES ('9', '门头沟区', '1236547891159753');
INSERT INTO `organization_address_district` VALUES ('10', '房山区', '1236547891159753');
INSERT INTO `organization_address_district` VALUES ('11', '通州区', '1236547891159753');
INSERT INTO `organization_address_district` VALUES ('12', '顺义区', '1236547891159753');
INSERT INTO `organization_address_district` VALUES ('13', '昌平区', '1236547891159753');
INSERT INTO `organization_address_district` VALUES ('14', '大兴区', '1236547891159753');
INSERT INTO `organization_address_district` VALUES ('15', '怀柔区', '1236547891159753');
INSERT INTO `organization_address_district` VALUES ('16', '平谷区', '1236547891159753');
INSERT INTO `organization_address_district` VALUES ('17', '密云县', '1236547891159753');
INSERT INTO `organization_address_district` VALUES ('18', '延庆县', '1236547891159753');


ALTER TABLE `main_group_shot`
CHANGE COLUMN `city_area_id` `district_id`  char(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `city_id`;

ALTER TABLE `main_dress`
	DROP COLUMN `home_page_index`,
	DROP COLUMN `channel_index`;

ALTER TABLE `main_dress_shop`
	ADD COLUMN `home_page_index` int(8) NULL AFTER `status`,
	ADD COLUMN `channel_index` int(8) NULL AFTER `home_page_index`;
--删除摄影师check_status
ALTER TABLE `organization_photographer`
	DROP COLUMN `check_status`;

	ALTER TABLE `main_photo_frame`
	MODIFY COLUMN `price` decimal(8) NOT NULL AFTER `name`,
	ADD COLUMN `cost` decimal(6) NULL COMMENT '成本价' AFTER `frame_number`;


--添加套餐摄影师表
DROP TABLE IF EXISTS `main_package_photographer`;
CREATE TABLE `main_package_photographer` (
  `id` char(16) NOT NULL,
  `package_id` char(16) DEFAULT NULL,
  `photographer_id` char(16) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
----------------------------------------------------------
---2015-01-20  start  (已执行)支付记录时间允许空，用于判断当前支付记录是否生效
----------------------------------------------------------
ALTER TABLE `order_purchase_order_payment`
MODIFY COLUMN `create_datetime`  datetime NULL AFTER `user_id`;
----------------------------------------------------------
---2015-01-20  end
----------------------------------------------------------

----------------------------------------------------------
---2015-01-21  start
----------------------------------------------------------
ALTER TABLE main_sample_photo_group ADD create_datetime datetime NULL;
----------------------------------------------------------
---2015-01-21  end
----------------------------------------------------------

ALTER TABLE `organization_photographer`
	ADD COLUMN `update_date_time` datetime NULL AFTER `favoriteAmount`;


----------------------------------------------------------
---2015-01-29  start
----------------------------------------------------------
ALTER TABLE `main_dress`
ADD COLUMN `ptype`  smallint NULL AFTER `favoriteAmount`;

ALTER TABLE `main_scene`
ADD COLUMN `ptype`  smallint NULL AFTER `favoriteAmount`;

	ADD COLUMN `update_date_time` datetime NULL AFTER `favoriteAmount`;
	update `organization_user` set `city_id`='headquarters' where `id`='i5ew904300009672';


	ALTER TABLE `main_sample_photo_group`
	MODIFY COLUMN `ptype` int(8) NOT NULL AFTER `status`,
	MODIFY COLUMN `home_page_index` int(8) NULL AFTER `ptype`,
	MODIFY COLUMN `channel_index` smallint(8) NULL AFTER `home_page_index`;

	ALTER TABLE `core_p_document`
	ADD COLUMN `status` tinyint(4) NULL AFTER `title`;

	ALTER TABLE `organization_role`
	MODIFY COLUMN `basic_type` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL AFTER `name`;

ALTER TABLE `main_sample_photo_group`
	MODIFY COLUMN `reason` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL AFTER `channel_index`;

ALTER TABLE `main_photographer_type_price`
	ADD COLUMN `team_price` decimal(10) NULL AFTER `status`;

ALTER TABLE `organization_user`
	ADD COLUMN `last_login_datetime` datetime NULL AFTER `role_id`;

ALTER TABLE `main_photographer_type_price`
	ADD COLUMN `list_index` smallint(8) NULL AFTER `status`;

ALTER TABLE `organization_photographer`
ADD COLUMN `favorite_count`  int(16) NULL DEFAULT 0 AFTER `update_date_time`;

ALTER TABLE `main_dress`
ADD COLUMN `favorite_count`  int(16) NULL DEFAULT 0 AFTER `ptype`;

ALTER TABLE `main_package`
ADD COLUMN `favorite_count`  int(16) NULL DEFAULT 0 AFTER `scene_range`;

ALTER TABLE `main_photo_frame`
ADD COLUMN `favorite_count`  int(16) NULL DEFAULT 0 AFTER `cost`;

ALTER TABLE `main_scene`
ADD COLUMN `favorite_count`  int(16) NULL DEFAULT 0 AFTER `ptype`;

ALTER TABLE `main_dress`
ADD COLUMN `order_amount`  int(11) NULL AFTER `favorite_count`;

--------------------------------------------
-- 2015-03-10   已执行
--------------------------------------------
ALTER TABLE `main_photographer_arrangement`
ADD COLUMN `discount`  varchar(8) NULL AFTER `order_id`;

--------------------------------------------
-- 2015-03-13   已执行
--------------------------------------------
ALTER TABLE `order_purchase_order`
ADD COLUMN `photographer_type_price`  decimal(10,2) NULL AFTER `add_fixed_count`;

update order_purchase_order orde set orde.photographer_type_price = (select price from main_photographer_type_price where ptype=orde.ptype
                                                                     and photographer_id = orde.photographer_id and status=1)
--------------------------------------------
-- 2015-03-16   已执行
--------------------------------------------
ALTER TABLE `main_consumer_photo`
ADD COLUMN `status`  tinyint(4) NULL AFTER `consumer_photo_group_id`;

update  main_consumer_photo set status=1;

ALTER TABLE `main_consumer_photo_group`
ADD COLUMN `status`  tinyint(4) NULL AFTER `ptype`;

update    main_consumer_photo_group set status=1;


--------------------------------------------
-- 2015-03-16   未执行
--------------------------------------------
ALTER TABLE `main_photo_frame`
ADD COLUMN `description`  varchar(256) NULL AFTER `list_index`;

ALTER TABLE `core_p_document`
ADD COLUMN `sample_content`  varchar(255) NULL AFTER `status`;

ALTER TABLE `order_purchase_order`
	ADD COLUMN `package_id` char(16) NULL AFTER `coach_total`;

ALTER TABLE `core_p_document`
	ADD COLUMN `publish_date` date NULL AFTER `sample_content`;
	------------------------------------------------
	-----2015-07-30 修改efc数据库 表字段status not null
	----------------------------------------------
alter table basic_banner modify the_status VARCHAR(1) not null;
alter table basic_document modify status INT(11) not null;

alter table basic_word_value modify status varchar(20) not null;
---UPDATE basic_word_value SET `status`='1' WHERE id='iccromiv00007v3r'

ALTER table master_recommended modify status varchar(255) not null;
ALTER table purchase_order_payment modify status varchar(4) not null;
