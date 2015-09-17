package com.efeiyi.ec.product.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
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
    private String name;
    private SubjectDescription subjectDescription;
    private Integer subjectIndex;
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

    @Column(name = "subject_index")
    public Integer getSubjectIndex() {
        return subjectIndex;
    }

    public void setSubjectIndex(Integer subjectIndex) {
        this.subjectIndex = subjectIndex;
    }

    @Column(name = "picture_url")
    public String getPictureUrl() {
        return pictureUrl;
    }

    public void setPictureUrl(String pictureUrl) {
        this.pictureUrl = pictureUrl;
    }

    @Column(name="name")
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "subject_discription_id")
    public SubjectDescription getSubjectDescription() {
        return subjectDescription;
    }

    public void setSubjectDescription(SubjectDescription subjectDescription) {
        this.subjectDescription = subjectDescription;
    }

    @JsonIgnore
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
