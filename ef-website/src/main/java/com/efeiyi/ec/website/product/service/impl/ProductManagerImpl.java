package com.efeiyi.ec.website.product.service.impl;

import com.efeiyi.ec.product.model.ProductModel;
import com.efeiyi.ec.purchase.model.CartProduct;
import com.efeiyi.ec.website.base.util.ApplicationException;
import com.efeiyi.ec.website.product.model.RequestParamModel;
import com.efeiyi.ec.website.product.service.ProductManager;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.PageInfo;
import com.ming800.core.taglib.PageEntity;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.LinkedHashMap;

/**
 * Created by Administrator on 2016/12/5 0005.
 */
@Service
public class ProductManagerImpl implements ProductManager {


    @Autowired
    private BaseManager baseManager;

    @Override
    public ProductModel getProductModelById(String id) throws ApplicationException {
        ProductModel productModel;
        if (id != null) {
            try {
                productModel = (ProductModel) baseManager.getObject(ProductModel.class.getName(), id);
            } catch (Exception e) {
                throw new ApplicationException(ApplicationException.SQL_ERROR);
            }
        } else {
            throw new ApplicationException(ApplicationException.PARAM_ERROR);
        }
        return productModel;
    }


    @Override
    public CartProduct saveCartProduct(ProductModel productModel, Integer amount) throws ApplicationException {
        CartProduct cartProduct;
        if (productModel != null && amount != null) {
            cartProduct = new CartProduct();
            cartProduct.setStatus("9");
            cartProduct.setAmount(amount);
            cartProduct.setIsChoose("1");
            cartProduct.setProductModel(productModel);
            try {
                baseManager.saveOrUpdate(CartProduct.class.getName(), cartProduct);
            } catch (Exception e) {
                throw new ApplicationException(ApplicationException.SQL_ERROR);
            }
        } else {
            throw new ApplicationException(ApplicationException.PARAM_ERROR);
        }
        return cartProduct;
    }

    @Override
    public Object searchProductModels(RequestParamModel requestParamModel) throws Exception {
        StringBuilder hql = new StringBuilder("select obj from ProductModel obj where obj.status='1' and obj.product.type='3' and obj.product.status!='0' and obj.price IS NOT NULL");
        String startPrice = requestParamModel.getStartPrice();
        String endPrice = requestParamModel.getEndPrice();
        String projectCategoryId = requestParamModel.getProjectCategoryId();
        String sortField = requestParamModel.getSortField();
        String sortFlag = requestParamModel.getSortFlag();
        String name = requestParamModel.getName();
        PageEntity pageEntity = new PageEntity();
        PageInfo pageInfo;
        try {
            int limit = Integer.parseInt(requestParamModel.getLimit());
            int offset = Integer.parseInt(requestParamModel.getOffset());
            pageEntity.setSize(limit);
            pageEntity.setrIndex(offset);
        } catch (Exception e) {
            throw new ApplicationException(ApplicationException.PARAM_ERROR);
        }
        if (startPrice != null && !startPrice.equals("") && endPrice != null && !endPrice.equals("")) {
            hql.append(" and obj.price between '" + startPrice + "' and '" + endPrice + "' ");
        }
        if (projectCategoryId != null && !projectCategoryId.equals("")) {
            hql.append(" and obj.product.project.projectCategory.id='" + projectCategoryId + "' ");
        }
        if (name != null && !name.equals("")) {
            hql.append(" and obj.name like '%" + name + "%' ");
        }
        if (sortField != null && !sortField.equals("") && sortFlag != null && !sortFlag.equals("")) {
            hql.append(" order by obj." + sortField + " " + sortFlag);
        }
        try {
            pageInfo = baseManager.listPageInfo(hql.toString(), pageEntity, null);
        } catch (Exception e) {
            throw new ApplicationException(ApplicationException.SQL_ERROR);
        }
        return pageInfo;
    }

    @Override
    public Object getProductCategory() throws Exception {
        try {
            String hql = "select obj from ProjectCategory obj where obj.status='1'";
            return baseManager.listObject(hql);
        } catch (Exception e) {
            throw new ApplicationException(ApplicationException.SQL_ERROR);
        }
    }

    @Override
    public Object getTenantGroup(RequestParamModel requestParamModel) throws Exception {
        String id = requestParamModel.getTenantId();
        String hql = "select obj from TenantGroup obj where obj.status='1' and obj.tenant.id=:tenantId";
        LinkedHashMap<String, Object> param = new LinkedHashMap<>();
        if (id != null && !id.equals("")) {
            param.put("tenantId", id);
        } else {
            throw new ApplicationException(ApplicationException.PARAM_ERROR);
        }
        try {
            return baseManager.listObject(hql, param);
        } catch (Exception e) {
            throw new ApplicationException(ApplicationException.SQL_ERROR);
        }
    }

    @Override
    public Object searchProductModelsByGroup(RequestParamModel requestParamModel) throws Exception {
        JSONObject jsonObject;
        PageEntity pageEntity = new PageEntity();
        PageInfo pageInfo;
        try {
            jsonObject = JSONObject.fromObject(requestParamModel.getParam());
            int limit = Integer.parseInt(requestParamModel.getLimit());
            int offset = Integer.parseInt(requestParamModel.getOffset());
            pageEntity.setSize(limit);
            pageEntity.setrIndex(offset);
        } catch (Exception e) {
            throw new ApplicationException(ApplicationException.PARAM_ERROR);
        }
        LinkedHashMap<String, Object> param = new LinkedHashMap<>();
        StringBuilder hql = new StringBuilder("select productModel from ProductModel productModel where productModel.status='1' and productModel.product.status!='0' and productModel.product.type='3'and  productModel.price IS NOT NULL");
        String startPrice = "";
        String endPrice = "";
        try {
            for (Object key : jsonObject.keySet()) {
                if (key.toString().equals("startPrice")) {
                    if (jsonObject.get(key) != null && !jsonObject.get(key).equals("")) {
                        startPrice = jsonObject.get(key).toString();
                    }
                } else if (key.toString().equals("endPrice")) {
                    if (jsonObject.get(key) != null && !jsonObject.get(key).equals("")) {
                        endPrice = jsonObject.get(key).toString();
                    }
                } else {
                    hql.append(" and productModel.");
                    hql.append(key.toString());
                    hql.append("=:");
                    hql.append(paramKeyFillter(key.toString()));
                    hql.append(" ");
                    param.put(paramKeyFillter(key.toString()), jsonObject.get(key));
                }
            }
            if (!startPrice.equals("") && !endPrice.equals("")) {
                hql.append(" and productModel.price between '" + startPrice + "' and '" + endPrice + "'");
            }
        } catch (Exception e) {
            throw new ApplicationException(ApplicationException.PARAM_ERROR);
        }
        try {
            pageInfo = baseManager.listPageInfo(hql.toString(), pageEntity, param);
        } catch (Exception e) {
            throw new ApplicationException(ApplicationException.SQL_ERROR);
        }
        return pageInfo;
    }

    private String paramKeyFillter(String key) {
        return key.replaceAll("\\.", "_");
    }

}
