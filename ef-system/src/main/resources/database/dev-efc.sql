------20150908-----
----------dev-efc------AC丶man----start
CREATE TABLE `master_message` (
`id`  char(16) NOT NULL ,
`content`  varchar(255) NULL ,
`type`  varchar(2) NULL ,
`master_id`  char(16) NULL ,
`project_id`  char(16) NULL ,
`author`  varchar(255) NULL ,
`create_datetime`  datetime NULL ,
PRIMARY KEY (`id`)
)
;
CREATE TABLE `master_message_attachment` (
  `id`  char(16) NOT NULL ,
  `file_name`  varchar(255) NULL ,
  `picture_url`  varchar(255) NULL ,
  `video_path`  varchar(255) NULL ,
  `master_message_id`  char(16) NULL,
  PRIMARY KEY (`id`)
)
;
----------dev-efc------AC丶man----end


------------20150909-------------
----------dev-efc------AC丶man----start
CREATE TABLE `master_followed` (
  `id`  char(16) NOT NULL ,
  `master_id`  char(16) NULL ,
  `user_id`  char(16) NULL ,
  `status`  varchar(20) NULL ,
  `create_datetime`  datetime(6) NULL ,
  PRIMARY KEY (`id`)
)
;
---------------20150918--------
----------------dev-efc---------
CREATE TABLE `master_comment` (
  `id`  char(16) NOT NULL ,
  `master_message_id`  char(16) NULL ,
  `content`  varchar(500) NULL ,
  `status`  varchar(20) NULL ,
  `user_id`  char(16) NULL ,
  `create_datetime`  datetime(6) NULL ,
  PRIMARY KEY (`id`)
)
;
---------------end----------------------
-----------20150921-----------
-----------dev-efc------------
CREATE TABLE `master_message_praise` (
  `id`  char(16) NOT NULL ,
  `master_message_id`  char(16) NULL ,
  `user_id`  char(16) NULL ,
  `praise_number`  int NULL ,
  PRIMARY KEY (`id`)
)
;
--------------end--------------

-----------start-----------
------------20150923----------
ALTER TABLE `master`
ADD COLUMN `fansAmount`  bigint(20) NULL AFTER `master_speech`;
ALTER TABLE `master`
CHANGE COLUMN `fansAmount` `fans_amount`  bigint(20) NULL DEFAULT NULL AFTER `master_speech`;
------------end-----------
ALTER TABLE `project`
CHANGE COLUMN `fansAmout` `fans_amount`  bigint(20) NULL DEFAULT NULL AFTER `district_id`;

