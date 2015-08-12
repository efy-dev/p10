package com.efeiyi.ec.website.order.controller;

import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.does.model.XSaveOrUpdate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by Administrator on 2015/7/30.
 */
@RestController
public class AddressController {

    @Autowired
    private BaseManager baseManager;

    @RequestMapping({"/address/listProvince.do"})
    public List<Object> listAddressProvince(HttpServletRequest request) throws Exception {
        XQuery xQuery = new XQuery("listAddressProvince_default", request);
        List<Object> objectList = baseManager.listObject(xQuery);
        return objectList;
    }

    @RequestMapping({"/address/listCity.do"})
         public List<Object> listAddressCity(HttpServletRequest request) throws  Exception{
        XQuery xQuery = new XQuery("listAddressCity_default" , request);
        xQuery.put("addressProvince_id",request.getParameter("provinceId"));
        List<Object> objectList = baseManager.listObject(xQuery);
        return objectList;
    }


    @RequestMapping({"/address/listDistrict"})
    public List<Object> listAddressDistrict(HttpServletRequest request) throws Exception{
        XQuery xQuery = new XQuery("listAddressDistrict_default",request);
        xQuery.put("addressCity_id",request.getParameter("cityId"));
        List<Object> objectList = baseManager.listObject(xQuery);
        XSaveOrUpdate xSaveOrUpdate = new XSaveOrUpdate("saveOrUpdateConsumerAddress",request);
        xSaveOrUpdate.getParamMap().put("city_id",request.getParameter("addrCityId"));
        baseManager.saveOrUpdate(xSaveOrUpdate);

        return objectList;
    }

}
