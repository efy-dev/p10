package com.efeiyi.ec.consumer.organization.service;

import java.util.Map;


/**
 * Created with IntelliJ IDEA.
 * User: ming
 * Date: 12-12-11
 * Time: 下午12:19
 * To change this template use File | Settings | File Templates.
 */
public interface SmsCheckManager {

    /**
     *
     * @param phone 发送短信的手机号
     * @param param 短信内容匹配 #key#=value&#key2#=value2
     * @param templateMap 短信模板所需参数
     * @return
     */
    String send(String phone, Map<String, String> param, Map<String, String> templateMap);

}
