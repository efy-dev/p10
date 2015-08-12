package com.efeiyi;

import java.util.Date;

/**
 * Created by Administrator on 2015/8/3.
 */
public class LabelRecordResult {

    private Date createDatetime;
    private Date lastCheckDatetime;
    private Long count;
    private String id;

    public Date getCreateDatetime() {
        return createDatetime;
    }

    public void setCreateDatetime(Date createDatetime) {
        this.createDatetime = createDatetime;
    }

    public Long getCount() {
        return count;
    }

    public void setCount(Long count) {
        this.count = count;
    }

    public LabelRecordResult(Date createDatetime,Date lastCheckDatetime, Long count, String id) {
        this.createDatetime = createDatetime;
        this.lastCheckDatetime = lastCheckDatetime;
        this.count = count;
        this.id = id;
    }

    public LabelRecordResult() {
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public Date getLastCheckDatetime() {
        return lastCheckDatetime;
    }

    public void setLastCheckDatetime(Date lastCheckDatetime) {
        this.lastCheckDatetime = lastCheckDatetime;
    }
}
