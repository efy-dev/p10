package com.efeiyi.ec.wiki.organization.controller;

import com.alibaba.fastjson.JSONObject;
import com.efeiyi.ec.organization.model.MyUser;
import com.efeiyi.ec.wiki.base.util.DigitalSignatureUtil;
import com.efeiyi.ec.wiki.base.util.WikiConfig;
import com.ming800.core.base.controller.BaseController;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.io.InputStream;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.TreeMap;

/**
 * Created by Administrator on 2015/12/22.
 *
 */
@Controller
public class SigninController extends BaseController {
    private static Logger logger = Logger.getLogger(SigninController.class);

    @RequestMapping(value ="/wiki/login.do", method = RequestMethod.POST)
    @ResponseBody
    public Map login(HttpServletRequest request)  {

            Map<String, String> resultMap = new HashMap<String, String>();
            TreeMap treeMap = new TreeMap();
         try {
            InputStream inputStream = request.getInputStream();
            byte[] bytes = new byte[request.getContentLength()];
            inputStream.read(bytes);
            String param = new String(bytes);
            JSONObject jsonObj = (JSONObject) JSONObject.parse(param);
            if ("".equals(jsonObj.getString("signmsg")) || "".equals(jsonObj.getString("username")) || "".equals(jsonObj.getString("password")) || "".equals(jsonObj.getString("timestamp"))) {
                resultMap.put("resultCode", "10001");
                resultMap.put("msg", "必选参数为空，请仔细检查");
            }

            String signmsg = jsonObj.getString("signmsg");
            treeMap.put("username", jsonObj.getString("username"));
            treeMap.put("password", jsonObj.getString("password"));
            boolean verify = DigitalSignatureUtil.verify(treeMap, signmsg);
            if (verify != true) {
                resultMap.put("resultCode", "10002");
                resultMap.put("msg", "参数校验不合格，请仔细检查");
            }

            LinkedHashMap<String, Object> map = new LinkedHashMap<String, Object>();
            map.put("username", jsonObj.getString("username"));
            MyUser user;
            try {
                user = (MyUser) baseManager.getUniqueObjectByConditions(WikiConfig.SQL_USER_GET, map);
                if (user.getPassword().equals(jsonObj.getString("password"))) {
                    resultMap.put("resultCode", "0");
                    resultMap.put("msg", "成功");
                }
            } catch (Exception e) {
                resultMap.put("resultCode", "10003");
                resultMap.put("msg", "用户名或密码错误");
            }
        }catch (Exception e){
            resultMap.put("resultCode", "10004");
            resultMap.put("msg", "未知错误，请联系管理员");
        }
        return resultMap;
    }
}
