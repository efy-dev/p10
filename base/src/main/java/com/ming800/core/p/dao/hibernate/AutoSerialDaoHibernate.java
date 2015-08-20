package com.ming800.core.p.dao.hibernate;

import com.ming800.core.base.dao.hibernate.BaseDaoSupport;
import com.ming800.core.p.dao.AutoSerialDao;
import com.ming800.core.p.model.AutoSerial;
import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import java.util.LinkedHashMap;

/**
 * Created by IntelliJ IDEA.
 * User: brightpower
 * Date: 2010-1-9
 * Time: 11:51:17
 * To change this template use File | Settings | File Templates.
 */
@Repository
public class AutoSerialDaoHibernate extends BaseDaoSupport<AutoSerial> implements AutoSerialDao {
    public AutoSerial getAutoSerial(String queryStr, LinkedHashMap<String, Object> queryParamMap){
        Query query = this.getSession().createQuery(queryStr).setString("groupName", queryParamMap.get("groupName").toString());
        return (AutoSerial) query.uniqueResult();
    }
}
