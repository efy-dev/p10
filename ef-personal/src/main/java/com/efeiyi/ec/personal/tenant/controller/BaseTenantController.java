package com.efeiyi.ec.personal.tenant.controller;

import com.efeiyi.ec.master.model.Master;
import com.efeiyi.ec.master.model.MasterProject;
import com.ming800.core.base.controller.BaseController;
import com.ming800.core.base.service.BaseManager;
import org.springframework.beans.factory.annotation.Autowired;

import javax.servlet.http.HttpServletRequest;
import java.util.LinkedHashMap;
import java.util.List;


/**
 * Created by kayson on 2015/7/25.
 *
 */
public class BaseTenantController extends BaseController {
    @Autowired
    BaseManager baseManager;
    protected Master master;

    public Master getMaster() {
        return master;
    }

    public void setMaster(Master master) {
        this.master = master;
    }


    public Master getTenantfromDomain(HttpServletRequest request)throws Exception{
        Master masterTemp = null;
        String subDommainName = (String)request.getAttribute("domainName");
        if(!"master".equalsIgnoreCase(subDommainName)){
            LinkedHashMap<String,Object> map = new LinkedHashMap<>();
            String queryHql ="from Master t where t.name=:name and t.status=:status";
            map.put("name",subDommainName);
            map.put("status","1");
            masterTemp =(Master) baseManager.getUniqueObjectByConditions(queryHql,map);
            List<MasterProject> projects = masterTemp.getMasterProjectList();
            masterTemp.setProjectName(mainTenantProject(projects));
        }
      return masterTemp;
    }


    public String mainTenantProject(List<MasterProject> masterProjects) {

        MasterProject masterProject = null;

        if (masterProjects != null && masterProjects.size() > 0) {

            for (MasterProject masterProjectTemp : masterProjects) {
                if (masterProjectTemp.getStatus().equals("1")) {
                    masterProject = masterProjectTemp;
                }
            }
            if (masterProject == null) {
                masterProject = masterProjects.get(0);
            }

            return masterProject.getProject().getName();
        } else {

            return "";
        }
    }
}
