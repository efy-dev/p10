package com.efeiyi.ec.system.product.service.impl;

import com.efeiyi.ec.master.model.Master;
import com.efeiyi.ec.product.model.*;
import com.efeiyi.ec.project.model.Project;
import com.efeiyi.ec.project.model.ProjectPropertyValue;
import com.efeiyi.ec.system.product.dao.ProductDao;
import com.efeiyi.ec.system.product.model.ProductModelBean;
import com.efeiyi.ec.system.product.service.ProductManager;
import com.efeiyi.ec.tenant.model.Tenant;
import com.ming800.core.base.dao.XdoDao;
import com.ming800.core.p.service.AutoSerialManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Created by Administrator on 2015/8/17.
 */
@Service
public class ProductManagerImpl implements ProductManager{

    @Autowired
    private ProductDao productDao;

    @Autowired
    private XdoDao xdoDao;

    @Autowired
    private AutoSerialManager autoSerialManager;

    @Override
    public int getMaxRecommendedIndex(String categoryId) {

        return productDao.getMaxRecommendedIndex(categoryId);
    }


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
                product.setStatus("2");
            }else {
                product.setProductModelList(xdoDao.getObjectList("from ProductModel where status!='0' and product.id=?",new Object[]{product.getId()}));
            }
            System.out.print("".equals(product.getProductDescription().getId()));
            if("".equals(product.getProductDescription().getId())){
                product.setProductDescription(null);
            }else {
                product.setProductDescription((ProductDescription) xdoDao.getObject(ProductDescription.class.getName(), product.getProductDescription().getId()));
            }
            if("".equals(product.getMaster().getId())){
                product.setMaster(null);
            }else {
                product.setMaster((Master) xdoDao.getObject(Master.class.getName(), product.getMaster().getId()));
            }
            if("".equals(product.getProject().getId())){
                product.setProject(null);
            }else {
                product.setProject((Project) xdoDao.getObject(Project.class.getName(), product.getProject().getId()));
            }
            if ("".equals(product.getTenant().getId())){
                product.setTenant((Tenant) xdoDao.getObject(Tenant.class.getName(), product.getTenant().getId()));
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
        String[] status = productModelBean.getModelStatus();
        Product product = (Product)xdoDao.getObject(Product.class.getName(), productModelBean.getProductId());
        if(ids != null){
            if (ids.length > 0) {
                for (int i = 0,j=0; i < ids.length; i++) {
                    if ("".equals(ids[i])) {
                        ProductModel productModel = new ProductModel();
                        productModel.setName(productModelBean.getModelName()[i]);
                        if(!"".equals(productModelBean.getModelAmount()[i])) {
                            productModel.setAmount(Integer.parseInt(productModelBean.getModelAmount()[i]));
                        }else {
                            productModel.setAmount(null);
                        }

                        if(!"".equals(productModelBean.getModelPrice()[i])) {
                            productModel.setPrice(new BigDecimal(productModelBean.getModelPrice()[i]));
                        }else {
                            productModel.setPrice(null);
                        }
                        if(!"".equals(productModelBean.getMarketPrice()[i])) {
                            productModel.setMarketPrice(new BigDecimal(productModelBean.getMarketPrice()[i]));
                        }else {
                            productModel.setMarketPrice(null);
                        }
                        productModel.setProduct(product);
                        productModel.setSerial(autoSerialManager.nextSerial("productModel"));
                        productModel.setStatus(status[i]);
                        if("1".equals(status[i])){
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
                        }
                        if("2".equals(status[i])){
                            productModel.setCustomProperty(productModelBean.getProperty()[j++]);
                            xdoDao.saveOrUpdateObject(productModel);
                        }

                    } else {
                        if ("0".equals(productModelBean.getModelStatus()[i])||"-1".equals(productModelBean.getModelStatus()[i])) {
                            ProductModel temp = (ProductModel)xdoDao.getObject(ProductModel.class.getName(),ids[i]);

                            xdoDao.deleteObject(ProductModel.class.getName(), ids[i]);
                            if(temp!=null) {
                                deleteProductPropertyValue(ids[i]);
                            }
                            if("-1".equals(productModelBean.getModelStatus()[i])){
                                j++;
                            }
                        } else if ("1".equals(productModelBean.getModelStatus()[i])) {
                            ProductModel productModel = (ProductModel) xdoDao.getObject(ProductModel.class.getName(), ids[i]);
                            if(!"".equals(productModelBean.getModelAmount()[i])) {
                                productModel.setAmount(Integer.parseInt(productModelBean.getModelAmount()[i]));
                            }else {
                                productModel.setAmount(null);
                            }

                            if(!"".equals(productModelBean.getModelPrice()[i])) {
                                productModel.setPrice(new BigDecimal(productModelBean.getModelPrice()[i]));
                            }else {
                                productModel.setPrice(null);
                            }
                            if(!"".equals(productModelBean.getMarketPrice()[i])) {
                                productModel.setMarketPrice(new BigDecimal(productModelBean.getMarketPrice()[i]));
                            }else {
                                productModel.setMarketPrice(null);
                            }
                         //   productModel.setAmount(Integer.parseInt(productModelBean.getModelAmount()[i]));
                            productModel.setName(productModelBean.getModelName()[i]);
                         //   productModel.setPrice(new BigDecimal(productModelBean.getModelPrice()[i]));
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
                        }else  if("2".equals(productModelBean.getModelStatus()[i])){
                            ProductModel productModel = (ProductModel) xdoDao.getObject(ProductModel.class.getName(), ids[i]);
                            if(!"".equals(productModelBean.getModelAmount()[i])) {
                                productModel.setAmount(Integer.parseInt(productModelBean.getModelAmount()[i]));
                            }else {
                                productModel.setAmount(null);
                            }

                            if(!"".equals(productModelBean.getModelPrice()[i])) {
                                productModel.setPrice(new BigDecimal(productModelBean.getModelPrice()[i]));
                            }else {
                                productModel.setPrice(null);
                            }
                            if(!"".equals(productModelBean.getMarketPrice()[i])) {
                                productModel.setMarketPrice(new BigDecimal(productModelBean.getMarketPrice()[i]));
                            }else {
                                productModel.setMarketPrice(null);
                            }
                    //        productModel.setAmount(Integer.parseInt(productModelBean.getModelAmount()[i]));
                            productModel.setName(productModelBean.getModelName()[i]);
                    //        productModel.setPrice(new BigDecimal(productModelBean.getModelPrice()[i]));
                            productModel.setCustomProperty(productModelBean.getProperty()[j++]);
                            xdoDao.saveOrUpdateObject(productModel);
                        }
                    }
                }
            }
        }
        if ("".equals(productModelBean.getDefaultId())) {
            ProductModel productModel = new ProductModel();
            if(!"".equals(productModelBean.getDefaultPrice())) {
                productModel.setAmount(Integer.parseInt(productModelBean.getDefaultAmount()));
            }else {
                productModel.setAmount(null);
            }
            productModel.setName(productModelBean.getDefaultName());
            if(!"".equals(productModelBean.getDefaultPrice())) {
                productModel.setPrice(new BigDecimal(productModelBean.getDefaultPrice()));
            }else {
                productModel.setPrice(null);
            }
            if(!"".equals(productModelBean.getDefaultMarketPrice())) {
                productModel.setMarketPrice(new BigDecimal(productModelBean.getDefaultMarketPrice()));
            }else {
                productModel.setMarketPrice(null);
            }
            productModel.setProduct(product);
            productModel.setSerial(autoSerialManager.nextSerial("productModel"));
            productModel.setStatus(productModelBean.getDefaultStatus());
            xdoDao.saveOrUpdateObject(productModel);
        }else {
            ProductModel productModel = (ProductModel) xdoDao.getObject(ProductModel.class.getName(), productModelBean.getDefaultId());
            if(!"".equals(productModelBean.getDefaultPrice())) {
                productModel.setAmount(Integer.parseInt(productModelBean.getDefaultAmount()));
            }
            productModel.setName(productModelBean.getDefaultName());
            if(!"".equals(productModelBean.getDefaultPrice())) {
                productModel.setPrice(new BigDecimal(productModelBean.getDefaultPrice()));
            }
            if(!"".equals(productModelBean.getDefaultMarketPrice())) {
                productModel.setMarketPrice(new BigDecimal(productModelBean.getDefaultMarketPrice()));
            }
       //     productModel.setAmount(Integer.parseInt(productModelBean.getDefaultAmount()));
            productModel.setName(productModelBean.getDefaultName());
       //     productModel.setPrice(new BigDecimal(productModelBean.getDefaultPrice()));
            xdoDao.saveOrUpdateObject(productModel);
        }

        return  product;
    }

    public void deleteProductPropertyValue(String modelId){
        List<ProductPropertyValue> pvs =  (List<ProductPropertyValue>)xdoDao.getObjectList("from ProductPropertyValue where 1=1 and productModel.id = ?",new Object[]{modelId});
        for(ProductPropertyValue productPropertyValue : pvs){
            xdoDao.deleteObject(ProductPropertyValue.class.getName(),productPropertyValue.getId());
        }
    }


    public void removeProduct(String id){

    }

    @Override
    public Subject saveSubject(Subject subject, String[] flag, String[] spId, String[] subjectPicture) {
        SubjectDescription subjectDescription = subject.getSubjectDescription();
        if("".equals(subject.getId())) {
            subject.setId(null);
            subjectDescription.setId(null);
        }
        xdoDao.saveOrUpdateObject(subjectDescription);
        subject.setSubjectDescription(subjectDescription);
        subject.setStatus("1");
        subject.setSubjectIndex(1);
        xdoDao.saveOrUpdateObject(subject);
            for(int i=0;i<spId.length;i++){
                if("0".equals(spId[i])){
                    SubjectPicture subjectPicture1 = new SubjectPicture();
                    subjectPicture1.setSubject(subject);
                    subjectPicture1.setPictureUrl(subjectPicture[i]);
                    xdoDao.saveOrUpdateObject(subjectPicture1);

                }else {
                    if("-1".equals(flag[i])){
                        xdoDao.deleteObject(SubjectPicture.class.getName(),spId[i]);

                    }
                }
            }

        return subject;
    }

    @Override
    public Product setProductStatus(String status, String id) {
        Product product = (Product)xdoDao.getObject(Product.class.getName(),id);
        product.setStatus(status);
        xdoDao.saveOrUpdateObject(product);
        return product;
    }
}
