package com.ming800.core.p.model;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;

/**
 * Created with IntelliJ IDEA.
 * User: ming
 * Date: 12-11-8
 * Time: 下午3:08
 * To change this template use File | Settings | File Templates.
 */
@Entity
@Table(name = "core_p_auto_serial")
public class AutoSerial {

    private String id;
    private Long serial;
    private String model;
    private String group;

    @Id
    @GenericGenerator(name = "id", strategy = "com.ming800.core.p.model.M8idGenerator")
    @GeneratedValue(generator = "id")
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @Column(name = "serial")
    public Long getSerial() {
        return serial;
    }

    public void setSerial(Long serial) {
        this.serial = serial;
    }

    @Column(name = "model")
    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }
    @Column(name = "groupName")
    public String getGroup() {return group;}

    public void setGroup(String group) {this.group = group;}
}
