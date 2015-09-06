package com.efeiyi.ec.system.project.dao.hibernate;
import com.efeiyi.ec.project.model.Project;
import com.efeiyi.ec.system.project.dao.TenantProjectDao;
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
public class ProjectDaoHibernate implements TenantProjectDao {

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
 public List<Project> getProjectList(String tenantId){
     String hql = "from Project where id not in (select project.id from TenantProject where tenant.id = :tenantId and  status = '1')";
     Query query = this.getSession().createQuery(hql)
             .setString("tenantId",tenantId);
     return  (List<Project>)query.list();
 }




}
