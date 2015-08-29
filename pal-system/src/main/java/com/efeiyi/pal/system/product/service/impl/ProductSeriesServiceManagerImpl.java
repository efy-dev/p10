package com.efeiyi.pal.system.product.service.impl;

import com.efeiyi.pal.organization.model.Tenant;
import com.efeiyi.pal.organization.model.TenantCertification;
import com.efeiyi.pal.product.model.Product;
import com.efeiyi.pal.product.model.ProductSeries;
import com.efeiyi.pal.product.model.ProductSeriesPropertyName;
import com.efeiyi.pal.product.model.TenantProductSeries;
import com.efeiyi.pal.system.product.dao.ProductSeriesDao;
import com.efeiyi.pal.system.product.service.ProductSeriesServiceManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

/**
 * Created by Administrator on 2015/8/27.
 */

@Service
@EnableTransactionManagement
public class ProductSeriesServiceManagerImpl implements ProductSeriesServiceManager {

    @Autowired
    @Qualifier("productSeriesDaoHibernate")
    private ProductSeriesDao productSeriesDao;

    @Override
    public Integer deleteProductPropertyValueByPropertyName(ProductSeriesPropertyName propertyName) {
        return productSeriesDao.deletePropertyValueByPropertyName(propertyName);
    }

    /**
     * 删除商品系列时（status=0），删除关联项
     * @param productSeries
     */
    @Override
    @Transactional(propagation = Propagation.REQUIRED)
    public void removeTenantProductSeriesByProductSeries(ProductSeries productSeries) {
        for (TenantProductSeries tps: productSeries.getTenantProductSeriesList()){
            tps.setStatus("0");
            productSeriesDao.saveOrUpdate(TenantProductSeries.class.getName(), tps);
        }
        for (Product p: productSeries.getProductList()){
            p.setStatus("0");
            productSeriesDao.saveOrUpdate(Product.class.getName(), p);
        }
    }

    /**
     * 删除商户时（status=0），删除关联项
     * @param tenant
     */
    @Override
    @Transactional(propagation = Propagation.REQUIRED)
    public void removeTenantProductSeriesByTenant(Tenant tenant) {
        for (TenantProductSeries tps: tenant.getTenantProductSeriesList()){
            tps.setStatus("0");
            productSeriesDao.saveOrUpdate(TenantProductSeries.class.getName(), tps);
        }
        for (Product p: tenant.getProductList()){
            p.setStatus("0");
            productSeriesDao.saveOrUpdate(Product.class.getName(), p);
        }
    }

    /**
     * 删除商户系列时（status=0），删除关联项
     * @param tenantProductSeries
     */
    @Override
    @Transactional(propagation = Propagation.REQUIRED)
    public void removeTenantProductSeries(TenantProductSeries tenantProductSeries) {
        for (Product p: tenantProductSeries.getProductList()){
            p.setStatus("0");
            productSeriesDao.saveOrUpdate(Product.class.getName(), p);
        }
        tenantProductSeries.setStatus("0");
        productSeriesDao.saveOrUpdate(TenantProductSeries.class.getName(), tenantProductSeries);
    }

    @Override
    public void removeTenantCertification(TenantCertification tenantCertification) {
        for (TenantProductSeries tps: tenantCertification.getTenantProductSeriesList()){
            tps.setTenantCertification(null);
            productSeriesDao.saveOrUpdate(TenantProductSeries.class.getName(), tps);
        }
        tenantCertification.setStatus("0");
        productSeriesDao.saveOrUpdate(TenantCertification.class.getName(), tenantCertification);
    }

}
