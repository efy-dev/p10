package com.efeiyi.ec.website.order.service.impl;

import com.efeiyi.ec.product.model.ProductModel;
import com.efeiyi.ec.website.order.service.StockManager;
import org.springframework.stereotype.Service;

/**
 * Created by Administrator on 2015/10/21 0021.
 */
@Service
public class StockManagerImpl implements StockManager {

    @Override
    public boolean isOutOfStock(ProductModel productModel, Integer amount) {
        return productModel.getAmount() >= amount;

    }

    @Override
    public boolean isStockEmpty(ProductModel productModel, Integer amount) {
        return productModel.getAmount() <= 0 && amount <= 0;
    }
}
