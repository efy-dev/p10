package com.efeiyi.ec.system.project.service;

import com.efeiyi.ec.product.model.Product;
import com.efeiyi.ec.product.model.ProductDescription;
import com.efeiyi.ec.system.product.model.ProductModelBean;

/**
 * Created by Administrator on 2015/8/17.
 */
public interface ProjectManager {
    /**
     * 关联商家
     * @param tenantId
     * @param projectId
     * @param tenantProjectId
     * @param status
     * @return
     */
   String linkTenant(String tenantId,String projectId,String tenantProjectId,String status);

    String removeProject(String id);
}
