//package com.efeiyi.ec.website.order.controller;
//
//import com.efeiyi.ec.organization.model.ConsumerAddress;
//import com.efeiyi.ec.website.base.util.AuthorizationUtil;
//import com.ming800.core.base.service.BaseManager;
//import com.ming800.core.does.model.XQuery;
//import com.ming800.core.does.model.XSaveOrUpdate;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.ResponseBody;
//
//import javax.servlet.http.HttpServletRequest;
//import java.util.List;
//
///**
// * Created by Administrator on 2015/7/30.
// */
//@Controller
//@RequestMapping("/myEfeiyi")
//public class AddressController {
//
//    @Autowired
//    private BaseManager baseManager;
//
//    @RequestMapping({"/address/listProvince.do"})
//    @ResponseBody
//    public List<Object> listAddressProvince(HttpServletRequest request) throws Exception {
//        XQuery xQuery = new XQuery("listAddressProvince_default", request);
//        List<Object> objectList = baseManager.listObject(xQuery);
//        return objectList;
//    }
//
//    @RequestMapping({"/address/listCity.do"})
//    @ResponseBody
//    public List<Object> listAddressCity(HttpServletRequest request) throws Exception {
//        XQuery xQuery = new XQuery("listAddressCity_default", request);
//        xQuery.put("addressProvince_id", request.getParameter("provinceId"));
//        List<Object> objectList = baseManager.listObject(xQuery);
//        return objectList;
//    }
//
//
//    @RequestMapping({"/address/listDistrict.do"})
//    @ResponseBody
//    public List<Object> listAddressDistrict(HttpServletRequest request) throws Exception {
//        XQuery xQuery = new XQuery("listAddressDistrict_default", request);
//        xQuery.put("addressCity_id", request.getParameter("cityId"));
//        List<Object> objectList = baseManager.listObject(xQuery);
//        return objectList;
//    }
//
////    @RequestMapping({"/address/list"})
////    public String listAddress(HttpServletRequest request, Model model) throws Exception {
////        XQuery xQuery = new XQuery("ListConsumerAddress_default", request);
////        List addressList = baseManager.listObject(xQuery);
////        model.addAttribute("addressList", addressList);
////
////        xQuery = new XQuery("listAddressProvince_default", request);
////        List<Object> objectList = baseManager.listObject(xQuery);
////        model.addAttribute("province", objectList);
////
////        return "/purchaseOrder/addressList";
////    }
//
//    @RequestMapping({"/addAddressOfMobile.do"})
//    public String Address(HttpServletRequest request, Model model) throws Exception {
//        String addressId = request.getParameter("addressId");
//
//        XQuery xQuery = new XQuery("listAddressProvince_default", request);
//        List<Object> objectList = baseManager.listObject(xQuery);
//        model.addAttribute("province", objectList);
//        if (addressId.equals("null")) {
//            return "/purchaseOrder/addAddress";
//        } else {
//            ConsumerAddress consumerAddress = (ConsumerAddress) baseManager.getObject(ConsumerAddress.class.getName(), addressId);
//            model.addAttribute("address", consumerAddress);
//            return "/purchaseOrder/updateAddress";
//        }
//    }
//
//
//
////    @RequestMapping({"addAddress.do"})
////    public String addAddress(HttpServletRequest request) throws Exception {
////        XSaveOrUpdate xSaveOrUpdate = new XSaveOrUpdate("saveOrUpdateConsumerAddress", request);
////        XQuery xQuery = new XQuery("ListConsumerAddress_default", request);
////        List addressList = baseManager.listObject(xQuery);
////        if (addressList == null || addressList.size() == 0) {
////            xSaveOrUpdate.getParamMap().put("status", 2);
////        }
////        xSaveOrUpdate.getParamMap().put("consumer_id", AuthorizationUtil.getMyUser().getId());
////        baseManager.saveOrUpdate(xSaveOrUpdate);
////
////        return "redirect:/myEfeiyi/address/list";
////
////    }
//
////    @RequestMapping({"addAddressOfMob.do"})
////    public String addAddressOfMobile(HttpServletRequest request) throws Exception {
////        XQuery xQuery = new XQuery("ListConsumerAddress_default", request);
////        List list = baseManager.listObject(xQuery);
////        if ("1".equals(request.getParameter("checkbox")) || list.size() == 0) {
////            String id = AuthorizationUtil.getMyUser().getId();
////            String hql = "update organization_consumer_address set status = '1'where status<>0 and consumer_id='" + id + "'";
////            baseManager.executeSql(null, hql, null);
////            XSaveOrUpdate xSaveOrUpdate1 = new XSaveOrUpdate("saveOrUpdateConsumerAddress", request);
////            xSaveOrUpdate1.getParamMap().put("status", "2");
////            xSaveOrUpdate1.getParamMap().put("consumer_id", AuthorizationUtil.getMyUser().getId());
////            baseManager.saveOrUpdate(xSaveOrUpdate1);
////            return "redirect:/myEfeiyi/address/list";
////        } else {
////            XSaveOrUpdate xSaveOrUpdate = new XSaveOrUpdate("saveOrUpdateConsumerAddress", request);
////            xSaveOrUpdate.getParamMap().put("consumer_id", AuthorizationUtil.getMyUser().getId());
////            baseManager.saveOrUpdate(xSaveOrUpdate);
////            return "redirect:/myEfeiyi/address/list";
////        }
////    }
//
//    @RequestMapping({"addAddressOfMob1.do"})
//    public String addAddressOfMobile1(HttpServletRequest request) throws Exception {
//        String id = AuthorizationUtil.getMyUser().getId();
//        String hql = "update organization_consumer_address set status = '1'where status<>0 and consumer_id='" + id + "'";
//        baseManager.executeSql(null, hql, null);
//        XSaveOrUpdate xSaveOrUpdate1 = new XSaveOrUpdate("saveOrUpdateConsumerAddress", request);
//        xSaveOrUpdate1.getParamMap().put("status", "2");
//        xSaveOrUpdate1.getParamMap().put("consumer_id", AuthorizationUtil.getMyUser().getId());
//        baseManager.saveOrUpdate(xSaveOrUpdate1);
//        String cartId = request.getParameter("cartId");
//        if (request.getParameter("callback") != null && !request.getParameter("callback").equals("")) {
//            return "redirect:/order/groupBuy/" + request.getParameter("groupProductId") + "/" + request.getParameter("amount") + "?callback=" + request.getParameter("callback");
//        } else if (cartId == null || cartId.equals("")) {
//            return "redirect:/order/easyBuy/" + request.getParameter("productModel") + "?amount=" + request.getParameter("amount");
//        }
//        return "redirect:/order/saveOrUpdateOrder.do?cartId=" + cartId;
//    }
//
//
//    @RequestMapping({"/removeAddress.do"})
//    public String removeAddress(HttpServletRequest request) throws Exception {
//        String addressId = request.getParameter("addressId");
//        baseManager.remove(ConsumerAddress.class.getName(), addressId);
//        return "redirect:/myEfeiyi/address/list";
//
//    }
//
////    @RequestMapping({"defaultAddress.do"})
////    @ResponseBody
////    public boolean defaultAddress(HttpServletRequest request) throws Exception {
////        String id = request.getParameter("consumerId");
////        String sql = "update organization_consumer_address set status = '1'where status<>0 and consumer_id='" + id + "'";
////        baseManager.executeSql(null, sql, null);
////        XSaveOrUpdate xSaveOrUpdate = new XSaveOrUpdate("saveOrUpdateConsumerAddress", request);
////        xSaveOrUpdate.getParamMap().put("consumer_id", AuthorizationUtil.getMyUser().getId());
////        baseManager.saveOrUpdate(xSaveOrUpdate);
////        return true;
////    }
//
//}
