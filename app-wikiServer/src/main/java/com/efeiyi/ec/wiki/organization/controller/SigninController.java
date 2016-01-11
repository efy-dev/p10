package com.efeiyi.ec.wiki.organization.controller;

import com.alibaba.fastjson.JSONObject;
import com.efeiyi.ec.organization.model.Consumer;
import com.efeiyi.ec.organization.model.MyUser;
import com.efeiyi.ec.wiki.base.util.DigitalSignatureUtil;
import com.efeiyi.ec.wiki.base.util.WikiConfig;
import com.efeiyi.ec.wiki.model.LogBean;
import com.ming800.core.base.controller.BaseController;
import com.ming800.core.base.service.BaseManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.io.InputStream;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Created by Administrator on 2015/12/22.
 *
 */
@Controller
public class SigninController extends BaseController {
    private static Logger logger = Logger.getLogger(SigninController.class);
    @Autowired
    BaseManager baseManager;
    @RequestMapping(value = "/wiki/login.do", method = RequestMethod.POST)
    @ResponseBody
    public Map login(HttpServletRequest request) {
        LogBean logBean = new LogBean();
        Map<String, String> resultMap = new HashMap<String, String>();
        TreeMap treeMap = new TreeMap();
        try {
            InputStream inputStream = request.getInputStream();
            byte[] bytes = new byte[request.getContentLength()];
            inputStream.read(bytes);
            String param = new String(bytes);
            JSONObject jsonObj = (JSONObject) JSONObject.parse(param);
            logBean.setCreateDate(new Date());
            logBean.setRequestMessage(jsonObj.toString());//************记录请求报文
            if ("".equals(jsonObj.getString("signmsg")) || "".equals(jsonObj.getString("username")) || "".equals(jsonObj.getString("password")) || "".equals(jsonObj.getString("timestamp"))) {
                logBean.setResultCode("10001");
                logBean.setMsg("必选参数为空，请仔细检查");
                baseManager.saveOrUpdate(LogBean.class.getName(),logBean);
                resultMap.put("resultCode", "10001");
                resultMap.put("msg", "必选参数为空，请仔细检查");
                return resultMap;
            }

            String signmsg = jsonObj.getString("signmsg");
            treeMap.put("username", jsonObj.getString("username"));
            treeMap.put("password", jsonObj.getString("password"));
            treeMap.put("timestamp", jsonObj.getString("timestamp"));
            boolean verify = DigitalSignatureUtil.verify(treeMap, signmsg);
            if (verify != true) {
                logBean.setResultCode("10002");
                logBean.setMsg("参数校验不合格，请仔细检查");
                baseManager.saveOrUpdate(LogBean.class.getName(),logBean);
                resultMap.put("resultCode", "10002");
                resultMap.put("msg", "参数校验不合格，请仔细检查");
                return resultMap;
            }

            LinkedHashMap<String, Object> map = new LinkedHashMap<String, Object>();
            map.put("username", jsonObj.getString("username"));
            MyUser user;
            try {
                user = (MyUser) baseManager.getUniqueObjectByConditions(WikiConfig.SQL_USER_GET, map);
                if (user.getPassword().equals(jsonObj.getString("password"))) {
                    logBean.setResultCode("0");
                    logBean.setMsg("成功");
                    baseManager.saveOrUpdate(LogBean.class.getName(),logBean);
                    resultMap.put("resultCode", "0");
                    resultMap.put("msg", "成功");
                }
            } catch (Exception e) {
                logBean.setResultCode("10003");
                logBean.setMsg("用户名或密码错误");
                baseManager.saveOrUpdate(LogBean.class.getName(),logBean);
                resultMap.put("resultCode", "10003");
                resultMap.put("msg", "用户名或密码错误");
            }
        } catch (Exception e) {
            logBean.setResultCode("10004");
            logBean.setMsg("未知错误，请联系管理员");
            baseManager.saveOrUpdate(LogBean.class.getName(),logBean);
            resultMap.put("resultCode", "10004");
            resultMap.put("msg", "未知错误，请联系管理员");
            return resultMap;
        }
        return resultMap;
    }


