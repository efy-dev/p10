package com.ming800.core.p.model;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.util.Date;
import java.util.List;


@Entity
@Table(name = "basic_word_value")
public class WordValue {

    private String id;
    private  String value;
    private String group;
    private Integer status;


    @Id
    @GenericGenerator(name = "id", strategy = "com.ming800.core.p.model.M8idGenerator")
    @GeneratedValue(generator = "id")
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @Column(name="value")
    public String getValue(){
        return  value;
    }
    public void  setValue(String value){
        this.value = value;
    }


    @Column(name = "group_id")
    public String getGroup() {
        return group;
    }

    public void setGroup(String group) {
        this.group = group;
    }

    @Column(name="status")
    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }




}
