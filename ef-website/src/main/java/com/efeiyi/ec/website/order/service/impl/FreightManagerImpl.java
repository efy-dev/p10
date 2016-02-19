package com.efeiyi.ec.website.order.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.efeiyi.ec.purchase.model.Freight;
import com.efeiyi.ec.website.order.service.FreightManager;
import com.ming800.core.base.service.BaseManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.LinkedHashMap;

/**
 * Created by Administrator on 2016/2/18.
 */
@Service
public class FreightManagerImpl implements FreightManager{

    @Autowired
    private BaseManager baseManager;

    @Override
    public Freight getFreight(JSONObject jsonObject) {
        String startProvince = jsonObject.getString("startProvince");
        String startCity = jsonObject.getString("startCity");
        String reachProvince = jsonObject.getString("reachProvince");
        String hql = " from Freight f where 1=1 ";
        LinkedHashMap<String, Object> hm = new LinkedHashMap<>();

        if(!"".equals(startProvince)){
            hql += " and f.startProvince=:startProvince ";
            hm.put("startProvince", startProvince);
        }
        if(!"".equals(startCity)){
            hql += " and f.startCity=:startCity ";
            hm.put("startCity", startCity);
        }
        if(!"".equals(reachProvince)){
            hql += " and f.reachProvince=:reachProvince ";
            hm.put("reachProvince", reachProvince);
        }

        Freight freight = (Freight) baseManager.listObject(hql,hm).get(0);
        return freight;
    }
}
