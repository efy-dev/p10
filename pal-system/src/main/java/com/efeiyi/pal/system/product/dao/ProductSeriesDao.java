package com.efeiyi.pal.system.product.dao;

import com.efeiyi.pal.product.model.ProductSeriesPropertyName;

/**
 * Created by Administrator on 2015/8/27.
 */

public interface ProductSeriesDao {

    Integer deletePropertyValueByPropertyName(ProductSeriesPropertyName propertyName);

}
