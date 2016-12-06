package com.efeiyi.ec.website.product.service;

import com.efeiyi.ec.product.model.ProductModel;
import com.efeiyi.ec.website.product.model.RequestParamModel;

/**
 * Created by Administrator on 2016/12/5 0005.
 */
public interface ProductManager {

    ProductModel getProductModelById(String id) throws Exception;

    Object searchProductModels(RequestParamModel requestParamModel) throws Exception;

    Object getProductCategory() throws Exception;

    Object getTenantGroup(RequestParamModel requestParamModel) throws Exception;

    Object searchProductModelsByGroup(RequestParamModel requestParamModel) throws Exception;


}
