ALTER TABLE `purchase_order_product`
ADD COLUMN `average`  varchar(16) NULL DEFAULT '' AFTER `status`;

ALTER TABLE `purchase_order_comment`
ADD COLUMN `purchase_order_business_reply_id`  char(16) NULL AFTER `create_datetime`;