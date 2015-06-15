package com.ming800.core.develop.service.impl;

import com.ming800.core.base.dao.XdoDao;
import com.ming800.core.develop.service.ExecuteHqlManager;
import com.ming800.core.base.util.SystemValueUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-10-12
 * Time: 上午10:14
 * To change this template use File | Settings | File Templates.
 */
@Service
public class ExecuteHqlManagerImpl implements ExecuteHqlManager {

    @Autowired
    private XdoDao xdoDao;

    @Override
    public String execute(String queryHql, String[] names) throws Exception {

        List<Object> objectList = xdoDao.getObjectList(queryHql);

        StringBuilder stringBuilder = new StringBuilder();
        stringBuilder.append("{").append("\"total\":").append(objectList.size()).append(",").append("\"rows\":");
        stringBuilder.append("[");
        for (Object object : objectList) {
            stringBuilder.append("{");
            for (String name : names) {
                Object fieldValue = SystemValueUtil.generateTempObjectValue(object, name.split("\\."));
                if (fieldValue != null) {
                    stringBuilder.append("\"").append(name).append("\":\"").append(fieldValue.toString()).append("\"").append(",");
                }
            }
            if (stringBuilder.toString().endsWith(",")) {
                stringBuilder.deleteCharAt(stringBuilder.length() - 1);
            }
            stringBuilder.append("},");
        }
        if (stringBuilder.toString().endsWith(",")) {
            stringBuilder.deleteCharAt(stringBuilder.length() - 1);
        }
        stringBuilder.append("]");
        stringBuilder.append("}");


        return stringBuilder.toString();  //To change body of implemented methods use File | Settings | File Templates.
    }
}
