package com.efeiyi.ec.website.organization.controller;

import com.efeiyi.ec.organization.model.*;
import com.efeiyi.ec.website.base.util.ApplicationException;
import com.efeiyi.ec.website.base.util.AuthorizationUtil;
import com.efeiyi.ec.website.organization.service.O2oAddressManager;
import com.ming800.core.base.controller.BaseController;

import com.ming800.core.does.model.XQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2016/12/5.
 */
@Controller
@RequestMapping("o2oAddress")
public class O2oAddressController extends BaseController {

    @Autowired
    O2oAddressManager addressManager;

    /**
     * 获取地址列表
     * @param request
     * @return resultMap
     */
    @RequestMapping("getAddressList")
    @ResponseBody
    public Map getConsumerAddressList(HttpServletRequest request) {
        Map<String, Object> resultMap = new HashMap<>();
        List<ConsumerAddress> consumerAddressList;

        String userId = AuthorizationUtil.getMyUser().getId();

        try {
            consumerAddressList = addressManager.getConsumerAddressList(userId);
        } catch (Exception e) {
            ApplicationException exception = new ApplicationException(ApplicationException.SQL_ERROR);
            return exception.toJSONObject();
        }

        resultMap.put("code", "0");
        resultMap.put("description", "获取地址列表成功");
        resultMap.put("data", consumerAddressList);
        return resultMap;
    }

    /**
     * 获取某个地址
     * @param request
     * @return resultMap
     */
    @RequestMapping("getAddress")
    @ResponseBody
    public Map getConsumerAddress(HttpServletRequest request) {
        Map<String, Object> resultMap = new HashMap<>();
        ConsumerAddress consumerAddress;
        String id = request.getParameter("id");

        try {
            consumerAddress = (ConsumerAddress) baseManager.getObject(ConsumerAddress.class.getName(), id);
        } catch (Exception e) {
            ApplicationException exception = new ApplicationException(ApplicationException.SQL_ERROR);
            return exception.toJSONObject();
        }

        resultMap.put("code", "0");
        resultMap.put("description", "获取地址成功");
        resultMap.put("data", consumerAddress);
        return resultMap;
    }

    /**
     * 新增地址
     * @param request
     * @return resultMap
     */
    @RequestMapping("addAddress")
    @ResponseBody
    public Map addConsumerAddress(HttpServletRequest request) {
        Map<String, Object> resultMap = new HashMap<>();
        ConsumerAddress consumerAddress = new ConsumerAddress();

        AddressProvince province = new AddressProvince();
        province.setId(request.getParameter("provinceId"));
        AddressCity city = new AddressCity();
        city.setId(request.getParameter("cityId"));
        AddressDistrict district = new AddressDistrict();
        district.setId(request.getParameter("districtId"));

        consumerAddress.setConsumer(AuthorizationUtil.getMyUser());
        consumerAddress.setProvince(province);
        consumerAddress.setCity(city);
        consumerAddress.setDistrict(district);
        consumerAddress.setDetails(request.getParameter("details"));
        consumerAddress.setPhone(request.getParameter("phone"));
        consumerAddress.setConsignee(request.getParameter("consignee"));
        consumerAddress.setStatus("1");

        try {
            addressManager.saveConsumerAddress(consumerAddress);
        } catch (Exception e) {
            ApplicationException exception = new ApplicationException(ApplicationException.SQL_ERROR);
            return exception.toJSONObject();
        }

        resultMap.put("code", "0");
        resultMap.put("description", "地址新增成功");
        resultMap.put("data", consumerAddress);
        return resultMap;
    }

    /**
     * 修改地址
     * @param request
     * @return resultMap
     */
    @RequestMapping("updateAddress")
    @ResponseBody
    public Map updateConsumerAddress(HttpServletRequest request) {
        Map<String, Object> resultMap = new HashMap<>();
        ConsumerAddress consumerAddress;

        String id = request.getParameter("id");
        String status = request.getParameter("status");

        try {
            consumerAddress = (ConsumerAddress) baseManager.getObject(ConsumerAddress.class.getName(), id);
        } catch (Exception e) {
            ApplicationException exception = new ApplicationException(ApplicationException.SQL_ERROR);
            return exception.toJSONObject();
        }

        AddressProvince province = new AddressProvince();
        province.setId(request.getParameter("provinceId"));
        AddressCity city = new AddressCity();
        city.setId(request.getParameter("cityId"));
        AddressDistrict district = new AddressDistrict();
        district.setId(request.getParameter("districtId"));

        consumerAddress.setConsumer(AuthorizationUtil.getMyUser());
        consumerAddress.setProvince(province);
        consumerAddress.setCity(city);
        consumerAddress.setDistrict(district);
        consumerAddress.setDetails(request.getParameter("details"));
        consumerAddress.setPhone(request.getParameter("phone"));
        consumerAddress.setConsignee(request.getParameter("consignee"));

        if(status != null) {
            consumerAddress.setStatus(status);
        }

        try {
            addressManager.saveConsumerAddress(consumerAddress);
        } catch (Exception e) {
            ApplicationException exception = new ApplicationException(ApplicationException.SQL_ERROR);
            return exception.toJSONObject();
        }

        resultMap.put("code", "0");
        resultMap.put("description", "地址修改成功");
        resultMap.put("data", consumerAddress);
        return resultMap;
    }

