package com.efeiyi.ec.website.activity.controller;

import com.efeiyi.ec.activity.group.model.GroupProduct;
import com.efeiyi.ec.organization.model.Consumer;
import com.efeiyi.ec.purchase.model.Coupon;
import com.efeiyi.ec.purchase.model.CouponBatch;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.PageInfo;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.p.service.AutoSerialManager;
import com.ming800.core.taglib.PageEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.Collections;
import java.util.Date;
import java.util.List;

/**
 * Created by Administrator on 2015/10/20.
 */
@Controller
//@RequestMapping("/product")
public class GroupProductController {
    @Autowired
    private BaseManager baseManager;

    @Autowired
    private AutoSerialManager autoSerialManager;

    @RequestMapping({"/tuan","/tuan.do"})
    public String listProduct1(HttpServletRequest request, Model model) throws Exception {
     return  "/groupProduct/groupProductList";
    }


    @RequestMapping("/sso.do")
    public String forward(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String redirect = request.getParameter("callUrl");
        String registeSuccess = request.getParameter("registeSuccess");
        String userId = request.getParameter("userId");
        if (userId != null && !"".equals(userId)) {
            Consumer consumer = (Consumer) baseManager.getObject(Consumer.class.getName(), userId);
            XQuery xQuery = new XQuery("listCouponBatch_defaultFlag", request);
            List<Object> couponBatchList = baseManager.listObject(xQuery);
            for (Object couponBatchTemp : couponBatchList) {
                if (((CouponBatch) couponBatchTemp).getCouponList().size() < ((CouponBatch) couponBatchTemp).getAmount()) {
                    Coupon coupon = new Coupon();
                    coupon.setStatus("1");
                    coupon.setSerial(autoSerialManager.nextSerial("orderSerial"));
                    coupon.setCouponBatch((CouponBatch) couponBatchTemp);
                    Date currentDate = new Date();
                    SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMdd");
                    String currentDateStr = simpleDateFormat.format(currentDate);
                    coupon.setUniqueKey(currentDateStr + coupon.getSerial());
                    coupon.setConsumer(consumer);
                    baseManager.saveOrUpdate(Coupon.class.getName(), coupon);
                }
            }
        }
        if (redirect != null) {
            return "redirect:http://" + redirect;
        }
        if (registeSuccess != null) {
            return "redirect:" + registeSuccess;
        }
        return "redirect:/";
    }

    /**
     * 团购产品列表
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/product/groupProduct.do/{index}")
    @ResponseBody
    public List<GroupProduct> listProduct(HttpServletRequest request,@PathVariable String index) throws Exception {
        XQuery xQuery = new XQuery("listGroupProduct_default",request);
        xQuery.put("status","1");
        List<GroupProduct> list = baseManager.listObject(xQuery);
        for(GroupProduct groupProduct:list){
            groupProduct.setProductName(groupProduct.getProductModel().getProduct().getName());
        }
        return list;
    }
    /**
     * 开团详情页
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/product/groupProduct/{groupProductId}")
    public String groupProductDetails(@PathVariable String groupProductId ,HttpServletRequest request, Model model) throws Exception {
        GroupProduct groupProduct = (GroupProduct) baseManager.getObject(GroupProduct.class.getName(), groupProductId);
        XQuery purchaseOrderProductQuery = new XQuery("listPurchaseOrderProduct_default",request);
        purchaseOrderProductQuery.put("productModel_id", groupProduct.getProductModel().getId());
        List<Object> purchaseOrderProductList = baseManager.listObject(purchaseOrderProductQuery);
        Collections.reverse(purchaseOrderProductList);
        model.addAttribute("groupProduct", groupProduct);
        model.addAttribute("purchaseOrderProductList", purchaseOrderProductList);
        return "/groupProduct/groupProductDetails";
    }
    /**
     * 评价详情
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/product/groupProduct/purchaseOrderComment/{groupProductId}/{index}")
    @ResponseBody
    public List<Object> getPurchaseOrderCommentList(@PathVariable String groupProductId ,HttpServletRequest request,@PathVariable String index) throws Exception {
        GroupProduct groupProduct = (GroupProduct) baseManager.getObject(GroupProduct.class.getName(), groupProductId);
        XQuery purchaseOrderProductQuery = new XQuery("listPurchaseOrderProduct_default",request);
        purchaseOrderProductQuery.put("productModel_id", groupProduct.getProductModel().getId());
        PageEntity pageEntity = new PageEntity();
        if (index != null) {
            pageEntity.setIndex(Integer.parseInt(index));
        }
        pageEntity.setSize(4);
        purchaseOrderProductQuery.setPageEntity(pageEntity);
        PageInfo pageInfo = baseManager.listPageInfo(purchaseOrderProductQuery);
        List<Object> list = pageInfo.getList();
        if(list!=null&&list.size()>0){
        Collections.reverse(list);
        }
        return list;
    }
    @RequestMapping(value = "/product/playDetails")
    public String returnPlayDetails(HttpServletRequest request, Model model){

        return  "/playDetails";
    }

}
