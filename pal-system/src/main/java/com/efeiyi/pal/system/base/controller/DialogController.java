package com.efeiyi.pal.system.base.controller;

import com.efeiyi.pal.label.model.Label;
import com.efeiyi.pal.organization.model.Tenant;
import com.efeiyi.pal.product.model.ProductSeries;
import com.efeiyi.pal.product.model.TenantProductSeries;
import com.efeiyi.pal.system.order.service.LabelServiceManager;
import com.ming800.core.base.dao.XdoDao;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.base.service.XdoManager;
import com.ming800.core.base.util.XDoUtil;
import com.ming800.core.does.model.Do;
import com.ming800.core.does.model.DoQuery;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.does.service.DoManager;
import com.ming800.core.p.service.AutoSerialManager;
import com.ming800.core.util.ApplicationContextUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

/**
 * Created by Administrator on 2015/7/29.
 *
 */
@RestController
public class DialogController {

    @Autowired
    private BaseManager baseManager;
    @Autowired
    private DoManager doManager;
    @Autowired
    private XdoManager xdoManager;
    @Autowired
    private AutoSerialManager autoSerialManager;
    @Autowired
    @Qualifier("labelServiceManagerImpl")
    private LabelServiceManager labelServiceManager;

    private XdoDao xdoDao = (XdoDao) ApplicationContextUtil.getApplicationContext().getBean("xdoDaoSupport");

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

    /**
     * 商户为空时商户系列中所有系列
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping({"/seriesByTenantNull/list/json"})
    public Set<Object> jsonListProductSeriesByTenantNull(HttpServletRequest request) throws Exception{
        XQuery xQuery = new XQuery("listTenantProductSeries_default", request);
        List<Object> list = this.baseManager.listObject(xQuery);
        List<Object> newList = new ArrayList<>();
        for(Object o:list){
            newList.add(((TenantProductSeries) o).getProductSeries());
        }
        return new HashSet<>(newList);
    }

    /**
     * 商户系列中某个商户包含的所有系列
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping({"/seriesByTenant/list/json"})
    public List<Object> jsonListProductSeriesByTenant(HttpServletRequest request) throws Exception{
        XQuery xQuery = new XQuery("listTenantProductSeries_productSeriesByTenant", request);
        List<Object> list = this.baseManager.listObject(xQuery);
        List<Object> newList = new ArrayList<>();
        for(Object o:list){
            newList.add(((TenantProductSeries) o).getProductSeries());
        }
        return newList;
    }

    /**
     * 系列为空时商户系列中所有商户
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping({"/TenantBySeriesNull/list/json"})
    public Set<Object> jsonListTenantByProductSeriesNull(HttpServletRequest request) throws Exception{
        XQuery xQuery = new XQuery("listTenantProductSeries_default", request);
        List<Object> list = this.baseManager.listObject(xQuery);
        List<Object> newList = new ArrayList<>();
        for(Object o:list){
            newList.add(((TenantProductSeries) o).getTenant());
        }
        return new HashSet<>(newList);
    }

    /**
     * 商户系列中某个系列包含的所有商户
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping({"/TenantBySeries/list/json"})
    public List<Object> jsonListTenantByProductSeries(HttpServletRequest request) throws Exception{
        XQuery xQuery = new XQuery("listTenantProductSeries_tenantByProductSeries", request);
        List<Object> list = this.baseManager.listObject(xQuery);
        List<Object> newList = new ArrayList<>();
        for(Object o:list){
            newList.add(((TenantProductSeries) o).getTenant());
        }
        return newList;
    }

    /**
     * Ajax新建或修改商户信息
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping("/tenant/saveTenantAjax.do")
    public String saveTenantAjax(HttpServletRequest request) throws Exception {
        Tenant tenant = new Tenant();
        String qm = request.getParameter("qm");

        String tenantId = request.getParameter("id");
        String type = "new";
        if (tenantId != null && !"".equals(tenantId.trim())) {
            type = "edit";
            tenant = (Tenant) baseManager.getObject(Tenant.class.getName(), tenantId);
        }
        Do tempDo = doManager.getDoByQueryModel(qm);
        tenant = (Tenant) XDoUtil.processSaveOrUpdateTempObject(tempDo, tenant, tenant.getClass(), request, type, xdoDao);
        if ("new".equals(type)){
            tenant.setStatus("1");
        }
        baseManager.saveOrUpdate(Tenant.class.getName(), tenant);
        String resultPage = request.getContextPath()+"/basic/xm.do?qm=viewTenant&tenant=tenant&id=" + tenant.getId();

        return resultPage;
    }

    /**
     * Ajax新建或修改非遗项目信息
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping("/productSeries/saveProductSeriesAjax.do")
    public String saveProductSeries(HttpServletRequest request) throws Exception {
        ProductSeries productSeries = new ProductSeries();
        String qm = request.getParameter("qm");

        String productSeriesId = request.getParameter("id");
        String type = "new";
        if (productSeriesId != null && !productSeriesId.equals("")) {
            type = "edit";
            productSeries = (ProductSeries) baseManager.getObject(ProductSeries.class.getName(), productSeriesId);
        }
        Do tempDo = doManager.getDoByQueryModel(qm);
        productSeries = (ProductSeries) XDoUtil.processSaveOrUpdateTempObject(tempDo, productSeries, productSeries.getClass(), request, type, xdoDao);
        if ("new".equals(type)){
            String serial = autoSerialManager.nextSerial("serial");
            productSeries.setSerial(serial);
            productSeries.setStatus("1");
        }
        baseManager.saveOrUpdate(productSeries.getClass().getName(), productSeries);

        String resultPage = request.getContextPath()+"/basic/xm.do?qm=viewProductSeries&ps=ps&id=" + productSeries.getId();
        return resultPage;
    }

    /**
     * Ajax作废单个标签
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping("/Label/cancelLabelAjax.do")
    public String cancelLabel(HttpServletRequest request) throws Exception {
        String labelId = request.getParameter("id");
        if (labelId == null || "".equals(labelId.trim())){
            throw new Exception("标签id不能为空");
        }
        Label label = (Label) baseManager.getObject(Label.class.getName(), labelId);
        label.setStatus("4");
        baseManager.saveOrUpdate(Label.class.getName(), label);
        return "ture";
    }

    @RequestMapping("/Label/cancelLabelListAjax.do")
    public String cancelLabelList(HttpServletRequest request) throws Exception {
        String qm = request.getParameter("qm");
        String conditions = request.getParameter("conditions");
        qm = qm.substring(1,qm.length());
        Do tempDo = doManager.getDoByQueryModel(qm.split("_")[0]);
        DoQuery tempDoQuery = tempDo.getDoQueryByName(qm.split("_")[1]);
        List<Label> labelList = (List<Label>) xdoManager.list(tempDo, tempDoQuery, conditions);
        String status = "4";
        labelServiceManager.activateOrCancelLabelList(status, labelList);

        return "true";
    }
}
