
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


ALTER TABLE `master_attachment`
ADD COLUMN `master_news_id`  varchar(16) NULL AFTER `title`;


ALTER TABLE `master_recommended`
ADD COLUMN `status`  varchar(20) NULL AFTER `sort`;

ALTER TABLE `master_work_recommended`
ADD COLUMN `master_work_id`  char(16) NULL AFTER `status`;


ALTER TABLE `master_news_tag`
CHANGE COLUMN `tenant_news_id` `master_news_id`  char(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `id`;


ALTER TABLE `mater_work_tag`
CHANGE COLUMN `tenant_work_id` `master_work_id`  char(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `status`;

