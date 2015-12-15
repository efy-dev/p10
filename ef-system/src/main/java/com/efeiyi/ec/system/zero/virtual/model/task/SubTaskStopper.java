package com.efeiyi.ec.system.zero.virtual.model.task;


import com.efeiyi.ec.system.zero.virtual.model.timer.SubTimer;
import com.efeiyi.ec.system.zero.virtual.model.timer.SuperTimer;
import com.efeiyi.ec.zero.virtual.model.VirtualPlan;

import java.util.List;

/**
 * Created by Administrator on 2015/11/25.
 */
public class SubTaskStopper extends BaseTimerTask {

    private VirtualPlan virtualPlan;

    public SubTaskStopper(VirtualPlan virtualPlan) {
        this.virtualPlan = virtualPlan;
    }

    @Override
    public void run() {
        try {
            execute(null);
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            super.cancel();
        }
    }

    @Override
    public void setVirtualPlan(VirtualPlan virtualPlan) {
        this.virtualPlan = virtualPlan;
    }

    @Override
    public void execute(List<VirtualPlan> virtualPlanList) {
        this.cancel();
    }

    @Override
    public boolean cancel() {

        SubTimer subTimer = SuperTimer.getInstance().getSubTimerMap().remove(virtualPlan);
        if(subTimer != null) {
            synchronized (subTimer) {
                subTimer.getSubTimer().cancel();
                logger.info("SubTaskTimer cancelled.");
                subTimer.getTimerTask().cancel();
                logger.info("SubTask cancelled.");
                subTimer.getStopperTimer().cancel();
                logger.info("StopperTimer cancelled.");
            }
        }
        logger.info("StopperTimerTask cancelled.");
        return super.cancel();
    }
}
