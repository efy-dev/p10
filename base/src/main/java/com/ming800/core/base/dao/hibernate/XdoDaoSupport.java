package com.ming800.core.base.dao.hibernate;

import com.ming800.core.base.dao.XdoDao;
import com.ming800.core.does.model.PageInfo;
import com.ming800.core.taglib.PageEntity;
import org.hibernate.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

import javax.persistence.Entity;
import java.util.Collection;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: ming
 * Date: 12-10-15
 * Time: 下午2:01
 * To change this template use File | Settings | File Templates.
 */
@Component
public class XdoDaoSupport implements XdoDao {


    @Autowired
    @Qualifier("sessionFactory")
    private SessionFactory sessionFactory;

    public Session getSession() {
//        sessionFactory
        return sessionFactory.getCurrentSession();
    }

    /**
     * 获取实体的名称
     *
     * @param <E>
     * @param clazz 实体类
     * @return
     */
    protected static <E> String getEntityName(Class<E> clazz) {
        String entityName = clazz.getSimpleName();
        Entity entity = clazz.getAnnotation(Entity.class);
        if (entity.name() != null && !"".equals(entity.name())) {
            entityName = entity.name();
        }
        return entityName;
    }

    @Override
    public Object getObject(String modelType, String id) {
/*        try {
            Class.forName(modelType);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
        }
        String entityName = BaseDaoSupport.getEntityName(modelType.getClass());*/
        return this.getSession().get(modelType, id);
    }

    @Override
    public void saveOrUpdateObject(String modelType, Object object) {
        this.getSession().saveOrUpdate(modelType, object);
    }

    /***
     * 临时添加测试使用
     * @param object
     */
    @Override
    public void saveOrUpdateObject(Object object) {
        this.getSession().saveOrUpdate(object);
    }
    @Override
    public void deleteObject(String modelType, String id) {
        String query = "delete from " + modelType + " s where s.id =:id";
        this.getSession().createQuery(query).setString("id", id).executeUpdate();//To change body of implemented methods use File | Settings | File Templates.
    }

    @Override
    public void batchSaveOrUpdate(String type, String modelType, List<Object> objectList) {

        StatelessSession session = sessionFactory.openStatelessSession();
        Transaction tx = session.beginTransaction();

        for (Object object : objectList) {
            if ("save".equals(type)) {
                session.insert(modelType, object);
            } else {
                session.update(modelType, object);
            }
        }
        tx.commit();
        session.close();

        //To change body of implemented methods use File | Settings | File Templates.
    }

    @Override
    public Object executeSql(String type, String queryStr, LinkedHashMap<String, Object> queryParamMap) {

        Query listQuery = this.getSession().createSQLQuery(queryStr);
        listQuery = setQueryParams(listQuery, queryParamMap);

        if ("list".equals(type)) {
            return listQuery.list();
        } else {
            return listQuery.executeUpdate();
        }
        //To change body of implemented methods use File | Settings | File Templates.
    }

    @Override
    public List getObjectList(String queryHql, LinkedHashMap<String, Object> queryParamMap) {

        Query listQuery = this.getSession().createQuery(queryHql);
        listQuery = setQueryParams(listQuery, queryParamMap);
        return listQuery.list();
    }

    @Override
    public List getObjectList(String queryHql, Object... params) {
        Query query = getSession().createQuery(queryHql);
        query = setParameters(query, params);
        return query.list();
    }


    @Override
    public List<Object> getObjectList(String hql, LinkedHashMap<String, Object> params, Integer limit, Integer offset) {
        Query query = getSession().createQuery(hql);
        if (params != null && params.size() > 0) {
            for (String key : params.keySet()) {
                query.setParameter(key, params.get(key));
            }
        }
        query.setFirstResult(offset);
        query.setMaxResults(limit);
        return query.list();
    }


    @Override
    public int removeObject(String modelType, String id) {

        String query = "update " + modelType + " s set s.status = 0 where s.id =:id";
        return this.getSession().createQuery(query).setString("id", id).executeUpdate();
    }


    @Override
    public PageInfo getPageByConditions(PageEntity pageEntity, String queryHql, LinkedHashMap<String, Object> queryParamMap) {
        Query listQuery = this.getSession().createQuery(queryHql);
        String tempSql = queryHql.trim().toUpperCase();
        if (tempSql.startsWith("SELECT")) {
            queryHql = queryHql.substring(tempSql.indexOf("FROM"));
        }
        Query countQuery = null;
        if (tempSql.contains("DISTINCT")) {
            if (tempSql.startsWith("FROM")) {
                countQuery = this.getSession().createQuery("SELECT COUNT(*) " + queryHql);
            } else {
                if (tempSql.split("FROM")[0].contains("DISTINCT")) {
                    String tem = tempSql.substring(tempSql.indexOf("DISTINCT"), tempSql.indexOf("FROM")).toLowerCase();
                    if (!tem.contains("ID")) tem = tem + ".id";
                    countQuery = this.getSession().createQuery("SELECT COUNT(" + tem + ")" + queryHql);
                } else {
                    String tt = tempSql.substring(tempSql.indexOf("FROM") + 4, tempSql.length());
                    countQuery = this.getSession().createQuery("SELECT COUNT(*) " + tt);
                }
            }
        } else {
            countQuery = this.getSession().createQuery("SELECT COUNT(*) " + queryHql);
        }

        //查询主要数据
        listQuery = setQueryParams(listQuery, queryParamMap);
        //查询数据的总条数（分页）
        countQuery = setQueryParams(countQuery, queryParamMap);

        return this.getPage(listQuery, countQuery, pageEntity);
    }


    /**
     * 执行批处理语句.如 之间insert, update, delete 等.
     */
    @Override
    public int execteBulk(final String hql, final LinkedHashMap<String, Object> queryParamMap) {
        Query query = getSession().createQuery(hql);
        query = setQueryParams(query, queryParamMap);
        Object result = query.executeUpdate();
        return result == null ? 0 : ((Integer) result).intValue();
    }

    @Override
    public Object getUniqueObjectByConditions(String queryHql, LinkedHashMap<String, Object> queryParamMap) {
        Query listQuery = this.getSession().createQuery(queryHql);
        listQuery = setQueryParams(listQuery, queryParamMap);
        return listQuery.uniqueResult();
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

    protected Query setQueryParams(Query query, LinkedHashMap<String, Object> queryParamMap) {
        if (queryParamMap != null && queryParamMap.size() > 0) {
            for (String paramName : queryParamMap.keySet()) {
                if (queryParamMap.get(paramName) instanceof Object[]) {
                    query.setParameterList(paramName, (Object[]) queryParamMap.get(paramName));
                } else if (queryParamMap.get(paramName) instanceof Collection) {
                    query.setParameterList(paramName, (Collection) queryParamMap.get(paramName));
                } else {
                    query.setParameter(paramName, queryParamMap.get(paramName));
                }
            }
        }

        return query;
    }

    public PageInfo getPage(Query listQuery, Query countQuery, PageEntity pageEntity) {
        if (pageEntity == null) {
            pageEntity = new PageEntity();
        }

        listQuery.setFirstResult(pageEntity.getrIndex());
        listQuery.setMaxResults(pageEntity.getSize());

        PageInfo info = new PageInfo();

        List list = listQuery.list();
        if (list != null && !list.isEmpty()) {
            info.setList(list);
        }

        //查询所有数据的条数
        info.setCount(((Long) countQuery.uniqueResult()).intValue());

        pageEntity.setCount(info.getCount());

        info.setPageEntity(pageEntity);

        return info;
    }

}
