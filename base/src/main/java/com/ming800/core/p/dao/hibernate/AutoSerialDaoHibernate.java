package com.ming800.core.p.dao.hibernate;

import com.ming800.core.base.dao.hibernate.BaseDaoSupport;
import com.ming800.core.p.dao.AutoSerialDao;
import com.ming800.core.p.model.AutoSerial;
import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import java.util.LinkedHashMap;
import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: brightpower
 * Date: 2010-1-9
 * Time: 11:51:17
 * To change this template use File | Settings | File Templates.
 */
@Repository
public class AutoSerialDaoHibernate extends BaseDaoSupport<AutoSerial> implements AutoSerialDao {
    public Long getAutoSerial(String queryStr, LinkedHashMap<String, Object> queryParamMap){
        Query query = this.getSession().createSQLQuery(queryStr).setString("groupName", queryParamMap.get("groupName").toString());
        Long serial=null;
        List list = query.list();
        if(list.size()>=1){
            serial=Long.parseLong(list.get(0).toString());
        }
        return serial;
    }
}
