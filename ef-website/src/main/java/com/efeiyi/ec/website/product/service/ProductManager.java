package com.efeiyi.ec.website.product.service;

import com.efeiyi.ec.product.model.ProductModel;
import com.efeiyi.ec.purchase.model.CartProduct;
import com.efeiyi.ec.website.base.util.ApplicationException;

/**
 * Created by Administrator on 2016/12/5 0005.
 */
public interface ProductManager {

    ProductModel getProductModelById(String id) throws ApplicationException;


    CartProduct saveCartProduct(ProductModel productModel, Integer amount) throws ApplicationException;

}
