package com.efeiyi.ec.system.product.controller;

import com.efeiyi.ec.product.model.SubjectProductModel;
import com.efeiyi.ec.project.model.ProjectCategoryProductModel;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.does.service.DoHandler;
import com.ming800.core.util.ApplicationContextUtil;
import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by Administrator on 2015/7/21.
 */
public class PListPCProductModelHandler implements DoHandler {

    private BaseManager baseManager = (BaseManager) ApplicationContextUtil.getApplicationContext().getBean("baseManagerImpl");

    @Override
    public ModelMap handle(ModelMap modelMap, HttpServletRequest request) throws Exception {

        if(request.getParameter("projectCategoryId")!=null&&request.getParameter("projectCategoryId")!=""){
            XQuery xQuery = new XQuery("listProjectCategoryProductModel_default2",request);
            xQuery.put("projectCategory_id",request.getParameter("projectCategoryId"));
            List<ProjectCategoryProductModel> projectCategoryProductModelList = baseManager.listObject(xQuery);
            modelMap.put("projectCategoryProductModelList",projectCategoryProductModelList);
        }

       modelMap.put("projectCategoryId",request.getParameter("projectCategoryId"));
//        XQuery xQuery = new XQuery();
//        List list =  baseManager.listObject(xQuery);

        return modelMap;
    }
}
