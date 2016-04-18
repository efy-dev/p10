package com.efeiyi.ec.wiki.model;

import com.efeiyi.ec.project.model.Project;
import com.fasterxml.jackson.annotation.JsonIgnore;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

/**
 * Created by Administrator on 2016/4/18.
 */
@Entity

@Table(name = "wiki_art_project")
public class ProjectWiki {
    private String id ;
    private String status;
    private Date createDatetime;
    private String type;
    private Project project;
    private ProjectDescription projectDescription;
    private List<ProjectPicture> projectPictureList;
    @Id
    @GenericGenerator(name = "id", strategy = "com.ming800.core.p.model.M8idGenerator")
    @GeneratedValue(generator = "id")
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }
    @Column(name="create_datetime")
    public Date getCreateDatetime() {
        return createDatetime;
    }

    public void setCreateDatetime(Date createDatetime) {
        this.createDatetime = createDatetime;
    }
    @Column(name = "status")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    @Column(name = "type")
    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    @OneToOne(fetch = FetchType.LAZY,optional = false)
    @JoinColumn(name="project_id")
    @JsonIgnore
    public Project getProject() {
        return project;
    }

    public void setProject(Project project) {
        this.project = project;
    }
    @OneToOne(fetch = FetchType.LAZY,optional = false)
    @JoinColumn(name="wiki_project_description_id")
    @JsonIgnore
    public ProjectDescription getProjectDescription() {
        return projectDescription;
    }

    public void setProjectDescription(ProjectDescription projectDescription) {
        this.projectDescription = projectDescription;
    }
    @JsonIgnore
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "projectWiki")
    public List<ProjectPicture> getProjectPictureList() {
        return projectPictureList;
    }

    public void setProjectPictureList(List<ProjectPicture> projectPictureList) {
        this.projectPictureList = projectPictureList;
    }
}
