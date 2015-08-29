package com.efeiyi.pal.system.product.dao;

import com.efeiyi.pal.product.model.ProductSeriesPropertyName;
import com.efeiyi.pal.product.model.TenantProductSeries;

/**
 * Created by Administrator on 2015/8/27.
 */

public interface ProductSeriesDao {

    Integer deletePropertyValueByPropertyName(ProductSeriesPropertyName propertyName);

    void saveOrUpdate(String modelType, Object object);
}
