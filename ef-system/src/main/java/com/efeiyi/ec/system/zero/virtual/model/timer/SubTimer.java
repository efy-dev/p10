package com.efeiyi.ec.system.zero.virtual.model.timer;

import com.efeiyi.ec.system.zero.virtual.model.task.BaseTimerTask;
import com.efeiyi.ec.system.zero.virtual.model.task.SubTaskStopper;
import org.apache.log4j.Logger;

import java.util.Timer;
import java.util.TimerTask;

/**
 * Created by Administrator on 2015/11/25.
 */
public class SubTimer {

    private Timer subTimer;
    private TimerTask subTimerTask;
    private Timer stopperTimer;
    private SubTaskStopper stopperTimerTask;
    private Logger logger = Logger.getLogger(SubTimer.class);

    public SubTimer(Timer subTimer, BaseTimerTask subTimerTask, Timer stopperTimer, SubTaskStopper stopperTimerTask) {
        this.subTimer = subTimer;
        this.subTimerTask = subTimerTask;
        this.stopperTimer = stopperTimer;
        this.stopperTimerTask = stopperTimerTask;
    }

    public SubTimer() {
    }

    public Timer getSubTimer() {
        return subTimer;
    }

    public void setSubTimer(Timer subTimer) {
        this.subTimer = subTimer;
    }

    public TimerTask getTimerTask() {
        return subTimerTask;
    }

    public void setSubTimerTask(TimerTask subTimerTask) {
        this.subTimerTask = subTimerTask;
    }

    public Timer getStopperTimer() {
        return stopperTimer;
    }

    public void setStopperTimer(Timer stopperTimer) {
        this.stopperTimer = stopperTimer;
    }

    public TimerTask getStopTimerTask() {
        return stopperTimerTask;
    }

    public void setStopperTimerTask(SubTaskStopper stopperTimerTask) {
        this.stopperTimerTask = stopperTimerTask;
    }

    public boolean cancel() {
        stopperTimerTask.cancel();
        logger.info("SubTimerTask " + subTimerTask.getClass().getName() +  " ended...................");
        return true;
    }
}
