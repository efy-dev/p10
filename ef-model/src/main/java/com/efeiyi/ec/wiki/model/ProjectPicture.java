package com.efeiyi.ec.wiki.model;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;

/**
 * Created by Administrator on 2016/4/18.
 */
@Entity
@Table(name = "wiki_project_picture")
public class ProjectPicture {
    private String id;
    private String pictureUrl;
    private String status;//1:工艺图片 2工艺详情页的图片
    private ProjectWiki projectWiki;//工艺项目
    private Integer sort;
    @Id
    @GenericGenerator(name = "id", strategy = "com.ming800.core.p.model.M8idGenerator")
    @GeneratedValue(generator = "id")
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }
    @Column(name = "status")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    @Column(name = "picture_url")
    public String getPictureUrl() {
        return pictureUrl;
    }

    public void setPictureUrl(String pictureUrl) {
        this.pictureUrl = pictureUrl;
    }
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "wiki_art_project")
    public ProjectWiki getProjectWiki() {
        return projectWiki;
    }

    public void setProjectWiki(ProjectWiki projectWiki) {
        this.projectWiki = projectWiki;
    }
    @Column(name = "sort")
    public Integer getSort() {
        return sort;
    }

    public void setSort(Integer sort) {
        this.sort = sort;
    }
}
