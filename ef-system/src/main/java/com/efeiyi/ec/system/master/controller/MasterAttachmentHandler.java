package com.efeiyi.ec.system.master.controller;

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
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;

/**
 * Created by Administrator on 2015/7/21.
 */
public class MasterAttachmentHandler implements MultipartHandler {

    private AliOssUploadManager aliOssUploadManager = (AliOssUploadManager) ApplicationContextUtil.getApplicationContext().getBean("aliOssUploadManagerImpl");
    private BaseManager baseManager = (BaseManager) ApplicationContextUtil.getApplicationContext().getBean("baseManagerImpl");


    @Override
    public ModelMap handleMultipart(Do tempDo, ModelMap modelMap, HttpServletRequest request, MultipartRequest multipartRequest) throws Exception {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
        String identify = sdf.format(new Date());
        String introductionId = request.getParameter("introductionId");
        String masterNewsId = request.getParameter("masterNewsId");
        MultipartFile multipartFile = multipartRequest.getFile("attachmentFile");
        String url = "attachment/" +identify + "/" + multipartFile.getOriginalFilename();

        aliOssUploadManager.uploadFile(multipartFile, "tenant", url);
        XSaveOrUpdate xSaveOrUpdate = new XSaveOrUpdate(tempDo.getName(), request);
        HashMap<String, Object> paramMap = xSaveOrUpdate.getParamMap();
        paramMap.put("url", url);
        MultipartFile multipartFile1 = multipartRequest.getFile("videoPath");
        String identify1 = sdf.format(new Date());
        if(multipartFile1!=null) {
            if (!multipartFile1.getOriginalFilename().equals("")) {
                url = "attachment/" + identify1 + "/" + multipartFile1.getOriginalFilename();
                aliOssUploadManager.uploadFile(multipartFile1, "tenant", url);
                paramMap.put("videoPath", url);
            }
        }

        paramMap.put("introduction.id", introductionId);
        paramMap.put("masterNews.id", masterNewsId);
        Object object = baseManager.saveOrUpdate(xSaveOrUpdate);
        modelMap.put("object", object);

        return modelMap;
    }
}
