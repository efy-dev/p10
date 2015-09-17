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
 * Created by Administrator on 2015/7/22.
 */
public class MasterMessageAttachmentHandler implements MultipartHandler {

    private AliOssUploadManager aliOssUploadManager = (AliOssUploadManager) ApplicationContextUtil.getApplicationContext().getBean("aliOssUploadManagerImpl");
    private BaseManager baseManager = (BaseManager) ApplicationContextUtil.getApplicationContext().getBean("baseManagerImpl");


    @Override
    public ModelMap handleMultipart(Do tempDo, ModelMap modelMap, HttpServletRequest request, MultipartRequest multipartRequest) throws Exception {

        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
        String identify = sdf.format(new Date());
        String masterMessageId = request.getParameter("masterMessageId");
        String type = request.getParameter("type");
        XSaveOrUpdate xSaveOrUpdate = new XSaveOrUpdate(tempDo.getName(), request);
        HashMap<String, Object> paramMap = xSaveOrUpdate.getParamMap();
        if ("1".equals(type) || "3".equals(type) || "5".equals(type)){
            String fileName = request.getParameter("fileName");
            paramMap.put("fileName",fileName);
        }else if ("2".equals(type)){
            MultipartFile multipartFile = multipartRequest.getFile("pictureUrl");
            String fileName = multipartFile.getOriginalFilename();
            if (!multipartFile.getOriginalFilename().equals("")) {
                String url = "attachment/" + fileName.substring(0,fileName.indexOf(".jpg"))+identify+".jpg";
                aliOssUploadManager.uploadFile(multipartFile, "tenant", url);
                paramMap.put("pictureUrl", url);
            }
        }else if ("4".equals(type)){
            MultipartFile multipartFile1 = multipartRequest.getFile("videoPath");
            if (!multipartFile1.getOriginalFilename().equals("")) {
                String url = "attachment/" + masterMessageId + "/" + multipartFile1.getOriginalFilename();
                aliOssUploadManager.uploadFile(multipartFile1, "tenant", url);
                paramMap.put("videoPath", url);
            }
        }
        Object object = baseManager.saveOrUpdate(xSaveOrUpdate);
        modelMap.put("object", object);

        return modelMap;
    }
}
