package com.efeiyi.ec.system.product.controller;



import com.efeiyi.ec.master.model.MasterProject;
import com.efeiyi.ec.product.model.Product;
import com.efeiyi.ec.product.model.ProductDescription;
import com.efeiyi.ec.product.model.ProductModel;
import com.efeiyi.ec.product.model.ProductPicture;
import com.efeiyi.ec.system.organization.util.AuthorizationUtil;
import com.efeiyi.ec.system.product.model.ProductModelBean;
import com.efeiyi.ec.system.product.service.ProductManager;
import com.ming800.core.base.controller.BaseController;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.p.service.AliOssUploadManager;
import com.ming800.core.p.service.AutoSerialManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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



    @Autowired
    private ProductManager productManager;


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
        String productModelId = request.getParameter("productModelId");
        Product product = null;
        ProductModel productModel = null;
        if(productId==null&&productModelId!=null){
            productModel = (ProductModel) baseManager.getObject(ProductModel.class.getTypeName(), productModelId);
        }else if(productModelId==null&&productId!=null){
            product = (Product) baseManager.getObject(Product.class.getTypeName(), productId);
        }
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
                if(product!=null) {
                    productPicture.setPictureUrl(url);
                    productPicture.setStatus("1");
                    productPicture.setProduct(product);
                    baseManager.saveOrUpdate(ProductPicture.class.getTypeName(), productPicture);
                    data = productPicture.getId()+":"+url;
                }else  if(productModel!=null){
                    productModel.setProductModel_url(url);
                    baseManager.saveOrUpdate(ProductModel.class.getName(),productModel);
                    data = productModel.getId()+":"+url;
                }

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

    /**获取项目 masterId*/
    @RequestMapping("/getProjectList.do")
    @ResponseBody
    public List<MasterProject> getProjectByMasterId(String masterId,HttpServletRequest request) {

        List<MasterProject> list = null;
        try {
            XQuery xQuery = new XQuery("listMasterProject_default",request);
            xQuery.put("master_id",masterId);
          list = baseManager.listObject(xQuery);
        }catch (Exception e){
            e.printStackTrace();
        }

        return list;
    }

    @RequestMapping("/Master.do")
    public String Master(Product product,ProductDescription productDescription,
                                 ProductPicture productPicture,ProductModelBean productModelBean,
                                 HttpServletRequest request,
                                 String resultPage,Model model,String step)  {

      if("product".equals(step)){

          model.addAttribute("object",productManager.saveProduct(product));

      }else if("description".equals(step)){

          model.addAttribute("object",productManager.saveProductDescription(productDescription));

      }else  if("model".equals(step)){
          try {
              model.addAttribute("object",productManager.saveProductModel(productModelBean));
          }catch (Exception e){
                e.printStackTrace();
          }
      }else if("picture".equals(step)){
               Product productTemp = (Product)baseManager.getObject(Product.class.getName(),request.getParameter("productId"));
               model.addAttribute("object",productTemp);
      }

        return resultPage;
    }

    @RequestMapping("/deletePicture.do")
    @ResponseBody
    public String deletePicture(String id){
         try {
            baseManager.delete(ProductPicture.class.getName(),id);
         }catch (Exception e){
              e.printStackTrace();
         }
        return  id;
    }

    @RequestMapping("/updatePicture.do")
    @ResponseBody
    public String updateModelPicture(String id,String status){
        try {
            ProductPicture productPicture = (ProductPicture)baseManager.getObject(ProductPicture.class.getName(),id);
            productPicture.setStatus(status);
            baseManager.saveOrUpdate(ProductPicture.class.getName(),productPicture);
        }catch (Exception e){
            e.printStackTrace();
        }
        return  id;
    }

    @RequestMapping("/removeProduct.do")
    @ResponseBody
    public String removeProduct(String id){

        try {

        }catch (Exception e){

        }
        return  "";
    }

}
