package com.ming800.core.does.model;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: ming
 * Date: 13-1-22
 * Time: 上午9:51
 * To change this template use File | Settings | File Templates.
 */
public class StatusTypeField extends Field {

    private List<StatusType> statusTypeList;

    public List<StatusType> getStatusTypeList() {
        return statusTypeList;
    }

    public void setStatusTypeList(List<StatusType> statusTypeList) {
        this.statusTypeList = statusTypeList;
    }
}
