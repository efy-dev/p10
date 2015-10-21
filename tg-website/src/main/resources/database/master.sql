/-----------------团员表生成-----------------/
CREATE TABLE `member` (
`id`  char(16) NOT NULL ,
`user_id`  char(16) NULL ,
`level`  char(4) NULL ,
`sup_member_id`  char(16) NULL ,
`status`  char(8) NULL ,
`group_id`  char(16) NULL ,
PRIMARY KEY (`id`)
)
;
/-------------------团员表生成-----------------------/

/----------------------团表生成---------------------------/
CREATE TABLE `group` (
`id`  char(16) NOT NULL ,
`group_product_id`  char(16) NULL ,
`status`  char(2) NULL ,
`create_datetime`  datetime NULL ,
`manmember_id`  char(16) NULL ,
PRIMARY KEY (`id`)
)
;


/----------------------团表生成------------------------/