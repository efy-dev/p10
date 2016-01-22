package com.efeiyi.ec.system.yale.question.dao.hibernate;

import com.efeiyi.ec.system.yale.question.dao.ScoreboardDao;
import com.ming800.core.p.model.WxCalledRecord;
import com.ming800.core.taglib.PageEntity;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

/**
 * Created by Administrator on 2016/1/18.
 * 排行榜 dao hibernate
 */
@SuppressWarnings("JpaQlInspection")
@Repository
public class ScoreboardDaoHibernate implements ScoreboardDao {

    @Autowired
    @Qualifier("sessionFactory")
    private SessionFactory sessionFactory;

    public Session getSession() {
        return sessionFactory.getCurrentSession();
    }

    @Override
    public Integer getSize(Date selStartDate, Date selEndDate) {
        String hql = "select distinct ppr.wxCalledRecord from ParticipationRecord ppr where record_type='1'and ppr.wxCalledRecord.dataKey='wxqaopenid'";
        hql = getHql(hql, selStartDate, selEndDate);
        Query query = this.getSession().createQuery(hql);
        query = getQuery(query, selStartDate, selEndDate);
        return query.list().size();
    }

    @Override
    public List<WxCalledRecord> getWxCalledRecordList(PageEntity pageEntity, Date selStartDate, Date selEndDate) {
        String hql = "select distinct ppr.wxCalledRecord from ParticipationRecord ppr where record_type='1'and ppr.wxCalledRecord.dataKey='wxqaopenid'";
        hql = getHql(hql, selStartDate, selEndDate);
        Query query = this.getSession().createQuery(hql)
                .setFirstResult(pageEntity.getrIndex())
                .setMaxResults(pageEntity.getSize());
        query = getQuery(query, selStartDate, selEndDate);
        return query.list();
    }

    @Override
    public Object[] getAnswerCountAndDate(WxCalledRecord wxCalledRecord, Date selStartDate, Date selEndDate) {
        String hql = "select count(ppr.id),min(ppr.createDatetime),max(ppr.createDatetime) from ParticipationRecord ppr where ppr.wxCalledRecord=:wxCalledRecord and ppr.recordType='1'";
        hql = getHql(hql, selStartDate, selEndDate);
        Query query = this.getSession().createQuery(hql).setParameter("wxCalledRecord", wxCalledRecord);
        query = getQuery(query, selStartDate, selEndDate);

        List list = query.list();

        if (list != null && list.size() >0){
            return (Object[]) list.get(0);
        }
        return null;
    }

    @Override
    public BigDecimal getRewardTotal(WxCalledRecord wxCalledRecord, Date selStartDate, Date selEndDate) {
        String hql = "select sum(ppr.balanceRecord.changeBalance) from ParticipationRecord ppr where ppr.wxCalledRecord=:wxCalledRecord and ppr.recordType='1'";
        hql = getHql(hql, selStartDate, selEndDate);
        Query query = this.getSession().createQuery(hql).setParameter("wxCalledRecord", wxCalledRecord);
        query = getQuery(query, selStartDate, selEndDate);

        List list = query.list();

        try{
            if (list != null && list.size() >0){
                return BigDecimal.valueOf(Double.valueOf(list.get(0).toString()));
            }
        }catch (Exception e){
//            System.out.println("当前微信记录Id: " + wxCalledRecord.getId() +" 用户没有奖励金额");
        }
        return new BigDecimal(0);
    }

    @Override
    public Integer getShareCount(WxCalledRecord wxCalledRecord, Date selStartDate, Date selEndDate) {
        String hql = "select count(ppr2.id) from ParticipationRecord ppr,ParticipationRecord ppr2 " +
                     "where ppr.recordType='1' and ppr.wxCalledRecord=:wxCalledRecord and ppr2.examination=ppr.examination and ppr2.recordType='2'";
        hql = getHql(hql, selStartDate, selEndDate);
        Query query = this.getSession().createQuery(hql).setParameter("wxCalledRecord", wxCalledRecord);
        query = getQuery(query, selStartDate, selEndDate);

        List list = query.list();
        if (list != null && list.size() >0){
            return Integer.parseInt(list.get(0).toString());
        }
        return null;
    }

    /**
     * 根据查询时间拼接HQL
     * @param hql HQL语句
     * @param selStartDate 开始时间
     * @param selEndDate 结束时间
     * @return HQL语句
     */
    private String getHql(String hql, Date selStartDate, Date selEndDate){
        hql = selStartDate == null? hql : hql+" and ppr.createDatetime > :selStartDate";
        hql = selEndDate == null? hql : hql+" and ppr.createDatetime < :selEndDate";
        return hql;
    }

    /**
     * 根据查询时间设置query参数
     * @param query query
     * @param selStartDate 开始时间
     * @param selEndDate 结束时间
     * @return query
     */
    private Query getQuery(Query query, Date selStartDate, Date selEndDate){
        query = selStartDate == null? query : query.setDate("selStartDate", selStartDate);
        query = selEndDate == null? query : query.setDate("selEndDate", selEndDate);
        return query;
    }
}
