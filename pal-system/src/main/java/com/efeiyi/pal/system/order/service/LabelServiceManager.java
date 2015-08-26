package com.efeiyi.pal.system.order.service;

import com.efeiyi.pal.label.model.Label;
import com.efeiyi.pal.purchase.model.PurchaseOrder;

import java.util.List;

/**
 * Created by Administrator on 2015/8/18.
 */
public interface LabelServiceManager {

    List<Label> getLabelListByMinSerialAndSumProduct(Integer sumProduct);

    void distributeLabelList(PurchaseOrder purchaseOrder, List<Label> labelList);

    List<Label> getLabelListByOrder(PurchaseOrder purchaseOrder);

    void activateOrCancelLabelList(String status, List<Label> labels);

}
