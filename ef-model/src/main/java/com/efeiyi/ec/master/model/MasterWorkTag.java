package com.efeiyi.ec.master.model;

import com.efeiyi.ec.project.model.ProjectTag;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;

/**
 * Created by Administrator on 2015/6/26.
 */
@Entity
@Table(name = "master_work_tag")
public class MasterWorkTag {
    private String id;
    private MasterWork masterWork;
    private ProjectTag projectTag;
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
    @JoinColumn(name = "master_work_id")
    public MasterWork getMasterWork() {
        return masterWork;
    }

    public void setMasterWork(MasterWork masterWork) {
        this.masterWork = masterWork;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "project_tag_id")
    public ProjectTag getProjectTag() {
        return projectTag;
    }

    public void setProjectTag(ProjectTag projectTag) {
        this.projectTag = projectTag;
    }

    @Column(name = "status")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString(){
        return  "MasterWorkTag{id = "+id+"}";
    }
}
