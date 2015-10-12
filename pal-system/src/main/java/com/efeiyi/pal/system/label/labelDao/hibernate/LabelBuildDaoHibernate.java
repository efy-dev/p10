package com.efeiyi.pal.system.label.labelDao.hibernate;

import com.efeiyi.pal.label.model.Label;
import com.efeiyi.pal.label.model.LabelBatch;
import com.efeiyi.pal.system.autoCode.Code2UrlConsumer;
import com.efeiyi.pal.system.autoCode.Url2FileConsumer;
import com.efeiyi.pal.system.label.labelDao.LabelBuildDao;
import com.ming800.core.p.service.AutoSerialManager;
import org.apache.commons.lang.RandomStringUtils;
import org.hibernate.CacheMode;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
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
    @Qualifier("autoSerialManager")
    private AutoSerialManager autoSerialManager;

    public Session getSession() {
        return sessionFactory.getCurrentSession();
    }

    /**
     * 批量生成二维码标签
     * @param labelBatch
     * @throws Exception
     */
    @Override
    public void buildLabelSetByLabelBatch(LabelBatch labelBatch) throws Exception{
        Session session = getSession();//使用同一个session
        session.setCacheMode(CacheMode.IGNORE);//关闭与二级缓存的交互
        Integer num = labelBatch.getAmount();
        int count = 0;
        Url2FileConsumer url2FileConsumer = new Url2FileConsumer(num,labelBatch.getId());
        for (int x = 0; x < 100; x++) {
            new Thread(new Code2UrlConsumer(url2FileConsumer)).start();
        }
        new Thread(url2FileConsumer).start();
//        long begin = System.currentTimeMillis();
        for (int i = 1; i <= num;) {
            String code = RandomStringUtils.randomNumeric(18);
            code = Long.toString(Long.parseLong(code), 36);
            if (code.length() != 12) {
               continue;
            }
            url2FileConsumer.getCodeList().add(code);
            i++;
            String serial = autoSerialManager.nextSerial("palLabelSerial");
            Label label = new Label();
            label.setSerial(serial);
            label.setCode(code);
            label.setLabelBatch(labelBatch);
            label.setPurchaseOrderLabel(null);
            label.setSeller(null);
            label.setStatus("1");
            session.saveOrUpdate(label);
            count++;
            if (count == 500) {
                session.flush();
                session.clear();
                count = 0;
            }
        }
        session.flush();
        url2FileConsumer.setGeneratorEnd(true);
        synchronized (url2FileConsumer.getCodeList()) {
            url2FileConsumer.getCodeList().notifyAll();
        }
//        System.out.print(System.currentTimeMillis()-begin);
    }

    /**
     * 批量生成 NFC标签的防伪码
     * @param labelBatch
     * @throws Exception
     */
    @Override
    public void buildLabelSetByLabelBatchNFC(LabelBatch labelBatch) throws Exception {
        Session session = getSession();//使用同一个session
        session.setCacheMode(CacheMode.IGNORE);//关闭与二级缓存的交互
        Integer num = labelBatch.getAmount();
        int count = 0;
//        long begin = System.currentTimeMillis();
        for (int i = 1; i <= num;) {
            String code = RandomStringUtils.randomNumeric(17);
            code = Long.toString(Long.parseLong(code), 36);
            if (code.length() != 11) {
                continue;
            }
            i++;
            String serial = autoSerialManager.nextSerial("palLabelSerial");
            Label label = new Label();
            label.setSerial(serial);
            label.setCode(code);
            label.setLabelBatch(labelBatch);
            label.setPurchaseOrderLabel(null);
            label.setSeller(null);
            label.setStatus("1");
            session.saveOrUpdate(label);
            count++;
            if (count == 500) {
                session.flush();
                session.clear();
                count = 0;
            }
        }
        session.flush();
//        System.out.print(System.currentTimeMillis()-begin);
    }

}
