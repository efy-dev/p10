package com.ming800.core.base.controller;

import com.ming800.core.does.service.DoHandler;
import com.ming800.core.does.service.ModuleManager;
import com.ming800.core.util.ApplicationContextUtil;
import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by IntelliJ IDEA.
 * User: ming
 * Date: 12-10-30
 * Time: 上午10:30
 * To change this template use File | Settings | File Templates.
 */

public class RelationFormHandler implements DoHandler {

    private ModuleManager moduleManager = (ModuleManager) ApplicationContextUtil.getApplicationContext().getBean("moduleManagerImpl");


    /**
     * newsAttachment  / messageAttachment  无法确定
     * setNews       /   setMessage         无法确定
     * setNewAttachmentList                 无法确定
     * 需要传值    com.ming800.info.model.NewsAttachment   和  nws（属性）
     */

    @Override
    public ModelMap handle(ModelMap modelMap, HttpServletRequest request) throws Exception {

        modelMap.put("xentityMap", moduleManager.fetchXentityMap());

        return modelMap;  //To change body of implemented methods use File | Settings | File Templates.
    }
}
