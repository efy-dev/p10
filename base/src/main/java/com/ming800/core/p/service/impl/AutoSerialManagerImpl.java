package com.ming800.core.p.service.impl;

import com.ming800.core.p.PConst;
import com.ming800.core.p.dao.AutoSerialDao;
import com.ming800.core.p.model.AutoSerial;
import com.ming800.core.p.model.CommonSerial;
import com.ming800.core.p.service.AutoSerialManager;
import com.ming800.core.p.service.CommonManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Stack;

/**
 * Created by IntelliJ IDEA.
 * User: brightpower
 * Date: 2010-1-9
 * Time: 11:49:55
 * To change this template use File | Settings | File Templates.
 */
@Service
public class AutoSerialManagerImpl implements AutoSerialManager {
    @Autowired
    private AutoSerialDao autoSerialDao;

    @Autowired
    private CommonManager commonManager;
    protected  static Stack<AutoSerial> updateSerials = new Stack<AutoSerial>();
 /*   public String nextAutoSerial(String model) {
        //检查表中是否包含该项对应的记录
        String queryStr = "from AutoSerial where model = :model and branch.id = :branchId order by serial desc";
        LinkedHashMap<String, Object> queryParamMap = new LinkedHashMap<>();
        queryParamMap.put("model", model);

        AutoSerial autoSerial = autoSerialDao.getUniqueObjectByConditions(queryStr, queryParamMap);
        if (autoSerial == null) {
            autoSerial = new AutoSerial();
            autoSerial.setSerial(PConst.AUTO_SERIAL_SERIAL_INIT_NUM);
            autoSerial.setModel(model);

            autoSerialDao.saveObject(autoSerial);
        } else {
            Integer intSerial = Integer.parseInt(autoSerial.getSerial()) + 1;
            autoSerial.setSerial(intSerial.toString());
            autoSerialDao.updateObject(autoSerial);
        }
        String serial = autoSerial.getSerial();
        while (serial.length() < 5) {
            serial = "0" + serial;
        }
        return serial;
    }*/

    public Long nextSerial(String group) throws Exception {
        if (updateSerials.empty()){
            makeSerials( group);
        }
        AutoSerial autoserial = updateSerials.pop();
        Long serial = autoserial.getSerial();
     return serial;
    }

    private void makeSerials(String group) throws Exception{
        CommonSerial commonSerial = commonManager.getAutoSerial(group);//获取xml配置对象
        //从数据库中获取初始值，如果为空，默认从1开始
        //String queryStr = "select max(serial) from core_p_auto_serial where groupName= :groupName order by serial desc LIMIT 1";
        String queryStr = "select max(serial) from AutoSerial where groupName= :groupName";
        LinkedHashMap<String, Object> queryParamMap = new LinkedHashMap<>();
        queryParamMap.put("groupName", group);
        Long autoSerial = autoSerialDao.getAutoSerial(queryStr, queryParamMap);

        //默认一次生成10个序列号
        int size =10;

        if(commonSerial.getCacheSize()!=null || commonSerial.getCacheSize()!=""){
            size = Integer.parseInt(commonSerial.getCacheSize());
        }
        int length = 8;
        if(commonSerial.getLength()!=null || commonSerial.getLength()!=""){
            length = Integer.parseInt(commonSerial.getLength());
        }
        int step = 1;
        if (commonSerial.getStep()!=null || commonSerial.getStep()!=""){
            step = Integer.parseInt(commonSerial.getStep());
        }
        Long begin= Long.parseLong(makeChar(length));
        if (autoSerial==null || autoSerial==0){
            for (int i=1;i<=size;i++){
                AutoSerial autoserial = new AutoSerial();
                autoserial.setSerial(begin+i*step);
                autoserial.setGroup(group);
                autoSerialDao.saveOrUpdateObject(autoserial);
                updateSerials.push(autoserial);
            }
        }else{
            for (int i=1;i<=size;i++){
                AutoSerial autoserial = new AutoSerial();
                autoserial.setSerial(autoSerial+begin+i*step);
                autoserial.setGroup(group);
                autoSerialDao.saveOrUpdateObject(autoserial);
                updateSerials.push(autoserial);
            }
        }

    }
    public String makeChar(int num){
        StringBuilder chars = new StringBuilder("1");
         for (int z=1;z<=num-1;z++){
            chars.append(0);
         }
        return chars.toString();
    }
    /*@Override
    public String getName(String model,String branchId){
        return model+"N"+this.nextAutoSerial(model,branchId);
    }
    @Override
    public String getOptionsValue(String formName,Integer branchId,String[] options){
        String tempStr = "";
        if(null != options && 0 != options.length){
            for(int i=0;i<options.length;i++){
                if(!"".equals(options[i])){
                    tempStr += this.nextAutoSerialByModule(formName,branchId)+","+options[i]+";";
                }
            }
        }
        return tempStr.substring(0,tempStr.trim().length()-1);
    }

    @Override
    public String getOptionValuesByEdit(String formName,Integer branchId,String[] strLabel,String[] strValue){
       String stemp = "";
       if(strLabel!=null&&strLabel.length!=0){
           for(int i=0;i<strLabel.length;i++){
               if(strLabel[i]!=""){
                   if(i<strValue.length){
                      stemp = stemp + strValue[i] + "," + strLabel[i] + ";";
                   }else{
                      stemp = stemp + this.nextAutoSerialByModule(formName,branchId) + "," + strLabel[i] + ";";
                   }
               }
           }
           stemp = stemp.substring(0,stemp.length()-1);
        }
        return stemp;
    }*/
}
