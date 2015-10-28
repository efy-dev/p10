package com.ming800.core.p.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import org.hibernate.annotations.GenericGenerator;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.util.Date;
import java.util.List;



@Entity
@Table(name = "base_document")
@Inheritance(strategy=InheritanceType.JOINED)
public class Document {

    private String id;
    private String title;
    private String name;
    private String keywords;
    private DocumentContent documentContent;
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date theDatetime;
    private Integer documentOrder;
    private String group;
    private String status;
    private String sampleContent;
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date publishDate;
    private List<DocumentAttachment> documentAttachmentList;
    private List<DocumentPicture> documentPictureList;


    @Id
    @GenericGenerator(name = "id", strategy = "com.ming800.core.p.model.M8idGenerator")
    @GeneratedValue(generator = "id")
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @Column(name = "title")
    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    @Column(name = "name")
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Column(name = "keywords")
    public String getKeywords() {
        return keywords;
    }

    public void setKeywords(String keywords) {
        this.keywords = keywords;
    }

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "document_content_id")
    public DocumentContent getDocumentContent() {
        return documentContent;
    }

    public void setDocumentContent(DocumentContent documentContent) {
        this.documentContent = documentContent;
    }

    @Column(name = "the_date_time")
    public Date getTheDatetime() {
        return theDatetime;
    }

    public void setTheDatetime(Date theDatetime) {
        this.theDatetime = theDatetime;
    }

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "document", cascade = CascadeType.ALL)
    public List<DocumentAttachment> getDocumentAttachmentList() {
        return documentAttachmentList;
    }

    public void setDocumentAttachmentList(List<DocumentAttachment> documentAttachmentList) {
        this.documentAttachmentList = documentAttachmentList;
    }

    @Column(name = "document_order")
    public Integer getDocumentOrder() {
        return documentOrder;
    }

    public void setDocumentOrder(Integer documentOrder) {
        this.documentOrder = documentOrder;
    }

    @Column(name = "group_name")
    public String getGroup() {
        return group;
    }

    public void setGroup(String group) {
        this.group = group;
    }

    @Column(name="status")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }




    @Column(name= "sample_content")
    public String getSampleContent() {
        return sampleContent;
    }

    public void setSampleContent(String sampleContent) {
        this.sampleContent = sampleContent;
    }
    @Column(name="publish_date")
    public Date getPublishDate() {
        return publishDate;
    }

    public void setPublishDate(Date publishDate) {
        this.publishDate = publishDate;
    }

    @JsonIgnore
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "document")
    public List<DocumentPicture> getDocumentPictureList() {
        return documentPictureList;
    }

    public void setDocumentPictureList(List<DocumentPicture> documentPictureList) {
        this.documentPictureList = documentPictureList;
    }
}
