package com.efeiyi.ec.wiki.masterWork.model;

import com.efeiyi.ec.master.model.MasterWork;
import com.efeiyi.ec.master.model.MasterWorkPicture;

import java.io.Serializable;
import java.util.List;

/**
 * Created by Administrator on 2016/4/5.
 */
public class MasterWorkModel implements Serializable {

    private String id;
    private String name;//作品名称
    private String size;//尺寸 规格
    private String material;//材质
    private String site;//馆藏地
    private String audio;//语音
    private String description;//介绍
    private String masterId;
    private String masterFullName;
    private String masterFavicon;//master头像
    private String masterLevel;//master级别
    private String projectId;
    private String projectName;//project名称
    private String projectDescription;// project描述
    private String projectLevel;//project级别
    private String projectCityName;//project地区
    private List<MasterWork> workList;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSize() {
        return size;
    }

    public void setSize(String size) {
        this.size = size;
    }

    public String getMaterial() {
        return material;
    }

    public void setMaterial(String material) {
        this.material = material;
    }

    public String getSite() {
        return site;
    }

    public void setSite(String site) {
        this.site = site;
    }

    public String getAudio() {
        return audio;
    }

    public void setAudio(String audio) {
        this.audio = audio;
    }

    public String getMasterId() {
        return masterId;
    }

    public void setMasterId(String masterId) {
        this.masterId = masterId;
    }

    public String getMasterFullName() {
        return masterFullName;
    }

    public void setMasterFullName(String masterFullName) {
        this.masterFullName = masterFullName;
    }

    public String getMasterFavicon() {
        return masterFavicon;
    }

    public void setMasterFavicon(String masterFavicon) {
        this.masterFavicon = masterFavicon;
    }

    public String getMasterLevel() {
        return masterLevel;
    }

    public void setMasterLevel(String masterLevel) {
        this.masterLevel = masterLevel;
    }

    public String getProjectId() {
        return projectId;
    }

    public void setProjectId(String projectId) {
        this.projectId = projectId;
    }

    public String getProjectName() {
        return projectName;
    }

    public void setProjectName(String projectName) {
        this.projectName = projectName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getProjectDescription() {
        return projectDescription;
    }

    public void setProjectDescription(String projectDescription) {
        this.projectDescription = projectDescription;
    }

    public String getProjectLevel() {
        return projectLevel;
    }

    public void setProjectLevel(String projectLevel) {
        this.projectLevel = projectLevel;
    }

    public String getProjectCityName() {
        return projectCityName;
    }

    public void setProjectCityName(String projectCityName) {
        this.projectCityName = projectCityName;
    }

    public List<MasterWork> getWorkList() {
        return workList;
    }

    public void setWorkList(List<MasterWork> workList) {
        this.workList = workList;
    }
}
