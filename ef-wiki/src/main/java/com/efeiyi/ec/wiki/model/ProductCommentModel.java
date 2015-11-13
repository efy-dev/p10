package com.efeiyi.ec.wiki.model;

import com.efeiyi.ec.organization.model.MyUser;
import com.efeiyi.ec.product.model.Product;

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
    private MyUser user;
    private MyUser moderator;
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

    public MyUser getUser() {
        return user;
    }

    public void setUser(MyUser user) {
        this.user = user;
    }

    public MyUser getModerator() {
        return moderator;
    }

    public void setModerator(MyUser moderator) {
        this.moderator = moderator;
    }

    public String getWatch() {
        return watch;
    }

    public void setWatch(String watch) {
        this.watch = watch;
    }
}
