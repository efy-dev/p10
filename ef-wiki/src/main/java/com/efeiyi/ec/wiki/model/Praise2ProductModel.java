package com.efeiyi.ec.wiki.model;

import com.efeiyi.ec.organization.model.MyUser;
import java.io.Serializable;
import java.util.Date;

/**
 * Created by Administrator on 2015/10/23.
 */
public class Praise2ProductModel implements Serializable {
    private String id;
    private String product;
    private MyUser user;
    private ProductComment comment;
    private String type;
    private Date createDateTime;
    private String status;
    private MyUser moderator;
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

    public MyUser getUser() {
        return user;
    }

    public void setUser(MyUser user) {
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
