package com.efeiyi.ec.website.organization.service.impl;

import com.efeiyi.ec.website.organization.service.ProductManager;
import com.efeiyi.ec.website.product.model.Product;
import com.ming800.core.base.dao.BaseDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by ACؼman on 2015/6/17.
 */

@Service
@Transactional
public class ProductManagerImpl implements ProductManager {

    @Autowired
    private BaseDao baseDao;


    @Override
    public List<Product> findByPrice(Double price) {
        List<Object> param = new ArrayList<Object>();
        String hql = "select p from Product p where p.price > ?";
        param.add(price);
        return baseDao.getObjectListByConditions(hql, null);
    }
}
