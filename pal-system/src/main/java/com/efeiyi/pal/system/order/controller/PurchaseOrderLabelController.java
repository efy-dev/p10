package com.efeiyi.pal.system.order.controller;

import com.efeiyi.pal.product.model.Product;
import com.efeiyi.pal.purchase.model.PurchaseOrder;
import com.efeiyi.pal.purchase.model.PurchaseOrderLabel;
import com.ming800.core.base.service.BaseManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLEncoder;

/**
 * Created by Administrator on 2015/8/17.
 * 订单-商品-标签 Controller
 */

@Controller
@RequestMapping("/purchaseOrderLabel")
public class PurchaseOrderLabelController {

    @Autowired
    private BaseManager baseManager;

    @RequestMapping("/savePurchaseOrderLabel.do")
    public ModelAndView savePurchaseOrderLabel(HttpServletRequest request) throws Exception{
        PurchaseOrderLabel purchaseOrderLabel = new PurchaseOrderLabel();

        String orderLabelId = request.getParameter("id");
        String type = "new";
        if (orderLabelId != null && !orderLabelId.equals("")) {
            type = "edit";
            purchaseOrderLabel = (PurchaseOrderLabel) baseManager.getObject(PurchaseOrderLabel.class.getName(), orderLabelId);
        }
        purchaseOrderLabel = setPurchaseOrderLabelBaseProperty(purchaseOrderLabel, request, type);
        purchaseOrderLabel = getRelationAttributeObject(purchaseOrderLabel, request);

        baseManager.saveOrUpdate(purchaseOrderLabel.getClass().getName(), purchaseOrderLabel);

        String resultPage = "redirect:/basic/xm.do?qm=viewPurchaseOrder&order=view&id="+purchaseOrderLabel.getPurchaseOrder().getId();
        return new ModelAndView(resultPage);
    }

    @RequestMapping("/removePurchaseOrderLabel.do")
    public ModelAndView removeTenantSource(HttpServletRequest request) throws Exception{
        String orderLabelId = request.getParameter("orderLabelId");
        if (orderLabelId == null || orderLabelId.trim().equals("")) {
            throw new Exception("id不能为空!");
        }
        PurchaseOrderLabel purchaseOrderLabel = (PurchaseOrderLabel) baseManager.getObject(PurchaseOrderLabel.class.getName(), orderLabelId);
        purchaseOrderLabel.setStatus("0");
        baseManager.saveOrUpdate(purchaseOrderLabel.getClass().getName(), purchaseOrderLabel);

        String resultPage = "redirect:/basic/xm.do?qm=viewPurchaseOrder&order=view&id="+purchaseOrderLabel.getPurchaseOrder().getId();
        return new ModelAndView(resultPage);
    }

    /**
     * 获取purchaseOrderLabel的Form表单基本数据
     * @param purchaseOrderLabel 订单商品标签
     * @param request 获取页面参数
     * @param type 新建"new"; 修改"edit"
     * @return purchaseOrderLabel 订单商品标签
     */
    private PurchaseOrderLabel setPurchaseOrderLabelBaseProperty(PurchaseOrderLabel purchaseOrderLabel, HttpServletRequest request, String type) throws Exception {
        String amount = request.getParameter("amount");
        purchaseOrderLabel.setAmount(Integer.valueOf(amount));
        if ("new".equals(type)) {
            purchaseOrderLabel.setStatus("1");
        }else {
            String status = request.getParameter("status");
            purchaseOrderLabel.setStatus(status);
        }
        String polType = request.getParameter("type");
        purchaseOrderLabel.setType(polType);
        return purchaseOrderLabel;
    }

    /**
     * 获取关联属性的对象
     * @param purchaseOrderLabel 订单商品标签
     * @param request 获取页面参数
     * @return purchaseOrderLabel 订单商品标签
     */
    private PurchaseOrderLabel getRelationAttributeObject(PurchaseOrderLabel purchaseOrderLabel, HttpServletRequest request){
        String purchaseOrderId = request.getParameter("purchaseOrder.id");
        PurchaseOrder purchaseOrder = (PurchaseOrder) baseManager.getObject(PurchaseOrder.class.getName(), purchaseOrderId);
        purchaseOrderLabel.setPurchaseOrder(purchaseOrder);

        String productId = request.getParameter("product.id");
        Product product = (Product) baseManager.getObject(Product.class.getName(), productId);
        purchaseOrderLabel.setProduct(product);

        return purchaseOrderLabel;
    }

    @RequestMapping("/downNFCTxt.do")
    public void downloadLabelTxt(HttpServletRequest request, HttpServletResponse response) throws Exception{

        String orderLabelId = request.getParameter("orderLabelId");

        PurchaseOrderLabel orderLabel = (PurchaseOrderLabel) baseManager.getObject(PurchaseOrderLabel.class.getName(), orderLabelId);
        String orderSerial = orderLabel.getPurchaseOrder().getSerial();
        String productName = orderLabel.getProduct().getName();
        String productSerial = orderLabel.getProduct().getSerial();

        String path = this.getClass().getClassLoader().getResource("/").getPath();
        File clazzDir = new File(path);
        String fileType = request.getParameter("filetype");
//        String fileName = clazzDir.getParent() + "/file/" + orderLabelId + (fileType == null?".txt":fileType);

        //文件名==订单编号-商品名称-商品编号-订单标签Id
        String fileName = orderSerial + "-" + productName + "-" + productSerial + "-" + orderLabelId + (fileType == null?".txt":fileType);

        File file = new File(clazzDir.getParent() + "/file/" +fileName);
        response.addHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(fileName, "UTF-8"));
        response.setContentLength((int) file.length());
        DataInputStream bis = null;
        try {
            if (!file.exists())
                throw new NullPointerException("指定文件" + fileName + "不存在");
//            bis = new DataInputStream(new FileInputStream(new File(fileName)));
            bis = new DataInputStream(new FileInputStream(new File(clazzDir.getParent() + "/file/" + fileName)));
            int i;
            while ((i = bis.read()) != -1) {
                response.getOutputStream().write(i);
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        } finally {
            try {
                bis.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

}
