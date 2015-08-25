package com.efeiyi.pal.system.order.service.impl;

import com.efeiyi.pal.label.model.Label;
import com.efeiyi.pal.purchase.model.PurchaseOrder;
import com.efeiyi.pal.purchase.model.PurchaseOrderLabel;
import com.efeiyi.pal.system.order.dao.LabelDao;
import com.efeiyi.pal.system.order.service.LabelServiceManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by Administrator on 2015/8/18.
 */

@Service
@EnableTransactionManagement
public class LabelServiceManagerImpl implements LabelServiceManager {

    @Autowired
    @Qualifier("labelDaoHibernate")
    private LabelDao labelDao;

    @Override
    public List<Label> getLabelListByMinSerialAndSumProduct(Integer sumProduct) {
        return labelDao.getLabelListByMinSerialAndSumProduct(sumProduct);
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED)
    public void distributeLabelList(PurchaseOrder purchaseOrder, List<Label> labelList) {

        List<PurchaseOrderLabel> POLList = purchaseOrder.getPurchaseOrderLabelList();
        int flag = 0;
        for (int j=0; j<POLList.size(); j++){
            PurchaseOrderLabel pol = POLList.get(j);
            for (int i=0; i<pol.getAmount(); i++){
                Label label = labelList.get(i+flag);
                label.setPurchaseOrderLabel(pol);
                label.setSeller(purchaseOrder.getTenant());
                label.setStatus("2");
                labelDao.saveOrUpdate(Label.class.getName(), label);
            }
            flag += pol.getAmount();
        }

    }

    @Override
    public List<Label> getLabelListByOrder(PurchaseOrder purchaseOrder) {
        return labelDao.getLabelListByOrder(purchaseOrder);
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED)
    public void activateOrCancelLabelList(String status, List<Label> labels) {
        for (Label label:labels){
            label.setStatus(status);
            labelDao.saveOrUpdate(Label.class.getName(), label);
        }
    }

}
