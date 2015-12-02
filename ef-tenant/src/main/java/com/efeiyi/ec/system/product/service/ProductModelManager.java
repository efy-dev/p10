package com.efeiyi.ec.system.product.service;

/**
 * Created by Administrator on 2015/8/17.
 */
public interface ProductModelManager {
    int getMaxRecommendedIndex(String categoryId);

    Integer updateAmount(String id, Integer amount, String creator);
}
