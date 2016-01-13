package com.efeiyi.ec.system.zero.company.dao;

import com.efeiyi.ec.purchase.model.PurchaseOrderGift;
import com.efeiyi.ec.zero.company.model.CompanyOrderBatch;

import java.util.List;

/**
 * Created by Administrator on 2015/12/15.
 * 企业礼品卡批次 Dao
 */
public interface CompanyOrderBatchDao {

    void buildOrderGiftSetByCompanyOrderBatch(CompanyOrderBatch companyOrderBatch) throws Exception;

    List<PurchaseOrderGift> getOrderGiftList(CompanyOrderBatch companyOrderBatch)throws Exception;

    void cancelOrderGift(String giftId)throws Exception;
}
