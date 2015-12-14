package com.efeiyi.ec.system.product.service;

import com.efeiyi.ec.product.model.Product;
import com.efeiyi.ec.product.model.ProductDescription;
import com.efeiyi.ec.product.model.Subject;
import com.efeiyi.ec.system.product.model.ProductModelBean;

/**
 * Created by Administrator on 2015/8/17.
 */
public interface ProductManager {
    int getMaxRecommendedIndex(String categoryId);

    Product saveProductDescription(ProductDescription productDescription);

    Product saveProduct(Product product);

    Product saveProductModel(ProductModelBean productModelBean) throws  Exception;

    Subject saveSubject(Subject subject, String[] flag,String[] spId,String[] subjectPicture);

    Product setProductStatus(String status,String id);

    String outExcel1(String[] homes,String on,String down);

    public  Integer productPictureSort(String productId);

    Integer productPictureSort1(String productId);

    public void changePictureSort(String sourceId,String sourceSort,String targetId,String targetSort);
}
