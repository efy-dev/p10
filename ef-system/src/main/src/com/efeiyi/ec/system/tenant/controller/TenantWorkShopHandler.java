package com.efeiyi.ec.system.tenant.controller;

import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.Do;
import com.ming800.core.does.model.XSaveOrUpdate;
import com.ming800.core.does.service.MultipartHandler;
import com.ming800.core.p.service.AliOssUploadManager;
import com.ming800.core.util.ApplicationContextUtil;
import org.springframework.ui.ModelMap;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;

/**
 * Created by Administrator on 2015/7/22.
 */
public class TenantWorkShopHandler implements MultipartHandler {

    private AliOssUploadManager aliOssUploadManager = (AliOssUploadManager) ApplicationContextUtil.getApplicationContext().getBean("aliOssUploadManagerImpl");
    private BaseManager baseManager = (BaseManager) ApplicationContextUtil.getApplicationContext().getBean("baseManagerImpl");


    @Override
    public ModelMap handleMultipart(Do tempDo, ModelMap modelMap, HttpServletRequest request, MultipartRequest multipartRequest) throws Exception {

        String tenantId = request.getParameter("tenant.id");

        MultipartFile multipartFile = multipartRequest.getFile("picture_url");
        String url = "work/"+tenantId+"/" + multipartFile.getOriginalFilename();
        aliOssUploadManager.uploadFile(multipartFile, "tenant", url);

        MultipartFile multipartFile1 = multipartRequest.getFile("videoPath");
        String url1 = "work/"+tenantId+"/" + multipartFile1.getOriginalFilename();
        aliOssUploadManager.uploadFile(multipartFile1, "tenant", url1);

        XSaveOrUpdate xSaveOrUpdate = new XSaveOrUpdate(tempDo.getName(), request);
        HashMap<String, Object> paramMap = xSaveOrUpdate.getParamMap();
        paramMap.put("picture_url", url);
        paramMap.put("videoPath", url1);
        Object object = baseManager.saveOrUpdate(xSaveOrUpdate);

        modelMap.put("object",object);

        return modelMap;
    }
}
