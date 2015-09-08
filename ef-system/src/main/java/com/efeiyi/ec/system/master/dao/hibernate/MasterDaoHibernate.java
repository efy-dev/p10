package com.efeiyi.ec.system.master.dao.hibernate;
import com.efeiyi.ec.master.model.Master;
import com.efeiyi.ec.master.model.MasterWorkRecommended;
import com.efeiyi.ec.system.master.dao.MasterDao;
import com.efeiyi.ec.system.master.dao.MasterWorkRecommendedDao;
import com.ming800.core.base.dao.XdoDao;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: lxh
 * Date: 2010-1-15
 * Time: 13:43:45
 * To change this template use File | Settings | File Templates.
 */
@Repository
public class MasterDaoHibernate implements MasterDao {

    @Autowired
    private  XdoDao xdoDao ;

    @Autowired
    @Qualifier("sessionFactory")
    private SessionFactory sessionFactory;

    public Session getSession() {
//        sessionFactory
        return sessionFactory.getCurrentSession();
    }


@Override
 public List<Master> getMasterList(String tenantId){
     String hql = "from Master where status = '1' and id not in (select master.id from TenantMaster where tenant.id = :tenantId and  status = '1')";
     Query query = this.getSession().createQuery(hql)
             .setString("tenantId",tenantId);
     return  (List<Master>)query.list();
 }




}
