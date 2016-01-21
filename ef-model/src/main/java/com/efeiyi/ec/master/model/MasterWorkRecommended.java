package com.efeiyi.ec.master.model;

import com.efeiyi.ec.project.model.Project;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Where;

import javax.persistence.*;
import java.io.Serializable;

/**
 * Created by Administrator on 2015/7/17.
 */
@Entity
@Table(name = "master_work_recommended")
public class MasterWorkRecommended implements Serializable {
    private String id;
    private Master master;
    private Project project;
    private MasterWork masterWork;
    private String status;

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
    @JoinColumn(name = "master_id")
    public Master getMaster() {
        return master;
    }

    public void setMaster(Master master) {
        this.master = master;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "project_id")
    public Project getProject() {
        return project;
    }

    public void setProject(Project project) {
        this.project = project;
    }

    @Column(name="status")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "master_work_id")
    @Where(clause = "status = 1")
    public MasterWork getMasterWork() {
        return masterWork;
    }

    public void setMasterWork(MasterWork masterWork) {
        this.masterWork = masterWork;
    }

    @Override
    public String toString(){
        return  "MasterWorkRecommended{id = "+id+"}";
    }
}
