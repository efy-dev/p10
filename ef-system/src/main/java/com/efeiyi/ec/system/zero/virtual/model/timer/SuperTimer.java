package com.efeiyi.ec.system.zero.virtual.model.timer;


import com.efeiyi.ec.zero.virtual.model.VirtualPlan;
import org.apache.log4j.Logger;

import java.util.HashMap;
import java.util.Map;
import java.util.Timer;
import java.util.concurrent.ConcurrentHashMap;

/**
 * Created by Administrator on 2015/11/25.
 */
public class SuperTimer {

    private static SuperTimer superTimer;
    private Timer coreTaskTimer = new Timer();
    private Map<VirtualPlan, SubTimer> subTimerMap = new HashMap<VirtualPlan, SubTimer>();
    private Map<VirtualPlan, Object> subTaskTempStoreMap = new ConcurrentHashMap<VirtualPlan, Object>();
    private long taskExecutionCycle = 86400000;
//    private long taskExecutionCycle = 86400;
    private Logger logger = Logger.getLogger(SuperTimer.class);


    public long getTaskExecutionCycle() {
        return taskExecutionCycle;
    }

    private SuperTimer() {
    }

    public static SuperTimer getInstance() {
        if (superTimer == null) {
            synchronized (SuperTimer.class) {
                if (superTimer == null) {
                    superTimer = new SuperTimer();
                }
            }
        }
        return superTimer;
    }

    public Map<VirtualPlan, SubTimer> getSubTimerMap() {
        return subTimerMap;
    }

    public Timer getCoreTaskTimer() {
        return coreTaskTimer;
    }

    public Map<VirtualPlan, Object> getSubTaskTempStoreMap() {
        return subTaskTempStoreMap;
    }

    public void cancel() {
        for (Map.Entry<VirtualPlan, SubTimer> subTimer : subTimerMap.entrySet()) {
            subTimer.getValue().cancel();
        }
        coreTaskTimer.cancel();
        logger.info("SuperTimer cancelled.........");
    }
}
