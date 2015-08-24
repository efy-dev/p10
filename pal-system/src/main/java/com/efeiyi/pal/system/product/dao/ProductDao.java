package com.efeiyi.pal.system.product.dao;

import com.efeiyi.pal.organization.model.Tenant;
import com.efeiyi.pal.product.model.Product;
import com.efeiyi.pal.product.model.ProductSeries;
import com.efeiyi.pal.product.model.TenantProductSeries;

/**
 * Created by Administrator on 2015/8/22.
 */
public interface ProductDao {
    boolean getDeliverLabelByProduct(Product product);

    Object getTenantProductSeriesByTenantAndProductSeries(Tenant tenant, ProductSeries productSeries);
}
