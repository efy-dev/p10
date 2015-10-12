package com.efeiyi.ec.wiki.base.util;

import com.efeiyi.ec.organization.model.AddressCity;
import com.efeiyi.ec.organization.model.AddressProvince;
import com.efeiyi.ec.project.model.Project;
import com.efeiyi.ec.wiki.model.ProjectModel;
import org.apache.log4j.Logger;

import java.util.Date;

/**
 * Created by Administrator on 2015/10/10.
 *
 */
public class projectConvertprojectModelUtil {
    private static Logger logger = Logger.getLogger(projectConvertprojectModelUtil.class);
    public static ProjectModel projectConvertprojectModel(Project project)  {
        ProjectModel projectModel = new ProjectModel();
        if (project!=null){
            projectModel.setCreateDateTime(project.getCreateDateTime() == null ? new Date(): project.getCreateDateTime());
            AddressCity addressCity;
            AddressProvince addressProvince;
            String addressProvinceName ="";
            if (null!=project.getAddressDistrict()){
                addressCity = project.getAddressDistrict().getAddressCity();
                if (null!=addressCity){
                    addressProvince = project.getAddressDistrict().getAddressCity().getAddressProvince();
                    if (null!=addressProvince){
                        addressProvinceName = addressProvince.getName();
                    }
                }
            }
            projectModel.setAddressDistrict(addressProvinceName==null?"":addressProvinceName);
            projectModel.setDescription(project.getDescription()==null?"":project.getDescription());
            projectModel.setFsAmount(project.getFsAmount()==null?0l:project.getFsAmount());
            projectModel.setLevel(project.getLevel()==null?"":project.getLevel());
            projectModel.setMasters((long)project.getMasterProjects().size());
            projectModel.setPicture_url(project.getPicture_url()==null?"":project.getPicture_url());
            projectModel.setPicture_wap_url(project.getPicture_wap_url()==null?"":project.getPicture_wap_url());
            projectModel.setProjectId(project.getId()==null?"":project.getId());
            projectModel.setProjectName(project.getName()==null?"":project.getName());
            projectModel.setWorks((long)project.getProductList().size());
        }

        return projectModel;
    }
}
