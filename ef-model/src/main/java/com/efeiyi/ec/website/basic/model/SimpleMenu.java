package com.efeiyi.ec.website.basic.model;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.util.List;

/**
 * Created by Administrator on 2015/6/16.
 */
@Entity
@Table(name="basic_simple_menu")
public class SimpleMenu {
    private String id;
    private String name;
    private List<SimpleMenuItem> simpleMenuItemList;

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

    @OneToMany(fetch = FetchType.LAZY)
    public List<SimpleMenuItem> getSimpleMenuItemList() {
        return simpleMenuItemList;
    }

    public void setSimpleMenuItemList(List<SimpleMenuItem> simpleMenuItemList) {
        this.simpleMenuItemList = simpleMenuItemList;
    }
}
