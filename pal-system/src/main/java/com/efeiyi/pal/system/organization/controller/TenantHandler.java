package com.efeiyi.pal.system.organization.controller;

import com.efeiyi.pal.organization.model.Tenant;
import com.efeiyi.pal.product.model.ProductSeries;
import com.ming800.core.base.dao.XdoDao;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.base.service.XdoManager;
import com.ming800.core.base.util.XDoUtil;
import com.ming800.core.does.model.Do;
import com.ming800.core.does.service.DoHandler;
import com.ming800.core.util.ApplicationContextUtil;
import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpServletRequest;
import java.util.HashSet;

/**
 * Created by Administrator on 2015/7/23.
 */

public class TenantHandler implements DoHandler {

    private BaseManager baseManager = (BaseManager) ApplicationContextUtil.getApplicationContext().getBean("baseManagerImpl");
    private XdoManager xdoManager = (XdoManager) ApplicationContextUtil.getApplicationContext().getBean("xdoManagerImpl");
    private XdoDao xdoDao = (XdoDao) ApplicationContextUtil.getApplicationContext().getBean("xdoDaoSupport");

    @Override
    public ModelMap handle(ModelMap modelMap, HttpServletRequest request) throws Exception {

        Tenant tenant = new Tenant();

        String labelBatchId = request.getParameter("id");
        String type = "new";
        if (labelBatchId != null && !labelBatchId.equals("")) {
            type = "edit";
            tenant = (Tenant) baseManager.getObject(Tenant.class.getName(), labelBatchId);
        }
        Do tempDo = (Do) modelMap.get("tempDo");
        tenant = (Tenant) XDoUtil.processSaveOrUpdateTempObject(tempDo, tenant, tenant.getClass(), request, type, xdoDao);

        tenant = getRelationAttributeObject(tenant, request, type);

        modelMap.put("object", tenant);
        return modelMap;
    }

    /**
     * 获取关联属性的对象
     * @param tenant
     * @param request
     * @param type
     * @return
     */
    private Tenant getRelationAttributeObject(Tenant tenant, HttpServletRequest request, String type){
//        String provinceId = request.getParameter("province.id");
//        String addressId = request.getParameter("address.id");
//
//        AddressProvince province = (AddressProvince) baseManager.getObject(AddressProvince.class.getName(), provinceId);
//        AddressDistrict address = (AddressDistrict) baseManager.getObject(AddressDistrict.class.getName(), addressId);
//
//        tenant.setProvince(province);
//        tenant.setAddress(address);

        if (type.equals("new")){
            tenant.setProductSeriesSet(new HashSet<ProductSeries>());
        }

        return tenant;
    }

}
