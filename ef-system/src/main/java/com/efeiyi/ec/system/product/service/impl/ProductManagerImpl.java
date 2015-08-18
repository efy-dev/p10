package com.efeiyi.ec.system.product.service.impl;

import com.efeiyi.ec.system.product.dao.ProductDao;
import com.efeiyi.ec.system.product.service.ProductManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by Administrator on 2015/8/17.
 */
@Service
public class ProductManagerImpl implements ProductManager{

    @Autowired
    private ProductDao productDao;
    @Override
    public int getMaxRecommendedIndex(String categoryId) {

        return productDao.getMaxRecommendedIndex(categoryId);
    }
}
