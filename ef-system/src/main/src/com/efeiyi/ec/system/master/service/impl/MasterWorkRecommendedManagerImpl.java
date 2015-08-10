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
    public String deleteMasterWorkRecommendByMasterWork(String masterWorkId) {
        masterWorkRecommendedDao.deleteMasterWorkRecommendByMasterWork(masterWorkId);
        return  masterWorkId;
    }

    @Override
    public String deleteMasterWorkRecommend(MasterWorkRecommended masterWorkRecommended) {
        masterWorkRecommendedDao.deleteMasterWorkRecommend(masterWorkRecommended);
        return  masterWorkRecommended.getId();
    }

    @Override
    public List deleteMasterWorkRecommendByProject(String projectId) {

        return  masterWorkRecommendedDao.deleteMasterWorkRecommendByProject(projectId);
    }

    @Override
    public List deleteMasterWorkRecommendByMaster(String masterId) {
       return masterWorkRecommendedDao.deleteMasterWorkRecommendByMaster(masterId);
    }

    @Override
    public void saveMasterWorkRecommend(MasterWorkRecommended masterWorkRecommended) {
        masterWorkRecommendedDao.saveMasterWorkRecommend(masterWorkRecommended);
    }
}
