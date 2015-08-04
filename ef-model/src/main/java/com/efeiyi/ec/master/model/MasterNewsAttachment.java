package com.efeiyi.ec.master.model;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;

/**
 * Created by AC丶man on 2015/7/17.
 */
@Entity
@Table(name = "master_news_attachment")
public class MasterNewsAttachment {

    private String id ;
    private String url;
    private MasterIntroduction introduction;
    private String status;
    private String title;
    private MasterNews masterNews;//资讯

    @Id
    @GenericGenerator(name = "id", strategy = "com.ming800.core.p.model.M8idGenerator")
    @GeneratedValue(generator = "id")
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @Column(name = "url")
    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "master_introduction_id")
    public MasterIntroduction getIntroduction() {
        return introduction;
    }

    public void setIntroduction(MasterIntroduction introduction) {
        this.introduction = introduction;

    }

    @Column(name = "status")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Column(name = "title")
    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "master_news_id")
    public MasterNews getMasterNews() {
        return masterNews;
    }

    public void setMasterNews(MasterNews masterNews) {
        this.masterNews = masterNews;
    }
}
