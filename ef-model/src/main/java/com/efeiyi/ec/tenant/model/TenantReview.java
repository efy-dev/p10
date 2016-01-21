package com.efeiyi.ec.tenant.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;
import java.util.List;


/**
 * Created by IntelliJ IDEA.
 * User: ming
 * Date: 12-10-15
 * Time: 上午11:06
 * To change this template use File | Settings | File Templates.
 */

@Entity
@Table(name = "tenant_review")
@JsonIgnoreProperties(value = {"hibernateLazyInitializer", "handler"})
public class TenantReview implements Serializable {

    private String id;
    private String content; // 审核意见
    private Date createDateTime;//审核时间
    private String review;//审核状态 3：审核失败 4：审核成功
    private BigTenant tenant;//审核的商户

    @Id
    @GenericGenerator(name = "id", strategy = "com.ming800.core.p.model.M8idGenerator")
    @GeneratedValue(generator = "id")
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @Column(name = "content")
    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    @Column(name = "create_datetime")
    public Date getCreateDateTime() {
        return createDateTime;
    }

    public void setCreateDateTime(Date createDateTime) {
        this.createDateTime = createDateTime;
    }

    @Column(name = "review_status")
    public String getReview() {
        return review;
    }

    public void setReview(String review) {
        this.review = review;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "tenant_id")
    public BigTenant getTenant() {
        return tenant;
    }

    public void setTenant(BigTenant tenant) {
        this.tenant = tenant;
    }

    @Override
    public String toString() {
        return "TenantReview{id = " + id + "}";
    }
}
