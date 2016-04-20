package com.efeiyi.ec.wiki.model;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;

/**
 * Created by Administrator on 2016/4/18.
 */
@Entity
@Table(name = "wiki_artistry_description")
public class ArtistryDescription {
    private String id;
    private String descriptionPC;
    private String descriptionWap;
    @Id
    @GenericGenerator(name = "id", strategy = "com.ming800.core.p.model.M8idGenerator")
    @GeneratedValue(generator = "id")
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }


    @Column(name = "description_pc")
    public String getDescriptionPC() {
        return descriptionPC;
    }

    public void setDescriptionPC(String descriptionPC) {
        this.descriptionPC = descriptionPC;
    }
    @Column(name = "description_wap")
    public String getDescriptionWap() {
        return descriptionWap;
    }

    public void setDescriptionWap(String descriptionWap) {
        this.descriptionWap = descriptionWap;
    }



}
