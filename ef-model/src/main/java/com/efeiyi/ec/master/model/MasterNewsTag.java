package com.efeiyi.ec.master.model;

import com.ming800.core.p.model.Tag;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;

/**
 * Created by Administrator on 2015/6/26.
 */
@Entity
@Table(name = "master_news_tag")
public class MasterNewsTag {
    private String id;
    private MasterNews masterNews;
    private Tag wordValue;
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

    @JoinColumn(name = "master_news_id")
    @ManyToOne(fetch = FetchType.LAZY)
    public MasterNews getMasterNews() {
        return masterNews;
    }

    public void setMasterNews(MasterNews masterNews) {
        this.masterNews = masterNews;
    }

    @JoinColumn(name = "base_word_value_id")
    @ManyToOne(fetch = FetchType.LAZY)
    public Tag getWordValue() {
        return wordValue;
    }

    public void setWordValue(Tag wordValue) {
        this.wordValue = wordValue;
    }

    @Column(name = "status")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString(){
        return  "MasterNewsTag{id = "+id+"}";
    }
}
