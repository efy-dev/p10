package com.ming800.core.p.service.impl;


import com.ming800.core.base.dao.XdoDao;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.p.model.CommonRecommended;
import com.ming800.core.p.model.Jmenu;
import com.ming800.core.p.model.Jnode;
import com.ming800.core.p.model.ObjectRecommended;
import com.ming800.core.p.service.CommonManager;
import com.ming800.core.p.service.JmenuManager;
import com.ming800.core.p.service.ObjectRecommendedManager;
import com.ming800.core.util.ApplicationContextUtil;
import org.apache.log4j.Logger;
import org.dom4j.Document;
import org.dom4j.Node;
import org.dom4j.io.SAXReader;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.core.io.support.ResourcePatternResolver;
import org.springframework.stereotype.Service;

import java.util.*;

/**
 * Created by IntelliJ IDEA.
 * User: ming
 * Date: 12-8-6
 * Time: 上午11:04
 * To change this template use File | Settings | File Templates.
 */
@Service
public class ObjectRecommendedManagerImpl implements ObjectRecommendedManager {

    @Autowired
    private CommonManager commonManager;

    @Autowired
    private XdoDao xdoDao;

    public  List getRecommendedList(String group) throws Exception {
        CommonRecommended recommended = commonManager.getRecommended(group);//获取xml文件对象
    //    Object object = xdoDao.getObject(recommended.getRecommendedModel(),recommended.getGroup());
        String hql = "from ObjectRecommended where 1=1 and group = ?";
        List<ObjectRecommended> objectRecommendedList =xdoDao.getObjectList(hql,new Object[]{group});//获取Object推荐集合
        List objectList = new ArrayList();
        for(ObjectRecommended objectRecommended : objectRecommendedList){//获取对象集合
            Object o = xdoDao.getObject(recommended.getRecommendedModel(),objectRecommended.getRecommendId());
            objectList.add(xdoDao.getObject(recommended.getRecommendedModel(),objectRecommended.getRecommendId()));
            System.out.print(o);
        }
        return  objectList;
    }
}
