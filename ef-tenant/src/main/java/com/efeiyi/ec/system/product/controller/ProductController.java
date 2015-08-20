package com.efeiyi.ec.system.product.controller;



import com.efeiyi.ec.product.model.Product;
import com.efeiyi.ec.product.model.ProductPicture;
import com.ming800.core.base.controller.BaseController;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.p.service.AliOssUploadManager;
import com.ming800.core.util.ApplicationContextUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by Administrator on 2015/6/18.
 */
@Controller
@RequestMapping("/product")
public class ProductController extends BaseController {
    @Autowired
    private BaseManager baseManager;

    @Autowired
    private AliOssUploadManager aliOssUploadManager;


    @RequestMapping("/listProduct.do")
    public ModelAndView getProductList(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {

        List<Product> list = baseManager.listObject("from Product");
        for (Iterator<Product> i = list.iterator();i.hasNext();){
            Product product = i.next();
            System.out.println(product.getName());

        }
        modelMap.put("listProduct", list);
        return new ModelAndView("/pc/product/productList", modelMap);
    }


    @RequestMapping({"/test/nav/{item}"})
    public String testNav(HttpServletRequest request,@PathVariable String item){
        String match = request.getServletPath();
//        System.out.println(match);
        request.setAttribute("match",match);
        return "/test/navTest";
    }

    @RequestMapping("/index.do")
    public String goIndex(HttpServletRequest request){
        return "/index";
    }

    @RequestMapping("/uploadify.do")
    @ResponseBody
    public String uploadProductImg(HttpServletRequest request ,HttpServletResponse response) throws Exception{
        String data = "";
        String productId = request.getParameter("productId");
        Product product = (Product)baseManager.getObject(Product.class.getTypeName(),productId);
        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
        Map<String,MultipartFile> fileMap = multipartRequest.getFileMap();
        // String ctxPath = request.getSession().getServletContext().getRealPath("/")+ File.separator+"uploadFiles";
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
        String identify = sdf.format(new Date());
        String url = "" ;
        for (Map.Entry<String,MultipartFile> entry : fileMap.entrySet()){
            ProductPicture productPicture = new ProductPicture();
            //上传文件
            MultipartFile mf = entry.getValue();
            String fileName = mf.getOriginalFilename();//获取原文件名
            url = "product/"+fileName.substring(0,fileName.indexOf(".jpg"))+identify+".jpg";
            try {
                aliOssUploadManager.uploadFile(mf, "tenant", url);
                productPicture.setPictureUrl(url);
                productPicture.setStatus(request.getParameter("status"));
                productPicture.setProduct(product);
                baseManager.saveOrUpdate(ProductPicture.class.getTypeName(),productPicture);
                data = productPicture.getId()+":"+url;
            }catch (Exception e){
                 e.printStackTrace();
            }

        }
        System.out.print(url);
        return data;


    }

    @RequestMapping("/getImg.do")
    @ResponseBody
    public String getImg(HttpServletRequest request ,HttpServletResponse response) throws Exception{

        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
        Map<String,MultipartFile> fileMap = multipartRequest.getFileMap();
        // String ctxPath = request.getSession().getServletContext().getRealPath("/")+ File.separator+"uploadFiles";
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
        String identify = sdf.format(new Date());
        String url ;
        for (Map.Entry<String,MultipartFile> entry : fileMap.entrySet()){
            //上传文件
            MultipartFile mf = entry.getValue();
            String fileName = mf.getOriginalFilename();//获取原文件名
            url = "product/"+fileName.substring(0,fileName.indexOf(".jpg"))+identify+".jpg";
            aliOssUploadManager.uploadFile(mf, "tenant", url);
        }
        return "";

    }



}
