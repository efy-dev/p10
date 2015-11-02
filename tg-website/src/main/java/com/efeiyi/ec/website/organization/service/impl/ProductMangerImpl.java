package com.efeiyi.ec.website.organization.service.impl;

import com.efeiyi.ec.product.model.Product;
import com.efeiyi.ec.website.organization.service.ProductManger;
import com.ming800.core.base.dao.XdoDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;


/**
 * Created by Administrator on 2015/6/25.
 */
@Service
@Transactional
public class ProductMangerImpl implements ProductManger{


    @Autowired
    private XdoDao xdodao;
    @Override
    public List<Product> getProduct() {

        String hql ="from Product";
        List<Product> productList=xdodao.getObjectList(hql);
        return productList;

    }
}
