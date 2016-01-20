package com.efeiyi.ec.wiki.project.model;

import java.io.Serializable;
import java.util.Date;

/**
 * Created by Administrator on 2015/10/9.
 *
 */
public class ProjectModel implements Serializable {
    private String projectId;
    private String projectName;
    private String addressDistrict;
    private String level;
    private Date createDateTime;//发布时间
    private String description;// project描述
    private String picture_pc_url;//project图片
    private String picture_wap_url;//移动端图片project图片
    private Long works;
    private Long fsAmount;

    public String getPicture_pc_url() {
        return picture_pc_url;
    }

    public void setPicture_pc_url(String picture_pc_url) {
        this.picture_pc_url = picture_pc_url;
    }

    private Long masters;

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

    public String getAddressDistrict() {
        return addressDistrict;
    }

    public void setAddressDistrict(String addressDistrict) {
        this.addressDistrict = addressDistrict;
    }

    public String getLevel() {
        return level;
    }

    public void setLevel(String level) {
        this.level = level;
    }

    public Date getCreateDateTime() {
        return createDateTime;
    }

    public void setCreateDateTime(Date createDateTime) {
        this.createDateTime = createDateTime;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }



    public String getPicture_wap_url() {
        return picture_wap_url;
    }

    public void setPicture_wap_url(String picture_wap_url) {
        this.picture_wap_url = picture_wap_url;
    }

    public Long getWorks() {
        return works;
    }

    public void setWorks(Long works) {
        this.works = works;
    }

    public Long getFsAmount() {
        return fsAmount;
    }

    public void setFsAmount(Long fsAmount) {
        this.fsAmount = fsAmount;
    }

    public Long getMasters() {
        return masters;
    }

    public void setMasters(Long masters) {
        this.masters = masters;
    }
}