    @RequestMapping(value = "/wiki/register.do", method = RequestMethod.POST)
    @ResponseBody
    public Map register(HttpServletRequest request) {
        LogBean logBean = new LogBean();
        Map<String, String> resultMap = new HashMap<String, String>();
        TreeMap treeMap = new TreeMap();
        try {
            InputStream inputStream = request.getInputStream();
            byte[] bytes = new byte[request.getContentLength()];
            inputStream.read(bytes);
            String param = new String(bytes);
            JSONObject jsonObj = (JSONObject) JSONObject.parse(param);
            logBean.setCreateDate(new Date());
            logBean.setRequestMessage(jsonObj.toString());//************记录请求报文
            if ("".equals(jsonObj.getString("signmsg")) || "".equals(jsonObj.getString("username")) ||
                "".equals(jsonObj.getString("password")) || "".equals(jsonObj.getString("timestamp")) || "".equals(jsonObj.getString("truename2"))) {
                resultMap.put("resultCode", "10001");
                resultMap.put("msg", "必选参数为空，请仔细检查");
                logBean.setResultCode("10001");
                logBean.setMsg("必选参数为空，请仔细检查");
                baseManager.saveOrUpdate(LogBean.class.getName(),logBean);
                return resultMap;
            }

            String signmsg = jsonObj.getString("signmsg");
            treeMap.put("username", jsonObj.getString("username"));
            treeMap.put("password", jsonObj.getString("password"));
            treeMap.put("timestamp", jsonObj.getString("timestamp"));
            treeMap.put("truename2", jsonObj.getString("truename2"));
            boolean verify = DigitalSignatureUtil.verify(treeMap, signmsg);
            if (verify != true) {
                resultMap.put("resultCode", "10002");
                resultMap.put("msg", "参数校验不合格，请仔细检查");
                logBean.setResultCode("10002");
                logBean.setMsg("参数校验不合格，请仔细检查");
                baseManager.saveOrUpdate(LogBean.class.getName(),logBean);
                return resultMap;
            }
            boolean flagg= isMobile(jsonObj.getString("username"));
            if(flagg==false){
                resultMap.put("resultCode", "10006");
                resultMap.put("msg", "手机号码校验不合格");
                logBean.setResultCode("10006");
                logBean.setMsg("手机号码校验不合格");
                baseManager.saveOrUpdate(LogBean.class.getName(),logBean);
                return resultMap;
            }
            LinkedHashMap<String, Object> map = new LinkedHashMap<String, Object>();
            map.put("username", jsonObj.getString("username"));
            MyUser user;
            try {
                user = (MyUser) baseManager.getUniqueObjectByConditions(WikiConfig.SQL_USER_GET, map);
                if (user!=null && user.getId()!=null) {
                    resultMap.put("resultCode", "-1");
                    resultMap.put("msg", "用户名已经存在");
                    logBean.setResultCode("-1");
                    logBean.setMsg("用户名已经存在");
                    baseManager.saveOrUpdate(LogBean.class.getName(),logBean);
                    return resultMap;
                }
            }catch(Exception e){
                resultMap.put("resultCode", "10005");
                resultMap.put("msg", "查询数据出现异常");
                logBean.setResultCode("10005");
                logBean.setMsg("查询数据出现异常");
                baseManager.saveOrUpdate(LogBean.class.getName(),logBean);
                return resultMap;
            }
           //***************************************保存用户信息
            Consumer myUser = new Consumer();
            myUser.setUsername(jsonObj.getString("username"));
            myUser.setPassword(jsonObj.getString("password"));
            myUser.setName2(jsonObj.getString("truename2"));
            myUser.setAccountExpired(false);
            myUser.setAccountLocked(false);
            myUser.setCredentialsExpired(false);
            myUser.setEnabled(true);
            myUser.setStatus("1");
            myUser.setCreateDatetime(new Date());
            baseManager.saveOrUpdate(Consumer.class.getName(),myUser);
            resultMap.put("resultCode", "0");
            resultMap.put("msg", "注册成功！");
            logBean.setResultCode("0");
            logBean.setMsg( "注册成功！");
            baseManager.saveOrUpdate(LogBean.class.getName(),logBean);
        } catch (Exception e) {
            resultMap.put("resultCode", "10004");
            resultMap.put("msg", "未知错误，请联系管理员");
            logBean.setResultCode("10004");
            logBean.setMsg("未知错误，请联系管理员");
            baseManager.saveOrUpdate(LogBean.class.getName(),logBean);
            return resultMap;
        }
        return resultMap;
    }


