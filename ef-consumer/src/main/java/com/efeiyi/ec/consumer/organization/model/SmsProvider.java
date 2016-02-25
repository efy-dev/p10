package com.efeiyi.ec.consumer.organization.model;

import java.util.Map;

/**
 * Created with IntelliJ IDEA.
 * User: ming
 * Date: 12-12-11
 * Time: 下午12:19
 * To change this template use File | Settings | File Templates.
 */
public interface SmsProvider {
    /**
     *
     * @param phone 发送短信的手机号
     * @param param 所发短信内容 #key#=value&#key2#=value2
     * @param templateMap 模板所用的参数
     * @return
     */
    SendCode post(String phone, Map<String, String> param, Map<String, String> templateMap);

}
