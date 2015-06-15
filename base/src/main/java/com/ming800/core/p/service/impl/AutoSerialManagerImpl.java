package com.ming800.core.p.service.impl;

import com.ming800.core.p.PConst;
import com.ming800.core.p.dao.AutoSerialDao;
import com.ming800.core.p.model.AutoSerial;
import com.ming800.core.p.service.AutoSerialManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.LinkedHashMap;

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

    public String nextAutoSerial(String model) {
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
