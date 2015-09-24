package com.efeiyi.ec.system.tenant.service.impl;

import com.efeiyi.ec.product.model.Product;
import com.efeiyi.ec.system.tenant.service.TenantManager;
import com.efeiyi.ec.tenant.model.TenantCategory;
import com.efeiyi.ec.tenant.model.TenantProductTag;
import com.ming800.core.base.dao.XdoDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by Administrator on 2015/8/17.
 */
@Service
public class TenantManagerImpl implements TenantManager{


    @Autowired
    private XdoDao xdoDao;



    @Override
    public String linkProduct(String tenantCategoryId, String productId, String tenantProductId, String status) {
        TenantProductTag tenantProductTag = null;
        try {
            tenantProductTag = (TenantProductTag)xdoDao.getObject(TenantProductTag.class.getName(),tenantProductId);
            if(tenantProductTag == null){
                tenantProductTag = new TenantProductTag();
                tenantProductTag.setTenantCategory((TenantCategory) xdoDao.getObject(TenantCategory.class.getName(), tenantCategoryId));
                tenantProductTag.setProduct((Product) xdoDao.getObject(Product.class.getName(), productId));
                tenantProductTag.setStatus("1");
            }else {
                if("0".equals(status)){
                    tenantProductTag.setStatus("1");
                }
                if("1".equals(status)){
//                    List<Product> productList = xdoDao.getObjectList("from Product where tenant.id=? and project.id=?",new Object[]{tenantId,tenantProject.getProject().getId()} );
//                    for(Product product:productList){
//                        product.setProject(null);
//                        xdoDao.saveOrUpdateObject(product);
//                    }
                    tenantProductTag.setStatus("0");
                }
            }
            xdoDao.saveOrUpdateObject(TenantProductTag.class.getName(), tenantProductTag);


        }catch (Exception e){
            e.printStackTrace();
        }
        return  tenantProductTag.getId();

    }
}
