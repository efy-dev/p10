package com.efeiyi.ec.art.organization.model;

import java.io.IOException;

/**
 * Created with IntelliJ IDEA.
 * User: ming
 * Date: 12-12-11
 * Time: 下午12:19
 * To change this template use File | Settings | File Templates.
 */
public interface SmsProvider {

    public final Integer SUCCESS = 0;//成功
    public final Integer FAILED = 1; //发送失败
    public final Integer LOSSDATA = 3; //数据丢失
    public final Integer ILLEGAL = 4; //手机号码不合法
    public final Integer UNKNOWN = 5; //未知错误
    public final Integer NORESULTS = 6; //无返回结果

    /**
     * 发送短信
     *
     * @param phone
     * @param content
     * @return
     */
    public SendCode post(String phone, String content, String tpl_id);

    public String checkAmount() throws IOException;

}
