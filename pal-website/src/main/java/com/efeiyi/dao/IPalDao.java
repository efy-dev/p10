package com.efeiyi.dao;

import org.hibernate.Query;

/**
 * Created by Administrator on 2015/8/19.
 */
public interface IPalDao {

    Query createQuery(String queryString);
    void saveOrUpdate(String modelType, Object object);
}
