package com.ming800.core.p.model;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 12-11-29
 * Time: 下午4:27
 * To change this template use File | Settings | File Templates.
 */
public class Notify {

    private Integer theType;    //检测密码是否更改，许可是否合法。。。 checkPassword    checkLicense
    private String note1;  //通知内容
    private String url1;    //通知的处理页面， 比如修改密码的页面，比如许可页面。

    public Integer getTheType() {
        return theType;
    }

    public void setTheType(Integer theType) {
        this.theType = theType;
    }

    public String getNote1() {
        return note1;
    }

    public void setNote1(String note1) {
        this.note1 = note1;
    }

    public String getUrl1() {
        return url1;
    }

    public void setUrl1(String url1) {
        this.url1 = url1;
    }
}
