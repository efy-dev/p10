package com.efeiyi.ec.website.order.service;

import com.efeiyi.ec.purchase.model.PrepaidCard;
import com.efeiyi.ec.purchase.model.PrepaidCardRecord;
import com.efeiyi.ec.purchase.model.PurchaseOrder;

public interface PrepaidCardManager {

    PrepaidCardRecord createPrepaidCardRecord(PurchaseOrder order, PrepaidCard prepaidCard);

    PrepaidCardRecord createPrepaidCardRecord(String orderId, PrepaidCard prepaidCard);

    PrepaidCardRecord confirmPrepaidCardRecord(String purchaseOrderId);

    PrepaidCardRecord getPrepaidCardRecordById(String prepaidCardRecordId);

    PrepaidCardRecord saveOrUpdatePrepaidCardRecord(PrepaidCardRecord prepaidCardRecord);

    PrepaidCard getPrepaidCardById(String prepaidCardId);

    PrepaidCard getPrepaidCardByCode(String code);

    PrepaidCard saveOrUpdatePrepaidCard(PrepaidCard prepaidCard);

    PrepaidCardRecord getPrepaidCardRecordByOrderId(String purchaseOrderId, String status);

}
