package com.efeiyi.ec.system.product.controller;

import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.Do;
import com.ming800.core.does.model.XSaveOrUpdate;
import com.ming800.core.does.service.DoHandler;
import com.ming800.core.does.service.MultipartHandler;
import com.ming800.core.p.service.AliOssUploadManager;
import com.ming800.core.util.ApplicationContextUtil;
import org.hibernate.envers.Audited;
import org.springframework.ui.ModelMap;
import org.springframework.web.multipart.MultipartRequest;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;

/**
 * Created by Administrator on 2015/7/20.
 */
public class formProductHandler implements DoHandler {

    @Audited
    private  BaseManager baseManager;

    @Override
    public ModelMap handle(ModelMap modelMap, HttpServletRequest request) throws Exception {



        modelMap.put("masterId" , request.getParameter("masterId"));

        return modelMap;
    }
}