    /**
     * 删除地址
     * @param request
     * @return resultMap
     */
    @RequestMapping("deleteAddress")
    @ResponseBody
    public Map deleteConsumerAddress(HttpServletRequest request) {
        Map<String, Object> resultMap = new HashMap<>();
        ConsumerAddress consumerAddress;
        String id = request.getParameter("id");

        try {
            consumerAddress = (ConsumerAddress) baseManager.getObject(ConsumerAddress.class.getName(), id);
            consumerAddress.setStatus("0");
            addressManager.saveConsumerAddress(consumerAddress);
        } catch (Exception e) {
            ApplicationException exception = new ApplicationException(ApplicationException.SQL_ERROR);
            return exception.toJSONObject();
        }

        resultMap.put("code", "0");
        resultMap.put("description", "地址删除成功");
        resultMap.put("data", consumerAddress);
        return resultMap;
    }

    /**
     * 获取省列表
     * @param request
     * @return resultMap
     */
    @RequestMapping("provinceList")
    @ResponseBody
    public Map listAddressProvince(HttpServletRequest request) {
        Map<String, Object> resultMap = new HashMap<>();
        List<AddressProvince> provinceList;
        XQuery xQuery;

        try {
            xQuery = new XQuery("listAddressProvince_default", request);
        } catch (Exception e) {
            ApplicationException exception = new ApplicationException(ApplicationException.INNER_ERROR);
            return exception.toJSONObject();
        }

        try {
            provinceList = baseManager.listObject(xQuery);
        } catch (Exception e) {
            ApplicationException exception = new ApplicationException(ApplicationException.SQL_ERROR);
            return exception.toJSONObject();
        }

        resultMap.put("code", "0");
        resultMap.put("description", "获取省列表成功");
        resultMap.put("data", provinceList);
        return resultMap;
    }

    /**
     * 获取市列表
     * @param request
     * @return resultMap
     */
    @RequestMapping("cityList")
    @ResponseBody
    public Map listAddressCity(HttpServletRequest request) {
        Map<String, Object> resultMap = new HashMap<>();
        XQuery xQuery;
        List<AddressCity> cityList;
        String provinceId = request.getParameter("provinceId");

        try {
            xQuery = new XQuery("listAddressCity_default", request);
        } catch (Exception e) {
            ApplicationException exception = new ApplicationException(ApplicationException.INNER_ERROR);
            return exception.toJSONObject();
        }

        xQuery.put("addressProvince_id", provinceId);

        try {
            cityList = baseManager.listObject(xQuery);
        } catch (Exception e) {
            ApplicationException exception = new ApplicationException(ApplicationException.SQL_ERROR);
            return exception.toJSONObject();
        }

        resultMap.put("code", "0");
        resultMap.put("description", "获取市列表成功");
        resultMap.put("data", cityList);
        return resultMap;
    }

    /**
     * 获取地区列表
     * @param request
     * @return resultMap
     */
    @RequestMapping("districtList")
    @ResponseBody
    public Map listAddressDistrict(HttpServletRequest request) {
        Map<String, Object> resultMap = new HashMap<>();
        XQuery xQuery;
        List<AddressDistrict> districtList;
        String cityId = request.getParameter("cityId");

        try {
            xQuery = new XQuery("listAddressDistrict_default", request);
        } catch (Exception e) {
            ApplicationException exception = new ApplicationException(ApplicationException.INNER_ERROR);
            return exception.toJSONObject();
        }

        xQuery.put("addressCity_id", cityId);

        try {
            districtList = baseManager.listObject(xQuery);
        } catch (Exception e) {
            ApplicationException exception = new ApplicationException(ApplicationException.SQL_ERROR);
            return exception.toJSONObject();
        }

        resultMap.put("code", "0");
        resultMap.put("description", "获取地区列表成功");
        resultMap.put("data", districtList);
        return resultMap;
    }

}
