package com.efeiyi.ec.system.couponBatch.controller;

import com.efeiyi.ec.product.model.Product;
import com.efeiyi.ec.project.model.Project;
import com.efeiyi.ec.purchase.model.CouponBatch;
import com.efeiyi.ec.tenant.model.Tenant;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.service.DoHandler;
import com.ming800.core.p.service.AutoSerialManager;
import com.ming800.core.util.ApplicationContextUtil;
import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by Administrator on 2015/10/27.
 */
public class CouponBatchHandler implements DoHandler {

    private BaseManager baseManager = (BaseManager) ApplicationContextUtil.getApplicationContext().getBean("baseManagerImpl");
    private AutoSerialManager autoSerialManager = (AutoSerialManager) ApplicationContextUtil.getApplicationContext().getBean("autoSerialManagerImpl");

    @Override
    public ModelMap handle(ModelMap modelMap, HttpServletRequest request) throws Exception {
        String serial = autoSerialManager.nextSerial("systemAutoSerial");
        Date date = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        String date1 = sdf.format(date);

        SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");

        CouponBatch couponBatch = new CouponBatch();
        couponBatch.setStatus("1");

        String deliverType = request.getParameter("deliverType");
        if("1".equals(deliverType) || "2".equals(deliverType)){
            couponBatch.setAmount(Integer.parseInt(request.getParameter("amount")));
        }

        if("2".equals(deliverType) || "3".equals(deliverType)){
            couponBatch.setEndReceiveTime(null);
            couponBatch.setStartReceiveTime(null);
        }else {
            couponBatch.setEndReceiveTime(request.getParameter("endReceiveTime"));
            couponBatch.setStartReceiveTime(request.getParameter("startReceiveTime"));
        }

        couponBatch.setDeliverType(request.getParameter("deliverType"));
        couponBatch.setEndDate(sdf1.parse(request.getParameter("endDate")));

        couponBatch.setIsCreatedCoupon(1);
        couponBatch.setName(request.getParameter("name"));

        String type = request.getParameter("type");
        if("1".equals(type)){
            couponBatch.setPrice(Float.parseFloat(request.getParameter("price")));
            couponBatch.setPriceLimit(Float.parseFloat(request.getParameter("priceLimit")));
        }else if("2".equals(type)){
            couponBatch.setPrice(Float.parseFloat(request.getParameter("price1")));
        }

        String range = request.getParameter("range");
        if("2".equals(range)){
            couponBatch.setProject((Project) baseManager.getObject(Project.class.getName(),request.getParameter("project")));
        }else if("3".equals(range)){
            couponBatch.setTenant((Tenant) baseManager.getObject(Tenant.class.getName(),request.getParameter("tenant")));
        }else if("4".equals(range)){
            couponBatch.setProduct((Product) baseManager.getObject(Product.class.getName(),request.getParameter("product")));
        }

        couponBatch.setRange(request.getParameter("range"));
        couponBatch.setStartDate(sdf1.parse(request.getParameter("startDate")));

        couponBatch.setType(request.getParameter("type"));
        couponBatch.setUniqueKey(date1+serial);

        modelMap.put("object",couponBatch);

        return modelMap;
    }
}
