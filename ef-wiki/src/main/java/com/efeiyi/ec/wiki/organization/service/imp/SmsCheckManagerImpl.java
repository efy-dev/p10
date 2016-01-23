package com.efeiyi.ec.wiki.organization.service.imp;

import com.efeiyi.ec.organization.model.BigUser;
import com.efeiyi.ec.wiki.organization.model.SendCode;
import com.efeiyi.ec.wiki.organization.model.SmsProvider;
import com.efeiyi.ec.wiki.organization.model.YunPianSmsProvider;
import com.efeiyi.ec.wiki.organization.service.SmsCheckManager;
import com.ming800.core.base.dao.XdoDao;
import com.ming800.core.base.service.BaseManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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

    @Autowired
    private XdoDao basicDao;
//    @Autowired
//    private BranchManager branchManager;

    @Autowired
    private BaseManager baseManager;

    @Override
    public String createCheckCode() {

        return String.valueOf(Math.random()).substring(2, 8);
    }



    @Override
    public String send(String phone, String content, String tpl_id, Integer company) {
        SmsProvider smsProvider = null;

            smsProvider = new YunPianSmsProvider();

        //非营销短信
        if(tpl_id.equals("3")){
            SendCode sendCode = smsProvider.post(phone, content, tpl_id);

            return sendCode.getMsg();
        }else{
                SendCode sendCode = smsProvider.post(phone, content, tpl_id);


                System.out.println(sendCode.getMsg());
                return sendCode.getMsg();
            }

    }
//
//    @Override
//    public void send(String phone, String code, String branchName,String tpl_id) throws Exception {
//        Branch branch = branchManager.getBranchByName(branchName);
//        String name = branch.getName() + branch.getSerial();
//        if (name.length() > 10) {
//            name = name.substring(0, 10);
//        }
//        SmsProvider smsProvider = new TianXinBoYiSmsProvider(name, name);
//        smsProvider.post(phone, "您的验证码：[" + code + "]请及时使用【明日科技】", null,tpl_id);
//    }

    @Override
    public Boolean checkPhoneRegistered(String phone) {
        String hql = "from BigUser b where b.username=:phone";
        LinkedHashMap<String, Object> queryParamMap = new LinkedHashMap<>();
        queryParamMap.put("phone", phone);
        List<BigUser> bigUserList = basicDao.getObjectList(hql, queryParamMap);
        if (bigUserList.size() < 1) {
            return true;
        } else {
            return false;
        }
    }
}
