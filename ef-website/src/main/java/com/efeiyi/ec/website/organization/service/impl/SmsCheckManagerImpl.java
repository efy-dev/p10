package com.efeiyi.ec.website.organization.service.impl;

import com.efeiyi.ec.organization.model.BigUser;
import com.efeiyi.ec.website.organization.model.SendCode;
import com.efeiyi.ec.website.organization.model.SmsProvider;
import com.efeiyi.ec.website.organization.model.YunPianSmsProvider;
import com.efeiyi.ec.website.organization.service.SmsCheckManager;
import com.ming800.core.base.dao.XdoDao;
import com.ming800.core.base.service.BaseManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;

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
