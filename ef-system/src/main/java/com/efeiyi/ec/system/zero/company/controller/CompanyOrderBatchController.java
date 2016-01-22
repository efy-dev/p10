package com.efeiyi.ec.system.zero.company.controller;

import com.efeiyi.ec.purchase.model.PurchaseOrderGift;
import com.efeiyi.ec.system.zero.company.service.CompanyOrderBatchServiceManager;
import com.efeiyi.ec.zero.company.model.CompanyOrderBatch;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

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
        if (orderBatchId == null || orderBatchId.trim().equals("")){
            throw new Exception("企业礼品卡批次Id不能为空");
        }
        CompanyOrderBatch companyOrderBatch = (CompanyOrderBatch) baseManager.getObject(CompanyOrderBatch.class.getName(), orderBatchId);
        return orderGiftListSave(companyOrderBatch, orderBatchId);
    }

    @RequestMapping("/company/downloadOrderGiftsTxt.do")
    public void downloadOrderGiftsTxt(HttpServletRequest request,HttpServletResponse response)throws Exception{
        String id = request.getParameter("id");
        List<PurchaseOrderGift> list;
        String filename;
        if (id == null || id.trim().equals("")){
            XQuery xQuery = new XQuery("listPurchaseOrderGift_companyDefault", request);
            list = baseManager.listObject(xQuery);
            filename = "All.csv";
        }else {
            CompanyOrderBatch companyOrderBatch = (CompanyOrderBatch) baseManager.getObject(CompanyOrderBatch.class.getName(), id);
            list = companyOrderBatchServiceManager.getOrderGiftList(companyOrderBatch);
            filename = companyOrderBatch.getSerial() + ".csv";
        }

        if (list == null || list.size() < 1){
            throw new Exception("获取企业礼品卡失败");
        }
        response.setContentType("text/csv;charset=UTF-8");
        response.setHeader("Content-disposition", "attachment;filename="+filename);
        for(PurchaseOrderGift purchaseOrderGift : list ){
            response.getWriter().write(purchaseOrderGift.getSerial()+","+"http://www.efeiyi.com/giftReceive/" + purchaseOrderGift.getId() + "\r\n");
        }
        response.getWriter().flush();
    }

    @RequestMapping("/company/cancelPurchaseOrderGift.do")
    public ModelAndView cancelPurchaseOrderGift(HttpServletRequest request) throws Exception {
        String giftId = request.getParameter("id");
        if (giftId == null || giftId.trim().equals("")){
            throw new Exception("获取礼品订单失败:订单Id为空");
        }
        companyOrderBatchServiceManager.cancelOrderGift(giftId);
        return new ModelAndView("redirect:/basic/xm.do?qm=plistBatchGift_default");
    }

    private ModelAndView orderGiftListSave(CompanyOrderBatch companyOrderBatch, String orderBatchId)throws Exception{
        if (companyOrderBatch == null){
            throw new Exception("Id为" + orderBatchId + "的企业礼品卡不存在");
        }
        companyOrderBatchServiceManager.buildOrderGiftSetByCompanyOrderBatch(companyOrderBatch);

        companyOrderBatch.setStatus("2");
        baseManager.saveOrUpdate(CompanyOrderBatch.class.getName(), companyOrderBatch);
        return new ModelAndView("redirect:/basic/xm.do?qm=plistPurchaseOrderGift_companyOrderBatch&type=company&conditions=companyOrderBatch.id:" + companyOrderBatch.getId());
    }

}
