package com.ming800.core.p.dao.hibernate;
import com.ming800.core.p.dao.RecommendedDao;
import com.ming800.core.p.model.ObjectRecommended;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: lxh
 * Date: 2010-1-15
 * Time: 13:43:45
 * To change this template use File | Settings | File Templates.
 */
@Repository
public class RecommendedDaoHibernate implements RecommendedDao {

    @Autowired
    @Qualifier("sessionFactory")
    private SessionFactory sessionFactory;

    public Session getSession() {
//        sessionFactory
        return sessionFactory.getCurrentSession();
    }

    /**
     * 获取推荐列表
     * @param queryHql
     * @param firstResult
     * @param maxResult
     * @param params
     * @return
     */

    @Override
    public  List getObjectListByLimit(String queryHql,Integer firstResult,Integer maxResult,Object... params){
        Query query = this.getSession().createQuery(queryHql);
        query = setParameters(query, params);
        query.setFirstResult(firstResult);
        query.setMaxResults(maxResult);
        return  query.list();

    }
    protected Query setParameters(Query query, Object[] paramlist) {
        if (paramlist != null) {
            for (int i = 0; i < paramlist.length; i++) {
                if (paramlist[i] instanceof Date) {
                    //TODO 难道这是bug 使用setParameter不行？？
                    query.setTimestamp(i, (Date) paramlist[i]);
                } else {
                    query.setParameter(i, paramlist[i]);
                }
            }
        }
        return query;
    }

    /***
     * 保存推荐对象
     * @param objectRecommended
     */
    public void saveObjectRecommend(ObjectRecommended objectRecommended){

        this.getSession().saveOrUpdate(objectRecommended);
    }

    /**
     * 更新排序字段
     * @param objectRecommended
     * @return
     */
    @Override
    public  Integer  updateSort(ObjectRecommended objectRecommended){

        String hql = "update ObjectRecommended set sort = :sort where id=:id";
        Query query =  this.getSession().createQuery(hql)
                .setInteger("sort", objectRecommended.getSort())
                .setString("id", objectRecommended.getId());
        return    query.executeUpdate();
    }

    @Override
    public void  deleteObjectRecommend(ObjectRecommended objectRecommended){
       String hql = "delete from ObjectRecommended where  id = :id";
        Query query = this.getSession().createQuery(hql)
                .setString("id", objectRecommended.getId());
        query.executeUpdate();
    }

    @Override
    public void deleteObjectRecommendByRecommendId(String recommendId){
       String hql = "delete from ObjectRecommended where recommendId = :recommendId";
        Query query = this.getSession().createQuery(hql)
                .setString("recommendId",recommendId);
        query.executeUpdate();
    }
}
