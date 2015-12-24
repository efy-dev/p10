package com.ming800.core.p.service.impl;

import com.ming800.core.p.PConst;
import com.ming800.core.p.dao.AutoSerialDao;
import com.ming800.core.p.model.AutoSerial;
import com.ming800.core.p.model.CommonSerial;
import com.ming800.core.p.service.AutoSerialManager;
import com.ming800.core.p.service.CommonManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.*;
import java.util.concurrent.ConcurrentLinkedQueue;

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
    //protected  static Stack<Long> updateSerials = new Stack<Long>();
    //protected  static List<Long> updateSerials = new ArrayList<Long>();
    //protected static Map<String,Stack> map = new HashMap<String,Stack>();
    //protected  static List<Long> updateSerials  = Collections.synchronizedList(new ArrayList());
    protected static Map<String,Queue> map = new HashMap<String,Queue>();
    String prefix;
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

    public String nextSerial(String group) throws Exception {
     /*  if(map.get(group) != null){
           updateSerials = map.get(group);
           //if (updateSerials.empty()){
           if (updateSerials.isEmpty()){
               makeSerials( group);
           }
       }else{
           makeSerials( group);
       }

       //return updateSerials.pop().toString();
        String returnSerial;
        synchronized(updateSerials){
             returnSerial = updateSerials.get(0).toString();
                            updateSerials.remove(0);
        }

        return returnSerial;*/
        Queue<Long> updateSerials = map.get(group);
        if (updateSerials == null) {
            synchronized (this) {
                if (map.get(group) == null) {
                    map.put(group, new ConcurrentLinkedQueue<Long>());
                    updateSerials = map.get(group);
                }
            }

        }
//       if(updateSerials.isEmpty()){
//            synchronized (updateSerials) {
//                if( updateSerials.isEmpty()) {
//                    updateSerials = makeSerials(group);
//                }
//            }
//        }//此代码块可能有些冗余，为了安全起见，先行保留

       synchronized (this) {
             if(!updateSerials.isEmpty()) {
                   return updateSerials.poll().toString();
                }else{
                  updateSerials = makeSerials(group);
                  return updateSerials.poll().toString();
               }
           
        }

        
    }

    private  Queue<Long> makeSerials(String group) throws Exception{
        CommonSerial commonSerial = commonManager.getAutoSerial(group);//获取xml配置对象
        //从数据库中获取初始值，如果为空，默认从1开始
        //String queryStr = "select max(serial) from core_p_auto_serial where groupName= :groupName order by serial desc LIMIT 1";
        String queryStr = "from AutoSerial where groupName= :groupName";
        LinkedHashMap<String, Object> queryParamMap = new LinkedHashMap<>();
        queryParamMap.put("groupName", group);
        AutoSerial autoSerial = autoSerialDao.getAutoSerial(queryStr, queryParamMap);

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

        if(commonSerial.getPrefix()!=null && !"".equalsIgnoreCase(commonSerial.getPrefix())){
            prefix = commonSerial.getPrefix();
        }
        Long begin= Long.parseLong(makeChar(length));
        Queue<Long> updateSerials = map.get(group);
        if (autoSerial==null){
            for (int i=1;i<=size;i++){
                Long serial= begin+i*step;
                if(i==size){
                    autoSerial = new AutoSerial();
                    autoSerial.setGroup(group);
                    autoSerial.setSerial(serial);
                    autoSerialDao.saveOrUpdateObject(autoSerial);
                }
                //updateSerials.push(serial);
                //updateSerials.add(serial);
                updateSerials.offer(serial);
            }
            //map.put(group,updateSerials);
        }else{
            for (int i=1;i<=size;i++){
                Long serial = autoSerial.getSerial()+i*step;
                if (i==size){
                    autoSerial.setSerial(serial);
                    autoSerialDao.saveOrUpdateObject(autoSerial);
                }
                //updateSerials.push(serial);
                //updateSerials.add(serial);
                updateSerials.offer(serial);
            }
            //map.put(group,updateSerials);
        }
        return updateSerials;
    }
    private String makeChar(int num){
        StringBuilder chars = new StringBuilder();
        Date now = new Date();
        int fg=0;
        if(prefix!=null && !"".equals(prefix)){
            if (prefix.equalsIgnoreCase("yyyymmdd")){
                SimpleDateFormat myFmt1=new SimpleDateFormat("yyyyMMdd");
                chars.append(myFmt1.format(now));
                fg = myFmt1.format(now).length();
            }else if(prefix.equalsIgnoreCase("yymm")){
                SimpleDateFormat myFmt1=new SimpleDateFormat("yyMM");
                chars.append(myFmt1.format(now));
                fg = myFmt1.format(now).length();
            }else if(prefix.equalsIgnoreCase("yyyymmddhhmmss")){
                SimpleDateFormat myFmt1=new SimpleDateFormat("yyyyMMddHHmmss");
                chars.append(myFmt1.format(now));
                fg = myFmt1.format(now).length();
            }

            for (int k=1;k<=num-fg;k++){
                chars.append(0);
            }
        }else{
            chars.append("1");
            for (int z=1;z<=num-1;z++){
                chars.append(0);
            }
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
