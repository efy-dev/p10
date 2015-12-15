package com.efeiyi.ec.system.zero.company.service.impl;

import com.efeiyi.ec.system.zero.company.dao.CompanyOrderBatchDao;
import com.efeiyi.ec.system.zero.company.service.CompanyOrderBatchServiceManager;
import com.efeiyi.ec.zero.company.model.CompanyOrderBatch;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by Administrator on 2015/12/15.
 * 企业礼品卡批次 Service实现类
 */

@Service
public class CompanyOrderBatchServiceManagerImpl implements CompanyOrderBatchServiceManager {

    @Autowired
    private CompanyOrderBatchDao companyOrderBatchDao;

    @Override
    public void buildOrderGiftSetByCompanyOrderBatch(CompanyOrderBatch companyOrderBatch) throws Exception {
        companyOrderBatchDao.buildOrderGiftSetByCompanyOrderBatch(companyOrderBatch);
    }
}
