package com.efeiyi.ec.system.zero.company.service;

import com.efeiyi.ec.zero.company.model.CompanyOrderBatch;

/**
 * Created by Administrator on 2015/12/15.
 * 企业礼品卡批次 Service
 */
public interface CompanyOrderBatchServiceManager {

    void buildOrderGiftSetByCompanyOrderBatch(CompanyOrderBatch companyOrderBatch) throws Exception;

}
