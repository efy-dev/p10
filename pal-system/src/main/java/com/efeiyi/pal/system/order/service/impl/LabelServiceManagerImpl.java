package com.efeiyi.pal.system.order.service.impl;

import com.efeiyi.pal.label.model.Label;
import com.efeiyi.pal.system.order.dao.LabelDao;
import com.efeiyi.pal.system.order.service.LabelServiceManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by Administrator on 2015/8/18.
 */

@Service
public class LabelServiceManagerImpl implements LabelServiceManager {

    @Autowired
    @Qualifier("labelDaoHibernate")
    private LabelDao labelDao;

    @Override
    public Integer getMinSerial() {
        return labelDao.getMinSerial();
    }

    @Override
    public List<Label> getLabelListByMinSerialAndSumProduct(Integer minSerial, Integer sumProduct) {
        return labelDao.getLabelListByMinSerialAndSumProduct(minSerial, sumProduct);
    }

}
