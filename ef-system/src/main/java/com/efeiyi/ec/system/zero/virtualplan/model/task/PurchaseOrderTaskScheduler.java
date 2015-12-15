package com.efeiyi.ec.system.zero.virtualplan.model.task;


import com.efeiyi.ec.product.model.ProductModel;
import com.efeiyi.ec.system.zero.virtualplan.model.timer.SuperTimer;
import com.efeiyi.ec.system.zero.virtualplan.util.VirtualPlanConstant;
import com.efeiyi.ec.zero.virtual.model.VirtualOrderPlan;
import com.efeiyi.ec.zero.virtual.model.VirtualPlan;
import com.efeiyi.ec.zero.virtual.model.VirtualProductModel;
import org.hibernate.exception.GenericJDBCException;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by Administrator on 2015/11/20.
 */
public class PurchaseOrderTaskScheduler extends BaseTimerTask {

    private VirtualOrderPlan virtualOrderPlan;
    private List<ProductModel> productModelList;

    @Override
    public boolean cancel() {
        SuperTimer.getInstance().getSubTaskTempStoreMap().put(virtualOrderPlan, productModelList);
        try {
            if (session == null || !session.isOpen()) {
                session = sessionFactory.openSession();
            }
            resetPlanStatus();
        } catch (GenericJDBCException jdbcE) {
            retrieveSessionFactory();
            resetPlanStatus();
        }
        logger.info("PurchaseOrderTaskScheduler cancelled.");
        return super.cancel();
    }

    private void resetPlanStatus() {
        virtualOrderPlan = (VirtualOrderPlan) session.get(VirtualOrderPlan.class, virtualOrderPlan.getId());
        virtualOrderPlan.setStatus(VirtualPlanConstant.planStatusNormal);
        session.saveOrUpdate(virtualOrderPlan);
        session.flush();
        session.close();
    }

    public void execute(List<VirtualPlan> virtualPlanList) {

        virtualOrderPlan = (VirtualOrderPlan) session.get(VirtualOrderPlan.class, virtualOrderPlan.getId());
        virtualOrderPlan.setStatus(VirtualPlanConstant.planStatusStarted);
        session.saveOrUpdate(virtualOrderPlan);
        session.flush();

        //生成ProductModel随机productModel
        productModelList = (List<ProductModel>) SuperTimer.getInstance().getSubTaskTempStoreMap().remove(virtualOrderPlan);
        if (productModelList == null || productModelList.isEmpty()) {
            productModelList = generateProductModelList();
            logger.info("PurchaseOrderTaskScheduler is resuming task.");
        }
        Random random = new Random();

        //生成随机时间点
        Long[] randomOrderTimePoint = new Long[productModelList.size()];
        DateFormat dateFormat = new SimpleDateFormat("yyyy,MM,dd,HH,mm,ss");
        Calendar futureCalendar = Calendar.getInstance();
        String[] nowArray = dateFormat.format(futureCalendar.getTime()).split(",");
        String[] peakTimeArray = dateFormat.format(virtualOrderPlan.getPeakTime()).split(",");
        futureCalendar.set(Integer.parseInt(nowArray[0]), Integer.parseInt(nowArray[1]) - 1, Integer.parseInt(nowArray[2]), Integer.parseInt(peakTimeArray[3]), Integer.parseInt(peakTimeArray[4]), Integer.parseInt(peakTimeArray[5]));
        long now = System.currentTimeMillis();
        long future = futureCalendar.getTimeInMillis();
        long futureFromNow = future - now;

        for (int x = 0; x < randomOrderTimePoint.length; x++) {
            randomOrderTimePoint[x] = (long) (random.nextGaussian() * 60 * 60 * 1000) * virtualOrderPlan.getStandardDeviation() + futureFromNow;
        }
        Arrays.sort(randomOrderTimePoint);
        System.out.println(randomOrderTimePoint[randomOrderTimePoint.length - 1]);
        int count = 0;
        for (int x = 0; x < randomOrderTimePoint.length; x++) {
            if(randomOrderTimePoint[x] >= 0) {
                SuperTimer.getInstance().getSubTimerMap()
                        .get(virtualOrderPlan)
                        .getSubTimer()
                        .schedule(new VirtualPurchaseOrderGenerator(productModelList, virtualOrderPlan), randomOrderTimePoint[x]);
                count++;
            }
        }

        logger.info("Ready to generate " + count + " virtual orders");
    }

    @Override
    public void run() {
        logger.info(" Purchase order arranging.");
        if (session == null || !session.isOpen()) {
            session = sessionFactory.openSession();
        }
        try {
            execute(null);
        } catch (GenericJDBCException jdbcE) {
            retrieveSessionFactory();
            execute(null);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (session != null) {
                session.close();
            }
        }
        logger.info("Purchase arranged.");
    }

    @Override
    public void setVirtualPlan(VirtualPlan virtualPlan) {
        if (session == null) {
            session = sessionFactory.openSession();
        }
        this.virtualOrderPlan = (VirtualOrderPlan) session.get(VirtualOrderPlan.class, virtualPlan.getId());
    }

    private List<ProductModel> generateProductModelList() {

        List<ProductModel> virtualProductModelList = new ArrayList<>();

        for (VirtualProductModel virtualProductModel : virtualOrderPlan.getVirtualProductModelList()) {
            //生成ProductModel池子
            List<ProductModel> subVirtualProductModelList = generateSubProductModelPool(virtualProductModel, virtualProductModel.getRandomAmount());
            virtualProductModelList.addAll(subVirtualProductModelList);
        }

        return virtualProductModelList;
    }

    private List<ProductModel> generateSubProductModelPool(VirtualProductModel virtualProductModel, int randomAmount) {

        List<ProductModel> subVirtualProductModelList = new LinkedList<>();
        for (int x = 0; x < randomAmount; x++) {
            subVirtualProductModelList.add(virtualProductModel.getProductModel());
        }
        return subVirtualProductModelList;
    }

    public List<ProductModel> getProductModelList() {
        return productModelList;
    }

    public void setProductModelList(List<ProductModel> productModelList) {
        this.productModelList = productModelList;
    }
}


