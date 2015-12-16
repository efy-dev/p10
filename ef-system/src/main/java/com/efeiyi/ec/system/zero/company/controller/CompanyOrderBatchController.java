package com.efeiyi.ec.system.zero.company.controller;

import com.efeiyi.ec.system.zero.company.service.CompanyOrderBatchServiceManager;
import com.efeiyi.ec.zero.company.model.CompanyOrderBatch;
import com.ming800.core.base.service.BaseManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by Administrator on 2015/12/15.
 * 企业礼品卡批次 Controller
 */

@Controller
public class CompanyOrderBatchController {

    @Autowired
    private BaseManager baseManager;
    @Autowired
    private CompanyOrderBatchServiceManager companyOrderBatchServiceManager;

    @RequestMapping("/company/saveCompanyOrderGiftList.do")
    public ModelAndView saveOrderGiftList(HttpServletRequest request)throws Exception{
        String orderBatchId = request.getParameter("id");
        if (orderBatchId.isEmpty() || orderBatchId.trim().equals("")){
            throw new Exception("企业礼品卡Id不能为空");
        }
        CompanyOrderBatch companyOrderBatch = (CompanyOrderBatch) baseManager.getObject(CompanyOrderBatch.class.getName(), orderBatchId);
        return orderGiftListSave(companyOrderBatch, orderBatchId);
    }

    private ModelAndView orderGiftListSave(CompanyOrderBatch companyOrderBatch, String orderBatchId)throws Exception{
        if (companyOrderBatch == null){
            throw new Exception("Id为" + orderBatchId + "的企业礼品卡不存在");
        }
        companyOrderBatchServiceManager.buildOrderGiftSetByCompanyOrderBatch(companyOrderBatch);

        companyOrderBatch.setStatus("2");
        baseManager.saveOrUpdate(CompanyOrderBatch.class.getName(), companyOrderBatch);
        return new ModelAndView("redirect:/basic/xm.do?qm=plistPurchaseOrderGift_companyOrderBatch&company=company&conditions=companyOrderBatch.id:" + companyOrderBatch.getId());
    }

}
