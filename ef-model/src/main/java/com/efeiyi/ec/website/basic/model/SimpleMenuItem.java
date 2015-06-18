package com.efeiyi.ec.website.basic.model;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;

/**
 * Created by Administrator on 2015/6/16.
 */
@Entity
@Table(name="basic_simple_menu_item")
public class SimpleMenuItem {
    private String id;
    private String name;
    private String label;
    private SimpleMenu simpleMenu;
    private Boolean choosed;
    private String url;

    @Id
    @GenericGenerator(name = "id", strategy = "com.ming800.core.p.model.M8idGenerator")
    @GeneratedValue(generator = "id")
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @Column(name="name")
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Column(name="label")
    public String getLabel() {
        return label;
    }

    public void setLabel(String label) {
        this.label = label;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name="menu_id")
    public SimpleMenu getSimpleMenu() {
        return simpleMenu;
    }

    public void setSimpleMenu(SimpleMenu simpleMenu) {
        this.simpleMenu = simpleMenu;
    }

    @Column(name="ischoosed")
    public Boolean getChoosed() {
        return choosed;
    }

    public void setChoosed(Boolean choosed) {
        this.choosed = choosed;
    }

    @Column(name="url")
    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }
}
