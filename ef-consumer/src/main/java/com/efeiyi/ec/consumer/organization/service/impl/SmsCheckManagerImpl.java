package com.efeiyi.ec.consumer.organization.service.impl;

import com.efeiyi.ec.consumer.organization.model.SendCode;
import com.efeiyi.ec.consumer.organization.model.SmsProvider;
import com.efeiyi.ec.consumer.organization.model.YunPianSmsProvider;
import com.efeiyi.ec.consumer.organization.service.SmsCheckManager;
import com.ming800.core.base.dao.XdoDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.Map;


/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-7-2
 * Time: 下午3:14
 * To change this template use File | Settings | File Templates.
 */
@Service
public class SmsCheckManagerImpl implements SmsCheckManager {

    @Autowired
    private XdoDao basicDao;

    @Override
     public String send(String phone, Map<String,String> param, String tpl_id,String template) {
        SmsProvider smsProvider;
         String msg="";
        switch (template){
            case "yp":
                smsProvider = new YunPianSmsProvider();
                SendCode sendCode = smsProvider.post(phone, param, tpl_id);
                msg=sendCode.getMsg();
                break;
        }

        return msg;


    }
    @Override
    public String send(String phone, Map<String,String> param, Map<String,String>templateMap) {
        SmsProvider smsProvider;
        String template=templateMap.get("template");
        String msg="";
        switch (template){
            case "yp":
                smsProvider = new YunPianSmsProvider();
                SendCode sendCode = smsProvider.post(phone, param, templateMap);
                msg =sendCode.getMsg();
                break;
        }

        return msg;

    }



}
