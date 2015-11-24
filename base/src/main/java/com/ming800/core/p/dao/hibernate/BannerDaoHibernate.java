package com.ming800.core.p.dao.hibernate;

import com.ming800.core.base.dao.hibernate.BaseDaoSupport;
import com.ming800.core.p.dao.BannerDao;
import com.ming800.core.p.dao.TagDao;
import com.ming800.core.p.model.Banner;
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
public class BannerDaoHibernate  implements BannerDao {

    @Autowired
    @Qualifier("sessionFactory")
    private SessionFactory sessionFactory;

    public Session getSession() {
//        sessionFactory
        return sessionFactory.getCurrentSession();
    }

    @Override
    public  List getBannerList(String groupName){

        Session session = this.getSession();
        Query query = session.createQuery("SELECT d FROM Banner d WHERE d.group = :group and d.status = '1'  order by d.bannerOrder desc ")
                .setString("group", groupName);
        return query.list();

      /*  Object [] objects = new  Object[]{group};
        String  hql = "SELECT * FROM Tag d where d.status != 0  and d.group = :group";

          return xdoDao.getObjectList(hql,objects);*/
    }

    /***
     * 保存轮播图
     * @param banner
     */
    @Override
    public void saveBanner(Banner banner){

        this.getSession().saveOrUpdate(banner);
    }


    @Override
    public void  deleteBanner(Banner banner){
        String hql = "delete from Banner where  id = :id";
        Query query = this.getSession().createQuery(hql)
                .setString("id", banner.getId());
        query.executeUpdate();
    }

    @Override
    public void  removeBanner(Banner banner){
        String hql = "update Banner set status = '0' where  id = :id";
        Query query = this.getSession().createQuery(hql)
                .setString("id", banner.getId());
        query.executeUpdate();
    }
    @Override
    public void  updateBannerOrder(Banner banner){
        String hql = "update Banner set bannerOrder = :bannerOrder where  id = :id";
        Query query = this.getSession().createQuery(hql)
                .setInteger("bannerOrder",banner.getBannerOrder())
                .setString("id", banner.getId());
        query.executeUpdate();
    }
}
