package com.efeiyi.ec.system.master.service.impl;

import com.efeiyi.ec.master.model.Master;
import com.efeiyi.ec.master.model.MasterProject;
import com.efeiyi.ec.master.model.MasterWorkRecommended;
import com.efeiyi.ec.system.master.dao.MasterWorkRecommendedDao;
import com.efeiyi.ec.system.master.service.MasterManager;
import com.efeiyi.ec.system.master.service.MasterWorkRecommendedManager;
import com.efeiyi.ec.tenant.model.Tenant;
import com.efeiyi.ec.tenant.model.TenantMaster;
import com.efeiyi.ec.tenant.model.TenantProject;
import com.ming800.core.base.dao.XdoDao;
import com.ming800.core.does.model.XQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: ming
 * Date: 12-8-6
 * Time: 上午11:04
 * To change this template use File | Settings | File Templates.
 */
@Service
public class MasterManagerImpl implements MasterManager {

    @Autowired
    private XdoDao xdoDao;

    @Override
    public String linkTenant(String tenantId, String masterId, String tenantMasterId, String status) {
        TenantMaster tenantMaster = null;
        try {
            tenantMaster = (TenantMaster)xdoDao.getObject(TenantMaster.class.getName(),tenantMasterId);
            if(tenantMaster == null){
                tenantMaster = new TenantMaster();
                tenantMaster.setTenant((Tenant)xdoDao.getObject(Tenant.class.getName(),tenantId));
                tenantMaster.setMaster((Master)xdoDao.getObject(Master.class.getName(),masterId));
                tenantMaster.setStatus("1");
            }else {
                if("0".equals(status)){
                    tenantMaster.setStatus("1");
                }
                if("1".equals(status)){
                    tenantMaster.setStatus("0");
                }
            }
            xdoDao.saveOrUpdateObject(TenantMaster.class.getName(), tenantMaster);
            List<MasterProject> masterProjectList =  xdoDao.getObjectList("from MasterProject where status = '1'and project.status!='0' and master.id = ?",new Object[]{masterId});
//            XQuery xQuery = new XQuery("listMasterProject_default",request);
//            xQuery.put("master_id",masterId);
//            List<MasterProject> masterProjectList = baseManager.listObject(xQuery);
            Tenant tenant = (Tenant)xdoDao.getObject(Tenant.class.getName(),tenantId);
            if(masterProjectList!=null){
                for (MasterProject masterProject :masterProjectList){
                    TenantProject tenantProject = null;
//                    xQuery = new XQuery("listTenantProject_default2",request);
//                    xQuery.put("tenant_id",tenantId);
//                    xQuery.put("project_id",masterProject.getProject().getId());
//                    List<TenantProject> mp = baseManager.listObject(xQuery);
                    List<TenantProject> mp = xdoDao.getObjectList("from TenantProject where tenant.id=? and project.id=?",new Object[]{tenantId,masterProject.getProject().getId()});
                    if(mp.size()!=0){
                        tenantProject = mp.get(0);
                        if("0".equals(status)) {
                            tenantProject.setStatus("1");
                        }
                        if("1".equals(status)) {
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
