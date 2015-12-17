package com.efeiyi.ec.system.zero.virtual.model.task;

import com.efeiyi.ec.product.model.ProductModel;
import com.efeiyi.ec.purchase.model.PurchaseOrder;
import com.efeiyi.ec.purchase.model.PurchaseOrderPayment;
import com.efeiyi.ec.purchase.model.PurchaseOrderProduct;
import com.efeiyi.ec.zero.virtual.model.VirtualOrderPlan;
import com.efeiyi.ec.zero.virtual.model.VirtualPlan;
import com.efeiyi.ec.zero.virtual.model.VirtualPurchaseOrder;
import com.efeiyi.ec.zero.virtual.model.VirtualUser;
import org.hibernate.exception.GenericJDBCException;

import java.util.Date;
import java.util.List;
import java.util.Random;

/**
 * Created by Administrator on 2015/11/26.
 */
public class VirtualPurchaseOrderGenerator extends BaseTimerTask {

    private VirtualOrderPlan virtualOrderPlan;
    private List<ProductModel> productModelList;


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
        List<VirtualUser> virtualUserList = virtualOrderPlan.getVirtualUserPlan().getVirtualUserList();
        VirtualUser virtualUser = virtualUserList.remove(random.nextInt(virtualUserList.size()));

        PurchaseOrder purchaseOrder = new PurchaseOrder();
        purchaseOrder.setCreateDatetime(new Date());
//        purchaseOrder.setMessage("虚拟专用");
//        purchaseOrder.setOrderType("虚拟专用");
        purchaseOrder.setStatus("9");//虚拟专用
        purchaseOrder.setOrderStatus(PurchaseOrder.ORDER_STATUS_FINISHED);
        purchaseOrder.setUser(virtualUser.getUser());

        PurchaseOrderProduct purchaseOrderProduct = new PurchaseOrderProduct();
        purchaseOrderProduct.setPurchaseOrder(purchaseOrder);
        purchaseOrderProduct.setProductModel(productModel);
        purchaseOrderProduct.setPurchaseAmount(1);
        purchaseOrderProduct.setPurchasePrice(productModel.getPrice());

        VirtualPurchaseOrder virtualPurchaseOrder = new VirtualPurchaseOrder();
        virtualPurchaseOrder.setPurchaseOrder(purchaseOrder);
        virtualPurchaseOrder.setVirtualOrderPlan(virtualOrderPlan);

        PurchaseOrderPayment purchaseOrderPayment = new PurchaseOrderPayment();
        purchaseOrderPayment.setUser(virtualUser.getUser());
        purchaseOrderPayment.setStatus("1");
        purchaseOrderPayment.setPurchaseOrder(purchaseOrder);
        purchaseOrderPayment.setCreateDateTime(new Date());
        purchaseOrderPayment.setPayWay("4");
        purchaseOrderPayment.setPaymentAmount(productModel.getPrice());

        logger.info(new Date() + ":" + virtualUser.getUser().getUsername() + " purchase a " + purchaseOrderProduct.getProductModel().getName());
        session.saveOrUpdate(purchaseOrder);
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
