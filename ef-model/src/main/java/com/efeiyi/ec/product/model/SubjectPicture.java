package com.efeiyi.ec.product.model;

import com.efeiyi.ec.product.model.Subject;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;

/**
 * Created by Administrator on 2015/9/16 0016.
 */
@Entity
@Table(name = "subject_picture")
public class SubjectPicture {

    private String id ;
    private String pictureUrl;
    private Subject subject;

    @Id
    @GenericGenerator(name = "id", strategy = "com.ming800.core.p.model.M8idGenerator")
    @GeneratedValue(generator = "id")
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @Column(name = "picture_url")
    public String getPictureUrl() {
        return pictureUrl;
    }

    public void setPictureUrl(String pictureUrl) {
        this.pictureUrl = pictureUrl;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "subject_id")
    public Subject getSubject() {
        return subject;
    }

    public void setSubject(Subject subject) {
        this.subject = subject;
    }

    @Override
    public String toString() {
        return "SubjectPicture{id = " + id + "}";
    }
}
