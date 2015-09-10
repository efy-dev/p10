package com.efeiyi.ec.wiki.model;

import com.efeiyi.ec.organization.model.AddressCity;
import com.efeiyi.ec.organization.model.BigUser;
import com.efeiyi.ec.project.model.Project;
import com.efeiyi.ec.project.model.ProjectCategory;
import com.efeiyi.ec.master.model.Master;
import com.fasterxml.jackson.annotation.JsonIgnore;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.util.Date;

/**
 * Created by Administrator on 2015/6/24.
 */
@Entity
@Table(name="wiki_project_content")
public class ProjectContent {
    private String id;
    private String content;
    private ProjectCategory category;
    private Master creator;
    private Date createDatetime;
    private String type;
    private Project project;
    private AddressCity city;


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
    @OneToOne(fetch = FetchType.LAZY,optional = false)
    @JoinColumn(name="project_id")
    @JsonIgnore
    public Project getProject() {return project;}

    public void setProject(Project project) {this.project = project;}
    @ManyToOne(fetch = FetchType.LAZY,optional = true)
    @JoinColumn(name="city_id")
    public AddressCity getCity() {
        return city;
    }

    public void setCity(AddressCity city) {
        this.city = city;
    }
}
