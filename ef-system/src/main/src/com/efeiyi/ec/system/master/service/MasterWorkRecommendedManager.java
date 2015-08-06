package com.efeiyi.ec.system.master.service;

import com.efeiyi.ec.master.model.MasterWorkRecommended;
import com.ming800.core.p.model.ObjectRecommended;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: ming
 * Date: 12-8-6
 * Time: 上午11:02
 * To change this template use File | Settings | File Templates.
 */
public interface MasterWorkRecommendedManager {


    /**
     * 删除作品推荐
     * 删除作品时 作品推荐状态随之删除
     * @param masterWorkId
     */
    void deleteMasterWorkRecommendByMasterWork(String masterWorkId);

    /**
     * 删除作品推荐
     * 取消作品推荐时 作品推荐随之删除
     * @param masterWorkRecommended
     */
    void  deleteMasterWorkRecommend(MasterWorkRecommended masterWorkRecommended);

    /**
     * 删除作品推荐
     * 删除项目时 项目中的所有推荐作品随之删除
     * @param projectId
     */
    void deleteMasterWorkRecommendByProject(String projectId);


    /**
     * 删除作品推荐
     * 删除大师时 大师的所有作品推荐随之删除
     * @param masterId
     */
    void deleteMasterWorkRecommendByMaster(String masterId);


}
