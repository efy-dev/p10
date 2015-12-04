package com.efeiyi.ec.consumer.order.controller;


import com.efeiyi.ec.purchase.model.PurchaseOrder;
import com.efeiyi.ec.purchase.model.PurchaseOrderComment;
import com.efeiyi.ec.purchase.model.PurchaseOrderCommentPicture;
import com.efeiyi.ec.purchase.model.PurchaseOrderProduct;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.does.model.XSaveOrUpdate;
import com.ming800.core.p.service.AliOssUploadManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2015/9/17.
 */
@Controller
@RequestMapping("comment")
public class PurchaseCommentController {
    @Autowired
    private BaseManager baseManager;
    @Autowired
    private AliOssUploadManager aliOssUploadManager;

    /**
     * PC端查看评�?
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/finishOrderList.do")
    public String finishOrder(HttpServletRequest request,Model model) throws Exception {

        XQuery xQuery = new XQuery("plistPurchaseOrder_default9",request);

        xQuery.addRequestParamToModel(model, request);
        List<Object> list = baseManager.listPageInfo(xQuery).getList();
        model.addAttribute("finishList",list);

    return "/purchaseOrder/purchaseComment";
    }

    /**
     * 移动端查看评�?
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/mobileFinishOrder.do")
    public String mobileFinishOrder(HttpServletRequest request,Model model){
        String orderId=request.getParameter("orderId");
        PurchaseOrder purchaseOrder= (PurchaseOrder) baseManager.getObject(PurchaseOrder.class.getName(), orderId);
        model.addAttribute("finishOrder",purchaseOrder);
        return "/purchaseOrder/purchaseComment";
    }

    /**
     * pc评价
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping("/saveComment.do")
    public String saveOrUpdateComment(HttpServletRequest request) throws Exception {
        int count=0;
        String id=request.getParameter("productId");
        XSaveOrUpdate xUpdate =new XSaveOrUpdate("saveOrUpdateComment",request);
        xUpdate.getParamMap().put("purchaseOrderProduct_id",id);
        PurchaseOrderComment comment = (PurchaseOrderComment)baseManager.saveOrUpdate(xUpdate);

        String[] url=request.getParameterValues("url");
      if(url!=null){
          for(int i=0;i<url.length;i++){

              XSaveOrUpdate commentPicture=new XSaveOrUpdate("saveOrUpdateCommentPicture",request);
              commentPicture.getParamMap().put("pictureUrl",url[i]);
              PurchaseOrderCommentPicture picture= (PurchaseOrderCommentPicture) baseManager.saveOrUpdate(commentPicture);
              picture.setPurchaseOrderComment(comment);
              baseManager.saveOrUpdate(PurchaseOrderCommentPicture.class.getName(),picture);
          }

      }

        PurchaseOrderProduct purchaseOrderProduct = (PurchaseOrderProduct)baseManager.getObject(PurchaseOrderProduct.class.getName(),id);
        purchaseOrderProduct.setStatus("1");
        purchaseOrderProduct.setPurchaseOrderComment(comment);
        baseManager.saveOrUpdate(PurchaseOrderProduct.class.getName(), purchaseOrderProduct);

        String productModelId=purchaseOrderProduct.getProductModel().getId();
        XQuery productModel = new XQuery("listPurchaseOrderProduct_default",request);
        productModel.put("productModel_id",productModelId);
        List<Object> purchaseOrderProductList=baseManager.listObject(productModel);
       if(purchaseOrderProductList.size()!=0){
           for(int i=0;i<purchaseOrderProductList.size();i++){
               PurchaseOrderProduct pop= (PurchaseOrderProduct) purchaseOrderProductList.get(i);
               pop.getPurchaseOrderComment().getStarts();
               count+= Integer.parseInt(pop.getPurchaseOrderComment().getStarts());

           }
           Double average=(double)count/purchaseOrderProductList.size();
           purchaseOrderProduct.setAverage(average);
           baseManager.saveOrUpdate(PurchaseOrderProduct.class.getName(), purchaseOrderProduct);
       }



        String orderId=request.getParameter("orderId");
        PurchaseOrder purchaseOrder=(PurchaseOrder)baseManager.getObject(PurchaseOrder.class.getName(),orderId);
        purchaseOrder.setOrderStatus(PurchaseOrder.ORDER_STATUS_FINISHED);
        for(PurchaseOrderProduct purchaseOrderProductTemp:purchaseOrder.getPurchaseOrderProductList()){
            String status=purchaseOrderProductTemp.getStatus();
            if(!"1".equals(status)){
                purchaseOrder.setOrderStatus(PurchaseOrder.ORDER_STATUS_UNCOMMENT);
                break;
            }
        }

        baseManager.saveOrUpdate(PurchaseOrder.class.getName(),purchaseOrder);


        return"redirect:/comment/finishOrderList.do";
    }

    /**
     * 移动端评价
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping("/saveMobileComment")
    public String saveOrUpdateMobilecomment(HttpServletRequest request) throws Exception {
        int count=0;
        String id=request.getParameter("productId");
        XSaveOrUpdate xUpdate =new XSaveOrUpdate("saveOrUpdateComment",request);
        xUpdate.getParamMap().put("purchaseOrderProduct_id",id);
        PurchaseOrderComment comment = (PurchaseOrderComment)baseManager.saveOrUpdate(xUpdate);

        String[] url=request.getParameterValues("url");
        if(url!=null){
            for(int i=0;i<url.length;i++){

                XSaveOrUpdate commentPicture=new XSaveOrUpdate("saveOrUpdateCommentPicture",request);
                commentPicture.getParamMap().put("pictureUrl",url[i]);
                PurchaseOrderCommentPicture picture= (PurchaseOrderCommentPicture) baseManager.saveOrUpdate(commentPicture);
                picture.setPurchaseOrderComment(comment);
                baseManager.saveOrUpdate(PurchaseOrderCommentPicture.class.getName(),picture);
            }

        }

        PurchaseOrderProduct purchaseOrderProduct = (PurchaseOrderProduct)baseManager.getObject(PurchaseOrderProduct.class.getName(),id);
        purchaseOrderProduct.setStatus("1");
        purchaseOrderProduct.setPurchaseOrderComment(comment);
        baseManager.saveOrUpdate(PurchaseOrderProduct.class.getName(), purchaseOrderProduct);

        String productModelId=purchaseOrderProduct.getProductModel().getId();
        XQuery productModel = new XQuery("listPurchaseOrderProduct_default",request);
        productModel.put("productModel_id",productModelId);
        List<Object> purchaseOrderProductList=baseManager.listObject(productModel);
        if(purchaseOrderProductList.size()!=0){
            for(int i=0;i<purchaseOrderProductList.size();i++){
                PurchaseOrderProduct pop= (PurchaseOrderProduct) purchaseOrderProductList.get(i);
                pop.getPurchaseOrderComment().getStarts();
                count+= Integer.parseInt(pop.getPurchaseOrderComment().getStarts());

            }
            Double average=(double)count/purchaseOrderProductList.size();
            purchaseOrderProduct.setAverage(average);
            baseManager.saveOrUpdate(PurchaseOrderProduct.class.getName(), purchaseOrderProduct);
        }



        String orderId=request.getParameter("orderId");
        PurchaseOrder purchaseOrder=(PurchaseOrder)baseManager.getObject(PurchaseOrder.class.getName(),orderId);
        purchaseOrder.setOrderStatus(PurchaseOrder.ORDER_STATUS_FINISHED);
        for(PurchaseOrderProduct purchaseOrderProductTemp:purchaseOrder.getPurchaseOrderProductList()){
            String status=purchaseOrderProductTemp.getStatus();
            if(!"1".equals(status)){
                purchaseOrder.setOrderStatus(PurchaseOrder.ORDER_STATUS_UNCOMMENT);
                break;
            }
        }

        baseManager.saveOrUpdate(PurchaseOrder.class.getName(),purchaseOrder);


        return"redirect:/order/myEfeiyi/list.do";

    }

    /**
     * 追加评价
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping("/addTOComment.do")
    public String addToComment(HttpServletRequest request) throws Exception {

        String parentCommentId=request.getParameter("parentComment");
        XSaveOrUpdate xUpdate =new XSaveOrUpdate("saveOrUpdateComment",request);
        PurchaseOrderComment subComment = (PurchaseOrderComment)baseManager.saveOrUpdate(xUpdate);
        PurchaseOrderComment comment= (PurchaseOrderComment) baseManager.getObject(PurchaseOrderComment.class.getName(),parentCommentId);
        comment.setSubPurchaseOrderComment(subComment);
        baseManager.saveOrUpdate(PurchaseOrderComment.class.getName(),comment);
        return "redirect:/comment/finishOrderList.do";

    }

    @RequestMapping("/uploadSd.do")
    @ResponseBody
    public String uploadProductImg(HttpServletRequest request) throws Exception{

        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
        Map<String,MultipartFile> fileMap = multipartRequest.getFileMap();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
        String identify = sdf.format(new Date());
        String url = "" ;
        for (Map.Entry<String,MultipartFile> entry : fileMap.entrySet()){
            //上传文件
            MultipartFile mf = entry.getValue();
            String fileName = mf.getOriginalFilename();//获取原文件名
            String hz = fileName.substring(fileName.indexOf("."),fileName.length());

            url = "comment/"+fileName.substring(0,fileName.indexOf(hz))+identify+hz;
            try {
                aliOssUploadManager.uploadFile(mf, "ec-efeiyi", url);
            }catch (Exception e){
                e.printStackTrace();
            }
        }
        return url;
    }

}
