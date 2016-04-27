package com.efeiyi.ec.wiki.model;

import com.efeiyi.ec.project.model.Project;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

/**
 * Created by Administrator on 2016/4/18.
 */
@Entity
@JsonIgnoreProperties(value = {"hibernateLazyInitializer", "handler"})
@Table(name = "wiki_artistry")
public class Artistry {
    private String id ;
    private String status;
    private Date createDatetime;
    private String type;
    private Project project;
    private ArtistryDescription artistryDescription;
    private List<ArtistryPicture> artistryPictureList;


    @Transient
    public ArtistryPicture getMainPicture() {
        List<ArtistryPicture> artistryPictures = getArtistryPictureList();
        for (ArtistryPicture artistryPicture : artistryPictures) {
            if (artistryPicture.getStatus().equals("1")) {
                return artistryPicture;
            }
        }
        return null;
    }

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

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name="project_id")
    @JsonIgnore
    public Project getProject() {
        return project;
    }

    public void setProject(Project project) {
        this.project = project;
    }
    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name="wiki_artistry_description_id")
    @JsonIgnore
    public ArtistryDescription getArtistryDescription() {
        return artistryDescription;
    }

    public void setArtistryDescription(ArtistryDescription artistryDescription) {
        this.artistryDescription = artistryDescription;
    }
    @JsonIgnore
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "artistry")
    public List<ArtistryPicture> getArtistryPictureList() {
        return artistryPictureList;
    }

    public void setArtistryPictureList(List<ArtistryPicture> artistryPictureList) {
        this.artistryPictureList = artistryPictureList;
    }
}
