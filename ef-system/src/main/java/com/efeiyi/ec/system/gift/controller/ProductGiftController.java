package com.efeiyi.ec.system.gift.controller;

import com.alibaba.fastjson.JSONObject;
import com.efeiyi.ec.gift.model.*;
import com.efeiyi.ec.product.model.ProductModel;
import com.efeiyi.ec.product.model.Subject;
import com.efeiyi.ec.product.model.SubjectDescription;
import com.efeiyi.ec.product.model.SubjectPicture;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.p.service.AliOssUploadManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

/**
 * Created by Administrator on 2016/5/5 0005.
 */
@Controller
public class ProductGiftController {

    @Autowired
    private BaseManager baseManager;

    @Autowired
    private AliOssUploadManager aliOssUploadManager;

    @RequestMapping("/productGiftIndustrySolution/saveOrUpdate.do")
    @ResponseBody
    public boolean createProductGiftIndustrySolution(HttpServletRequest request) {
        try {
            String industryId = request.getParameter("industryId");
            String giftId = request.getParameter("giftId");
            ProductGiftIndustrySolution productGiftIndustrySolution = new ProductGiftIndustrySolution();
            productGiftIndustrySolution.setIndustrySolution((IndustrySolution) baseManager.getObject(IndustrySolution.class.getName(), industryId));
            productGiftIndustrySolution.setProductGift((ProductGift) baseManager.getObject(ProductGift.class.getName(), giftId));
            productGiftIndustrySolution.setStatus("1");
            baseManager.saveOrUpdate(ProductGiftIndustrySolution.class.getName(), productGiftIndustrySolution);
            return true;
        } catch (Exception e) {
            return false;
        }
    }


    @RequestMapping({"/productGift/relation.do"})
    public String relationProductGiftTag(HttpServletRequest request) {
        String productGiftId = request.getParameter("productGift.id");
        ProductGift productGift = (ProductGift) baseManager.getObject(ProductGift.class.getName(), productGiftId);
        String productGiftTagValueIds = request.getParameter("productGiftTagValueIds");
        if (productGiftTagValueIds != null && !productGiftTagValueIds.equals("")) {
            List<String> productGiftTagValueIdList = Arrays.asList(productGiftTagValueIds.split(";"));
            for (String id : productGiftTagValueIdList) {
                ProductGiftTagValue productGiftTagValue = (ProductGiftTagValue) baseManager.getObject(ProductGiftTagValue.class.getName(), id);
                ProductGiftTag productGiftTag = new ProductGiftTag();
                productGiftTag.setProductGift(productGift);
                productGiftTag.setProductGiftTagValue(productGiftTagValue);
                productGiftTag.setStatus("1");
                baseManager.saveOrUpdate(ProductGiftTag.class.getName(), productGiftTag);
            }
        }
        return "redirect:/basic/xm.do?qm=viewProductGift&id=" + productGiftId;
    }


    //关联商品批量处理方法
    @RequestMapping({"/dealProductGift.do"})
    @ResponseBody
    public String dealProductGift() {
        List<ProductModel> productModels = baseManager.listObject("select obj from ProductModel obj where obj.status!=0");
        List<ProductGift> productGiftList = new ArrayList<>();
        int testNum = 0;
        for (ProductModel productModel : productModels) {
            try {

                ProductGift productGift = new ProductGift();
                productGift.setStatus("1");
                productGift.setCreateDatetime(new Date());
                if (productModel.getProduct().getProductModelList().size() > 1) {
                    productGift.setName(productModel.getProduct().getName() + "[" + productModel.getName() + "]");
                } else {
                    productGift.setName(productModel.getName());
                }
                productGift.setProductModel(productModel);
                productGift.setProject(productModel.getProduct().getProject());
                productGift.setProjectCategory(productModel.getProduct().getProject().getProjectCategory());
                productGiftList.add(productGift);
            } catch (Exception e) {
                testNum += 1;
                continue;
            }
        }

        for (ProductGift productGift : productGiftList) {
            baseManager.saveOrUpdate(ProductGift.class.getName(), productGift);
        }
        List<ProductGift> productGifts = baseManager.listObject("select obj from ProductGift obj where obj.status!=0");
        return productGifts.size() + ":" + testNum + ":" + productGiftList.size();

    }


    //提交富文本修改的接口
    @RequestMapping({"/subjectDescription/saveOrUpdate.do"})
    public String saveOrUpdateSubjectDescription(HttpServletRequest request) {
        String content = request.getParameter("content");
        String objectId = request.getParameter("objectId");
        String callbackUrl = request.getParameter("callbackUrl");
        String subjectId = request.getParameter("subjectId");
        Subject subject = (Subject) baseManager.getObject(Subject.class.getName(), subjectId);
        SubjectDescription subjectDescription;
        if (objectId != null && !objectId.equals("")) {
            subjectDescription = (SubjectDescription) baseManager.getObject(SubjectDescription.class.getName(), objectId);
            subjectDescription.setContent(content);
            baseManager.saveOrUpdate(SubjectDescription.class.getName(), subjectDescription);
        } else {
            subjectDescription = new SubjectDescription();
            subjectDescription.setContent(content);
            baseManager.saveOrUpdate(SubjectDescription.class.getName(), subjectDescription);
            subject.setSubjectDescription(subjectDescription);
            baseManager.saveOrUpdate(Subject.class.getName(), subject);
        }
        return "redirect:" + callbackUrl;
    }


    //上传图图片的接口 (单图片上传接口)
    @RequestMapping({"/subjectDescription/image/upload.do"})
    @ResponseBody
    public ResponseEntity uploadDescriptionImage(HttpServletRequest request) {
        String subjectId = request.getParameter("subjectId");
        Subject subject = (Subject) baseManager.getObject(Subject.class.getName(), subjectId);
        SubjectPicture subjectPicture = new SubjectPicture();
        subjectPicture.setSubject(subject);
        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
        Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();
        String url;
        Map.Entry<String, MultipartFile> entry = fileMap.entrySet().iterator().next();
        MultipartFile mf = entry.getValue();
        String fileName = mf.getOriginalFilename();//获取原文件名
        url = "subject/content/" + fileName;
        subjectPicture.setPictureUrl(url);
        baseManager.saveOrUpdate(SubjectPicture.class.getName(), subjectPicture);
        try {
            aliOssUploadManager.uploadFile(mf, "ef-gift", url);
        } catch (Exception e) {
            e.printStackTrace();
        }
        String imgPath = "gift-oss.efeiyi.com/" + url;
        String result = "{\"original\":\"" + fileName + "\",\"name\":\"" + fileName + "\",\"url\":\"" + imgPath + "\",\"size\":\"" + mf.getSize() + "\",\"type\":\"" + mf.getContentType() + "\",\"state\":\"SUCCESS\"}";
        JSONObject jsonObject = JSONObject.parseObject(result);
        return new ResponseEntity(jsonObject, HttpStatus.OK);
    }
}
