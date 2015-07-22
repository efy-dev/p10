package com.efeiyi.ec.project.model;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;

/**
 * Created by Administrator on 2015/7/22.
 * 项目标签
 */
@Entity
@Table(name = "project_tag")
public class ProjectTag {
    private String id;
    private Project project;//项目
    private String value;//项目标签
    private String order;
    @Id
    @GenericGenerator(name = "id", strategy = "com.ming800.core.p.model.M8idGenerator")
    @GeneratedValue(generator = "id")
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @Column(name = "value")
    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    @Column(name = "order")
    public String getOrder() {
        return order;
    }

    public void setOrder(String order) {
        this.order = order;
    }

    @ManyToOne
    @JoinColumn(name="project_id")
    public Project getProject() {
        return project;
    }

    public void setProject(Project project) {
        this.project = project;
    }



}
