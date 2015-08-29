package com.efeiyi.ec.system.product.controller;

import com.efeiyi.ec.master.model.MasterProject;
import com.efeiyi.ec.organization.model.MyUser;
import com.efeiyi.ec.project.model.Project;
import com.efeiyi.ec.project.model.ProjectProperty;
import com.efeiyi.ec.system.organization.util.AuthorizationUtil;
import com.efeiyi.ec.tenant.model.TenantMaster;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.Do;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.does.model.XSaveOrUpdate;
import com.ming800.core.does.service.DoHandler;
import com.ming800.core.does.service.MultipartHandler;
import com.ming800.core.p.service.AliOssUploadManager;
import com.ming800.core.p.service.AutoSerialManager;
import com.ming800.core.util.ApplicationContextUtil;
import org.hibernate.envers.Audited;
import org.springframework.ui.ModelMap;
import org.springframework.web.multipart.MultipartRequest;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2015/7/20.
 */
public class formProductHandler implements DoHandler {

    private BaseManager baseManager = (BaseManager) ApplicationContextUtil.getApplicationContext().getBean("baseManagerImpl");


    private AutoSerialManager autoSerialManager = (AutoSerialManager) ApplicationContextUtil.getApplicationContext().getBean("autoSerialManagerImpl");

    @Override
    public ModelMap handle(ModelMap modelMap, HttpServletRequest request) throws Exception {

        modelMap.put("serial" ,autoSerialManager.nextSerial("product"));
        modelMap.put("tenantId",AuthorizationUtil.getMyUser().getBigTenant().getId());
        XQuery xQuery = new XQuery("listTenantMaster_default",request);
        List<TenantMaster> list = baseManager.listObject(xQuery);//大师
        Map<String,List> projectMap = new HashMap<>();
        Map<String,List> propertyMap = new HashMap<>();
        for(TenantMaster tenantMaster : list){
            xQuery = new XQuery("listMasterProject_default",request);
            xQuery.put("master_id",tenantMaster.getMaster().getId());
            List<MasterProject> masterProjectList = baseManager.listObject(xQuery);
            projectMap.put(tenantMaster.getMaster().getId(),masterProjectList);//项目
            for (MasterProject masterProject : masterProjectList){//属性
                xQuery = new XQuery("listProjectProperty_default",request);
                xQuery.put("project_id",masterProject.getProject().getId());
                List<ProjectProperty> projectPropertyList = baseManager.listObject(xQuery);
                propertyMap.put(masterProject.getProject().getId(),projectPropertyList);
            }
        }
        modelMap.put("propertyMap",propertyMap);
        modelMap.put("projectMap",projectMap);
        modelMap.put("masterList",list);
        return modelMap;
    }
}
