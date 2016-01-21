package com.efeiyi.ec.project.model;

import com.efeiyi.ec.product.model.Product;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.io.Serializable;

/**
 * Created by Administrator on 2015/7/23.
 */
@Entity
@Table(name = "base_recommended")
@JsonIgnoreProperties(value = {"hibernateLazyInitializer", "handler"})
public class ProjectCategoryRecommended implements Serializable{
    private String id;
    private ProjectCategory projectCategory;
    private String sort;
    private String status;
    private String group;


    @Id
    @GenericGenerator(name = "id", strategy = "com.ming800.core.p.model.M8idGenerator")
    @GeneratedValue(generator = "id")
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }


    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "recommend_id")
    public ProjectCategory getProjectCategory() {
        return projectCategory;
    }

    public void setProjectCategory(ProjectCategory projectCategory) {
        this.projectCategory = projectCategory;
    }

    @Column(name = "sort")
    public String getSort() {
        return sort;
    }

    public void setSort(String sort) {
        this.sort = sort;
    }

    @Column(name = "status")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Column(name = "group_name")
    public String getGroup() {
        return group;
    }

    public void setGroup(String group) {
        this.group = group;
    }

    @Override
    public String toString() {
        return "ProjectCategoryRecommended{id = " + id + "}";
    }
}
