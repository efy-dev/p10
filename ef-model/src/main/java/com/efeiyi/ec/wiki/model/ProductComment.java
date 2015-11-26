package com.efeiyi.ec.wiki.model;

import com.efeiyi.ec.organization.model.MyUser;
import com.efeiyi.ec.organization.model.User;
import com.efeiyi.ec.product.model.Product;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * Created by Administrator on 2015/9/25.
 *
 */
@Entity
@Table(name = "wiki_Product_comment")
@JsonIgnoreProperties(value = {"hibernateLazyInitializer", "handler"})
public class ProductComment implements Serializable {

    private String id ;
    private String status;
    private String content;
    private Product product;
    private ProductComment fatherComment;
    private List<ProductComment> subComment;
    private Date createDateTime;
    private User user;
    private List<ProductPraise> praise;
    private Long amount;
    private User moderator;
    private String watch;
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

    @Column(name = "content")
    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }


    @JsonIgnore
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_id")
    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }


    @Column(name = "create_datetime")
    public Date getCreateDateTime() {
        return createDateTime;
    }

    public void setCreateDateTime(Date createDateTime) {
        this.createDateTime = createDateTime;
    }


    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
    @JsonIgnore
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "father_comment_id")
    public ProductComment getFatherComment() {
        return fatherComment;
    }

    public void setFatherComment(ProductComment fatherComment) {
        this.fatherComment = fatherComment;
    }
    @JsonIgnore
    @OneToMany(fetch = FetchType.LAZY,mappedBy = "fatherComment", cascade = CascadeType.ALL)
    public List<ProductComment> getSubComment() {
        return subComment;
    }

    public void setSubComment(List<ProductComment> subComment) {
        this.subComment = subComment;
    }

    @JsonIgnore
    @OneToMany(fetch = FetchType.LAZY,mappedBy = "comment", cascade = CascadeType.ALL)
    public List<ProductPraise> getPraise() {
        return praise;
    }

    public void setPraise(List<ProductPraise> praise) {
        this.praise = praise;
    }

    @Column(name = "praise_number")
    public Long getAmount() {
        return amount;
    }

    public void setAmount(Long amount) {
        this.amount = amount;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "moderator_id")
    public User getModerator() {
        return moderator;
    }

    public void setModerator(User moderator) {
        this.moderator = moderator;
    }
    @Column(name = "watch")

    public String getWatch() {
        return watch;
    }

    public void setWatch(String watch) {
        this.watch = watch;
    }
}
