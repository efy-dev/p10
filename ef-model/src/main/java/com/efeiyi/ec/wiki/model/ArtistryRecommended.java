package com.efeiyi.ec.wiki.model;

import com.efeiyi.ec.project.model.Project;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Where;

import javax.persistence.*;
import java.io.Serializable;

/**
 * Created by Administrator on 2016/4/29.
 */
@Entity
@Table(name = "base_recommended")
@JsonIgnoreProperties(value = {"hibernateLazyInitializer", "handler"})
public class ArtistryRecommended implements Serializable {

    private String id;
    private Artistry artistry;
    private Integer sort;
    private String status;
    private String groupName;


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

    @Column(name = "group_name")
    @Where(clause = "group_name = wiki.artistryRecommend")
    public String getGroupName() {
        return groupName;
    }

    public void setGroupName(String groupName) {
        this.groupName = groupName;
    }

    @Override
    public String toString() {
        return "ArtistryRecommended{id = " + id + "}";
    }
}
