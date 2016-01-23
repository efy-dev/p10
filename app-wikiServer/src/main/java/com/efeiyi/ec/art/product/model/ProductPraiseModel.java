package com.efeiyi.ec.art.product.model;

import com.efeiyi.ec.organization.model.User;
import com.efeiyi.ec.art.model.ProductComment;

import java.io.Serializable;
import java.util.Date;

/**
 * Created by Administrator on 2015/10/23.
 */
public class ProductPraiseModel implements Serializable {
    private String id;
    private String product;
    private User user;
    private ProductComment comment;
    private String type;
    private Date createDateTime;
    private String status;
    private User moderator;
    private String watch;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getProduct() {
        return product;
    }

    public void setProduct(String product) {
        this.product = product;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public ProductComment getComment() {
        return comment;
    }

    public void setComment(ProductComment comment) {
        this.comment = comment;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public Date getCreateDateTime() {
        return createDateTime;
    }

    public void setCreateDateTime(Date createDateTime) {
        this.createDateTime = createDateTime;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
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
