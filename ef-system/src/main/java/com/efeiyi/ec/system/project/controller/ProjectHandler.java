package com.efeiyi.ec.system.project.controller;

import com.efeiyi.ec.project.model.Project;
import com.efeiyi.ec.project.model.ProjectCategory;
import com.efeiyi.ec.tenant.model.TenantMaster;
import com.efeiyi.ec.wiki.model.ProjectContent;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.base.service.XdoManager;
import com.ming800.core.does.model.Do;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.does.service.DoHandler;
import com.ming800.core.does.service.MultipartHandler;
import com.ming800.core.p.service.AliOssUploadManager;
import com.ming800.core.util.ApplicationContextUtil;
import org.springframework.ui.ModelMap;
import org.springframework.web.multipart.MultipartRequest;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Created by Administrator on 2015/7/16.
 */
public class ProjectHandler implements DoHandler {

  //  private AliOssUploadManager aliOssUploadManager = (AliOssUploadManager) ApplicationContextUtil.getApplicationContext().getBean("aliOssUploadManagerImpl");
    private BaseManager baseManager = (BaseManager) ApplicationContextUtil.getApplicationContext().getBean("baseManagerImpl");

    @Override
    public ModelMap handle(ModelMap modelMap, HttpServletRequest request) throws Exception {
        XQuery xQuery = new XQuery("listProjectCategory_default",request);
        List<ProjectCategory> list = baseManager.listObject(xQuery);//大师
        modelMap.put("fatherId",request.getParameter("fatherId"));
        modelMap.put("projectCategoryList",list);
        if(null!=request.getParameter("projectid") && !"".equalsIgnoreCase(request.getParameter("projectid"))){
          Project project = (Project) baseManager.getObject(Project.class.getName(), request.getParameter("projectid"));
            List<ProjectContent> list2 = project.getProjectContents();
            if(list2 != null && list2.size()>=1){
                modelMap.put("projectContentList",list2);
            }else {
                modelMap.put("message","this project hasnot associated any projectcontent");
            }

        }
        SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String createDatetime = sdf2.format(new Date());
        modelMap.put("createDateTime",createDatetime);
        return modelMap;
    }
}
