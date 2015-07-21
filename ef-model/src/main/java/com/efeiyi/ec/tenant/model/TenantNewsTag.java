package com.efeiyi.ec.tenant.model;

import com.ming800.core.p.model.WordValue;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;

/**
 * Created by Administrator on 2015/6/26.
 */
@Entity
@Table(name = "tenant_news_tag")
public class TenantNewsTag {
    private String id;
    private TenantNews tenantNews;
    private WordValue wordValue;
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

    @JoinColumn(name = "tenant_news_id")
    @ManyToOne(fetch = FetchType.LAZY)
    public TenantNews getTenantNews() {
        return tenantNews;
    }

    public void setTenantNews(TenantNews tenantNews) {
        this.tenantNews = tenantNews;
    }

    @JoinColumn(name = "base_word_value_id")
    @ManyToOne(fetch = FetchType.LAZY)
    public WordValue getWordValue() {
        return wordValue;
    }

    public void setWordValue(WordValue wordValue) {
        this.wordValue = wordValue;
    }

    @Column(name = "status")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
