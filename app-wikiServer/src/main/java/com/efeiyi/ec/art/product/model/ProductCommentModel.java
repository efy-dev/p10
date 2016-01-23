package com.efeiyi.ec.art.product.model;

import com.efeiyi.ec.organization.model.User;
import com.efeiyi.ec.art.model.ProductComment;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * Created by Administrator on 2015/10/23.
 *
 */
public class ProductCommentModel implements Serializable {
    private String id ;
    private String status;
    private String content;
    private String product;
    private ProductComment fatherComment;
    private List<ProductComment> subComment;
    private Date createDateTime;
    private User user;
    private User moderator;
    private String watch;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getProduct() {
        return product;
    }

    public void setProduct(String product) {
        this.product = product;
    }

    public ProductComment getFatherComment() {
        return fatherComment;
    }

    public void setFatherComment(ProductComment fatherComment) {
        this.fatherComment = fatherComment;
    }

    public List<ProductComment> getSubComment() {
        return subComment;
    }

    public void setSubComment(List<ProductComment> subComment) {
        this.subComment = subComment;
    }

    public Date getCreateDateTime() {
        return createDateTime;
    }

    public void setCreateDateTime(Date createDateTime) {
        this.createDateTime = createDateTime;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public User getModerator() {
        return moderator;
    }

    public void setModerator(User moderator) {
        this.moderator = moderator;
    }

    public String getWatch() {
        return watch;
    }

    public void setWatch(String watch) {
        this.watch = watch;
    }
}
