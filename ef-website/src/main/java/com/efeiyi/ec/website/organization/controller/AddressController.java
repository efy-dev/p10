package com.efeiyi.ec.website.organization.controller;

import com.efeiyi.ec.organization.model.*;
import com.efeiyi.ec.website.base.util.ApplicationException;
import com.efeiyi.ec.website.base.util.AuthorizationUtil;
import com.efeiyi.ec.website.organization.service.AddressManager;
import com.ming800.core.base.controller.BaseController;
import com.ming800.core.does.model.XQuery;
import net.sf.json.JSONObject;
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
@RequestMapping("address")
public class AddressController extends BaseController {

    @Autowired
    private AddressManager addressManager;

    @RequestMapping({"/getDefaultConsumerAddress"})
    @ResponseBody
    public JSONObject getDefaultConsumerAddress() {
        ConsumerAddress consumerAddress;
        try {
            consumerAddress = addressManager.getConsumerAddressByStatus(AuthorizationUtil.getMyUser().getId(), "2");
        } catch (ApplicationException ae) {
            return ae.toJSONObject();
        }

        JSONObject result = new JSONObject();
        result.put("code", "0");
        if (consumerAddress != null) {
            result.put("addressId", consumerAddress.getId());
            try {
                result.put("addressCity", consumerAddress.getCity().getName());
                result.put("addressProvince", consumerAddress.getProvince().getName());
                result.put("addressDistrict", consumerAddress.getDistrict().getName());
            } catch (Exception e) {
                e.printStackTrace();
            }
            result.put("addressDetail", consumerAddress.getDetails());
            result.put("addressConsignee", consumerAddress.getConsignee());
            result.put("addressPhone", consumerAddress.getPhone());
        } else {
            result.put("addressId", null);
        }

        return result;

    }


    @RequestMapping({"/getConsumerAddressById"})
    @ResponseBody
    public JSONObject getConsumerAddressById(HttpServletRequest request) {
        ConsumerAddress consumerAddress;
        try {
            consumerAddress = (ConsumerAddress) baseManager.getObject(ConsumerAddress.class.getName(), request.getParameter("id"));
        } catch (Exception e) {
            return new ApplicationException(ApplicationException.SQL_ERROR).toJSONObject();
        }

        JSONObject result = new JSONObject();
        result.put("code", "0");
        if (consumerAddress != null) {
            result.put("addressId", consumerAddress.getId());
            try {
                result.put("addressCity", consumerAddress.getCity().getName());
                result.put("addressProvince", consumerAddress.getProvince().getName());
                result.put("addressDistrict", consumerAddress.getDistrict().getName());
            } catch (Exception e) {
                e.printStackTrace();
            }
            result.put("addressDetail", consumerAddress.getDetails());
            result.put("addressConsignee", consumerAddress.getConsignee());
            result.put("addressPhone", consumerAddress.getPhone());
        } else {
            result.put("addressId", null);
        }

        return result;

    }

