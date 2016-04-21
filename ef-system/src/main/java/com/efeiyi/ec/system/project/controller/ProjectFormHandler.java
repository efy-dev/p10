package com.efeiyi.ec.system.project.controller;

import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.Do;
import com.ming800.core.does.model.XSaveOrUpdate;
import com.ming800.core.does.service.MultipartHandler;
import com.ming800.core.p.service.AliOssUploadManager;
import com.ming800.core.util.ApplicationContextUtil;
import org.springframework.ui.ModelMap;
import org.springframework.web.multipart.MultipartRequest;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;

/**
 * Created by Administrator on 2015/7/16.
 */
public class ProjectFormHandler implements MultipartHandler {

    private AliOssUploadManager aliOssUploadManager = (AliOssUploadManager) ApplicationContextUtil.getApplicationContext().getBean("aliOssUploadManagerImpl");
    private BaseManager baseManager = (BaseManager) ApplicationContextUtil.getApplicationContext().getBean("baseManagerImpl");

    @Override
    public ModelMap handleMultipart(Do tempDo, ModelMap modelMap, HttpServletRequest request, MultipartRequest multipartRequest) throws Exception {

        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
        String identify = sdf.format(new Date());
        String url = "photo/" + identify + ".jpg";
        XSaveOrUpdate xSaveOrUpdate = new XSaveOrUpdate(tempDo.getName(), request);
        HashMap<String, Object> paramMap = xSaveOrUpdate.getParamMap();

        if (!multipartRequest.getFile("picture_url").getOriginalFilename().equals("")) {
            aliOssUploadManager.uploadFile(multipartRequest.getFile("picture_url"), "ef-wiki", "project_picture/" + multipartRequest.getFile("picture_url").getOriginalFilename());
            paramMap.put("picture_url", "project_picture/" + multipartRequest.getFile("picture_url").getOriginalFilename());
        }
        if (!multipartRequest.getFile("picture_wap_url").getOriginalFilename().equals("")) {
            aliOssUploadManager.uploadFile(multipartRequest.getFile("picture_wap_url"), "ef-wiki", "project_picture/" + multipartRequest.getFile("picture_wap_url").getOriginalFilename());
            paramMap.put("picture_wap_url", "project_picture/" + multipartRequest.getFile("picture_wap_url").getOriginalFilename());
        }
        if (!multipartRequest.getFile("picture_pc_url").getOriginalFilename().equals("")) {
            aliOssUploadManager.uploadFile(multipartRequest.getFile("picture_pc_url"), "ef-wiki", "project_picture/" + multipartRequest.getFile("picture_pc_url").getOriginalFilename());
            paramMap.put("picture_pc_url", "project_picture/" + multipartRequest.getFile("picture_pc_url").getOriginalFilename());
        }
        //������� start
        Object object = baseManager.saveOrUpdate(xSaveOrUpdate);
        //������� end
        modelMap.put("object", object);
        SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String createDatetime = sdf2.format(new Date());
        modelMap.put("createDateTime",createDatetime);
        modelMap.put("fatherId",request.getParameter("fatherId"));
        return modelMap;
    }
}
