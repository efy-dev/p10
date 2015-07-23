package com.efeiyi.ec.system.tenant.controller;

import com.efeiyi.ec.product.model.Product;
import com.efeiyi.ec.product.model.ProductDescription;
import com.efeiyi.ec.project.model.Project;
import com.efeiyi.ec.project.model.ProjectTag;
import com.efeiyi.ec.tenant.model.*;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.Do;
import com.ming800.core.does.model.XSaveOrUpdate;
import com.ming800.core.does.service.MultipartHandler;
import com.ming800.core.p.model.WordValue;
import com.ming800.core.p.service.AliOssUploadManager;
import com.ming800.core.util.ApplicationContextUtil;
import org.springframework.ui.ModelMap;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;

/**
 * Created by Administrator on 2015/7/21.
 */
public class TenantWorkFormHandler implements MultipartHandler {

    private AliOssUploadManager aliOssUploadManager = (AliOssUploadManager) ApplicationContextUtil.getApplicationContext().getBean("aliOssUploadManagerImpl");
    private BaseManager baseManager = (BaseManager) ApplicationContextUtil.getApplicationContext().getBean("baseManagerImpl");


    @Override
    public ModelMap handleMultipart(Do tempDo, ModelMap modelMap, HttpServletRequest request, MultipartRequest multipartRequest) throws Exception {
        String introductionId = request.getParameter("tenant.id");
        MultipartFile multipartFile = multipartRequest.getFile("picurl");
        String url = "work/"+introductionId+"/" + multipartFile.getOriginalFilename();
        aliOssUploadManager.uploadFile(multipartFile, "tenant", url);
        XSaveOrUpdate xSaveOrUpdate = new XSaveOrUpdate(tempDo.getName(), request);
        HashMap<String, Object> paramMap = xSaveOrUpdate.getParamMap();
        paramMap.put("picture_url", url);
        paramMap.put("tenant.id", introductionId);
        Object object = baseManager.saveOrUpdate(xSaveOrUpdate);

        //介绍
        String introductionContent = request.getParameter("productDescription");
        ProductDescription productDescription = new ProductDescription();
        productDescription.setContent(introductionContent);
        Product product = new Product();
        product.setId(((TenantWork)object).getId());
        productDescription.setProduct(product);

        baseManager.saveOrUpdate(ProductDescription.class.getName(),productDescription);

        ((TenantWork)object).setProductDescription(productDescription);

        baseManager.saveOrUpdate(TenantWork.class.getName(),object);



        List<String> tagValueList = new ArrayList<>();

        Enumeration<String> paramEnumeration = request.getParameterNames();

        while (paramEnumeration.hasMoreElements()) {
            String paramKey = paramEnumeration.nextElement();
            if (paramKey.startsWith("tag")) {
                String value = request.getParameter(paramKey);
                tagValueList.add(value);
            }
        }

        if (tagValueList.size() > 0) {
            for (String tagId : tagValueList) {
                ProjectTag projectTag= new ProjectTag();
                projectTag.setId(tagId);
                TenantWorkTag tenantWorkTag = new TenantWorkTag();
                tenantWorkTag.setProjectTag(projectTag);
                tenantWorkTag.setTenantWork((TenantWork)object);
                tenantWorkTag.setStatus("1");
                baseManager.saveOrUpdate(TenantWorkTag.class.getName(),tenantWorkTag);
            }

        }


        modelMap.put("object", object);
        return modelMap;
    }
}
