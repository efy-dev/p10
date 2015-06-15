package com.ming800.core.base.model;


import org.hibernate.annotations.GenericGenerator;
import javax.persistence.*;


/**
 * Created with IntelliJ IDEA.
 * User: ming
 * Date: 12-11-10
 * Time: 上午9:59
 * To change this template use File | Settings | File Templates.
 */
@Entity
@Table(name = "core_base_relation")
public class Relation {

    private String id;

    private String entity;
    private String objectId;
    private String entity1;
    private String objectId1;


    @Id
    @GenericGenerator(name = "id", strategy = "com.ming800.core.p.model.M8idGenerator")
    @GeneratedValue(generator = "id")
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @Column(name = "entity_name")
    public String getEntity() {
        return entity;
    }

    public void setEntity(String entity) {
        this.entity = entity;
    }

    @Column(name = "object_id")
    public String getObjectId() {
        return objectId;
    }

    public void setObjectId(String objectId) {
        this.objectId = objectId;
    }

    @Column(name = "entity1_name")
    public String getEntity1() {
        return entity1;
    }

    public void setEntity1(String entity1) {
        this.entity1 = entity1;
    }

    @Column(name = "object1_id")
    public String getObjectId1() {
        return objectId1;
    }

    public void setObjectId1(String objectId1) {
        this.objectId1 = objectId1;
    }
}
