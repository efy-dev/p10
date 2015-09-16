package com.efeiyi.ec.project.model;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.util.List;

/**
 * Created by Administrator on 2015/9/16 0016.
 */
@Entity
@Table(name = "subject")
public class Subject {

    private String id ;
    private String pictureUrl;
    private SubjectDiscription subjectDiscription;
    private List<SubjectPicture> subjectPictureList;
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

    @Column(name = "picture_url")
    public String getPictureUrl() {
        return pictureUrl;
    }

    public void setPictureUrl(String pictureUrl) {
        this.pictureUrl = pictureUrl;
    }

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "subject_discription_id")
    public SubjectDiscription getSubjectDiscription() {
        return subjectDiscription;
    }

    public void setSubjectDiscription(SubjectDiscription subjectDiscription) {
        this.subjectDiscription = subjectDiscription;
    }

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "subject")
    public List<SubjectPicture> getSubjectPictureList() {
        return subjectPictureList;
    }

    public void setSubjectPictureList(List<SubjectPicture> subjectPictureList) {
        this.subjectPictureList = subjectPictureList;
    }

    @Column(name = "status")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
