package com.efeiyi.ec.system.master.controller;

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
 * Created by Administrator on 2015/7/20.
 */
public class MasterHandler implements MultipartHandler {
    private AliOssUploadManager aliOssUploadManager = (AliOssUploadManager) ApplicationContextUtil.getApplicationContext().getBean("aliOssUploadManagerImpl");
    private BaseManager baseManager = (BaseManager) ApplicationContextUtil.getApplicationContext().getBean("baseManagerImpl");


    @Override
    public ModelMap handleMultipart(Do tempDo, ModelMap modelMap, HttpServletRequest request, MultipartRequest multipartRequest) throws Exception {

        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
        String identify = sdf.format(new Date());
        String url = "photo/" + identify + ".jpg";
        XSaveOrUpdate xSaveOrUpdate = new XSaveOrUpdate(tempDo.getName(), request);
        HashMap<String, Object> paramMap = xSaveOrUpdate.getParamMap();

        if (!multipartRequest.getFile("favicon").getOriginalFilename().equals("")) {
            aliOssUploadManager.uploadFile(multipartRequest.getFile("favicon"), "tenant", url);
            paramMap.put("favicon", url);
        }

        if (!multipartRequest.getFile("background").getOriginalFilename().equals("")) {
            aliOssUploadManager.uploadFile(multipartRequest.getFile("background"), "tenant", "background/" + multipartRequest.getFile("background").getOriginalFilename());
            paramMap.put("backgroundUrl", "background/" + multipartRequest.getFile("background").getOriginalFilename());

        }

        if (!multipartRequest.getFile("logo").getOriginalFilename().equals("")) {
            aliOssUploadManager.uploadFile(multipartRequest.getFile("logo"), "tenant", "logo/" + multipartRequest.getFile("logo").getOriginalFilename());
            paramMap.put("logoUrl", "logo/" + multipartRequest.getFile("logo").getOriginalFilename());
        }

        if (!multipartRequest.getFile("identityPicture").getOriginalFilename().equals("")) {
            aliOssUploadManager.uploadFile(multipartRequest.getFile("identityPicture"), "tenant", "identityPicture/" + multipartRequest.getFile("identityPicture").getOriginalFilename());
            paramMap.put("identityPicture", "identityPicture/" + multipartRequest.getFile("identityPicture").getOriginalFilename());
        }

        //������� start
        Object object = baseManager.saveOrUpdate(xSaveOrUpdate);
        //������� end
        modelMap.put("object", object);

        return modelMap;
    }
}
