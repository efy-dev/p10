package com.ming800.core.p.dao.hibernate;

import com.ming800.core.base.dao.hibernate.BaseDaoSupport;
import com.ming800.core.p.dao.DictionaryDao;
import com.ming800.core.p.model.DictionaryData;
import org.hibernate.Query;
import org.hibernate.Session;
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
public class DictionaryDaoHibernate extends BaseDaoSupport<DictionaryData> implements DictionaryDao {

    @Override
    public List<DictionaryData> getDictionaryDataListById(Integer branchId, String sid) {
        Session session = this.getSession();
        Query query = session.createQuery("SELECT d FROM DictionaryData d WHERE d.branch.id = :branchId and d.dictionaryId = :sid and d.theStatus = 0 order by d.id ")
                .setInteger("branchId", branchId)
                .setString("sid", sid);
        return query.list();
    }

    @Override
    public DictionaryData getDictionaryData(Integer branchId, Integer id) {
        Session session = this.getSession();
        DictionaryData dictionaryData = (DictionaryData) session.get(DictionaryData.class, id);
        return dictionaryData.getTheStatus() == 0 ? dictionaryData : null;
      /*  if(this.super.getObjectList("SELECT d FROM DictionaryData d WHERE d.branchId ="+branchId+" and d.id ="+id+" and d.status = 0")!=null){
            return (DictionaryData)this.super.getObjectList("FROM DictionaryData d WHERE d.branchId ="+branchId+" and d.id ="+id+" and d.status = 0").get(0);
        }else{
            return null;
        }*/
    }

   /* @Override
    public PageInfo getDictionaryDataList(Integer branchId,String sid, PageEntity pageEntity) {
        Session session = this.getSession();
        Query listQuery = session.createQuery("SELECT d FROM DictionaryData d WHERE d.branchId = :branchId and d.definationName = :sid and d.status = 0")
                .setInteger("branchId",branchId)
                .setString("sid",sid);
        Query countQuery = session.createQuery("SELECT COUNT(d.id) FROM DictionaryData d WHERE d.branchId = :branchId and d.definationName = :sid and d.status = 0")
                .setInteger("branchId",branchId)
                .setString("sid",sid);
        return this.getPageInfo(listQuery,countQuery,pageEntity);
    }*/

    @Override
    public void saveOrUpdateDictionaryData(DictionaryData dictData) {
        super.saveOrUpdateObject(dictData);//To change body of implemented methods use File | Settings | File Templates.
    }

    public List<DictionaryData> getDictDefinationList(String sid) {
        Query query = this.getSession().createQuery("FROM DictionaryData d  where d.dictionaryId='" + sid + "'");
        return query.list();
    }

    public void saveOrUpdateData(DictionaryData dictionaryData) {
        super.saveOrUpdateObject(dictionaryData);
    }

    public void updateDictionaryData(DictionaryData dictionaryData) {
        super.updateObject(dictionaryData);

    }
}
