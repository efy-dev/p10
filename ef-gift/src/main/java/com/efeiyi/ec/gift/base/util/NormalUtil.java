package com.efeiyi.ec.gift.base.util;

import com.efeiyi.ec.product.model.ProductModel;

import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2016/2/15 0015.
 */
public class NormalUtil {

    public static void productNameFilter(List<ProductModel> productModelList, Map<ProductModel, String> map) {
        if (productModelList != null && productModelList.size() > 0) {
            for (ProductModel productModelTemp : productModelList) {
                StringBuilder s = new StringBuilder(productModelTemp.getProduct().getName());
                if (productModelTemp.getProduct().getProductModelList().size() == 1) {
                    map.put(productModelTemp, s.toString());
                } else {
                    s.append("[").append(productModelTemp.getName());
                    if (s.toString().length() > 14) {
                        s = new StringBuilder(s.substring(0, 14));
                        s.append("...").append("]");
                    } else {
                        s.append("]");
                    }
                    map.put(productModelTemp, s.toString());
                }
            }
        }
    }

}
