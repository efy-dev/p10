package com.efeiyi.pal.system.product.service;

import com.efeiyi.pal.organization.model.Tenant;
import com.efeiyi.pal.organization.model.TenantCertification;
import com.efeiyi.pal.product.model.ProductSeries;
import com.efeiyi.pal.product.model.ProductSeriesPropertyName;
import com.efeiyi.pal.product.model.TenantProductSeries;

/**
 * Created by Administrator on 2015/8/27.
 */

public interface ProductSeriesServiceManager {

    Integer deleteProductPropertyValueByPropertyName(ProductSeriesPropertyName propertyName);

    void removeTenantProductSeriesByProductSeries(ProductSeries productSeries);

    void removeTenantProductSeriesByTenant(Tenant tenant);

    void removeTenantProductSeries(TenantProductSeries tenantProductSeries);

    void removeTenantCertification(TenantCertification tenantCertification);

}
