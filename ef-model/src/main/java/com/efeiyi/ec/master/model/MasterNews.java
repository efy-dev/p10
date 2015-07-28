package com.efeiyi.ec.master.model;

import com.efeiyi.ec.organization.model.User;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

/**
 * Created by Administrator on 2015/6/24.
 */
@Entity
@Table(name="master_news")
public class MasterNews {
    private String id;
    private String title;
    private Date createDateTime;
    private User creator;
    private String content;
    private Master master;
    private String status;
    private String dataSource; //来源
    private List<MasterNewsTag> masterNewsTagList;
    private List<MasterAttachment> masterAttachmentList;//附件
    @Id
    @GenericGenerator(name = "id", strategy = "com.ming800.core.p.model.M8idGenerator")
    @GeneratedValue(generator = "id")
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @Column(name="title")
    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    @Column(name="create_datetime")
    public Date getCreateDateTime() {
        return createDateTime;
    }

    public void setCreateDateTime(Date createDateTime) {
        this.createDateTime = createDateTime;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name="user_id")
    public User getCreator() {
        return creator;
    }

    public void setCreator(User creator) {
        this.creator = creator;
    }

    @Column(name="content")
    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "tenant_id")
    public Master getMaster() {
        return master;
    }

    public void setMaster(Master master) {
        this.master = master;
    }

    @Column(name = "status")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Column(name = "data_source")
    public String getDataSource() {
        return dataSource;
    }

    public void setDataSource(String dataSource) {
        this.dataSource = dataSource;
    }

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "masterNews")
    public List<MasterNewsTag> getMasterNewsTagList() {
        return masterNewsTagList;
    }

    public void setMasterNewsTagList(List<MasterNewsTag> masterNewsTagList) {
        this.masterNewsTagList = masterNewsTagList;
    }

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "masterNews")
    public List<MasterAttachment> getMasterAttachmentList() {
        return masterAttachmentList;
    }

    public void setMasterAttachmentList(List<MasterAttachment> masterAttachmentList) {
        this.masterAttachmentList = masterAttachmentList;
    }
}
