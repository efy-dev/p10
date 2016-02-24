package com.efeiyi.ec.website.order.service;

import com.alibaba.fastjson.JSONObject;
import com.efeiyi.ec.purchase.model.Freight;

/**
 * Created by Administrator on 2016/2/18.
 */
public interface FreightManager {
    Freight getFreight(String startCity,String reachProvince);
    String calculateFreight(double weight,double standardYkg,double ykg360,Freight freight);
}
