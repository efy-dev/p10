package com.efeiyi.ec.website.product.service.impl;

import com.efeiyi.ec.product.model.ProductModel;
import com.efeiyi.ec.website.base.util.ApplicationException;
import com.efeiyi.ec.website.product.service.ProductManager;
import com.ming800.core.base.service.BaseManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by Administrator on 2016/12/5 0005.
 */
@Service
public class ProductManagerImpl implements ProductManager {


    @Autowired
    private BaseManager baseManager;

    @Override
    public ProductModel getProductModelById(String id) throws Exception {
        ProductModel productModel;
        if (id != null) {
            try {
                productModel = (ProductModel) baseManager.getObject(ProductModel.class.getName(), id);
            } catch (Exception e) {
                throw new ApplicationException(ApplicationException.SQL_ERROR);
            }
        } else {
            throw new ApplicationException(ApplicationException.PARAM_ERROR);
        }
        return productModel;
    }
}
