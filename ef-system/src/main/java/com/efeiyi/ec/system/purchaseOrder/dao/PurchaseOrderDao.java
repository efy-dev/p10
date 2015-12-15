package com.efeiyi.ec.system.purchaseOrder.dao;



import com.efeiyi.ec.purchase.model.PurchaseOrder;
import com.ming800.core.base.dao.BaseDao;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: ming
 * Date: 12-10-16
 * Time: ����4:18
 * To change this template use File | Settings | File Templates.
 */
public interface PurchaseOrderDao extends BaseDao<PurchaseOrder>{

    String updateOrderStatus(PurchaseOrder purchaseOrder);
    public List getResult();


}
