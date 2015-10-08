package com.efeiyi.ec.system.product.service.impl;

import com.efeiyi.ec.product.model.ProductModel;
import com.efeiyi.ec.product.model.ProductModelRecord;
import com.efeiyi.ec.system.product.dao.ProductModelDao;
import com.efeiyi.ec.system.product.service.ProductModelManager;
import com.ming800.core.base.dao.XdoDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by Administrator on 2015/8/17.
 */
@Service
public class ProductModelManagerImpl implements ProductModelManager {

    @Autowired
    private ProductModelDao productModelDao;
    @Autowired
    private XdoDao xdoDao;
    @Override
    public int getMaxRecommendedIndex(String categoryId) {

        return productModelDao.getMaxRecommendedIndex(categoryId);
    }

    @Override
    public Integer updateAmount(String id, Integer amount, String creator) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String date = sdf.format(new Date());
        Integer tempAmount = null;
        try {
            ProductModel productModel = (ProductModel)xdoDao.getObject(ProductModel.class.getName(),id);
            tempAmount = amount + productModel.getAmount();
            productModel.setAmount(tempAmount);
            xdoDao.saveOrUpdateObject(ProductModel.class.getName(), productModel);
            ProductModelRecord productModelRecord = new ProductModelRecord();
            productModelRecord.setAmount(amount);
            productModelRecord.setProductModel(productModel);
            productModelRecord.setCreateDateTime(sdf.parse(date));
            productModelRecord.setCreator(creator);
            productModelRecord.setStatus("1");
            xdoDao.saveOrUpdateObject(productModelRecord);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return tempAmount;
    }
}
