package com.efeiyi.ec.system.organization.service.impl;

import com.efeiyi.ec.master.model.Master;
import com.efeiyi.ec.master.model.MasterProject;
import com.efeiyi.ec.product.model.Product;
import com.efeiyi.ec.project.model.Project;
import com.efeiyi.ec.system.organization.service.TenantManager;
import com.efeiyi.ec.tenant.model.*;
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
                tenantProject.setTenant((BigTenant) xdoDao.getObject(BigTenant.class.getName(), tenantId));
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
    public String linkProduct(String tenantCategoryId, String productId, String tenantProductId, String status) {
        TenantProductTag tenantProductTag = null;
        try {
            tenantProductTag = (TenantProductTag)xdoDao.getObject(TenantProductTag.class.getName(),tenantProductId);
            if(tenantProductTag == null){
                tenantProductTag = new TenantProductTag();
                tenantProductTag.setTenantCategory((TenantCategory) xdoDao.getObject(TenantCategory.class.getName(), tenantCategoryId));
                tenantProductTag.setProduct((Product) xdoDao.getObject(Product.class.getName(), productId));
                tenantProductTag.setStatus("1");
            }else {
                if("0".equals(status)){
                    tenantProductTag.setStatus("1");
                }
                if("1".equals(status)){
//                    List<Product> productList = xdoDao.getObjectList("from Product where tenant.id=? and project.id=?",new Object[]{tenantId,tenantProject.getProject().getId()} );
//                    for(Product product:productList){
//                        product.setProject(null);
//                        xdoDao.saveOrUpdateObject(product);
//                    }
                    tenantProductTag.setStatus("0");
                }
            }
            xdoDao.saveOrUpdateObject(TenantProductTag.class.getName(), tenantProductTag);


        }catch (Exception e){
            e.printStackTrace();
        }
        return  tenantProductTag.getId();

    }


    @Override
    public String linkMaster(String tenantId, String masterId, String tenantMasterId, String status) {
        TenantMaster tenantMaster = null;
        try {
            tenantMaster = (TenantMaster)xdoDao.getObject(TenantMaster.class.getName(),tenantMasterId);
            if(tenantMaster == null){
                tenantMaster = new TenantMaster();
                tenantMaster.setTenant((BigTenant)xdoDao.getObject(BigTenant.class.getName(),tenantId));
                tenantMaster.setMaster((Master)xdoDao.getObject(Master.class.getName(),masterId));
                tenantMaster.setStatus("1");
            }else {
                if("0".equals(status)){
                    tenantMaster.setStatus("1");
                }
                if("1".equals(status)){
                    List<Product> productList = xdoDao.getObjectList("from Product where tenant.id=? and master.id=?",new Object[]{tenantId,masterId} );
                    for(Product product:productList){
                        product.setMaster(null);
                        xdoDao.saveOrUpdateObject(product);
                    }
                    tenantMaster.setStatus("0");
                }
            }
            xdoDao.saveOrUpdateObject(TenantMaster.class.getName(), tenantMaster);
            List<MasterProject> masterProjectList =  xdoDao.getObjectList("from MasterProject where status = '1'and project.status!='0' and master.id = ?",new Object[]{masterId});

            BigTenant tenant = (BigTenant)xdoDao.getObject(BigTenant.class.getName(),tenantId);
            if(masterProjectList!=null){
                for (MasterProject masterProject :masterProjectList){
                    TenantProject tenantProject = null;

                    List<TenantProject> mp = xdoDao.getObjectList("from TenantProject where tenant.id=? and project.id=?",new Object[]{tenantId,masterProject.getProject().getId()});
                    if(mp.size()!=0){
                        tenantProject = mp.get(0);
                        if("0".equals(status)) {
                            tenantProject.setStatus("1");
                        }
                        if("1".equals(status)) {
                            List<Product> productList = xdoDao.getObjectList("from Product where tenant.id=? and project.id=?",new Object[]{tenantId,tenantProject.getProject().getId()} );
                            for(Product product:productList){
                                product.setProject(null);
                                xdoDao.saveOrUpdateObject(product);
                            }
                            tenantProject.setStatus("0");
                        }
                    }else{
                        if("0".equals(status)) {
                            tenantProject = new TenantProject();
                            tenantProject.setStatus("1");
                            tenantProject.setProject(masterProject.getProject());
                            tenantProject.setTenant(tenant);
                        }
                    }
                    xdoDao.saveOrUpdateObject(TenantProject.class.getName(),tenantProject);
                }
            }



        }catch (Exception e){
            e.printStackTrace();
        }
        return tenantMaster.getId();
    }
}
