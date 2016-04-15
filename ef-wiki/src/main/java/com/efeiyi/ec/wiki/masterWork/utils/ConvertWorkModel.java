package com.efeiyi.ec.wiki.masterWork.utils;

import com.efeiyi.ec.master.model.MasterWork;
import com.efeiyi.ec.wiki.masterWork.model.MasterWorkModel;

import java.util.List;

/**
 * Created by Administrator on 2016/4/5.
 */
public class ConvertWorkModel {

    public static MasterWorkModel convertMasterWorkModel(MasterWork work , List<MasterWork> workList) throws Exception {
        MasterWorkModel workModel = new MasterWorkModel();
        workModel.setId(work.getId());
        workModel.setName(work.getName() == null ? "" : work.getName());
        workModel.setSize(work.getSize() == null ? "" : work.getSize());
        workModel.setSite(work.getSite() == null ? "" : work.getSite());
        workModel.setAudio(work.getAudio() == null ? "" : work.getAudio());
        workModel.setMaterial(work.getMaterial()==null?"":work.getMaterial());
        workModel.setDescription(work.getDescription() == null ? "" : work.getDescription());
        if (work.getMaster() != null && work.getMaster().getId() != null) {
            workModel.setMasterId(work.getMaster().getId());
            workModel.setMasterFullName(work.getMaster().getFullName() == null ? "" : work.getMaster().getFullName());
            workModel.setMasterFavicon(work.getMaster().getFavicon() == null ? "" : work.getMaster().getFavicon());
            workModel.setMasterLevel(work.getMaster().getLevel() == null ? "" : work.getMaster().getLevel());
        }
        if (work.getProject() != null && work.getProject().getId() != null) {
            workModel.setProjectId(work.getProject().getId());
            workModel.setProjectName(work.getProject().getName() == null ? "" : work.getProject().getName());
            workModel.setProjectLevel(work.getProject().getLevel() == null ? "" : work.getProject().getLevel());
            if (work.getProject().getAddressDistrict() != null && work.getProject().getAddressDistrict().getId() != null){
                workModel.setProjectCityName(work.getProject().getAddressDistrict().getName() == null ? "" : work.getProject().getAddressDistrict().getName());
            }
            workModel.setProjectDescription(work.getProject().getDescription() == null ? "" : work.getProject().getDescription());
            workModel.setWorkList(workList);
        }
        return workModel;
    }
}
