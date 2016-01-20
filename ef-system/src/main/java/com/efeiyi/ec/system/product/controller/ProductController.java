package com.efeiyi.ec.system.product.controller;


import com.efeiyi.ec.master.model.MasterProject;
import com.efeiyi.ec.product.model.*;
import com.efeiyi.ec.project.model.ProjectCategory;
import com.efeiyi.ec.project.model.ProjectCategoryProductModel;
import com.efeiyi.ec.system.product.model.ProductModelBean;
import com.efeiyi.ec.system.product.service.ProductManager;
import com.efeiyi.ec.system.product.service.ProductModelManager;
import com.efeiyi.ec.tenant.model.BigTenant;
import com.efeiyi.ec.tenant.model.Tenant;
import com.efeiyi.ec.tenant.model.TenantMaster;
import com.ming800.core.base.controller.BaseController;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.p.service.AliOssUploadManager;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
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
import java.io.*;
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
    private ProductModelManager productModelManager;

    @Autowired
    private AliOssUploadManager aliOssUploadManager;

    @Autowired
    private ProductManager productManager;


    @RequestMapping("/listProduct.do")
    public ModelAndView getProductList(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {

        List<Product> list = baseManager.listObject("from Product");
        for (Iterator<Product> i = list.iterator(); i.hasNext(); ) {
            Product product = i.next();
            System.out.println(product.getName());

        }
        modelMap.put("listProduct", list);
        return new ModelAndView("/pc/product/productList", modelMap);
    }


    @RequestMapping({"/test/nav/{item}"})
    public String testNav(HttpServletRequest request, @PathVariable String item) {
        String match = request.getServletPath();
//        System.out.println(match);
        request.setAttribute("match", match);
        return "/test/navTest";
    }


    @RequestMapping({"/test/upload/file.do"})
    public boolean uploadFile(MultipartFile multipartFile, MultipartRequest request) throws Exception {
        return aliOssUploadManager.uploadFile(request.getFile("test"), "ef-video", "testfile");
    }

    @RequestMapping("/recommendedProductModel.do")
    public String recommendedProduct(HttpServletRequest request) {
        String id = request.getParameter("id");

        String categoryId = request.getParameter("categoryId");

        ProductModel productModel = (ProductModel) baseManager.getObject(ProductModel.class.getName(), id);
        int maxValue = productModelManager.getMaxRecommendedIndex(categoryId);

        productModel.setRecommendIndex(maxValue + 1);

        baseManager.saveOrUpdate(ProductModel.class.getName(), productModel);

        return "redirect:/basic/xm.do?qm=plistProductModel_index";


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


    @RequestMapping({"/changeImg.do"})
    public String uploadMasterNewsPicture(MultipartRequest multipartRequest,String trueUrl,String changeImgUrl, HttpServletRequest request) throws Exception {

        MultipartFile multipartFile = multipartRequest.getFile("changeFile");

        boolean result = aliOssUploadManager.uploadFile(multipartFile, "ec-efeiyi", trueUrl);


        return changeImgUrl;

    }

    @RequestMapping("/subjectUploadify.do")
    @ResponseBody
    public String subjectUploadifyImg(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String data = "";

        String subjectId = request.getParameter("subjectId");
        Subject subject = null;
        if(!"".equals(subjectId)){
                subject = (Subject) baseManager.getObject(Subject.class.getTypeName(), subjectId);
        }
        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
        Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();
        // String ctxPath = request.getSession().getServletContext().getRealPath("/")+ File.separator+"uploadFiles";
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
        String identify = sdf.format(new Date());
        String url = "";
        for (Map.Entry<String, MultipartFile> entry : fileMap.entrySet()) {
            SubjectPicture subjectPicture = new SubjectPicture();
            //上传文件
            MultipartFile mf = entry.getValue();
            String fileName = mf.getOriginalFilename();//获取原文件名

                url = "subject/" + fileName;



            try {
                aliOssUploadManager.uploadFile(mf, "ec-efeiyi", url);
//                if(subject != null && "2".equals(request.getParameter("status"))) {
//                    subjectPicture.setPictureUrl(url);
//                    subjectPicture.setSubject(subject);
//                    baseManager.saveOrUpdate(SubjectPicture.class.getTypeName(), subjectPicture);
//
//                    data = subjectPicture.getId() + ":" + url;
//                 }else {
//                    data = url;
//                }
            } catch (Exception e) {
                e.printStackTrace();
            }

        }
        System.out.print(url);
        return url;


    }

    @RequestMapping("/getImg.do")
    @ResponseBody
    public String getImg(HttpServletRequest request, HttpServletResponse response) throws Exception {

        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
        Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();
        // String ctxPath = request.getSession().getServletContext().getRealPath("/")+ File.separator+"uploadFiles";
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
        String identify = sdf.format(new Date());
        String url;
        for (Map.Entry<String, MultipartFile> entry : fileMap.entrySet()) {
            //上传文件
            MultipartFile mf = entry.getValue();
            String fileName = mf.getOriginalFilename();//获取原文件名
            url = "product/" + fileName.substring(0, fileName.indexOf(".jpg")) + identify + ".jpg";
            aliOssUploadManager.uploadFile(mf, "tenant", url);
        }
        return "";

    }

    /**
     * 获取项目 masterId
     */
    @RequestMapping("/getProjectList.do")
    @ResponseBody
    public List<MasterProject> getProjectByMasterId(String masterId, HttpServletRequest request) {

        List<MasterProject> list = null;
        try {
            XQuery xQuery = new XQuery("listMasterProject_default", request);
            xQuery.put("master_id", masterId);
            list = baseManager.listObject(xQuery);
        } catch (Exception e) {
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

        model.addAttribute("view",request.getParameter("view"));


        if ("product".equals(step)) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
            String identify = sdf.format(new Date());
            String url = "";
            try {

//            try {
//                Product product1 =        productManager.saveProduct(product);
//                System.out.print(product1.getMaster().getName());
//            }catch (Exception e){
//
//            }
                if(multipartRequest.getFile("picture_url1")!=null&&!"".equals(multipartRequest.getFile("picture_url1"))) {
                    if (!multipartRequest.getFile("picture_url1").getOriginalFilename().equals("")) {
                        url = "product/" + identify + multipartRequest.getFile("picture_url1").getOriginalFilename();
                        product.setPicture_url(url);
                        aliOssUploadManager.uploadFile(multipartRequest.getFile("picture_url1"), "ec-efeiyi", url);
                    }
                }
                Product temProduct = productManager.saveProduct(product);
                //  &tenantId=${tenantId}&masterId=${masterId}&id=
                String tenantId = "0";
                String masterId = "0";
                if (temProduct.getTenant() != null) {
                    tenantId = temProduct.getTenant().getId();
                }
                if (temProduct.getMaster() != null) {
                    masterId = temProduct.getMaster().getId();
                }

                resultPage = resultPage + "&tenantId="+tenantId+"&masterId="+masterId+"&id="+temProduct.getId();

            }catch (Exception e){
                e.printStackTrace();
            }

            //  model.addAttribute("object",productManager.saveProduct(product));



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

    @RequestMapping("/saveSubject.do")
    public String saveNewProduct(Subject subject, String[] flag,String[] spId,String[] subjectPicture,
                                 HttpServletRequest request,
                                 String resultPage) {

                try {
                   productManager.saveSubject(subject,flag,spId,subjectPicture);

                }catch (Exception e){
                   e.printStackTrace();
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

    @RequestMapping("/removeProduct.do")
    @ResponseBody
    public String removeProduct(String id,HttpServletRequest request) {
        try {
            baseManager.remove(Product.class.getName(), id);
            XQuery xQuery = new XQuery("listProductModel_default5",request);
            xQuery.put("product_id",id);
            for(ProductModel productModel : (List<ProductModel>)baseManager.listObject(xQuery)){
                baseManager.remove(ProductModel.class.getName(),productModel.getId());
            }
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

    @RequestMapping("/linkTenant.do")
    @ResponseBody
    public String linkTenant(String tenantId, String productId) {
        try {
            Product product = (Product) baseManager.getObject(Product.class.getName(), productId);
            product.setBigTenant((BigTenant) baseManager.getObject(BigTenant.class.getName(), tenantId));
            baseManager.saveOrUpdate(Product.class.getName(), product);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return tenantId;
    }

    @RequestMapping("/changeTenant.do")
    @ResponseBody
    public Map changeTenant(String tenantId, HttpServletRequest request) {
        Map<String, List> map = new HashMap<>();
        List masterList = null;
        List projectList = null;
        try {
            XQuery xQuery = new XQuery("listTenantMaster_default", request);
            xQuery.put("tenant_id", tenantId);
            masterList = baseManager.listObject(xQuery);
            map.put("masterList", masterList);
            xQuery = new XQuery("listTenantProject_default", request);
            xQuery.put("tenant_id", tenantId);
            projectList = baseManager.listObject(xQuery);
            map.put("projectList", projectList);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return map;
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

    @RequestMapping("/setModelPicture.do")
    @ResponseBody
    public String setModelPicture(String modelId, String pictureId,String oldModelId, HttpServletRequest request) {

        ProductPicture productPicture = null;
        try {
//            productPicture = (ProductPicture) baseManager.getObject(ProductPicture.class.getName(), pictureId);
//            if ("0".equals(modelId)) {
////                productPicture.setProductModel(null);
//            } else {
//                ProductModel productModel = (ProductModel) baseManager.getObject(ProductModel.class.getName(), modelId);
//    //            productModel.setProductModel_url(productPicture.getPictureUrl());
//    //            baseManager.saveOrUpdate(ProductModel.class.getName(),productModel);
//                productPicture.setProductModel(productModel);
//            }
//            baseManager.saveOrUpdate(ProductPicture.class.getName(), productPicture);
            productPicture = productManager.setModelPicture(modelId,pictureId,oldModelId);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return modelId;
    }


    @RequestMapping("/linkSubject.do")
    @ResponseBody
    public String linkSubject(String subjectId, String productModelId,String subjectProductModelId,String status, HttpServletRequest request) {

        try {
            if("0".equals(status)){
                SubjectProductModel subjectProductModel = (SubjectProductModel)baseManager.getObject(SubjectProductModel.class.getName(),subjectProductModelId);
                subjectProductModel.setStatus(status);
                baseManager.saveOrUpdate(SubjectProductModel.class.getName(),subjectProductModel);

            }else {
                SubjectProductModel subjectProductModel = null;
                if("0".equals(subjectProductModelId)){
                    subjectProductModel = new SubjectProductModel();
                }else {
                    subjectProductModel = (SubjectProductModel)baseManager.getObject(SubjectProductModel.class.getName(),subjectProductModelId);
                }
                subjectProductModel.setStatus(status);
                subjectProductModel.setSubject((Subject)baseManager.getObject(Subject.class.getName(),subjectId));
                subjectProductModel.setProductModel((ProductModel) baseManager.getObject(ProductModel.class.getName(), productModelId));
                baseManager.saveOrUpdate(SubjectProductModel.class.getName(), subjectProductModel);
                subjectProductModelId = subjectProductModel.getId();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return subjectProductModelId;
    }

    @RequestMapping("/updateSubjectIndex.do")
    @ResponseBody
    public String updateSubjectIndex(String subjectId, HttpServletRequest request) {

        try {
           Subject subject = (Subject)baseManager.getObject(Subject.class.getName(),subjectId);
            subject.setSubjectIndex(subject.getSubjectIndex() + 1);
            baseManager.saveOrUpdate(Subject.class.getName(),subject);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return subjectId;
    }

    @RequestMapping("/linkProjectCategory.do")
    @ResponseBody
    public String linkProjectCategory(String projectCategoryId, String productModelId,String projectCategoryProductModelId,String status, HttpServletRequest request) {

        try {
            if("0".equals(status)){
                ProjectCategoryProductModel projectCategoryProductModel = (ProjectCategoryProductModel)baseManager.getObject(ProjectCategoryProductModel.class.getName(),projectCategoryProductModelId);
                projectCategoryProductModel.setStatus(status);
                projectCategoryProductModel.setSort(0);
                baseManager.saveOrUpdate(ProjectCategoryProductModel.class.getName(),projectCategoryProductModel);

            }else {
                ProjectCategoryProductModel projectCategoryProductModel = null;
                if("0".equals(projectCategoryProductModelId)){
                    projectCategoryProductModel = new ProjectCategoryProductModel();
                }else {
                    projectCategoryProductModel = (ProjectCategoryProductModel)baseManager.getObject(ProjectCategoryProductModel.class.getName(),projectCategoryProductModelId);
                }
                projectCategoryProductModel.setSort(0);
                projectCategoryProductModel.setStatus(status);
                projectCategoryProductModel.setProjectCategory((ProjectCategory) baseManager.getObject(ProjectCategory.class.getName(), projectCategoryId));
                projectCategoryProductModel.setProductModel((ProductModel) baseManager.getObject(ProductModel.class.getName(), productModelId));
                baseManager.saveOrUpdate(ProjectCategoryProductModel.class.getName(), projectCategoryProductModel);
                projectCategoryProductModelId = projectCategoryProductModel.getId();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return projectCategoryProductModelId;
    }

    @RequestMapping("/updateProductModelSort.do")
    @ResponseBody
    public String updateProductModelSort(String id, String sort, HttpServletRequest request) {

        try {
            ProjectCategoryProductModel projectCategoryProductModel
                     = (ProjectCategoryProductModel)baseManager.getObject(ProjectCategoryProductModel.class.getName(),id);
            if("".equals(sort)||sort==null){
                projectCategoryProductModel.setSort(0);
            }else {
                projectCategoryProductModel.setSort(Integer.parseInt(sort));
            }
          baseManager.saveOrUpdate(ProjectCategoryProductModel.class.getName(),projectCategoryProductModel);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return id;
    }


    @RequestMapping("/setProductStatus.do")
    @ResponseBody
    public String setProductStatus(String id, String status, HttpServletRequest request) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
         String data = id;
        try {
          Product product =  productManager.setProductStatus(status, id);
            if(status.equals("1"))
            data = sdf.format(product.getShowDateTime());

        } catch (Exception e) {
            e.printStackTrace();
        }
        return data;
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

    @RequestMapping("/outExcel.do")
    @ResponseBody
    public String outExcel2(HttpServletRequest request,String home,String on ,String down,HttpServletResponse response) {
        String [] homes = home.split(",");
        try {

            String fileName = productManager.outExcel1(homes,on,down);
            File file = new File(fileName);
            InputStream fis = new BufferedInputStream(new FileInputStream(fileName));
            byte[] buffer = new byte[fis.available()];
            fis.read(buffer);
            fis.close();
            // 清空response
            response.reset();
            response.addHeader("Content-Disposition", "attachment;filename="
                    + new String(file.getName().getBytes()));
            response.addHeader("Content-Length", "" + file.length());
            OutputStream toClient = new BufferedOutputStream(
                    response.getOutputStream());
            response.setContentType("application/vnd.ms-excel;charset=gb2312");
            toClient.write(buffer);
            toClient.flush();
            toClient.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @RequestMapping("/createXML.do")
    @ResponseBody
    public void createXML(HttpServletRequest request){
        String path = request.getServletContext().getRealPath("/productxml");
        productManager.createXMLByAddedProduct(path);
    }


    @RequestMapping("/updateShow.do")
    @ResponseBody
    public String updateShow(String subjectId,String show, HttpServletRequest request) {

        try {
            Subject subject = (Subject)baseManager.getObject(Subject.class.getName(),subjectId);
            subject.setSubjectShow(show);
            baseManager.saveOrUpdate(Subject.class.getName(),subject);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return subjectId;
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
            XQuery xQuery = new XQuery("listProduct_default2",request);
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


    @RequestMapping("/initProductViewSort.do")
    @ResponseBody
    public String initProductViewSort(HttpServletRequest request){
        String f = "1";
        try {
            XQuery xQuery = new XQuery("listProduct_default2",request);
            List<Product> productList = baseManager.listObject(xQuery);
            for(Product product : productList){
                if(product.getProductPictureList()!=null){
                    int i=1;
                    for(ProductPicture productPicture : product.getProductPictureList()){
                        if("3".equals(productPicture.getStatus())&&productPicture.getSort()==null){
                            productPicture.setSort(i++);
                            baseManager.saveOrUpdate(ProductPicture.class.getName(),productPicture);

                        }
                        if("9".equals(productPicture.getStatus())&&productPicture.getSort()==null){
                            productPicture.setSort(i++);
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
