package com.efeiyi.ec.website.product.service;

import com.efeiyi.ec.product.model.ProductModel;

/**
 * Created by Administrator on 2016/12/5 0005.
 */
public interface ProductManager {

    ProductModel getProductModelById(String id) throws Exception;

}
