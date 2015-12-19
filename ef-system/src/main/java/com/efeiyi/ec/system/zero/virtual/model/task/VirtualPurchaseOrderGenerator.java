package com.efeiyi.ec.system.zero.virtual.model.task;

import com.efeiyi.ec.product.model.ProductModel;
import com.efeiyi.ec.purchase.model.PurchaseOrder;
import com.efeiyi.ec.purchase.model.PurchaseOrderPayment;
import com.efeiyi.ec.purchase.model.PurchaseOrderProduct;
import com.efeiyi.ec.zero.virtual.model.*;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.util.ApplicationContextUtil;
import org.hibernate.exception.GenericJDBCException;
import org.springframework.transaction.support.TransactionSynchronizationManager;

import java.util.Date;
import java.util.List;
import java.util.Random;

/**
 * Created by Administrator on 2015/11/26.
 */
public class VirtualPurchaseOrderGenerator extends BaseTimerTask {

    private VirtualOrderPlan virtualOrderPlan;
    private List<ProductModel> productModelList;
    private BaseManager baseManager = (BaseManager) ApplicationContextUtil.getApplicationContext().getBean("baseManagerImpl");


    public VirtualPurchaseOrderGenerator(List<ProductModel> productModelList, VirtualOrderPlan virtualOrderPlan) {
        super();
        this.productModelList = productModelList;
        setVirtualPlan(virtualOrderPlan);
    }

    public void execute(List<VirtualPlan> virtualPlanList) {
        Random random = new Random();
        if (session == null || !session.isOpen()) {
            session = sessionFactory.openSession();
        }
        virtualOrderPlan = (VirtualOrderPlan) session.get(VirtualOrderPlan.class, virtualOrderPlan.getId());
        ProductModel productModel = productModelList.remove(random.nextInt(productModelList.size()));
        VirtualUserPlan virtualUserPlan = (VirtualUserPlan)session.get(VirtualUserPlan.class.getName(),virtualOrderPlan.getVirtualUserPlan().getId());
//        Query query = session.createQuery("from VirtualUser x where x.virtualUserPlan=:virtualUserPlan").setParameter("virtualUserPlan",virtualUserPlan);
//        List<VirtualUser> virtualUserList = query.list();
//        virtualUserPlan = (VirtualUserPlan)session.get(VirtualUserPlan.class,virtualUserPlan.getId());
        List<VirtualUser> virtualUserList = virtualUserPlan.getVirtualUserList();
//        TransactionSynchronizationManager.initSynchronization();
        baseManager.getObject(virtualUserPlan.getClass().getName(),virtualUserPlan.getId());
        VirtualUser virtualUser = virtualUserList.remove(random.nextInt(virtualUserList.size()));

//        PurchaseOrder purchaseOrder = new PurchaseOrder();
        VirtualPurchaseOrder virtualPurchaseOrder = new VirtualPurchaseOrder();
        virtualPurchaseOrder.setCreateDatetime(new Date());
//        purchaseOrder.setMessage("虚拟专用");
//        purchaseOrder.setOrderType("虚拟专用");
        virtualPurchaseOrder.setStatus("9");//虚拟专用
        virtualPurchaseOrder.setOrderStatus(PurchaseOrder.ORDER_STATUS_FINISHED);
        virtualPurchaseOrder.setUser(virtualUser.getUser());

        PurchaseOrderProduct purchaseOrderProduct = new PurchaseOrderProduct();
        purchaseOrderProduct.setPurchaseOrder(virtualPurchaseOrder);
        purchaseOrderProduct.setProductModel(productModel);
        purchaseOrderProduct.setPurchaseAmount(1);
        purchaseOrderProduct.setPurchasePrice(productModel.getPrice());

//        VirtualPurchaseOrder virtualPurchaseOrder = new VirtualPurchaseOrder();
//        virtualPurchaseOrder.setPurchaseOrder(purchaseOrder);
        virtualPurchaseOrder.setVirtualOrderPlan(virtualOrderPlan);

        PurchaseOrderPayment purchaseOrderPayment = new PurchaseOrderPayment();
        purchaseOrderPayment.setUser(virtualUser.getUser());
        purchaseOrderPayment.setStatus("1");
        purchaseOrderPayment.setPurchaseOrder(virtualPurchaseOrder);
        purchaseOrderPayment.setCreateDateTime(new Date());
        purchaseOrderPayment.setPayWay("4");
        purchaseOrderPayment.setPaymentAmount(productModel.getPrice());

        logger.info(new Date() + ":" + virtualUser.getUser().getUsername() + " purchase a " + purchaseOrderProduct.getProductModel().getName());
//        session.saveOrUpdate(virtualPurchaseOrder);
        session.saveOrUpdate(purchaseOrderProduct);
        session.saveOrUpdate(virtualPurchaseOrder);
        session.saveOrUpdate(purchaseOrderPayment);
        session.flush();
    }

    @Override
    public void run() {
        try {
            if (session == null || !session.isOpen()) {
                session = sessionFactory.openSession();
            }
            execute(null);
        } catch (GenericJDBCException jdbcE) {
            retrieveSessionFactory();
            execute(null);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
    }

    @Override
    public void setVirtualPlan(VirtualPlan virtualPlan) {
        virtualOrderPlan = (VirtualOrderPlan) virtualPlan;
    }
}
