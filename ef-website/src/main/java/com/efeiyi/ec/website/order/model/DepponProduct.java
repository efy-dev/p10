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

    @Value("#{configProperties['standardYkg']}")
    private String standardYkg;//标准快递首重

    @Value("#{configProperties['standardAkg']}")
    private String standardAkg;//标准快递续重

    @Value("#{configProperties['ykg360']}")
    private String ykg360;//360优惠首重

    @Value("#{configProperties['akg360']}")
    private String akg360;//360优惠续重


    public String getStandardYkg() {
        return standardYkg;
    }

    public void setStandardYkg(String standardYkg) {
        this.standardYkg = standardYkg;
    }

    public String getStandardAkg() {
        return standardAkg;
    }

    public void setStandardAkg(String standardAkg) {
        this.standardAkg = standardAkg;
    }

    public String getYkg360() {
        return ykg360;
    }

    public void setYkg360(String ykg360) {
        this.ykg360 = ykg360;
    }

    public String getAkg360() {
        return akg360;
    }

    public void setAkg360(String akg360) {
        this.akg360 = akg360;
    }

    public String getProductCode() {
        return productCode;
    }

    public void setProductCode(String productCode) {
        this.productCode = productCode;
    }
}
