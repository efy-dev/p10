package com.ming800.core.p.dao.hibernate;

import com.ming800.core.base.dao.XdoDao;
import com.ming800.core.base.dao.hibernate.BaseDaoSupport;
import com.ming800.core.p.dao.TagDao;
import com.ming800.core.p.model.ObjectRecommended;
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
public class TagDaoHibernate  implements TagDao {


    @Autowired
    @Qualifier("sessionFactory")
    private SessionFactory sessionFactory;

    public Session getSession() {
//        sessionFactory
        return sessionFactory.getCurrentSession();
    }

    @Override
    public  List getTagList(String groupName){

        Session session = this.getSession();
        Query query = session.createQuery("SELECT d FROM Tag d WHERE d.groupName = :group and d.status = '1'  order by d.id ")
                .setString("group", groupName);
        return query.list();

      /*  Object [] objects = new  Object[]{group};
        String  hql = "SELECT * FROM Tag d where d.status != 0  and d.group = :group";

          return xdoDao.getObjectList(hql,objects);*/
    }

    /***
     * 保存字典
     * @param tag
     */
    @Override
    public void saveTag(Tag tag){

        this.getSession().saveOrUpdate(tag);
    }


    @Override
    public void  deleteTag(Tag tag){
        String hql = "delete from Tag where  id = :id";
        Query query = this.getSession().createQuery(hql)
                .setString("id", tag.getId());
        query.executeUpdate();
    }

    @Override
    public void  removeTag(Tag tag){
        String hql = "update Tag set status = '0' where  id = :id";
        Query query = this.getSession().createQuery(hql)
                .setString("id", tag.getId());
        query.executeUpdate();
    }
}
