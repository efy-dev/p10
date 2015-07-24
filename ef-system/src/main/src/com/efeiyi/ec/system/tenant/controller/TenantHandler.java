package com.efeiyi.ec.system.tenant.controller;

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
public class TenantHandler implements MultipartHandler{
    private AliOssUploadManager aliOssUploadManager = (AliOssUploadManager) ApplicationContextUtil.getApplicationContext().getBean("aliOssUploadManagerImpl");
    private BaseManager baseManager = (BaseManager) ApplicationContextUtil.getApplicationContext().getBean("baseManagerImpl");


    @Override
    public ModelMap handleMultipart(Do tempDo, ModelMap modelMap, HttpServletRequest request, MultipartRequest multipartRequest) throws Exception {

        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
        String identify = sdf.format(new Date());
        String url = "photo/"+identify+".jpg";
        boolean result = aliOssUploadManager.uploadFile(multipartRequest.getFile("favicon"), "tenant", url);
        boolean result2 = aliOssUploadManager.uploadFile(multipartRequest.getFile("background"), "tenant", "background/"+multipartRequest.getFile("background").getOriginalFilename());
        //������� start
        XSaveOrUpdate xSaveOrUpdate = new XSaveOrUpdate(tempDo.getName(),request);
        HashMap<String,Object> paramMap = xSaveOrUpdate.getParamMap();
        paramMap.put("favicon",url);
        paramMap.put("backgroundUrl","background/"+multipartRequest.getFile("background").getOriginalFilename());
        Object object = baseManager.saveOrUpdate(xSaveOrUpdate);
        //������� end
        modelMap.put("object",object);

        return modelMap;
    }
}
