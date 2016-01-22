package com.efeiyi.ec.project.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Where;

import javax.persistence.*;
import java.util.List;

/**
 * Created by Administrator on 2015/6/24.
 */
@Entity
@Table(name="project_property")
@JsonIgnoreProperties(value = {"hibernateLazyInitializer", "handler"})
public class ProjectProperty {
    private String id;
    private String name;//属性
    private Project project;//项目
    private String sort;//排序
    private String status;//状态
    private List<ProjectPropertyValue> projectPropertyValueList;//属性值

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name="project_id")
    public Project getProject() {
        return project;
    }

    public void setProject(Project project) {
        this.project = project;
    }

    @Column(name="name")
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Column(name="sort")
    public String getSort() {
        return sort;
    }

    public void setSort(String sort) {
        this.sort = sort;
    }

    @Column(name="status")
    @Where(clause = "status=1")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Id
    @GenericGenerator(name = "id", strategy = "com.ming800.core.p.model.M8idGenerator")
    @GeneratedValue(generator = "id")
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @OneToMany(fetch = FetchType.LAZY,mappedBy = "projectProperty")
    public List<ProjectPropertyValue> getProjectPropertyValueList() {
        return projectPropertyValueList;
    }

    public void setProjectPropertyValueList(List<ProjectPropertyValue> projectPropertyValueList) {
        this.projectPropertyValueList = projectPropertyValueList;
    }

    @Override
    public String toString() {
        return "ProjectProperty{id = " + id + "}";
    }
}
