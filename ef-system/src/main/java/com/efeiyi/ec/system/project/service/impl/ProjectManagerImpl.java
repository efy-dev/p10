package com.efeiyi.ec.system.project.service.impl;

import com.efeiyi.ec.master.model.Master;
import com.efeiyi.ec.master.model.MasterProject;
import com.efeiyi.ec.product.model.Product;
import com.efeiyi.ec.product.model.ProductDescription;
import com.efeiyi.ec.product.model.ProductModel;
import com.efeiyi.ec.product.model.ProductPropertyValue;
import com.efeiyi.ec.project.model.Project;
import com.efeiyi.ec.project.model.ProjectPropertyValue;
import com.efeiyi.ec.system.product.dao.ProductDao;
import com.efeiyi.ec.system.product.model.ProductModelBean;
import com.efeiyi.ec.system.product.service.ProductManager;
import com.efeiyi.ec.system.project.service.ProjectManager;
import com.efeiyi.ec.tenant.model.BigTenant;
import com.efeiyi.ec.tenant.model.Tenant;
import com.efeiyi.ec.tenant.model.TenantMaster;
import com.efeiyi.ec.tenant.model.TenantProject;
import com.ming800.core.base.dao.XdoDao;
import com.ming800.core.p.service.AutoSerialManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Created by Administrator on 2015/8/17.
 */
@Service
public class ProjectManagerImpl implements ProjectManager{


    @Autowired
    private XdoDao xdoDao;

    @Override
    public String linkTenant(String tenantId, String projectId, String tenantProjectId, String status) {
        TenantProject tenantProject = null;
        try {
            tenantProject = (TenantProject)xdoDao.getObject(TenantProject.class.getName(),tenantProjectId);
            if(tenantProject == null){
                tenantProject = new TenantProject();
                tenantProject.setTenant((BigTenant)xdoDao.getObject(BigTenant.class.getName(),tenantId));
                tenantProject.setProject((Project) xdoDao.getObject(Project.class.getName(), projectId));
                tenantProject.setStatus("1");
            }else {
                if("0".equals(status)){
                    tenantProject.setStatus("1");
                }
                if("1".equals(status)){
                    List<Product> productList = xdoDao.getObjectList("from Product where tenant.id=? and project.id=?",new Object[]{tenantId,tenantProject.getProject().getId()} );
                    for(Product product:productList){
                        product.setProject(null);
                        xdoDao.saveOrUpdateObject(product);
                    }
                    tenantProject.setStatus("0");
                }
            }
            xdoDao.saveOrUpdateObject(TenantProject.class.getName(), tenantProject);


        }catch (Exception e){
            e.printStackTrace();
        }
        return  tenantProject.getId();

    }

    @Override
    public String removeProject(String id) {
        Project project = (Project)xdoDao.getObject(Project.class.getName(),id);
        String sql = "from MasterProject where project.id = ?";
        List<MasterProject> list = xdoDao.getObjectList(sql,new Object[]{id});
        if(list.size()!=0){
            for(MasterProject masterProject : list){
                masterProject.setStatus("0");
                xdoDao.saveOrUpdateObject(masterProject);
            }
        }
        sql = "from TenantProject where project.id = ?";
        List<TenantProject> list2 = xdoDao.getObjectList(sql,new Object[]{id});
        if(list2.size()!=0){
            for(TenantProject tenantProject : list2){
                tenantProject.setStatus("0");
                xdoDao.saveOrUpdateObject(tenantProject);
            }
        }

        project.setStatus("0");
        xdoDao.saveOrUpdateObject(project);
        return id;

    }
}
