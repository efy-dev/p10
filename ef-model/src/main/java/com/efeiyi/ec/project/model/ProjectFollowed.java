package com.efeiyi.ec.project.model;

import com.efeiyi.ec.organization.model.Consumer;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Where;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

/**
 * Created by Administrator on 2015/9/9.
 *
 */
@Entity
@Table(name="projectFollowed")
@JsonIgnoreProperties(value = {"hibernateLazyInitializer", "handler"})
public class ProjectFollowed implements Serializable {
    private String id;
    private Project project;
    private Consumer user;
    private String status;
    private Date createDatetime;
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
    @JoinColumn(name = "project_id")
    public Project getProject() {
        return project;
    }

    public void setProject(Project project) {
        this.project = project;
    }
    @Column(name="status")
    @Where(clause = "status=1")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "consumer_id")
    public Consumer getUser() {
        return user;
    }

    public void setUser(Consumer user) {
        this.user = user;
    }
    @Column(name="createDatetime")
    public Date getCreateDatetime() {
        return createDatetime;
    }

    public void setCreateDatetime(Date createDatetime) {
        this.createDatetime = createDatetime;
    }
}
