package com.efeiyi.ec.website.organization.model;

import java.io.IOException;
import java.util.HashMap;

/**
 * Created with IntelliJ IDEA.
 * User: ming
 * Date: 12-12-11
 * Time: 下午12:19
 * To change this template use File | Settings | File Templates.
 */
public interface SmsProvider {

    /**
     * 发送短信
     *
     * @param phone
     * @param content
     * @return
     */
    SendCode post(String phone, String content, String tpl_id);

    /**
     * 发送短信
     *
     * @param phone
     * @param param
     * @return
     */
    SendCode post(String phone, HashMap<String,String> param, String tpl_id);

    String checkAmount() throws IOException;

}
