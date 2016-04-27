package com.efeiyi.ec.gift.organization.model;

/**
 * Created by Administrator on 2014/12/29.
 */
public class SendCode {
    private int code;
    private String msg;
    private SendCode result;

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public SendCode getResult() {
        return result;
    }

    public void setResult(SendCode result) {
        this.result = result;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }
}
