package com.efeiyi.pal.system.product.service.impl;

import com.efeiyi.pal.organization.model.Tenant;
import com.efeiyi.pal.product.model.Product;
import com.efeiyi.pal.product.model.ProductSeries;
import com.efeiyi.pal.product.model.TenantProductSeries;
import com.efeiyi.pal.system.product.dao.ProductDao;
import com.efeiyi.pal.system.product.service.ProductServiceManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

/**
 * Created by Administrator on 2015/8/22.
 */

@Service
public class ProductServiceManagerImpl implements ProductServiceManager {

    @Autowired
    @Qualifier("productDaoHibernate")
    private ProductDao productDao;

    @Override
    public boolean getDeliverLabelByProduct(Product product) {
        return productDao.getDeliverLabelByProduct(product);
    }

    @Override
    public Object getTenantProductSeriesByTenantAndProductSeries(Tenant tenant, ProductSeries productSeries) {
        return productDao.getTenantProductSeriesByTenantAndProductSeries(tenant, productSeries);
    }

}