    @RequestMapping(value = "/wiki/checkUserName.do", method = RequestMethod.POST)
    @ResponseBody
    public Map checkUserName(HttpServletRequest request) {
        LogBean logBean = new LogBean();
        Map<String, String> resultMap = new HashMap<String, String>();
        TreeMap treeMap = new TreeMap();
        try {
            InputStream inputStream = request.getInputStream();
            byte[] bytes = new byte[request.getContentLength()];
            inputStream.read(bytes);
            String param = new String(bytes);
            JSONObject jsonObj = (JSONObject) JSONObject.parse(param);
            logBean.setCreateDate(new Date());
            logBean.setRequestMessage(jsonObj.toString());
            if ("".equals(jsonObj.getString("signmsg")) || "".equals(jsonObj.getString("username")) ||
                    "".equals(jsonObj.getString("password")) || "".equals(jsonObj.getString("timestamp")) || "".equals(jsonObj.getString("truename2"))) {
                resultMap.put("resultCode", "10001");
                resultMap.put("msg", "必选参数为空，请仔细检查");
                logBean.setResultCode("10001");
                logBean.setMsg("必选参数为空，请仔细检查");
                baseManager.saveOrUpdate(LogBean.class.getName(),logBean);
                return resultMap;
            }

            String signmsg = jsonObj.getString("signmsg");
            treeMap.put("username", jsonObj.getString("username"));
            treeMap.put("timestamp", jsonObj.getString("timestamp"));
            boolean verify = DigitalSignatureUtil.verify(treeMap, signmsg);
            if (verify != true) {
                resultMap.put("resultCode", "10002");
                resultMap.put("msg", "参数校验不合格，请仔细检查");
                logBean.setResultCode("10002");
                logBean.setMsg( "参数校验不合格，请仔细检查");
                baseManager.saveOrUpdate(LogBean.class.getName(),logBean);
                return resultMap;
            }

            LinkedHashMap<String, Object> map = new LinkedHashMap<String, Object>();
            map.put("username", jsonObj.getString("username"));
            MyUser user;
            try {
                user = (MyUser) baseManager.getUniqueObjectByConditions(WikiConfig.SQL_USER_GET, map);
                if (user!=null && user.getId()!=null) {
                    resultMap.put("resultCode", "-1");
                    resultMap.put("msg", "用户名已经存在");
                    logBean.setResultCode("-1");
                    logBean.setMsg( "用户名已经存在");
                }else {
                    resultMap.put("resultCode", "0");
                    resultMap.put("msg", "成功");
                    logBean.setResultCode("0");
                    logBean.setMsg("成功");

                }
                baseManager.saveOrUpdate(LogBean.class.getName(),logBean);
            } catch (Exception e) {
                resultMap.put("resultCode", "10005");
                resultMap.put("msg", "查询数据出现异常");
                logBean.setResultCode("10005");
                logBean.setMsg( "查询数据出现异常");
                baseManager.saveOrUpdate(LogBean.class.getName(),logBean);
                return resultMap;
                //e.printStackTrace();
            }


        } catch(Exception e){
            resultMap.put("resultCode", "10004");
            resultMap.put("msg", "未知错误，请联系管理员");
            logBean.setResultCode("10004");
            logBean.setMsg("未知错误，请联系管理员");
            baseManager.saveOrUpdate(LogBean.class.getName(),logBean);
            return resultMap;
        }
        return resultMap;
    }
    /**
     * 手机号验证
     *
     * @param  str
     * @return 验证通过返回true
     */
    public static boolean isMobile(String str) {
        Pattern p ;
        Matcher m ;
        boolean b;
        p = Pattern.compile("^[1][3,4,5,8][0-9]{9}$"); // 验证手机号
        m = p.matcher(str);
        b = m.matches();
        return b;
    }

}