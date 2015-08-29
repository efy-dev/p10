package com.efeiyi.pal.system.label.labelService.impl;

import com.ming800.core.p.dao.AutoSerialDao;
import com.ming800.core.p.model.AutoSerial;
import com.ming800.core.p.model.CommonSerial;
import com.ming800.core.p.service.AutoSerialManager;
import com.ming800.core.p.service.CommonManager;
import org.springframework.beans.factory.annotation.Autowired;

import java.text.SimpleDateFormat;
import java.util.*;
import java.util.concurrent.ConcurrentLinkedQueue;

/**
 * Created by Administrator on 2015/8/28.
 */
public class AutoSerialManagerImpl extends com.ming800.core.p.service.impl.AutoSerialManagerImpl {
    @Autowired
    private AutoSerialDao autoSerialDao;

    @Autowired
    private CommonManager commonManager;
    //    protected Queue<Long> updateSerials;
    protected static Map<String, Queue> map = new HashMap<String, Queue>();
    String prefix;


    @Override
    public String nextSerial(String group) throws Exception {
//        if(map.get(group) != null){
//            updateSerials = map.get(group);
//            if (updateSerials.size() == 0){
//                makeSerials( group);
//            }
//        }else{
//            updateSerials = new ConcurrentLinkedQueue<Long>();
//            makeSerials( group);
//        }
        Queue<Long> updateSerials = map.get(group);
        if (updateSerials == null || updateSerials.size() == 0) {
            synchronized (group) {
                if (map.get(group) == null) {
                    map.put(group, new ConcurrentLinkedQueue<Long>());
                }
            }
            updateSerials = makeSerials(group);
        }

        return updateSerials.poll().toString();
    }

    private Queue<Long> makeSerials(String group) throws Exception {
        CommonSerial commonSerial = commonManager.getAutoSerial(group);//获取xml配置对象
        //从数据库中获取初始值，如果为空，默认从1开始
        //String queryStr = "select max(serial) from core_p_auto_serial where groupName= :groupName order by serial desc LIMIT 1";
        String queryStr = "from AutoSerial where groupName= :groupName";
        LinkedHashMap<String, Object> queryParamMap = new LinkedHashMap<>();
        queryParamMap.put("groupName", group);
        AutoSerial autoSerial = autoSerialDao.getAutoSerial(queryStr, queryParamMap);

        //默认一次生成10个序列号
        int size = 10;

        if (commonSerial.getCacheSize() != null || commonSerial.getCacheSize() != "") {
            size = Integer.parseInt(commonSerial.getCacheSize());
        }
        int length = 8;
        if (commonSerial.getLength() != null || commonSerial.getLength() != "") {
            length = Integer.parseInt(commonSerial.getLength());
        }
        int step = 1;
        if (commonSerial.getStep() != null || commonSerial.getStep() != "") {
            step = Integer.parseInt(commonSerial.getStep());
        }

        if (commonSerial.getPrefix() != null && !"".equalsIgnoreCase(commonSerial.getPrefix())) {
            prefix = commonSerial.getPrefix();
        }
        Long begin = Long.parseLong(makeChar(length));
        Queue<Long> updateSerials = map.get(group);
        if (autoSerial == null) {
            for (int i = 1; i <= size; i++) {
                Long serial = begin + i * step;
                if (i == size) {
                    autoSerial = new AutoSerial();
                    autoSerial.setGroup(group);
                    autoSerial.setSerial(serial);
                    autoSerialDao.saveOrUpdateObject(autoSerial);
                }
                updateSerials.offer(serial);
            }
//            map.put(group,updateSerials);
        } else {
            for (int i = 1; i <= size; i++) {
                Long serial = autoSerial.getSerial() + i * step;
                if (i == size) {
                    autoSerial.setSerial(serial);
                    autoSerialDao.saveOrUpdateObject(autoSerial);
                }
                updateSerials.offer(serial);
            }
//            map.put(group,updateSerials);
        }
        return updateSerials;
    }

    private String makeChar(int num) {
        StringBuilder chars = new StringBuilder();
        Date now = new Date();
        int fg = 0;
        if (prefix != null && !"".equals(prefix)) {
            if (prefix.equalsIgnoreCase("yyyymmdd")) {
                SimpleDateFormat myFmt1 = new SimpleDateFormat("yyyyMMdd");
                chars.append(myFmt1.format(now));
                fg = myFmt1.format(now).length();
            } else if (prefix.equalsIgnoreCase("yymm")) {
                SimpleDateFormat myFmt1 = new SimpleDateFormat("yyMM");
                chars.append(myFmt1.format(now));
                fg = myFmt1.format(now).length();
            } else if (prefix.equalsIgnoreCase("yyyymmddhhmmss")) {
                SimpleDateFormat myFmt1 = new SimpleDateFormat("yyyyMMddHHmmss");
                chars.append(myFmt1.format(now));
                fg = myFmt1.format(now).length();
            }

            for (int k = 1; k <= num - fg; k++) {
                chars.append(0);
            }
        } else {
            chars.append("1");
            for (int z = 1; z <= num - 1; z++) {
                chars.append(0);
            }
        }


        return chars.toString();
    }
}
