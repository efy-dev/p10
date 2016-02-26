package com.efeiyi.ec.website.order.service;

import com.efeiyi.ec.organization.model.ConsumerAddress;
import com.efeiyi.ec.purchase.model.PurchaseOrder;

import java.math.BigDecimal;

/**
 * Created by Administrator on 2016/2/24.
 */
public interface PostageManager {
    //通过父订单查询邮费
    BigDecimal getFreight(PurchaseOrder purchaseOrder,ConsumerAddress consumerAddress);
    //通过子订单查询邮费（对于没有子订单的就为父订单）
    BigDecimal getFreight(PurchaseOrder purchaseOrder,String reachProvince);
    //校验运费
    boolean fetchFreight(String freight,BigDecimal returnFreight);
}
