package com.efeiyi.ec.website.order.model;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

/**
 * Created by Administrator on 2015/12/19.
 *
 */
@Component
public class DepponProduct {//根据配置文件查询德邦物流对应套餐
    @Value("#{configProperties['productCode']}")
    private String productCode;

    public String getProductCode() {
        return productCode;
    }

    public void setProductCode(String productCode) {
        this.productCode = productCode;
    }
}
