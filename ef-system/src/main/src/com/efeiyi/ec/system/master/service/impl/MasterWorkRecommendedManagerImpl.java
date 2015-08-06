package com.efeiyi.ec.system.master.service.impl;

import com.efeiyi.ec.master.model.MasterWorkRecommended;
import com.efeiyi.ec.system.master.dao.MasterWorkRecommendedDao;
import com.efeiyi.ec.system.master.service.MasterWorkRecommendedManager;
import com.ming800.core.base.dao.XdoDao;
import com.ming800.core.p.dao.RecommendedDao;
import com.ming800.core.p.model.CommonRecommended;
import com.ming800.core.p.model.ObjectRecommended;
import com.ming800.core.p.service.CommonManager;
import com.ming800.core.p.service.ObjectRecommendedManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: ming
 * Date: 12-8-6
 * Time: 上午11:04
 * To change this template use File | Settings | File Templates.
 */
@Service
public class MasterWorkRecommendedManagerImpl implements MasterWorkRecommendedManager {

    @Autowired
    private MasterWorkRecommendedDao masterWorkRecommendedDao;


    @Override
    public void deleteMasterWorkRecommendByMasterWork(String masterWorkId) {
        masterWorkRecommendedDao.deleteMasterWorkRecommendByMasterWork(masterWorkId);
    }

    @Override
    public void deleteMasterWorkRecommend(MasterWorkRecommended masterWorkRecommended) {
        masterWorkRecommendedDao.deleteMasterWorkRecommend(masterWorkRecommended);
    }

    @Override
    public void deleteMasterWorkRecommendByProject(String projectId) {
         masterWorkRecommendedDao.deleteMasterWorkRecommendByProject(projectId);
    }

    @Override
    public void deleteMasterWorkRecommendByMaster(String masterId) {
        masterWorkRecommendedDao.deleteMasterWorkRecommendByMaster(masterId);
    }
}
