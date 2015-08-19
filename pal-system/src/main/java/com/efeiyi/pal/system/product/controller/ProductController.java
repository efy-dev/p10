package com.efeiyi.pal.system.product.controller;

import com.efeiyi.pal.organization.model.Tenant;
import com.efeiyi.pal.organization.model.TenantCertification;
import com.efeiyi.pal.organization.model.TenantSource;
import com.efeiyi.pal.product.model.Product;
import com.efeiyi.pal.product.model.ProductPropertyValue;
import com.efeiyi.pal.product.model.ProductSeries;
import com.ming800.core.base.dao.XdoDao;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.base.service.XdoManager;
import com.ming800.core.p.service.AliOssUploadManager;
import com.ming800.core.util.ApplicationContextUtil;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartRequest;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by Administrator on 2015/8/4.
 */

@Controller
@RequestMapping("/product")
public class ProductController {

    private BaseManager baseManager = (BaseManager) ApplicationContextUtil.getApplicationContext().getBean("baseManagerImpl");
    private XdoManager xdoManager = (XdoManager) ApplicationContextUtil.getApplicationContext().getBean("xdoManagerImpl");
    private XdoDao xdoDao = (XdoDao) ApplicationContextUtil.getApplicationContext().getBean("xdoDaoSupport");
    private AliOssUploadManager aliOssUploadManager = (AliOssUploadManager) ApplicationContextUtil.getApplicationContext().getBean("aliOssUploadManagerImpl");

    @RequestMapping("/saveProductAndNext.do")
    public ModelAndView saveProductSeries(ModelMap modelMap, HttpServletRequest request, MultipartRequest multipartRequest) throws Exception {
        Product product = new Product();

        String productId = request.getParameter("id");
        String type = "new";
        if (productId != null && !productId.equals("")) {
            type = "edit";
            product = (Product) baseManager.getObject(Product.class.getName(), productId);
        }
//        Do tempDo = (Do) modelMap.get("tempDo");
//        productSeries = (ProductSeries) XDoUtil.processSaveOrUpdateTempObject(tempDo, productSeries, productSeries.getClass(), request, type, xdoDao);

        product = setProductBaseProperty(product, request);

        product = getRelationAttributeObject(product, request, type);
        product = upLoadLogo(multipartRequest, product);

        baseManager.saveOrUpdate(product.getClass().getName(), product);

//        productSeries = (ProductSeries) baseManager.getObject(ProductSeries.class.getName(), productSeries.getId());

        modelMap.put("product", product);
        modelMap.put("PPVList", product.getProductPropertyValueList());
        modelMap.put("PSPNList", product.getProductSeries().getProductSeriesPropertyNameList());
        modelMap.put("PSPNListSize", product.getProductSeries().getProductSeriesPropertyNameList().size());
//        String resultPage = "redirect:/basic/xm.do?qm=formProductSeriesPropertyName&conditions=productSeries.id:" + productSeries.getId();

        String resultPage = "/productPropertyValue/productPropertyValueListForm";

        return new ModelAndView(resultPage);
    }

    /**
     * 获取关联属性的对象
     * @param product
     * @param request
     * @param type
     * @return
     */
    private Product getRelationAttributeObject(Product product, HttpServletRequest request, String type){
        String productSeriesId = request.getParameter("productSeries.id");
        ProductSeries newProductSeries = (ProductSeries) baseManager.getObject(ProductSeries.class.getName(), productSeriesId);
        String tenantId = request.getParameter("tenant.id");
        Tenant tenant = (Tenant) baseManager.getObject(Tenant.class.getName(), tenantId);

//        String tenantSourceId = request.getParameter("tenantSource.id");
//        String tenantCertificationId = request.getParameter("tenantCertification.id");
//        TenantSource tenantSource = (TenantSource) baseManager.getObject(TenantSource.class.getName(), tenantSourceId);
//        TenantCertification tenantCertification = (TenantCertification) baseManager.getObject(TenantCertification.class.getName(), tenantCertificationId);

        if (type.equals("new")){
            List<ProductPropertyValue> productPropertyValueList = new ArrayList();
            product.setProductPropertyValueList(productPropertyValueList);
        }
        if (type.equals("edit")){
            ProductSeries oldProductSeries = product.getProductSeries();
            if (!oldProductSeries.equals(newProductSeries)){
                deleteRelatedAttributes(product);
            }
        }

        product.setProductSeries(newProductSeries);
        product.setTenant(tenant);
//        product.setTenantSource(tenantSource);
//        product.setTenantCertification(tenantCertification);

        return product;
    }

    /**
     * 获取Form表单基本数据
     * @param product
     * @param request
     * @return
     */
    private Product setProductBaseProperty(Product product, HttpServletRequest request) throws ParseException {
        String name = request.getParameter("name");
        String masterName = request.getParameter("masterName");
        String serial = request.getParameter("serial");
        String status = request.getParameter("status");
        String shoppingUrl = request.getParameter("shoppingUrl");

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd" );
        Date date = sdf.parse(request.getParameter("madeYear"));

        product.setName(name);
        product.setMasterName(masterName);
        product.setSerial(serial);
        product.setStatus(status);
        product.setShoppingUrl(shoppingUrl);
        product.setMadeYear(date);

        return product;
    }

    /**
     * 商品系列更改后，删除系列对应属性的商品对应值
     * @param product
     * @return
     */
    private Product deleteRelatedAttributes(Product product){
        List<ProductPropertyValue> PPVList = product.getProductPropertyValueList();
        for (ProductPropertyValue ppv: PPVList){
            baseManager.delete(ppv.getClass().getName(), ppv.getId());
        }
        product.setProductPropertyValueList(new ArrayList<ProductPropertyValue>());
        return product;
    }

    /**
     * 上传商品logo
     * @param multipartRequest
     * @param product
     * @return
     * @throws Exception
     */
    private Product upLoadLogo(MultipartRequest multipartRequest, Product product) throws Exception{
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
        String identify = sdf.format(new Date());
        String url = "product/" + identify + ".jpg";

        if (!multipartRequest.getFile("logo").getOriginalFilename().equals("")) {
//            aliOssUploadManager.uploadFile(multipartRequest.getFile("logo"), "315pal", "product/logo/" + multipartRequest.getFile("logo").getOriginalFilename());
//            product.setImgUrl("product/logo/" + multipartRequest.getFile("logo").getOriginalFilename());
            aliOssUploadManager.uploadFile(multipartRequest.getFile("logo"), "315pal", url);
            product.setImgUrl(url);
        }

        return product;
    }

}
