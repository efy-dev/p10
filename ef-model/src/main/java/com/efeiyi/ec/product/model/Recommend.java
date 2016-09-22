package com.efeiyi.ec.product.model;

import com.efeiyi.ec.organization.model.Image;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.util.Date;

/**
 * Created by Administrator on 2016/9/5 0005.
 * 手动推荐，可以自动生成推荐，也可以自定义推荐，可以编辑自动生成的推荐 （最新）
 * 如果以后支持了系统推荐，这个类就没用了
 */
@Entity
@Table(name = "recommend")
public class Recommend {

    public static final String GROUP_GARDEN_HOME = "001";  //园区导览的首页推荐分组

    private String id;
    private Image image;        //图片
    private String title;       //标题
    private String shortText;   //简介
    private String type;        //类型
    private String status;      //状态
    private String redirect;    //跳转链接
    private Date createDatetime;//创建时间
    private String group;       //分组

    @Id
    @GenericGenerator(name = "id", strategy = "com.ming800.core.p.model.M8idGenerator")
    @GeneratedValue(generator = "id")
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "image_id")
    public Image getImage() {
        return image;
    }

    public void setImage(Image image) {
        this.image = image;
    }

    @Column(name = "title")
    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    @Column(name = "short_text")
    public String getShortText() {
        return shortText;
    }

    public void setShortText(String shortText) {
        this.shortText = shortText;
    }

    @Column(name = "type")
    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    @Column(name = "status")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Column(name = "redirect")
    public String getRedirect() {
        return redirect;
    }

    public void setRedirect(String redirect) {
        this.redirect = redirect;
    }

    @Column(name = "create_datetime")
    public Date getCreateDatetime() {
        return createDatetime;
    }

    public void setCreateDatetime(Date createDatetime) {
        this.createDatetime = createDatetime;
    }

    @Column(name = "recommend_group")
    public String getGroup() {
        return group;
    }

    public void setGroup(String group) {
        this.group = group;
    }
}
