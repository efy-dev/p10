package com.ming800.core.p.service.impl;
import antlr.StringUtils;
import com.ming800.core.base.dao.XdoDao;
import com.ming800.core.p.dao.RecommendedDao;
import com.ming800.core.p.model.CommonRecommended;
import com.ming800.core.p.model.ObjectRecommended;
import com.ming800.core.p.service.CommonManager;
import com.ming800.core.p.service.ObjectRecommendedManager;
import org.springframework.beans.factory.annotation.Autowired;
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
    private RecommendedDao recommendedDao;
    @Autowired
    private XdoDao xdoDao;

    public  List getRecommendedList(String group) throws Exception {
        CommonRecommended recommended = commonManager.getRecommended(group);//获取xml文件对象
        String hql = "from ObjectRecommended where 1=1 and status = 1 and groupName = ? order by sort ";
        List<ObjectRecommended> objectRecommendedList = null;
        if(recommended.getAmount()!=null){
            objectRecommendedList = recommendedDao.getObjectListByLimit(hql,0,Integer.parseInt(recommended.getAmount()),new Object[]{group});//获取Object推荐集合(limit)
        }else{
            objectRecommendedList = xdoDao.getObjectList(hql,new Object[]{group});//获取Object推荐集合
        }
        List objectList = new ArrayList();
        for(ObjectRecommended objectRecommended : objectRecommendedList){//获取对象集合
            Object o = xdoDao.getObject(recommended.getRecommendedModel(),objectRecommended.getRecommendId());
            objectList.add(o);
        }
        return  objectList;
    }

    @Override
    public void saveObjectRecommend(ObjectRecommended objectRecommended) {
          recommendedDao.saveObjectRecommend(objectRecommended);
      //  xdoDao.saveOrUpdateObject(objectRecommended);
    }

    @Override
    public Integer updateSort(ObjectRecommended objectRecommended){
        return  recommendedDao.updateSort(objectRecommended);
    }

    @Override
   public void  deleteObjectRecommend(ObjectRecommended objectRecommended){
      recommendedDao.deleteObjectRecommend(objectRecommended);
   }



    @Override
    public void deleteObjectRecommendByRecommendId(String recommendId) {
            if(!"".equals(recommendId) && recommendId != null){
                recommendedDao.deleteObjectRecommendByRecommendId(recommendId);
            }
    }
}
