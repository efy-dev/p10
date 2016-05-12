package com.efeiyi.ec.personal.master.controller;

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
public class MasterWorkShopHandler implements MultipartHandler {

    private AliOssUploadManager aliOssUploadManager = (AliOssUploadManager) ApplicationContextUtil.getApplicationContext().getBean("aliOssUploadManagerImpl");
    private BaseManager baseManager = (BaseManager) ApplicationContextUtil.getApplicationContext().getBean("baseManagerImpl");


    @Override
    public ModelMap handleMultipart(Do tempDo, ModelMap modelMap, HttpServletRequest request, MultipartRequest multipartRequest) throws Exception {

        String masterId = request.getParameter("master.id");
        XSaveOrUpdate xSaveOrUpdate = new XSaveOrUpdate(tempDo.getName(), request);
        HashMap<String, Object> paramMap = xSaveOrUpdate.getParamMap();

        MultipartFile multipartFile = multipartRequest.getFile("picture_url1");
        if (!multipartFile.getOriginalFilename().equals("")) {
            String url = "work/" + masterId + "/" + multipartFile.getOriginalFilename();
            aliOssUploadManager.uploadFile(multipartFile, "tenant", url);
            paramMap.put("picture_url", url);
        }


        MultipartFile multipartFile1 = multipartRequest.getFile("videoPath1");
        if (!multipartFile1.getOriginalFilename().equals("")) {
            String url1 = "work/" + masterId + "/" + multipartFile1.getOriginalFilename();
            aliOssUploadManager.uploadFile(multipartFile1, "tenant", url1);
            paramMap.put("videoPath", url1);
        }

        Object object = baseManager.saveOrUpdate(xSaveOrUpdate);

        modelMap.put("object", object);

        return modelMap;
    }
}
