package com.efeiyi.ec.gift.organization.service.impl;

import com.efeiyi.ec.gift.organization.model.SendCode;
import com.efeiyi.ec.gift.organization.model.SmsProvider;
import com.efeiyi.ec.gift.organization.model.YunPianSmsProvider;
import com.efeiyi.ec.gift.organization.service.SmsCheckManager;
import org.springframework.stereotype.Service;

import java.util.HashMap;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-7-2
 * Time: 下午3:14
 * To change this template use File | Settings | File Templates.
 */
@Service
public class SmsCheckManagerImpl implements SmsCheckManager {

    @Override
    public String send(String phone, String content, String tpl_id, Integer company) {
        SmsProvider smsProvider = new YunPianSmsProvider();
        if (tpl_id.equals("3")) {
            SendCode sendCode = smsProvider.post(phone, content, tpl_id);
            return sendCode.getMsg();
        } else {
            SendCode sendCode = smsProvider.post(phone, content, tpl_id);
            System.out.println(sendCode.getMsg());
            return sendCode.getMsg();
        }
    }

    @Override
    public String send(String phone, HashMap<String, String> param, String tpl_id) {
        SmsProvider smsProvider = new YunPianSmsProvider();
        if (tpl_id.equals("3")) {
            SendCode sendCode = smsProvider.post(phone, param, tpl_id);
            return sendCode.getMsg();
        } else {
            SendCode sendCode = smsProvider.post(phone, param, tpl_id);
            System.out.println(sendCode.getMsg());
            return sendCode.getMsg();
        }

    }


}
