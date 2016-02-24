package com.efeiyi.ec.website.order.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.efeiyi.ec.purchase.model.Freight;
import com.efeiyi.ec.website.order.service.FreightManager;
import com.ming800.core.base.service.BaseManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.LinkedHashMap;
import java.util.List;

/**
 * Created by Administrator on 2016/2/18.
 */
@Service
public class FreightManagerImpl implements FreightManager{

    @Autowired
    private BaseManager baseManager;

    @Override
    public Freight getFreight(String startCity,String reachProvince) {
        String hql = " from Freight f where 1=1 ";
        LinkedHashMap<String, Object> hm = new LinkedHashMap<>();

        if(!"".equals(startCity)){
            hql += " and f.startCity=:startCity ";
            hm.put("startCity", startCity);
        }
        if(!"".equals(reachProvince)){
            hql += " and f.reachProvince=:reachProvince ";
            hm.put("reachProvince", reachProvince);
        }

        Freight freight =null;
        List freightList = baseManager.listObject(hql, hm);
        if (freightList == null || freightList.size()==0){
            return null;
        }else{
            freight = (Freight) freightList.get(0);
        }

        return freight;
    }

    @Override
    public String calculateFreight(double weight, double standardYkg, double ykg360,Freight freight) {
        if(weight > ykg360){
            return new BigDecimal(weight - ykg360).multiply(new BigDecimal(freight.getAkg360Money())).add(new BigDecimal(freight.getYkg360Money())).setScale(0,BigDecimal.ROUND_HALF_UP).toString();
        }else if (weight == ykg360){
            return freight.getYkg360Money();
        }else if (weight < ykg360){
            if (weight <= standardYkg){
                return freight.getStandardYkgMoney();
            }else if (weight > standardYkg){
                return new BigDecimal(weight - standardYkg).multiply(new BigDecimal(freight.getStandardAkgMoney())).add(new BigDecimal(freight.getStandardYkgMoney())).setScale(0,BigDecimal.ROUND_HALF_UP).toString();
            }
        }
        return null;
    }
}
