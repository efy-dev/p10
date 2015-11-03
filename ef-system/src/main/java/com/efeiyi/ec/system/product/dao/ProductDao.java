package com.efeiyi.ec.system.product.dao;

import java.util.List;

public interface ProductDao {
    int getMaxRecommendedIndex(String categoryId);
    public List getResult();
}
