package com.ming800.core.p.dao.hibernate;
import com.ming800.core.p.dao.DocumentDao;
import com.ming800.core.p.model.Document;
import com.ming800.core.p.model.Tag;
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
public class DocumentDaoHibernate implements DocumentDao{


    @Autowired
    @Qualifier("sessionFactory")
    private SessionFactory sessionFactory;

    public Session getSession() {
//        sessionFactory
        return sessionFactory.getCurrentSession();
    }

    @Override
    public  List getDocumentList(String groupName){

        Session session = this.getSession();
        Query query = session.createQuery("SELECT d FROM Document d WHERE d.group = :group and d.status = 1  order by d.id ")
                .setString("group", groupName);
        return query.list();

      /*  Object [] objects = new  Object[]{group};
        String  hql = "SELECT * FROM Tag d where d.status != 0  and d.group = :group";

          return xdoDao.getObjectList(hql,objects);*/
    }

    /***
     * 保存字典
     * @param document
     */
    @Override
    public void saveDocument(Document document){

        this.getSession().saveOrUpdate(document);
    }


    @Override
    public void  deleteDocument(Document document){
        String hql = "delete from Document where  id = :id";
        Query query = this.getSession().createQuery(hql)
                .setString("id", document.getId());
        query.executeUpdate();
    }

    @Override
    public void  removeDocument(Document document){
        String hql = "update Document set status = 0 where  id = :id";
        Query query = this.getSession().createQuery(hql)
                .setString("id", document.getId());
        query.executeUpdate();
    }
}
