package com.efeiyi.ec.system.basic.controller;

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
public class BasicBannerFormHandler implements MultipartHandler{
    private AliOssUploadManager aliOssUploadManager = (AliOssUploadManager) ApplicationContextUtil.getApplicationContext().getBean("aliOssUploadManagerImpl");
    private BaseManager baseManager = (BaseManager) ApplicationContextUtil.getApplicationContext().getBean("baseManagerImpl");


    @Override
    public ModelMap handleMultipart(Do tempDo, ModelMap modelMap, HttpServletRequest request, MultipartRequest multipartRequest) throws Exception {

        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
        String identify = sdf.format(new Date());
        String url=request.getParameter("OldImageUrl");
        String bucket;
        if(!multipartRequest.getFile("imageUrl").getOriginalFilename().equals("")) {
         url = "banner/"+identify+"_"+request.getParameter("groupName")+".jpg";
         bucket = request.getParameter("bucket");
            boolean result = aliOssUploadManager.uploadFile(multipartRequest.getFile("imageUrl"), bucket, url);
        }

        XSaveOrUpdate xSaveOrUpdate = new XSaveOrUpdate(tempDo.getName(),request);
        HashMap<String,Object> paramMap = xSaveOrUpdate.getParamMap();
        paramMap.put("imageUrl",url);
        paramMap.put("group",request.getParameter("groupName"));
        paramMap.put("status","1");

//        Master tenant = new Master();
//        tenant.setId(request.getParameter("tenant_id"));
        //paramMap.put("tenant.id",request.getParameter("tenant.id"));

        Object object = baseManager.saveOrUpdate(xSaveOrUpdate);


        modelMap.put("object",object);

        return modelMap;
    }
}
