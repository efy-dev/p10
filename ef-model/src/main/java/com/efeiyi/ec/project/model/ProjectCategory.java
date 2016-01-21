package com.efeiyi.ec.project.model;

import com.efeiyi.ec.product.model.Product;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.ming800.core.p.model.ObjectRecommended;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Where;

import javax.persistence.*;
import java.io.Serializable;
import java.util.List;

/**
 * Created by Administrator on 2015/7/22.
 * 非遗类别管理
 */
@Entity
@Table(name = "project_category")
@JsonIgnoreProperties(value = {"hibernateLazyInitializer", "handler"})
public class ProjectCategory implements Serializable{
    private String id;
    private String name;//类别
    private ProjectCategory fatherCategory;//父id
    private String serial;//类别号
    private String status;//状态
    private String level;//级别
    private String type;//1.美术,2.技艺
    private String pictureUrl;
    private String context;//类别简介
    private List<ProjectCategoryRecommended> projectCategoryRecommendeds;

    @Id
    @GenericGenerator(name = "id", strategy = "com.ming800.core.p.model.M8idGenerator")
    @GeneratedValue(generator = "id")
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @Column(name = "name")
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }


    @Column(name="serial")
    public String getSerial() {
        return serial;
    }

    public void setSerial(String serial) {
        this.serial = serial;
    }

    @Column(name="status")
    @Where(clause = "status=1")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Column(name="level")
    public String getLevel() {
        return level;
    }

    public void setLevel(String level) {
        this.level = level;
    }

    @Column(name="type")
    public String getType(){
      return  type;
    }

    public  void  setType(String type){
       this.type = type;
    }

    @JsonIgnore
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name="fathercategory_id")
    public ProjectCategory getFatherCategory() {
        return fatherCategory;
    }

    public void setFatherCategory(ProjectCategory fatherCategory) {
        this.fatherCategory = fatherCategory;
    }

    @JsonIgnore
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "projectCategory", cascade = CascadeType.ALL)
    public List<ProjectCategoryRecommended> getProjectCategoryRecommendeds() {
        return projectCategoryRecommendeds;
    }

    public void setProjectCategoryRecommendeds(List<ProjectCategoryRecommended> projectCategoryRecommendeds) {
        this.projectCategoryRecommendeds = projectCategoryRecommendeds;
    }

    @Column(name = "picture_url")
    public String getPictureUrl() {
        return pictureUrl;
    }

    public void setPictureUrl(String pictureUrl) {
        this.pictureUrl = pictureUrl;
    }

    @Column(name = "context")
    public String getContext() {
        return context;
    }

    public void setContext(String context) {
        this.context = context;
    }

    @Override
    public String toString() {
        return "ProjectCategory{id = " + id + "}";
    }
}

