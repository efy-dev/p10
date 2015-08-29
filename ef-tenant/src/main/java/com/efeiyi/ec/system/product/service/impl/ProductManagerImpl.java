package com.efeiyi.ec.system.product.service.impl;
import com.efeiyi.ec.product.model.Product;
import com.efeiyi.ec.product.model.ProductDescription;
import com.efeiyi.ec.product.model.ProductModel;
import com.efeiyi.ec.product.model.ProductPropertyValue;
import com.efeiyi.ec.project.model.ProjectProperty;
import com.efeiyi.ec.project.model.ProjectPropertyValue;
import com.efeiyi.ec.system.product.model.ProductModelBean;
import com.efeiyi.ec.system.product.service.ProductManager;
import com.ming800.core.base.dao.XdoDao;
import com.ming800.core.p.service.AutoSerialManager;
import org.apache.commons.beanutils.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: ming
 * Date: 12-8-6
 * Time: 上午11:04
 * To change this template use File | Settings | File Templates.
 */
@Service
public class ProductManagerImpl implements ProductManager {

    @Autowired
    private XdoDao xdoDao;

    @Autowired
    private AutoSerialManager autoSerialManager;

    @Override
    public Product saveProductDescription(ProductDescription productDescription){

        Product productTemp = (Product)xdoDao.getObject(Product.class.getName(),productDescription.getProduct().getId());

            try {
                if("".equals(productDescription.getId())){
                    productDescription.setId(null);
                    productDescription.setProduct(productTemp);
                    xdoDao.saveOrUpdateObject(ProductDescription.class.getName(), productDescription);
                    productTemp.setProductDescription(productDescription);
                    xdoDao.saveOrUpdateObject(Product.class.getName(), productTemp);
                }else {
                    xdoDao.saveOrUpdateObject(ProductDescription.class.getName(), productDescription);
                }


            }catch (Exception e){
                e.printStackTrace();
            }

        return  productTemp;
    }

    @Override
    public Product saveProduct(Product product) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        try {
        if("".equals(product.getId())){
                product.setId(null);
                product.setCreateDateTime(sdf.parse(sdf.format(new Date())));

        }
            System.out.print("".equals(product.getProductDescription().getId()));
            if("".equals(product.getProductDescription().getId())){
                product.setProductDescription(null);
            }else {
                product.setProductDescription((ProductDescription)xdoDao.getObject(ProductDescription.class.getName(),product.getProductDescription().getId()));
            }

            xdoDao.saveOrUpdateObject(Product.class.getName(),product);
        }catch (Exception e){
            e.printStackTrace();
        }


        return product;
    }


    @Override
    public Product saveProductModel(ProductModelBean productModelBean) throws  Exception{

        String[] ids = productModelBean.getModelId();
        Product product = (Product)xdoDao.getObject(Product.class.getName(), productModelBean.getProductId());
        if(ids.length>0) {
            for (int i = 0; i < ids.length; i++) {
                if ("".equals(ids[i])) {
                    ProductModel productModel = new ProductModel();
                    productModel.setAmount(Integer.parseInt(productModelBean.getModelAmount()[i]));
                    productModel.setName(productModelBean.getModelName()[i]);
                    productModel.setPrice(new BigDecimal(productModelBean.getModelPrice()[i]));
                    productModel.setProduct(product);
                    productModel.setSerial(autoSerialManager.nextSerial("productModel"));
                    productModel.setStatus("1");
                    xdoDao.saveOrUpdateObject(productModel);
                    String[] propertyValueIds = productModelBean.getModelProperty()[i].split(",");
                    for (String propertyValueId : propertyValueIds) {
                        ProjectPropertyValue projectPropertyValue = (ProjectPropertyValue) xdoDao.getObject(ProjectPropertyValue.class.getName(), propertyValueId);
                        ProductPropertyValue productPropertyValue = new ProductPropertyValue();
                        productPropertyValue.setProductModel(productModel);
                        productPropertyValue.setProjectPropertyValue(projectPropertyValue);
                        productPropertyValue.setProjectProperty(projectPropertyValue.getProjectProperty());
                        xdoDao.saveOrUpdateObject(productPropertyValue);
                    }
                } else {
                    if ("0".equals(productModelBean.getModelStatus()[i])) {
                        xdoDao.deleteObject(ProductModel.class.getName(), ids[i]);
                        deleteProductPropertyValue(ids[i]);
                    } else if ("1".equals(productModelBean.getModelStatus()[i])) {
                        ProductModel productModel = (ProductModel) xdoDao.getObject(ProductModel.class.getName(), ids[i]);
                        productModel.setAmount(Integer.parseInt(productModelBean.getModelAmount()[i]));
                        productModel.setName(productModelBean.getModelName()[i]);
                        productModel.setPrice(new BigDecimal(productModelBean.getModelPrice()[i]));
                        xdoDao.saveOrUpdateObject(productModel);
                        deleteProductPropertyValue(ids[i]);
                        String[] propertyValueIds = productModelBean.getModelProperty()[i].split(",");
                        for (String propertyValueId : propertyValueIds) {
                            ProjectPropertyValue projectPropertyValue = (ProjectPropertyValue) xdoDao.getObject(ProjectPropertyValue.class.getName(), propertyValueId);
                            ProductPropertyValue productPropertyValue = new ProductPropertyValue();
                            productPropertyValue.setProductModel(productModel);
                            productPropertyValue.setProjectPropertyValue(projectPropertyValue);
                            productPropertyValue.setProjectProperty(projectPropertyValue.getProjectProperty());
                            xdoDao.saveOrUpdateObject(productPropertyValue);
                        }
                    }
                }
            }
        }
        return  product;
    }

    public void deleteProductPropertyValue(String modelId){
        List<ProductPropertyValue> pvs =  (List<ProductPropertyValue>)xdoDao.getObjectList("from ProductPropertyValue where 1=1 and productModel.id = ?",new Object[]{modelId});
        for(ProductPropertyValue productPropertyValue : pvs){
            xdoDao.deleteObject(ProductPropertyValue.class.getName(),productPropertyValue.getId());
        }
    }


}
