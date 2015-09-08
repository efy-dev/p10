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
  `master_message_id`  char(16) NULL,
  PRIMARY KEY (`id`)
)
;


