package com.efeiyi.association.dao.hibernate;

import com.efeiyi.association.dao.MyDocumentDao;
import com.ming800.core.p.model.Document;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: Administrator
 * Date: 2015-10-09
 */

@Repository
public class MyDocumentDaoHibernate implements MyDocumentDao {

    @Autowired
    @Qualifier("sessionFactory")
    private SessionFactory sessionFactory;

    public Session getSession() {
        return sessionFactory.getCurrentSession();
    }

    @Override
    public  List getDocumentList(String groupName){
        Session session = this.getSession();
        Query query = session.createQuery("SELECT d FROM Document d WHERE d.group = :group and d.status = 1  order by d.id ")
                .setString("group", groupName);
        return query.list();
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
        String sql = "delete from base_document where id = :id";
        Query query = this.getSession().createSQLQuery(sql)
                .setString("id", document.getId());
        query.executeUpdate();
    }

    @Override
    public void  removeDocument(Document document){
        String sql = "update base_document set status = 0 where  id = :id";
        Query query = this.getSession().createSQLQuery(sql)
                .setString("id", document.getId());
        query.executeUpdate();
    }
}
