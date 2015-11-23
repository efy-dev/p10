package com.efeiyi.ec.website.order.service;

import com.efeiyi.ec.product.model.ProductModel;
import org.omg.PortableInterceptor.INACTIVE;

/**
 * Created by Administrator on 2015/10/21 0021.
 */
public interface StockManager {

    boolean isOutOfStock(ProductModel productModel,Integer amount);

    boolean isStockEmpty(ProductModel productModel,Integer amount);

}