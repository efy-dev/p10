package com.efeiyi.pal.system.base.controller;

import com.efeiyi.pal.organization.model.Tenant;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by Administrator on 2015/7/29.
 */
@RestController
public class DialogController {

    @Autowired
    private BaseManager baseManager;

    /**
     * 获取所有商户
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping({"/tenant/list/json"})
    public List<Object> listTenant(HttpServletRequest request) throws Exception{
        XQuery xQuery = new XQuery("listTenant_default", request);
        List<Object> list = this.baseManager.listObject(xQuery);
        return list;
    }

    /**
     * 获取所有商品
     * @param model
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping({"/product/list/json"})
    public List<Object> listProduct(Model model, HttpServletRequest request) throws Exception{
        XQuery xQuery = new XQuery("listProduct_default", request);
        xQuery.addRequestParamToModel(model, request);
        List<Object> list = this.baseManager.listObject(xQuery);
        return list;
    }

    /**
     * 获取一个商户的所有商品
     * @param model
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping({"/product2/list/json"})
    public List<Object> listProduct2(Model model, HttpServletRequest request) throws Exception{
        XQuery xQuery = new XQuery("listProduct_tenant", request);
        xQuery.addRequestParamToModel(model, request);
        List<Object> list = this.baseManager.listObject(xQuery);
        return list;
    }

    /**
     * 获取所有订单
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping({"/order/list/json"})
    public List<Object> listOrder(HttpServletRequest request) throws Exception{
        XQuery xQuery = new XQuery("listPurchaseOrder_default", request);
        List<Object> list = this.baseManager.listObject(xQuery);
        return list;
    }

    /**
     * 获取所有商品系列
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping({"/productSeries/list/json"})
    public List<Object> listProductSeries(HttpServletRequest request) throws Exception{
        XQuery xQuery = new XQuery("listProductSeries_default", request);
        List<Object> list = this.baseManager.listObject(xQuery);
        return list;
    }

    /**
     * 获取一个商户
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping({"/tenant/one/json"})
    public String oneTenant(HttpServletRequest request) throws Exception{
        String tenantId = request.getParameter("tenantId");
        Tenant tenant = (Tenant) baseManager.getObject(Tenant.class.getName(), tenantId);
        return tenant.getId();
    }

    /**
     * 获取一个商户的所有溯源信息
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping({"/tenantSource/list/json"})
    public List<Object> listTenantSource(HttpServletRequest request) throws Exception{
        XQuery xQuery = new XQuery("listTenantSource_default", request);
        List<Object> list = this.baseManager.listObject(xQuery);
        return list;
    }

    /**
     * 获取一个商户的所有认证信息
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping({"/tenantCertification/list/json"})
    public List<Object> listTenantCertification(HttpServletRequest request) throws Exception{
        XQuery xQuery = new XQuery("listTenantCertification_default", request);
        List<Object> list = this.baseManager.listObject(xQuery);
        return list;
    }

    /**
     * 获取所有用户
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping({"/user/list/json"})
    public List<Object> listUser(HttpServletRequest request) throws Exception{
        XQuery xQuery = new XQuery("listUser_default", request);
        List<Object> list = this.baseManager.listObject(xQuery);
        return list;
    }

}
