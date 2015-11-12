package com.efeiyi.ec.system.master.service;

import com.efeiyi.ec.master.model.MasterWorkRecommended;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: ming
 * Date: 12-8-6
 * Time: 上午11:02
 * To change this template use File | Settings | File Templates.
 */
public interface MasterManager {

    /**
     * 关联商家
     * @param tenantId
     * @param masterId
     * @param tenantMasterId
     * @param status
     * @return
     */
    String linkTenant(String tenantId,String masterId,String tenantMasterId,String status);

    String removeMaster(String id);

    String removeMasterMessage(String id);

}
