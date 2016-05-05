package com.efeiyi.ec.wiki.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;

/**
 * Created by Administrator on 2016/4/29 0029.
 */


@Entity
@Table(name = "base_recommended")
@JsonIgnoreProperties(value = {"hibernateLazyInitializer", "handler"})
public class ArtistryRecommend {


    private String id;
    private String groupName;
    private Artistry artistry;
    private Integer sort;
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

    @Column(name = "group_name")
    public String getGroupName() {
        return groupName;
    }

    public void setGroupName(String groupName) {
        this.groupName = groupName;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "recommend_id")
    public Artistry getArtistry() {
        return artistry;
    }

    public void setArtistry(Artistry artistry) {
        this.artistry = artistry;
    }

    @Column(name = "sort")
    public Integer getSort() {
        return sort;
    }

    public void setSort(Integer sort) {
        this.sort = sort;
    }

    @Column(name = "status")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

}
