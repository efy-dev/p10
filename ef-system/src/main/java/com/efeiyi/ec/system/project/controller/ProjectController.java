package com.efeiyi.ec.system.project.controller;

import com.efeiyi.ec.master.model.Master;
import com.efeiyi.ec.project.model.Project;
import com.efeiyi.ec.project.model.ProjectPropertyValue;
import com.efeiyi.ec.system.product.service.ProductManager;
import com.efeiyi.ec.system.product.service.ProductModelManager;
import com.efeiyi.ec.system.project.dao.TenantProjectDao;
import com.efeiyi.ec.tenant.model.Tenant;
import com.efeiyi.ec.tenant.model.TenantMaster;
import com.efeiyi.ec.tenant.model.TenantProject;
import com.ming800.core.base.controller.BaseController;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.p.service.AliOssUploadManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import java.util.List;


/**
 * Created by Administrator on 2015/6/18.
 */
@Controller
@RequestMapping("/product")
public class ProjectController extends BaseController {
    @Autowired
    private BaseManager baseManager;

    @Autowired
    private ProductModelManager productModelManager;

    @Autowired
    private AliOssUploadManager aliOssUploadManager;

    @Autowired
    private ProductManager productManager;

    @Autowired
    private TenantProjectDao tenantProjectDao;

    @RequestMapping("/delProjectPropertyValue.do")
    @ResponseBody
  public String deleteProjectPropertyValue(String id){
        try {
            baseManager.delete(ProjectPropertyValue.class.getName(),id);
        }catch (Exception e){
               e.printStackTrace();
        }

        return  id;
  }

    @RequestMapping("/saveOrUpdateProjectPropertyValue.do")
    public String saveOrUpdateProjectPropertyValue(ProjectPropertyValue projectPropertyValue,String resultPage){
          ProjectPropertyValue projectPropertyValueTemp = null;
       try{
          if(projectPropertyValue.getId()==null||projectPropertyValue.getId()==""){
              projectPropertyValueTemp.setId(null);
              projectPropertyValueTemp.setProjectProperty(projectPropertyValue.getProjectProperty());
              projectPropertyValueTemp.setValue(projectPropertyValue.getValue());
          }else {
              projectPropertyValueTemp = (ProjectPropertyValue)baseManager.getObject(ProjectPropertyValue.class.getName(),projectPropertyValue.getId());
              projectPropertyValueTemp.setValue(projectPropertyValue.getValue());
          }
           baseManager.saveOrUpdate(ProjectPropertyValue.class.getName(),projectPropertyValueTemp);
       }catch (Exception e){
               e.printStackTrace();
       }

        return  resultPage;
    }

    @RequestMapping("/project/toTenantProject.do")
    public String toTenantProject(Model model,String tenantId){
        List<Project> projectList = null;
        try {
            projectList = tenantProjectDao.getProjectList(tenantId);
        }catch (Exception e){
            e.printStackTrace();
        }
        model.addAttribute("objectList",projectList);
        model.addAttribute("tenantId",tenantId);
        return "/tenantProject/projectList";
    }

    @RequestMapping("/project/linkTenant.do")
    @ResponseBody
    public String linkTenant(String tenantId,String projectId,String tenantProjectId,String status){
        TenantProject tenantProject = null;
        try {
            tenantProject = (TenantProject)baseManager.getObject(TenantProject.class.getName(),tenantProjectId);
            if(tenantProject == null){
                tenantProject = new TenantProject();
                tenantProject.setTenant((Tenant)baseManager.getObject(Tenant.class.getName(),tenantId));
                tenantProject.setProject((Project) baseManager.getObject(Project.class.getName(), projectId));
                tenantProject.setStatus("1");
            }else {
                if("0".equals(status)){
                    tenantProject.setStatus("1");
                }
                if("1".equals(status)){
                    tenantProject.setStatus("0");
                }
            }
            baseManager.saveOrUpdate(TenantProject.class.getName(),tenantProject);


        }catch (Exception e){
            e.printStackTrace();
        }
        return  tenantProject.getId();
    }


    @RequestMapping("/project/updateStatus.do")
    @ResponseBody
    public String updateStatus(String id,String status){
        Project project = (Project)baseManager.getObject(Project.class.getName(),id);
        try {
             project.setStatus(status);
            baseManager.saveOrUpdate(Project.class.getName(),project);

        }catch (Exception e){
            e.printStackTrace();
        }
        return  status;
    }

}
