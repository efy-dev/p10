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



