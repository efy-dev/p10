package com.efeiyi.pal.system.order.dao;

import com.efeiyi.pal.label.model.Label;
import com.efeiyi.pal.purchase.model.PurchaseOrder;

import java.util.List;

/**
 * Created by Administrator on 2015/8/18.
 */
public interface LabelDao {

    List<Label> getLabelListByMinSerialAndSumProduct(Integer sumProduct);

    void saveOrUpdate(String modelType, Object object);

    List<Label> getLabelListByOrder(PurchaseOrder purchaseOrder);

}
