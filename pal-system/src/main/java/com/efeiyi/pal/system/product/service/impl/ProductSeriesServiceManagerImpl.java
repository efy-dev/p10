package com.efeiyi.pal.system.product.service.impl;

import com.efeiyi.pal.product.model.ProductSeriesPropertyName;
import com.efeiyi.pal.system.product.dao.ProductSeriesDao;
import com.efeiyi.pal.system.product.service.ProductSeriesServiceManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

/**
 * Created by Administrator on 2015/8/27.
 */

@Service
public class ProductSeriesServiceManagerImpl implements ProductSeriesServiceManager {

    @Autowired
    @Qualifier("productSeriesDaoHibernate")
    private ProductSeriesDao productSeriesDao;

    @Override
    public Integer deleteProductPropertyValueByPropertyName(ProductSeriesPropertyName propertyName) {
        return productSeriesDao.deletePropertyValueByPropertyName(propertyName);
    }

}
