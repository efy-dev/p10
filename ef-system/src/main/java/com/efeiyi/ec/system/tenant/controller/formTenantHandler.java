package com.efeiyi.ec.system.tenant.controller;

import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.Do;
import com.ming800.core.does.model.XSaveOrUpdate;
import com.ming800.core.does.service.DoHandler;
import com.ming800.core.does.service.MultipartHandler;
import com.ming800.core.p.service.AliOssUploadManager;
import com.ming800.core.p.service.AutoSerialManager;
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
public class formTenantHandler implements DoHandler {

    private AutoSerialManager autoSerialManager = (AutoSerialManager) ApplicationContextUtil.getApplicationContext().getBean("autoSerialManagerImpl");
    @Override
    public ModelMap handle(ModelMap modelMap, HttpServletRequest request) throws Exception {
        if("".equals(request.getParameter("id"))||request.getParameter("id")==null){
            modelMap.put("serial" ,autoSerialManager.nextSerial("product"));
        }else {
            modelMap.put("serial","1");
        }
        return null;
    }
}
