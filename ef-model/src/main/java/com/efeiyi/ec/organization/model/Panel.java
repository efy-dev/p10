package com.efeiyi.ec.organization.model;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.util.List;

/**
 * Created by Administrator on 2016/9/6 0006.
 */
@Entity
@Table(name = "panel")
public class Panel {

    private String id;
    private List<ImagePanel> imageList;
    private String content;
    private Image media;
    private String owner;
    private String status;
    private String type;

    @Id
    @GenericGenerator(name = "id", strategy = "com.ming800.core.p.model.M8idGenerator")
    @GeneratedValue(generator = "id")
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "panelId")
    public List<ImagePanel> getImageList() {
        return imageList;
    }

    public void setImageList(List<ImagePanel> imageList) {
        this.imageList = imageList;
    }

    @Column(name = "content")
    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "media_id")
    public Image getMedia() {
        return media;
    }

    public void setMedia(Image media) {
        this.media = media;
    }

    @Column(name = "owner_id")
    public String getOwner() {
        return owner;
    }

    public void setOwner(String owner) {
        this.owner = owner;
    }

    @Column(name = "status")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Column(name = "type")
    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }
}
