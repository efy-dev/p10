package com.efeiyi.ec.website.organization.service;


import java.util.HashMap;

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
     * @param phone 手机号
     * @param content #key#=value&#key2#=value2
     * @param tpl_id 云片模版的Id
     * @param company 1
     * @return
     */
    String send(String phone, String content, String tpl_id, Integer company);

    String send(String phone, HashMap<String,String> param, String tpl_id);


}
