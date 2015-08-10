package com.efeiyi.ec.system.master.dao.hibernate;
import com.efeiyi.ec.master.model.MasterWorkRecommended;
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
public class MasterWorkRecommendedDaoHibernate implements MasterWorkRecommendedDao {

    @Autowired
    private  XdoDao xdoDao ;

    @Autowired
    @Qualifier("sessionFactory")
    private SessionFactory sessionFactory;

    public Session getSession() {
//        sessionFactory
        return sessionFactory.getCurrentSession();
    }



    /**
     * 获取推荐列表
     * @param queryHql
     * @param firstResult
     * @param maxResult
     * @param params
     * @return
     */

   /*
    public  List getObjectListByLimit(String queryHql,Integer firstResult,Integer maxResult,Object... params){
        Query query = this.getSession().createQuery(queryHql);
        query = setParameters(query, params);
        query.setFirstResult(firstResult);
        query.setMaxResults(maxResult);
        return  query.list();

    }
    protected Query setParameters(Query query, Object[] paramlist) {
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
        return query;
    }
*/
    /***
     * 保存作品推荐
     * @param masterWorkRecommended
     */
    @Override
    public void saveMasterWorkRecommend(MasterWorkRecommended masterWorkRecommended){

        this.getSession().saveOrUpdate(masterWorkRecommended);
    }

    /**
     * 更新排序字段
     * @param objectRecommended
     * @return
     */
   /*
    public  Integer  updateSort(ObjectRecommended objectRecommended){

        String hql = "update ObjectRecommended set sort = :sort where id=:id";
        Query query =  this.getSession().createQuery(hql)
                .setInteger("sort", objectRecommended.getSort())
                .setString("id", objectRecommended.getId());
        return    query.executeUpdate();
    }
*/



    @Override
    public String   deleteMasterWorkRecommend(MasterWorkRecommended masterWorkRecommended){
       String hql = "delete from MasterWorkRecommended where  id = :id";
        Query query = this.getSession().createQuery(hql)
                .setString("id", masterWorkRecommended.getId());
        query.executeUpdate();
        return  masterWorkRecommended.getId();
    }

    @Override
    public String deleteMasterWorkRecommendByMasterWork(String masterWorkId){
       String hql = "delete from MasterWorkRecommended where masterWork.id = :masterWorkId";
        Query query = this.getSession().createQuery(hql)
                .setString("masterWorkId",masterWorkId);
        query.executeUpdate();
        return  masterWorkId;
    }

    @Override
    public List deleteMasterWorkRecommendByProject(String projectId){
      List list =  xdoDao.getObjectList("from MasterWorkRecommended where project.id = ?", new Object[]{projectId});
        for( Object o: list){
            deleteMasterWorkRecommend((MasterWorkRecommended)o);
        }
        return  list;
    }

    @Override
    public List deleteMasterWorkRecommendByMaster(String masterId){
        List list =  xdoDao.getObjectList("from MasterWorkRecommended where master.id = ?", new Object[]{masterId});
        for( Object o: list){
            deleteMasterWorkRecommend((MasterWorkRecommended)o);
        }
        return  list;
    }

}
