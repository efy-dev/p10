package com.ming800.core.base.model;

import com.ming800.core.does.model.Xentity;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-6-5
 * Time: 下午12:06
 * To change this template use File | Settings | File Templates.
 */
public class RelationObject {


    private Xentity xentity;
    private String objectId;
    private String objectName;


    public Xentity getXentity() {
        return xentity;
    }

    public void setXentity(Xentity xentity) {
        this.xentity = xentity;
    }

    public String getObjectId() {
        return objectId;
    }

    public void setObjectId(String objectId) {
        this.objectId = objectId;
    }

    public String getObjectName() {
        return objectName;
    }

    public void setObjectName(String objectName) {
        this.objectName = objectName;
    }
}