    /**
     * 获取地址列表
     *
     * @param request
     * @return resultMap
     */
    @RequestMapping("getAddressList")
    @ResponseBody
    public Map getConsumerAddressList(HttpServletRequest request) {
        Map<String, Object> resultMap = new HashMap<>();
        List<ConsumerAddress> consumerAddressList;

        String userId = AuthorizationUtil.getMyUser().getId();

        if (userId == null) {
            ApplicationException exception = new ApplicationException(ApplicationException.INNER_ERROR);
            exception.setInnerDescription("用户没有登录");
            return exception.toJSONObject();
        }

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
     *
     * @param request
     * @return resultMap
     */
    @RequestMapping("getAddress")
    @ResponseBody
    public Map getConsumerAddress(HttpServletRequest request) {
        Map<String, Object> resultMap = new HashMap<>();
        ConsumerAddress consumerAddress;

        Map<String, String[]> paramMap = request.getParameterMap();
        String id = paramMap.get("id")[0];

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
     *
     * @param request
     * @return resultMap
     */
    @RequestMapping("addAddress")
    @ResponseBody
    public Map addConsumerAddress(HttpServletRequest request) {
        Map<String, Object> resultMap = new HashMap<>();
        ConsumerAddress consumerAddress = new ConsumerAddress();

        Map<String, String[]> paramMap = request.getParameterMap();

        MyUser user = AuthorizationUtil.getMyUser();
//        user.setId("ie884zfj2wy1h50s");
        if (user.getId() == null) {
            ApplicationException exception = new ApplicationException(ApplicationException.INNER_ERROR);
            exception.setInnerDescription("用户没有登录");
            return exception.toJSONObject();
        }

        if (paramMap.containsKey("provinceId")) {
            AddressProvince province = new AddressProvince();
            province.setId(paramMap.get("provinceId")[0]);
            consumerAddress.setProvince(province);
        }

        if (paramMap.containsKey("cityId")) {
            AddressCity city = new AddressCity();
            city.setId(paramMap.get("cityId")[0]);
            consumerAddress.setCity(city);
        }

        if (paramMap.containsKey("districtId")) {
            AddressDistrict district = new AddressDistrict();
            district.setId(paramMap.get("districtId")[0]);
            consumerAddress.setDistrict(district);
        }

        consumerAddress.setConsumer(user);
        consumerAddress.setDetails(paramMap.get("details")[0]);
        consumerAddress.setPhone(paramMap.get("phone")[0]);
        consumerAddress.setConsignee(paramMap.get("consignee")[0]);
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
     *
     * @param request
     * @return resultMap
     */
    @RequestMapping("updateAddress")
    @ResponseBody
    public Map updateConsumerAddress(HttpServletRequest request) {
        Map<String, Object> resultMap = new HashMap<>();
        ConsumerAddress consumerAddress;

        Map<String, String[]> paramMap = request.getParameterMap();

        String id = paramMap.get("id")[0];
        String status = paramMap.get("status")[0];

        MyUser user = new MyUser();//AuthorizationUtil.getMyUser();
        user.setId("ie884zfj2wy1h50s");
        if (user.getId() == null) {
            ApplicationException exception = new ApplicationException(ApplicationException.INNER_ERROR);
            exception.setInnerDescription("用户没有登录");
            return exception.toJSONObject();
        }

        try {
            consumerAddress = (ConsumerAddress) baseManager.getObject(ConsumerAddress.class.getName(), id);
        } catch (Exception e) {
            ApplicationException exception = new ApplicationException(ApplicationException.SQL_ERROR);
            return exception.toJSONObject();
        }

        if (paramMap.containsKey("provinceId")) {
            AddressProvince province = new AddressProvince();
            province.setId(paramMap.get("provinceId")[0]);
            consumerAddress.setProvince(province);
        }

        if (paramMap.containsKey("cityId")) {
            AddressCity city = new AddressCity();
            city.setId(paramMap.get("cityId")[0]);
            consumerAddress.setCity(city);
        }

        if (paramMap.containsKey("districtId")) {
            AddressDistrict district = new AddressDistrict();
            district.setId(paramMap.get("districtId")[0]);
            consumerAddress.setDistrict(district);
        }

        consumerAddress.setConsumer(user);
        consumerAddress.setDetails(paramMap.get("details")[0]);
        consumerAddress.setPhone(paramMap.get("phone")[0]);
        consumerAddress.setConsignee(paramMap.get("consignee")[0]);

        if (status != null) {
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
     *
     * @param request
     * @return resultMap
     */
    @RequestMapping("deleteAddress")
    @ResponseBody
    public Map deleteConsumerAddress(HttpServletRequest request) {
        Map<String, Object> resultMap = new HashMap<>();
        ConsumerAddress consumerAddress;

        Map<String, String[]> paramMap = request.getParameterMap();
        String id = paramMap.get("id")[0];

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
     *
     * @param request
     * @return resultMap
     */
    @RequestMapping("getProvinceList")
    @ResponseBody
    public Map getProvinceList(HttpServletRequest request) {
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
     *
     * @param request
     * @return resultMap
     */
    @RequestMapping("getCityList")
    @ResponseBody
    public Map getCityList(HttpServletRequest request) {
        Map<String, Object> resultMap = new HashMap<>();
        XQuery xQuery;
        List<AddressCity> cityList;

        Map<String, String[]> paramMap = request.getParameterMap();

        try {
            xQuery = new XQuery("listAddressCity_default", request);
        } catch (Exception e) {
            ApplicationException exception = new ApplicationException(ApplicationException.INNER_ERROR);
            return exception.toJSONObject();
        }

        xQuery.put("addressProvince_id", paramMap.get("provinceId")[0]);

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
     *
     * @param request
     * @return resultMap
     */
    @RequestMapping("getDistrictList")
    @ResponseBody
    public Map getDistrictList(HttpServletRequest request) {
        Map<String, Object> resultMap = new HashMap<>();
        XQuery xQuery;
        List<AddressDistrict> districtList;

        Map<String, String[]> paramMap = request.getParameterMap();

        try {
            xQuery = new XQuery("listAddressDistrict_default", request);
        } catch (Exception e) {
            ApplicationException exception = new ApplicationException(ApplicationException.INNER_ERROR);
            return exception.toJSONObject();
        }

        xQuery.put("addressCity_id", paramMap.get("cityId")[0]);

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
