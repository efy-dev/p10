package com.efeiyi.ec.system.product.controller;



import com.efeiyi.ec.master.model.MasterProject;
import com.efeiyi.ec.product.model.Product;
import com.efeiyi.ec.product.model.ProductDescription;
import com.efeiyi.ec.product.model.ProductModel;
import com.efeiyi.ec.product.model.ProductPicture;
import com.efeiyi.ec.system.organization.util.AuthorizationUtil;
import com.efeiyi.ec.system.product.model.ProductModelBean;
import com.efeiyi.ec.system.product.service.ProductManager;
import com.efeiyi.ec.system.product.service.ProductModelManager;
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
import org.springframework.web.multipart.MultipartRequest;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
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
    private ProductModelManager productModelManager;

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
    public String uploadProductImg(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String data = "";
        String productId = "";
        Product product = null;
        if(request.getParameter("trueUrl")==null||"".equals(request.getParameter("trueUrl"))) {
            productId = request.getParameter("productId");
            product = (Product) baseManager.getObject(Product.class.getTypeName(), productId);
        }
        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
        Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();
        // String ctxPath = request.getSession().getServletContext().getRealPath("/")+ File.separator+"uploadFiles";
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
        String identify = sdf.format(new Date());
        String url = "";
        Integer sort = 0;
        for (Map.Entry<String, MultipartFile> entry : fileMap.entrySet()) {
            ProductPicture productPicture = new ProductPicture();
            //上传文件
            MultipartFile mf = entry.getValue();
            String fileName = mf.getOriginalFilename();//获取原文件名
            Integer index = 0;
            String hz = fileName.substring(fileName.indexOf("."),fileName.length());
            String imgName = fileName.substring(0, fileName.indexOf(hz));
            url = "product/" + fileName.substring(0, fileName.indexOf(hz)) + identify + hz;
            if(request.getParameter("trueUrl")!=null&&!"".equals(request.getParameter("trueUrl"))){
                url = request.getParameter("trueUrl");
                aliOssUploadManager.uploadFile(mf, "ec-efeiyi", url);
            }else {
                try {
                    aliOssUploadManager.uploadFile(mf, "ec-efeiyi", url);
                    productPicture.setPictureUrl(url);
                    if(request.getParameter("status").equals("3")){
                        sort = productManager.productPictureSort(product.getId())+1;
                        productPicture.setSort(sort);
                    }
                    if(request.getParameter("status").equals("1")){
                        sort = productManager.productPictureSort1(product.getId())+1;
                        productPicture.setSort(sort);
                    }
                    productPicture.setStatus(request.getParameter("status"));
                    productPicture.setProduct(product);
                    baseManager.saveOrUpdate(ProductPicture.class.getTypeName(), productPicture);
                    data = productPicture.getId() + ":" + url + ":" + imgName+hz+":"+sort;
                } catch (Exception e) {
                    e.printStackTrace();
                }
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

    @RequestMapping("/saveNewProduct.do")
    public String saveNewProduct(Product product, ProductDescription productDescription,
                                 ProductPicture productPicture, ProductModelBean productModelBean,
                                 HttpServletRequest request,
                                 MultipartRequest multipartRequest,
                                 String resultPage, Model model, String step) {

        model.addAttribute("view", request.getParameter("view"));


        if ("product".equals(step)) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
            String identify = sdf.format(new Date());
            String url = "";
            if(multipartRequest.getFile("picture_url1")!=null&&!"".equals(multipartRequest.getFile("picture_url1"))) {
                if (!multipartRequest.getFile("picture_url1").getOriginalFilename().equals("")) {
                    url = "product/" + identify + multipartRequest.getFile("picture_url1").getOriginalFilename();
                    product.setPicture_url(url);
                    try {
                        aliOssUploadManager.uploadFile(multipartRequest.getFile("picture_url1"), "ec-efeiyi", url);
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
            }
            Product temProduct = productManager.saveProduct(product);
            String tenantId = "0";
            String masterId = "0";
            if (temProduct.getTenant() != null) {
                tenantId = temProduct.getTenant().getId();
            }
            if (temProduct.getMaster() != null) {
                masterId = temProduct.getMaster().getId();
            }
            resultPage = resultPage + "&tenantId="+tenantId+"&masterId="+masterId+"&id="+temProduct.getId();

        } else if ("description".equals(step)) {

            model.addAttribute("object", productManager.saveProductDescription(productDescription));

        } else if ("model".equals(step)) {
            try {
                model.addAttribute("object", productManager.saveProductModel(productModelBean));
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else if ("picture".equals(step)) {
            Product productTemp = (Product) baseManager.getObject(Product.class.getName(), request.getParameter("productId"));
            model.addAttribute("object", productTemp);
        }

        return resultPage;
    }

    @RequestMapping("/deletePicture.do")
    @ResponseBody
    public String deletePicture(String id) {
        try {
            baseManager.delete(ProductPicture.class.getName(), id);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return id;
    }
    @RequestMapping("/updatePicture.do")
    @ResponseBody
    public String updateModelPicture(String id, String status,String productId,String modelId,HttpServletRequest request) {

        ProductModel tempProductModel = null;
        String tempStatus = status;
        try {

            ProductPicture productPicture = (ProductPicture) baseManager.getObject(ProductPicture.class.getName(), id);
            if("0".equals(modelId)){
                XQuery productModelXQuery = new XQuery("listProductModel_default4",request);
                productModelXQuery.put("product_id",productId);
                tempProductModel = (ProductModel)baseManager.listObject(productModelXQuery).get(0);


            }else if(modelId!=null){
                tempProductModel = (ProductModel)baseManager.getObject(ProductModel.class.getName(),modelId);

            }else {
                modelId = "0";
            }
            if("1".equals(status)){

                tempProductModel.setProductModel_url(productPicture.getPictureUrl());
                baseManager.saveOrUpdate(ProductModel.class.getName(),tempProductModel);
                productPicture.setProductModel(tempProductModel);
                XQuery xQuery = new XQuery("listProductPicture_default2",request);
                xQuery.put("product_id",productId);
                xQuery.put("productModel_id",tempProductModel.getId());
                List<ProductPicture> pictures = baseManager.listObject(xQuery);
                if(pictures.size()!=0){
                    ProductPicture picture = pictures.get(0);
                    picture.setStatus("1");
                    baseManager.saveOrUpdate(ProductPicture.class.getName(),picture);
                }
                tempStatus = "2";
            }else if("2".equals(status)){
                tempProductModel.setProductModel_url(null);
                baseManager.saveOrUpdate(ProductModel.class.getName(),tempProductModel);
                productPicture.setProductModel(tempProductModel);
                tempStatus = "1";
            }


            productPicture.setStatus(tempStatus);

            baseManager.saveOrUpdate(ProductPicture.class.getName(), productPicture);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return modelId;
    }
    @RequestMapping("/setModelPicture.do")
    @ResponseBody
    public String setModelPicture(String modelId, String pictureId,String oldModelId, HttpServletRequest request) {

        ProductPicture productPicture = null;
        try {
//            productPicture = (ProductPicture) baseManager.getObject(ProductPicture.class.getName(), pictureId);
//            if ("0".equals(modelId)) {
//            } else {
//                ProductModel productModel = (ProductModel) baseManager.getObject(ProductModel.class.getName(), modelId);
//                productPicture.setProductModel(productModel);
//            }
//            baseManager.saveOrUpdate(ProductPicture.class.getName(), productPicture);
            productPicture = productManager.setModelPicture(modelId,pictureId,oldModelId);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return modelId;
    }


    @RequestMapping("/removeProduct.do")
    @ResponseBody
    public String removeProduct(String id){

        try {

        }catch (Exception e){

        }
        return  "";
    }

    @RequestMapping("/updateAmount.do")
    @ResponseBody
    public String updateAmount(String id, Integer amount,String creator, HttpServletRequest request) {
        String tempAmount = null;
        try {
            tempAmount = productModelManager.updateAmount(id,amount,creator).toString();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return tempAmount;
    }

    @RequestMapping("/changeMaster.do")
    @ResponseBody
    public List changeMaster(String masterId, HttpServletRequest request) {
        List list = null;
        try {
            XQuery xQuery = new XQuery("listMasterProject_default", request);
            xQuery.put("master_id", masterId);
            list = baseManager.listObject(xQuery);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }


    @RequestMapping("/setProductStatus.do")
    @ResponseBody
    public String setProductStatus(String id, String status, HttpServletRequest request) {

        try {
            productManager.setProductStatus(status,id);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return id;
    }

    @RequestMapping("/changePictureSort.do")
    @ResponseBody
    public String changePictureSort(String sourceId,String sourceSort,String targetId,String targetSort ) throws Exception {
        productManager.changePictureSort(sourceId,sourceSort,targetId,targetSort);
        return "";

    }

    @RequestMapping("/updatePictureSort.do")
    @ResponseBody
    public String updatePictureSort(String id,String sort) throws Exception {
        ProductPicture productPicture = (ProductPicture)baseManager.getObject(ProductPicture.class.getName(),id);
        productPicture.setSort(Integer.parseInt(sort));
        baseManager.saveOrUpdate(ProductPicture.class.getName(),productPicture);
        return sort;

    }



    @RequestMapping("/initSort.do")
    @ResponseBody
    public String initSort(HttpServletRequest request){
        String f = "1";
        try {
            XQuery xQuery = new XQuery("listProduct_default1",request);
            List<Product> productList = baseManager.listObject(xQuery);
            for(Product product : productList){
                if(product.getProductPictureList()!=null){
                    int i=1;
                    for(ProductPicture productPicture : product.getProductPictureList()){
                        if("1".equals(productPicture.getStatus())){
                            productPicture.setSort(i++);
                            baseManager.saveOrUpdate(ProductPicture.class.getName(),productPicture);

                        }
                        if("2".equals(productPicture.getStatus())){
                            productPicture.setSort(0);
                            baseManager.saveOrUpdate(ProductPicture.class.getName(),productPicture);
                        }

                    }
                }
            }
        } catch (Exception e) {
            f = "0";
            e.printStackTrace();
        }
        return f;
    }
}
