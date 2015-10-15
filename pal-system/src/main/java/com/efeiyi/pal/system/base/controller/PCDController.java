package com.efeiyi.pal.system.base.controller;

import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by Administrator on 2015/9/7.
 * 省市县级联 Controller
 */
@RestController
public class PCDController {

    @Autowired
    private BaseManager baseManager;

    @RequestMapping({"/pal/address/provinceList.do"})
    public List getProvinceList(HttpServletRequest request) throws Exception {
        XQuery xQuery = new XQuery("listAddressProvince_default", request);
        return baseManager.listObject(xQuery);
    }

    @RequestMapping({"/pal/address/cityListByProvince.do"})
    public List getCityListByProvince(Model model, HttpServletRequest request) throws Exception {
        XQuery xQuery = new XQuery("listAddressCity_province", request);
        xQuery.addRequestParamToModel(model, request);
        return baseManager.listObject(xQuery);
    }

    @RequestMapping({"/pal/address/districtListByCity.do"})
    public List getDistrictListByCity(Model model, HttpServletRequest request) throws Exception {
        XQuery xQuery = new XQuery("listAddressDistrict_city", request);
        xQuery.addRequestParamToModel(model, request);
        return baseManager.listObject(xQuery);
    }

}
