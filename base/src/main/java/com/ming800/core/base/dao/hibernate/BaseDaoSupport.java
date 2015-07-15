package com.ming800.core.base.dao.hibernate;

import com.ming800.core.base.dao.BaseDao;
import com.ming800.core.taglib.PageEntity;
import com.ming800.core.does.model.PageInfo;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;

import javax.persistence.Entity;
import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
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
public class BaseDaoSupport<T> implements BaseDao<T> {

    private Class entityClass;

    @Autowired
    @Qualifier("sessionFactory")
    private SessionFactory sessionFactory;

    public SessionFactory getSessionFactory() {
        return this.sessionFactory;
    }

    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    public Session getSession() {
        //事务必须是开启的(Required)，否则获取不到
        return sessionFactory.getCurrentSession();
    }


    public BaseDaoSupport() {
        Type genType = getClass().getGenericSuperclass();
        Type[] params = ((ParameterizedType) genType).getActualTypeArguments();
        entityClass = (Class) params[0];
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
    public T getObject(Integer id) {
        return (T) this.getSession().get(entityClass, id);
    }

    @Override
    public T getObject(String id) {
        return (T) this.getSession().get(entityClass, id);
    }

    @Override
    public void saveObject(T entity) {
        this.getSession().save(entity);
    }

    @Override
    public void updateObject(T entity) {
        this.getSession().update(entity);
    }

    @Override
    public void saveOrUpdateObject(T entity) {
        this.getSession().saveOrUpdate(entity);
    }

    @Override
    public void deleteObject(T entity) {
        this.getSession().delete(entity);
    }

    protected void setParameters(Query query, Object[] paramlist) {
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
    }

    @Override
    public List<T> getObjectList(String queryHql, Object... params) {

        Query query = getSession().createQuery(queryHql);
        setParameters(query, params);
        return query.list();
    }

    @Override
    public T getUniqueObjectByConditions(String queryHql, LinkedHashMap<String, Object> queryParamMap) {
        Query listQuery = this.getSession().createQuery(queryHql);
        setQueryParams(listQuery, queryParamMap);
        return (T) listQuery.uniqueResult();
    }

    @Override
    public List<T> getObjectListByConditions(String queryHql, LinkedHashMap<String, Object> queryParamMap) {

        Query listQuery = this.getSession().createQuery(queryHql);
        setQueryParams(listQuery, queryParamMap);
        return listQuery.list();
    }

    @Override
    public PageInfo getPageByConditions(PageEntity pageEntity, String queryString, Object... params) {
        if (pageEntity == null) {
            pageEntity = new PageEntity();
        }
        Query listQuery = this.getSession().createQuery(queryString);
        String tempSql = queryString.trim().toUpperCase();
        if (tempSql.startsWith("SELECT")) {
            queryString = queryString.substring(tempSql.indexOf("FROM"));
        }
        Query countQuery = null;
        if (tempSql.contains("DISTINCT")) {
            if (tempSql.startsWith("FROM")) {
                countQuery = this.getSession().createQuery("SELECT COUNT(*) " + queryString);
            } else {
                if (tempSql.split("FROM")[0].contains("DISTINCT")) {
                    String tem = tempSql.substring(tempSql.indexOf("DISTINCT"), tempSql.indexOf("FROM")).toLowerCase();
                    if (tem.contains("ID")) tem = tem + ".id";
                    countQuery = this.getSession().createQuery("SELECT COUNT(" + tem + ")" + queryString);
                } else {
                    String tt = tempSql.substring(tempSql.indexOf("FROM") + 4, tempSql.length());
                    countQuery = this.getSession().createQuery("SELECT COUNT(*) " + tt);
                }
            }
        } else {
            countQuery = this.getSession().createQuery("SELECT COUNT(*) " + queryString);
        }
        int i = 0;
        for (Object param : params) {
            listQuery.setParameter(i, param);
            countQuery.setParameter(i, param);
            i++;
        }
        listQuery.setFirstResult(pageEntity.getrIndex());
        listQuery.setMaxResults(pageEntity.getSize());
        PageInfo info = new PageInfo();

        List list = listQuery.list();
        if (list != null && !list.isEmpty()) {
            info.setList(list);
        }

        info.setCount(((Long) countQuery.uniqueResult()).intValue());
        pageEntity.setCount(info.getCount());
        info.setPageEntity(pageEntity);
        return info;
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
                    if (tem.contains("ID")) tem = tem + ".id";
                    countQuery = this.getSession().createQuery("SELECT COUNT(" + tem + ")" + queryHql);
                } else {
                    String tt = tempSql.substring(tempSql.indexOf("FROM") + 4, tempSql.length());
                    countQuery = this.getSession().createQuery("SELECT COUNT(*) " + tt);
                }
            }
        } else {
            countQuery = this.getSession().createQuery("SELECT COUNT(*) " + queryHql);
        }

        setQueryParams(listQuery, queryParamMap);
        setQueryParams(countQuery, queryParamMap);

        return this.getPage(listQuery, countQuery, pageEntity);
    }


    protected static void setQueryParams(Query query, LinkedHashMap<String, Object> queryParamMap) {
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
    }

    @Override
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

        info.setCount(((Long) countQuery.uniqueResult()).intValue());

        pageEntity.setCount(info.getCount());

        info.setPageEntity(pageEntity);

        return info;
    }

    /*@Override
    @SuppressWarnings("unchecked")
    public <T> List<T> cacheList(Query query) {
        List<T> list = new ArrayList<T>();
        Iterator<T> it = query.iterate();
        while (it.hasNext()) {
            list.add(it.next());
        }
        return list;
    }*/

}
