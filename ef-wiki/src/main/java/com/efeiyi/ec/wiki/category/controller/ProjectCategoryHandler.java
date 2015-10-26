package com.efeiyi.ec.wiki.category.controller;

import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.service.DoHandler;
import com.ming800.core.util.ApplicationContextUtil;
import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpServletRequest;



/**
 * Created by Administrator on 2015/9/24.
 *
 */
public class ProjectCategoryHandler implements DoHandler {

    private BaseManager baseManager = (BaseManager) ApplicationContextUtil.getApplicationContext().getBean("baseManagerImpl");

    @Override
    public ModelMap handle(ModelMap modelMap, HttpServletRequest request) throws Exception {
       String addType = request.getParameter("qm").split("_")[1];
        modelMap.put("addType",addType);
        String conditions = request.getParameter("conditions");
        if(conditions != null && !conditions.equals("")){
            switch (addType){
               case "Category": modelMap.put("query",conditions.split(":")[1]); break;
               case "level": modelMap.put("query",conditions.split(":")[1]); break;
               default:modelMap.put("query",conditions.split(":")[1]);break;
            }
        }

        return modelMap;
    }
}
