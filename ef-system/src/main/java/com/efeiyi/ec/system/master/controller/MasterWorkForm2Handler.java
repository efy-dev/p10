package com.efeiyi.ec.system.master.controller;

import com.efeiyi.ec.master.model.Master;
import com.efeiyi.ec.project.model.ProjectCategory;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.does.model.Xentity;
import com.ming800.core.does.service.DoHandler;
import com.ming800.core.util.ApplicationContextUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by Administrator on 2015/7/21.
 */
public class MasterWorkForm2Handler implements DoHandler {

    private BaseManager baseManager = (BaseManager) ApplicationContextUtil.getApplicationContext().getBean("baseManagerImpl");
    @Override
    public ModelMap handle(ModelMap modelMap, HttpServletRequest request) throws Exception {

        XQuery xQuery = new XQuery("listMaster3_default",request);
        List<Master> masterList =(List<Master>)baseManager.listObject(xQuery);
        modelMap.put("masterList",masterList);
        xQuery = new XQuery("listProjectCategory2_default",request);
        List<ProjectCategory> projectCategoryList =(List<ProjectCategory>)baseManager.listObject(xQuery);
        modelMap.put("projectCategoryList",projectCategoryList);

        return modelMap;
    }
}
