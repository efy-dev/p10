package com.efeiyi.ec.system.product.service;

import com.efeiyi.ec.master.model.MasterWorkRecommended;
import com.efeiyi.ec.product.model.Product;
import com.efeiyi.ec.product.model.ProductDescription;
import com.efeiyi.ec.system.product.model.ProductModelBean;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: ming
 * Date: 12-8-6
 * Time: 上午11:02
 * To change this template use File | Settings | File Templates.
 */
public interface ProductManager {

    Product saveProductDescription(ProductDescription productDescription);

    Product saveProduct(Product product);

    Product saveProductModel(ProductModelBean productModelBean) throws  Exception;

    Product setProductStatus(String status,String id);

    Integer productPictureSort(String productId);

    Integer productPictureSort1(String productId);

    void changePictureSort(String sourceId,String sourceSort,String targetId,String targetSort);

}
