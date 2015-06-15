package com.ming800.core.does.model;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-1-6
 * Time: 下午5:21
 * To change this template use File | Settings | File Templates.
 */
public class GroupType {
    private String name;
    private List<GroupTypeEntity> groupTypeEntityList;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public List<GroupTypeEntity> getGroupTypeEntityList() {
        return groupTypeEntityList;
    }

    public void setGroupTypeEntityList(List<GroupTypeEntity> groupTypeEntityList) {
        this.groupTypeEntityList = groupTypeEntityList;
    }
}
