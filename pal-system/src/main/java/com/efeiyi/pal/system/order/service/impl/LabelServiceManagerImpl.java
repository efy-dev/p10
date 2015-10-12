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
import java.util.Map;

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
    public List<Label> getLabelListByMinSerialAndSumProduct(Integer sumProduct, String type) {
        return labelDao.getLabelListByMinSerialAndSumProduct(sumProduct, type);
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED)
    public void distributeLabelList(PurchaseOrder purchaseOrder, Map<String, List<Label>> listMap) {

        List<PurchaseOrderLabel> POLList = purchaseOrder.getPurchaseOrderLabelList();
        int flag = 0;
        //分配二维码标签
        for (int j=0; j<POLList.size(); j++){
            PurchaseOrderLabel pol = POLList.get(j);
            if ("2".equals(pol.getType())){
                continue;
            }
            for (int i=0; i<pol.getAmount(); i++){
                Label label = listMap.get("listQR").get(i+flag);
                label.setPurchaseOrderLabel(pol);
                label.setSeller(purchaseOrder.getTenant());
                label.setStatus("2");
                labelDao.saveOrUpdate(Label.class.getName(), label);
            }
            flag += pol.getAmount();
        }


        //还需要写入文件---待处理

        flag = 0;
        //分配NFC标签
        for (int j=0; j<POLList.size(); j++){
            PurchaseOrderLabel pol = POLList.get(j);
            if ("1".equals(pol.getType())){
                continue;
            }
            for (int i=0; i<pol.getAmount(); i++){
                Label label = listMap.get("sumNFC").get(i+flag);
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
