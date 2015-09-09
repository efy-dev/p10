package com.efeiyi.pal.system.base.dao;

import com.efeiyi.pal.organization.model.Tenant;
import com.efeiyi.pal.product.model.ProductSeries;

import java.util.Set;

/**
 * Created by Administrator on 2015/9/8.
 *
 */
public interface ModalDao {

    Set<Object> getListLikesName(String name, String type);

    Set<Object> getObjectByTenantLikesName(String name, Tenant tenant, String type);

    Set<Object> getTypeFromTenantProductSeriesLikesName(String name, String type);

    Set<Object> getTypeFromTenantProductSeriesByObjectLikesName(String name, String type, String type2, Object object);

}
