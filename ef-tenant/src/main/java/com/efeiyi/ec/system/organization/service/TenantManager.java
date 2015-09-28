package com.efeiyi.ec.system.organization.service;

/**
 * Created by Administrator on 2015/8/17.
 */
public interface TenantManager {
    /**
     * 关联商家
     * @param tenantId
     * @param projectId
     * @param tenantProjectId
     * @param status
     * @return
     */
   String linkProject(String tenantId, String projectId, String tenantProjectId, String status);

    String linkProduct(String tenantCategoryId, String productId, String tenantProductId, String status);

    String linkMaster(String tenantId,String masterId,String tenantMasterId,String status);
}
