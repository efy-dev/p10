package com.efeiyi.ec.system.organization.service.impl;

import com.efeiyi.ec.product.model.Product;
import com.efeiyi.ec.project.model.Project;
import com.efeiyi.ec.system.organization.service.TenantManager;
import com.efeiyi.ec.tenant.model.Tenant;
import com.efeiyi.ec.tenant.model.TenantProject;
import com.ming800.core.base.dao.XdoDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by Administrator on 2015/8/17.
 */
@Service
public class TenantManagerImpl implements TenantManager{


    @Autowired
    private XdoDao xdoDao;

    @Override
    public String linkProject(String tenantId, String projectId, String tenantProjectId, String status) {
        TenantProject tenantProject = null;
        try {
            tenantProject = (TenantProject)xdoDao.getObject(TenantProject.class.getName(),tenantProjectId);
            if(tenantProject == null){
                tenantProject = new TenantProject();
                tenantProject.setTenant((Tenant)xdoDao.getObject(Tenant.class.getName(),tenantId));
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
}
