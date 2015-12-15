package com.efeiyi.ec.system.zero.company.controller;

import com.efeiyi.ec.product.model.ProductModel;
import com.efeiyi.ec.zero.company.model.CompanyOrderBatch;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.service.DoHandler;
import com.ming800.core.p.service.AutoSerialManager;
import com.ming800.core.util.ApplicationContextUtil;
import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;

/**
 * Created by Administrator on 2015/12/15.
 * 企业礼品卡 新建或更新Handler
 */

public class CompanyOrderBatchFormHandler implements DoHandler {

    private BaseManager baseManager = (BaseManager) ApplicationContextUtil.getApplicationContext().getBean("baseManagerImpl");
    private AutoSerialManager autoSerialManager = (AutoSerialManager) ApplicationContextUtil.getApplicationContext().getBean("autoSerialManagerImpl");

    @Override
    public ModelMap handle(ModelMap modelMap, HttpServletRequest request) throws Exception {

        CompanyOrderBatch companyOrderBatch = new CompanyOrderBatch();

        String giftId = request.getParameter("id");
        String type = "new";
        if (giftId != null && !"".equals(giftId.trim())) {
            type = "edit";
            companyOrderBatch = (CompanyOrderBatch) baseManager.getObject(CompanyOrderBatch.class.getName(), giftId);
        }

        companyOrderBatch = getRelationProperty(companyOrderBatch, request);
        companyOrderBatch = getBaseProperty(companyOrderBatch, request);

        if (type.equals("new")){
            companyOrderBatch.setStatus("1");//状态 0假删  1正常  2已生成礼品卡
            companyOrderBatch.setCreateDatetime(new Date());
            companyOrderBatch.setSerial(autoSerialManager.nextSerial("companyOrderBatch"));
        }
        modelMap.put("object", companyOrderBatch);
        return modelMap;
    }

    /**
     * 企业礼品卡批次关联对象
     * @param companyOrderBatch 企业礼品卡
     * @param request request
     * @return companyOrderBatch
     * @throws Exception
     */
    private CompanyOrderBatch getRelationProperty(CompanyOrderBatch companyOrderBatch, HttpServletRequest request) throws Exception{
        String productModelId = request.getParameter("productModel.id");
        ProductModel productModel = (ProductModel) baseManager.getObject(ProductModel.class.getName(), productModelId);
        companyOrderBatch.setProductModel(productModel);
        return companyOrderBatch;
    }

    /**
     * 企业礼品卡批次基本属性
     * @param companyOrderBatch 企业礼品卡
     * @param request request
     * @return companyOrderBatch
     * @throws Exception
     */
    private CompanyOrderBatch getBaseProperty(CompanyOrderBatch companyOrderBatch, HttpServletRequest request)throws Exception{
        String amount = request.getParameter("amount");
        String message = request.getParameter("message");
        String companyName = request.getParameter("companyName");
        companyOrderBatch.setMessage(message);
        companyOrderBatch.setAmount(Integer.parseInt(amount));
        companyOrderBatch.setCompanyName(companyName);
        return companyOrderBatch;
    }
}
