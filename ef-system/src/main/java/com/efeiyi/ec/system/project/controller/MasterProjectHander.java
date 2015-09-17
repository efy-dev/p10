package com.efeiyi.ec.system.project.controller;

import com.efeiyi.ec.master.model.MasterProject;
import com.efeiyi.ec.wiki.model.ProjectContent;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.does.service.DoHandler;
import com.ming800.core.util.ApplicationContextUtil;
import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by Administrator on 2015/9/15.
 *
 */
public class MasterProjectHander implements DoHandler {

    private BaseManager baseManager = (BaseManager) ApplicationContextUtil.getApplicationContext().getBean("baseManagerImpl");

    @Override
    public ModelMap handle(ModelMap modelMap, HttpServletRequest request) throws Exception {
        XQuery xQuery = new XQuery("listMasterProject2Master_default2",request);
        List<MasterProject> list = baseManager.listObject(xQuery);//大师
        modelMap.put("objectList",list);

        XQuery xQuery2 = new XQuery("plistProjectWiki_default3",request);
        List<ProjectContent> list2 = baseManager.listObject(xQuery2);//大师
        modelMap.put("projectContentList",list2);

        return modelMap;
    }
}
