package com.efeiyi.ec.system.product.service.impl;

import com.efeiyi.ec.system.product.dao.ProductModelDao;
import com.efeiyi.ec.system.product.service.ProductModelManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by Administrator on 2015/8/17.
 */
@Service
public class ProductModelManagerImpl implements ProductModelManager {

    @Autowired
    private ProductModelDao productModelDao;
    @Override
    public int getMaxRecommendedIndex(String categoryId) {

        return productModelDao.getMaxRecommendedIndex(categoryId);
    }
}
