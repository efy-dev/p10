package com.efeiyi.ec.system.product.dao;

import java.util.List;

public interface ProductDao {
    int getMaxRecommendedIndex(String categoryId);
    public List getResult();
    /**获取商品详情图片最大排序**/
    public Integer getProductPicture(String productId);
}
