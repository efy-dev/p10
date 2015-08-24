package com.efeiyi.pal.system.product.controller;

import com.efeiyi.pal.product.model.Product;
import com.efeiyi.pal.product.model.ProductImg;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.p.service.AliOssUploadManager;
import com.ming800.core.util.ApplicationContextUtil;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartRequest;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by Administrator on 2015/8/24.
 */

@Controller
@RequestMapping("/productImg")
public class ProductImgController {

    private BaseManager baseManager = (BaseManager) ApplicationContextUtil.getApplicationContext().getBean("baseManagerImpl");
    private AliOssUploadManager aliOssUploadManager = (AliOssUploadManager) ApplicationContextUtil.getApplicationContext().getBean("aliOssUploadManagerImpl");

    @RequestMapping("/saveProductImg.do")
    public ModelAndView saveProductImg(HttpServletRequest request, MultipartRequest multipartRequest) throws Exception{

        ProductImg productImg = new ProductImg();

        String productId = request.getParameter("productId");
        if (productId == null || productId.trim().equals("")){
            throw new Exception("class com.efeiyi.pal.system.product.controller.ProductImgController saveProductImg method: productId is null !");
        }
        Product product = (Product)baseManager.getObject(Product.class.getName(), productId);
        productImg.setProduct(product);
        productImg.setStatus("1");
        productImg = upLoadImg(multipartRequest, productImg);
        baseManager.saveOrUpdate(ProductImg.class.getName(), productImg);

        String resultPage = "redirect:/basic/xm.do?qm=viewProduct&id=" + product.getId();

        return new ModelAndView(resultPage);
    }

    @RequestMapping("/removeProductImg.do")
    public ModelAndView removeProductImg(HttpServletRequest request) throws Exception{
        String productId = request.getParameter("productId");
        String ImgId = request.getParameter("ImgId");
        if (productId == null || productId.trim().equals("")){
            throw new Exception("class com.efeiyi.pal.system.product.controller.ProductImgController removeProductImg method: productId is null !");
        }
        if (ImgId == null || ImgId.trim().equals("")){
            throw new Exception("class com.efeiyi.pal.system.product.controller.ProductImgController removeProductImg method: ImgId is null !");
        }
        Product product = (Product) baseManager.getObject(Product.class.getName(), productId);
        ProductImg productImg = (ProductImg) baseManager.getObject(ProductImg.class.getName(), ImgId);
        productImg.setStatus("0");
        baseManager.saveOrUpdate(ProductImg.class.getName(), productImg);

        String resultPage = "redirect:/basic/xm.do?qm=viewProduct&id=" + product.getId();

        return new ModelAndView(resultPage);
    }

    private ProductImg upLoadImg(MultipartRequest multipartRequest, ProductImg productImg) throws Exception{
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
        String identify = sdf.format(new Date());
        String url = "product/" + identify + ".jpg";

        if (!multipartRequest.getFile("Img").getOriginalFilename().equals("")) {
            aliOssUploadManager.uploadFile(multipartRequest.getFile("Img"), "315pal", url);
            productImg.setImgUrl(url);
        }

        return productImg;
    }

}
