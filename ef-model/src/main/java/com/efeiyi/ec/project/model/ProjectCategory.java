package com.efeiyi.ec.project.model;

import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Where;

import javax.persistence.*;

/**
 * Created by Administrator on 2015/7/22.
 * 非遗类别管理
 */
@Entity
@Table(name = "project_category")
public class ProjectCategory {
    private String id;
    private String name;//类别
    private ProjectCategory fatherCategory;//父id
    private String serial;//类别号
    private String status;//状态
    private String level;//级别
    private String type;//1.美术,2.技艺

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

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name="fathercategory_id")
    public ProjectCategory getFatherCategory() {
        return fatherCategory;
    }

    public void setFatherCategory(ProjectCategory fatherCategory) {
        this.fatherCategory = fatherCategory;
    }
}

