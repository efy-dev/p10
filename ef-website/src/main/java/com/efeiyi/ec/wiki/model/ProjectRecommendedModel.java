package com.efeiyi.ec.wiki.model;

import com.efeiyi.ec.project.model.Project;

import java.io.Serializable;

/**
 * Created by Administrator on 2015/10/21.
 *
 */
public class ProjectRecommendedModel implements Serializable {

    private String id;
    private Project project;
    private Integer sort;
    private String status;
    private String groupName;
    private String attention;

    public String getAttention() {
        return attention;
    }

    public void setAttention(String attention) {
        this.attention = attention;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }




    public Project getProject() {
        return project;
    }

    public void setProject(Project project) {
        this.project = project;
    }


    public Integer getSort() {
        return sort;
    }

    public void setSort(Integer sort) {
        this.sort = sort;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getGroupName() {
        return groupName;
    }

    public void setGroupName(String groupName) {
        this.groupName = groupName;
    }
}