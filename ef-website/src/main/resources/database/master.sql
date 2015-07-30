
#---------------未执行----------------
ALTER TABLE `purchase_cart_product`
ADD COLUMN `status`  char(8) NULL AFTER `product_id`;

ALTER TABLE `purchase_order`
ADD COLUMN `status`  char(8) NULL AFTER `user_address_id`;


ALTER TABLE `purchase_order`
ADD COLUMN `total`  decimal NULL AFTER `status`;

ALTER TABLE `purchase_order`
ADD COLUMN `orderStatus`  char(255) NULL AFTER `total`;

ALTER TABLE `purchase_order_payment`
ADD COLUMN `paymentAmount`  decimal NULL AFTER `status`;

