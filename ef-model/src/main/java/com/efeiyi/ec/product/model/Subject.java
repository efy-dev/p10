package com.efeiyi.ec.product.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.util.Date;
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
    private List<SubjectProduct> subjectProductList;
    private String status;
    private String template;//1 普通 2 活动
    private String type;//类别
    private String subjectShow;//1 上架 0  下架
    private Date startDateTime;
    private Date endDateTime;
    private Date createDateTime;

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

    @JsonIgnore
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "product")
    public List<SubjectProduct> getSubjectProductList() {
        return subjectProductList;
    }

    public void setSubjectProductList(List<SubjectProduct> subjectProductList) {
        this.subjectProductList = subjectProductList;
    }

    @Column(name = "template")
    public String getTemplate() {
        return template;
    }

    public void setTemplate(String template) {
        this.template = template;
    }

    @Column(name = "type")
    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }
    @Column(name = "subject_show")
    public String getSubjectShow() {
        return subjectShow;
    }

    public void setSubjectShow(String subjectShow) {
        this.subjectShow = subjectShow;
    }

    @Column(name = "start_datetime")
    public Date getStartDateTime() {
        return startDateTime;
    }

    public void setStartDateTime(Date startDateTime) {
        this.startDateTime = startDateTime;
    }

    @Column(name = "end_datetime")
    public Date getEndDateTime() {
        return endDateTime;
    }

    public void setEndDateTime(Date endDateTime) {
        this.endDateTime = endDateTime;
    }

    @Column(name = "create_datetime")
    public Date getCreateDateTime() {
        return createDateTime;
    }

    public void setCreateDateTime(Date createDateTime) {
        this.createDateTime = createDateTime;
    }

    @Override
    public String toString() {
        return "Subject{id = " + id + "}";
    }
}
