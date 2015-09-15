package com.efeiyi.ec.wiki.model;

import com.efeiyi.ec.organization.model.AddressCity;
import com.efeiyi.ec.organization.model.BigUser;
import com.efeiyi.ec.organization.model.Consumer;
import com.efeiyi.ec.project.model.Project;
import com.efeiyi.ec.project.model.ProjectCategory;
import com.efeiyi.ec.master.model.Master;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

/**
 * Created by Administrator on 2015/6/24.
 */
@Entity
@Table(name="wiki_project_content")
@JsonIgnoreProperties(value = {"hibernateLazyInitializer", "handler"})
public class ProjectContent {
    private String id;
    private String content;
    private ProjectCategory category;
    private Master creator;
    private Date createDatetime;
    private String type;
    private Project project;
    //private List<Consumer> consumer;



    @Id
    @GenericGenerator(name = "id", strategy = "com.ming800.core.p.model.M8idGenerator")
    @GeneratedValue(generator = "id")
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @Column(name="content")
    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name="category_id")
    public ProjectCategory getCategory() {
        return category;
    }

    public void setCategory(ProjectCategory category) {
        this.category = category;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name="creator")
    public Master getCreator() {
        return creator;
    }

    public void setCreator(Master creator) {
        this.creator = creator;
    }

    @Column(name="create_datetime")
    public Date getCreateDatetime() {
        return createDatetime;
    }

    public void setCreateDatetime(Date createDatetime) {
        this.createDatetime = createDatetime;
    }
    @Column(name="type")
    public String getType() { return type; }

    public void setType(String type) { this.type = type; }
    @ManyToOne(fetch = FetchType.LAZY,optional = false)
    @JoinColumn(name="project_id")
    @JsonIgnore
    public Project getProject() {return project;}

    public void setProject(Project project) {this.project = project;}

  /*  @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(name = "wiki_projectContent_consumer",
            joinColumns = { @JoinColumn(name = "projectContent_id") },
            inverseJoinColumns = { @JoinColumn(name = "consumer_id") }
    )
    public List<Consumer> getConsumer() {
        return consumer;
    }

    public void setConsumer(List<Consumer> consumer) {
        this.consumer = consumer;
    }*/

}
