package com.efeiyi.ec.personal.master.controller;

import com.efeiyi.ec.master.model.Master;
import com.efeiyi.ec.master.model.MasterNews;
import com.efeiyi.ec.master.model.MasterWork;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.Do;
import com.ming800.core.does.model.XSaveOrUpdate;
import com.ming800.core.does.service.DoHandler;
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
public class MasterNewsHandler implements DoHandler {
    private BaseManager baseManager = (BaseManager) ApplicationContextUtil.getApplicationContext().getBean("baseManagerImpl");

    @Override
    public ModelMap handle(ModelMap modelMap, HttpServletRequest request) throws Exception {
        String newsId = request.getParameter("id");
        MasterNews news = (MasterNews) baseManager.getObject(MasterNews.class.getName(),newsId);
//        Master master = (Master) baseManager.getObject(Master.class.getName(),request.getParameter("masterId"));
        modelMap.put("object", news);
//        modelMap.put("master", master);
        return modelMap;
    }
}
