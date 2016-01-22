package com.efeiyi.ec.master.model;

import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Where;

import javax.persistence.*;
import java.util.List;

/**
 * Created by Administrator on 2015/6/24.
 */
@Entity
@Table(name="master_introduction")
public class MasterIntroduction {
    private String id;
    private Master master;
    private String type;
    private String title;
    private String status;
    private String content;
    private List<MasterIntroductionAttachment> attachmentList;


    @Id
    @GenericGenerator(name = "id", strategy = "com.ming800.core.p.model.M8idGenerator")
    @GeneratedValue(generator = "id")
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name = "master_id")
    public Master getMaster() {
        return master;
    }

    public void setMaster(Master master) {
        this.master = master;
    }

    @Column(name="type")
    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    @Column(name="title")
    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    @Column(name = "status")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Column(name = "content")
    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "introduction")
    @Where( clause = "status=1")
    public List<MasterIntroductionAttachment> getAttachmentList() {
        return attachmentList;
    }

    public void setAttachmentList(List<MasterIntroductionAttachment> attachmentList) {
        this.attachmentList = attachmentList;
    }
    @Override
    public String toString(){
        return  "MasterIntroduction{id = "+id+"}";
    }
}
