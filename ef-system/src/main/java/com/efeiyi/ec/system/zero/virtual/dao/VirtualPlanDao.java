package com.efeiyi.ec.system.zero.virtual.dao;

import com.efeiyi.ec.purchase.model.PurchaseOrderProduct;
import com.efeiyi.ec.zero.virtual.model.VirtualOrderPlan;
import com.efeiyi.ec.zero.virtual.model.VirtualUser;
import com.efeiyi.ec.zero.virtual.model.VirtualUserPlan;
import com.ming800.core.taglib.PageEntity;

import java.util.List;

/**
 * Created by Administrator on 2015/12/9.
 * 虚拟计划 Dao
 */
public interface VirtualPlanDao {

    /**
     * 获取订单计划中计划的订单总数
     * @param virtualOrderPlan 虚拟订单计划
     * @return 虚拟订单计划中订单总数
     * @throws Exception
     */
    Integer getOrderRelation(VirtualOrderPlan virtualOrderPlan)throws Exception;

    /**
     * 获取虚拟订单计划已完成的订单列表
     * @param virtualOrderPlan 虚拟订单计划
     * @param pageEntity 分页信息
     * @return 订单商品列表
     */
    List<PurchaseOrderProduct> getOrderProductList(VirtualOrderPlan virtualOrderPlan, PageEntity pageEntity)throws Exception;

    /**
     * 获取虚拟用户计划已完成的用户列表
     * @param virtualUserPlan 虚拟用户计划
     * @param pageEntity 分页信息
     * @return 虚拟用户列表
     * @throws Exception
     */
    List<VirtualUser> getVirtualUserList(VirtualUserPlan virtualUserPlan, PageEntity pageEntity)throws Exception;

    /**
     * 删除虚拟计划
     * @param id 计划Id
     * @throws Exception
     */
    void deleteVirtualPlan(String id)throws Exception;
}
