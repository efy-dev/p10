package com.ming800.core.does.model;

import com.ming800.core.does.service.DoManager;
import com.ming800.core.util.ApplicationContextUtil;

import javax.servlet.http.HttpServletRequest;
import java.util.Enumeration;
import java.util.HashMap;

/**
 * Created by Administrator on 2015/7/8.
 * XSaveOrUpdate 负责存储保存祸根新操作所需要的信息
 */
public class XSaveOrUpdate {

    private Do tempDo;  //数据类型信息
    private HashMap<String, Object> paramMap;  //需要更新或者保存的字段值

    private DoManager doManager = (DoManager) ApplicationContextUtil.getApplicationContext().getBean("doManagerImpl");

    public XSaveOrUpdate() {
    }

    public XSaveOrUpdate(String doName, HttpServletRequest request) throws Exception {
        tempDo = doManager.getDoByQueryModel(doName.split("_")[0]);
        paramMap = new HashMap<>();
        Enumeration<String> keySet = request.getParameterNames();
        //把request转化成map来操作
        while (keySet.hasMoreElements()) {
            String key = keySet.nextElement();
            paramMap.put(key, request.getParameter(key));
        }
    }

    public HashMap<String, Object> getParamMap() {
        return paramMap;
    }

    public void setParamMap(HashMap<String, Object> paramMap) {
        this.paramMap = paramMap;
    }

    public Do getTempDo() {
        return tempDo;
    }

    public void setTempDo(Do tempDo) {
        this.tempDo = tempDo;
    }
}
