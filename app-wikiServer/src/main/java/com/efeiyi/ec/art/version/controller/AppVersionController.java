package com.efeiyi.ec.art.version.controller;

import com.alibaba.fastjson.JSONObject;

import com.efeiyi.ec.art.base.model.LogBean;
import com.efeiyi.ec.art.base.util.AppConfig;
import com.efeiyi.ec.art.base.util.DigitalSignatureUtil;
import com.efeiyi.ec.art.base.util.JsonAcceptUtil;
import com.efeiyi.ec.art.version.model.AppVersionUpGrade;
import com.ming800.core.base.controller.BaseController;
import com.ming800.core.base.service.BaseManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

/**
 * Created by Administrator on 2016/1/23.
 *
 */
@Controller
public class AppVersionController extends BaseController{
    private static Logger logger = Logger.getLogger(AppVersionController.class);
    @Autowired
    BaseManager baseManager;
    @RequestMapping(value = "/app/upgrade.do", method = RequestMethod.POST)
    @ResponseBody
    public Map upgrade(HttpServletRequest request) {
        LogBean logBean = new LogBean();
        Map<String, Object> resultMap = new HashMap<String, Object>();
        TreeMap treeMap = new TreeMap();
        try {
            JSONObject jsonObj = JsonAcceptUtil.receiveJson(request);
            logBean.setCreateDate(new Date());
            logBean.setRequestMessage(jsonObj.toString());//************记录请求报文
            if ("".equals(jsonObj.getString("signmsg")) || "".equals(jsonObj.getString("platform"))
                    || "".equals(jsonObj.getString("version_id")) || "".equals(jsonObj.getString("timestamp"))
                    || "".equals(jsonObj.getString("version_mini")) || "".equals(jsonObj.getString("version_code"))) {
                logBean.setResultCode("10001");
                logBean.setMsg("必选参数为空，请仔细检查");
                baseManager.saveOrUpdate(LogBean.class.getName(), logBean);
                resultMap.put("resultCode", "10001");
                resultMap.put("resultMsg", "必选参数为空，请仔细检查");
                return resultMap;
            }

            String signmsg = jsonObj.getString("signmsg");
            treeMap.put("platform", jsonObj.getString("platform"));
            String version_id = jsonObj.getString("version_id");
            String version_mini = jsonObj.getString("version_mini");
            treeMap.put("version_id", version_id);
            treeMap.put("version_mini", version_mini);
            treeMap.put("version_code", jsonObj.getString("version_code"));
            treeMap.put("timestamp", jsonObj.getString("timestamp"));
            boolean verify = DigitalSignatureUtil.verify(treeMap, signmsg);
            if (verify != true) {
                logBean.setResultCode("10002");
                logBean.setMsg("参数校验不合格，请仔细检查");
                baseManager.saveOrUpdate(LogBean.class.getName(), logBean);
                resultMap.put("resultCode", "10002");
                resultMap.put("resultMsg", "参数校验不合格，请仔细检查");
                return resultMap;
            }

           //判断逻辑
            LinkedHashMap<String, Object> map = new LinkedHashMap<String, Object>();
            map.put("platform", jsonObj.getString("platform"));
            AppVersionUpGrade appVersionUpGrade = (AppVersionUpGrade)baseManager.getUniqueObjectByConditions(AppConfig.SQL_APP_VERSION_INFO, map);
            if(appVersionUpGrade.getUpdateType()!= null){
                if( "0".equals(appVersionUpGrade.getUpdateType())){//0不升级
                    logBean.setResultCode("100010");
                    logBean.setMsg("已是最新版本，无需升级！");
                    baseManager.saveOrUpdate(LogBean.class.getName(), logBean);
                    resultMap.put("resultCode", "100010");
                    resultMap.put("resultMsg", "已是最新版本，无需升级！");
                    return resultMap;
                }else  if ("1".equals(appVersionUpGrade.getUpdateType())){
                    if(version_id!=appVersionUpGrade.getVersion_id()){//大版本不相等
                        logBean.setResultCode("100012");
                        logBean.setMsg("您的版本很旧了，可以升级");
                        baseManager.saveOrUpdate(LogBean.class.getName(), logBean);
                        resultMap.put("resultCode", "100012");
                        resultMap.put("version_info", appVersionUpGrade);
                        resultMap.put("resultMsg", "您的版本很旧了，可以升级");
                        return resultMap;
                    }else{
                        if(version_mini!=appVersionUpGrade.getSub_version_id()){//小版本不同，可以提示升级
                            logBean.setResultCode("100013");
                            logBean.setMsg("检测到有新版本了，可以升级");
                            baseManager.saveOrUpdate(LogBean.class.getName(), logBean);
                            resultMap.put("resultCode", "100013");
                            resultMap.put("version_info", appVersionUpGrade);
                            resultMap.put("resultMsg", "检测到有新版本了，可以升级");
                            return resultMap;
                        }else {//最新版本
                            logBean.setResultCode("100010");
                            logBean.setMsg("已是最新版本，无需升级！");
                            baseManager.saveOrUpdate(LogBean.class.getName(), logBean);
                            resultMap.put("resultCode", "100010");
                            resultMap.put("resultMsg", "已是最新版本，无需升级！");
                        }
                    }

                }else if("2".equals(appVersionUpGrade.getUpdateType())){//强制升级
                    if(version_id==appVersionUpGrade.getVersion_id()){
                        if(version_mini==appVersionUpGrade.getSub_version_id()){//已是最新版本
                            logBean.setResultCode("100010");
                            logBean.setMsg("已是最新版本，无需升级！");
                            baseManager.saveOrUpdate(LogBean.class.getName(), logBean);
                            resultMap.put("resultCode", "100010");
                            resultMap.put("resultMsg", "已是最新版本，无需升级！");
                            return resultMap;
                        }
                    }else{//强制升级
                        logBean.setResultCode("100014");
                        logBean.setMsg("请升级到最新版本，以免影响您的使用");
                        baseManager.saveOrUpdate(LogBean.class.getName(), logBean);
                        resultMap.put("resultCode", "100014");
                        resultMap.put("version_info", appVersionUpGrade);
                        resultMap.put("resultMsg", "请升级到最新版本，以免影响您的使用");
                    }
                }
            }else {
                logBean.setResultCode("100011");
                logBean.setMsg("版本校验出错了");
                baseManager.saveOrUpdate(LogBean.class.getName(), logBean);
                resultMap.put("resultCode", "100011");
                resultMap.put("resultMsg", "版本校验出错了");
                return resultMap;
            }



        } catch(Exception e){
            logBean.setResultCode("10004");
            logBean.setMsg("未知错误，请联系管理员");
            baseManager.saveOrUpdate(LogBean.class.getName(),logBean);
            resultMap.put("resultCode", "10004");
            resultMap.put("resultMsg", "未知错误，请联系管理员");
            return resultMap;
        }

        return resultMap;
    }

}
