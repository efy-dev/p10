package com.efeiyi.pal.system.label.labelDao.hibernate;

import com.efeiyi.pal.label.model.Label;
import com.efeiyi.pal.label.model.LabelBatch;
import com.efeiyi.pal.system.label.labelDao.LabelBuildDao;
import com.ming800.core.p.service.AutoSerialManager;
import org.apache.commons.lang.RandomStringUtils;
import org.hibernate.CacheMode;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

/**
 * Created by Administrator on 2015/8/19.
 */

@Repository
public class LabelBuildDaoHibernate implements LabelBuildDao {

    @Autowired
    @Qualifier("sessionFactory")
    private SessionFactory sessionFactory;

    @Autowired
    private AutoSerialManager autoSerialManager;

    public Session getSession() {
        return sessionFactory.getCurrentSession();
    }

    @Override
    public void buildLabelSetByLabelBatch(LabelBatch labelBatch) throws Exception{
        Session session = getSession();//使用同一个session
        session.setCacheMode(CacheMode.IGNORE);//关闭与二级缓存的交互
        //Transaction tx = session.beginTransaction();
        Integer flag = labelBatch.getAmount();

        for (int i = 1; i <= flag; i++) {
            String code = RandomStringUtils.randomNumeric(10);
            Long serial = autoSerialManager.nextSerial("palLabelSerial");
            Label label = new Label();
            label.setSerial(serial);
            label.setCode(code);
            label.setLabelBatch(labelBatch);
            label.setPurchaseOrderLabel(null);
            label.setSeller(null);
            label.setStatus("1");
            session.saveOrUpdate(label);
            if (i % 50 == 0) {
                session.flush();
                session.clear();
            }
        }
       // tx.commit();
    }

}
