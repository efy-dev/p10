package com.efeiyi.ec.project.model;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;

/**
 * Created by Administrator on 2015/5/28.
 * 非遗类别管理
 */
@Entity
@Table(name = "project_category")
public class ProjectCategory {
    private String id;
    private String name;//类别
    private String fatherCategoryId;//父id
    private String serial;//类别号
    private String status;//状态
    private String level;//级别

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

    @Column(name="fathercategory_id")
    public String getFatherCategoryId() {
        return fatherCategoryId;
    }
    public void setFatherCategoryId(String fatherCategoryId) {
        this.fatherCategoryId = fatherCategoryId;
    }

    @Column(name="serial")
    public String getSerial() {
        return serial;
    }

    public void setSerial(String serial) {
        this.serial = serial;
    }

    @Column(name="status")
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
}
