package com.efeiyi.ec.system.zero.virtualplan.model.task;

import com.efeiyi.ec.system.zero.virtualplan.model.timer.SubTimer;
import com.efeiyi.ec.system.zero.virtualplan.model.timer.SuperTimer;
import com.efeiyi.ec.system.zero.virtualplan.util.VirtualPlanConstant;
import com.efeiyi.ec.zero.virtual.model.VirtualPlan;
import org.hibernate.Query;
import org.hibernate.exception.GenericJDBCException;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Timer;

/**
 * Created by Administrator on 2015/11/23.
 */
public class CoreTaskScheduler extends BaseTimerTask {
    private static CoreTaskScheduler coreTaskScheduler;
//    private List<VirtualPlan> virtualPlanList;

    private CoreTaskScheduler() {
    }

    public static CoreTaskScheduler getInstance() {
        if (coreTaskScheduler == null) {
            synchronized (CoreTaskScheduler.class) {
                if (coreTaskScheduler == null) {
                    coreTaskScheduler = new CoreTaskScheduler();
                }
            }
        }
        return coreTaskScheduler;
    }

    @Override
    public void run() {
        logger.info("CoreTimer executing.");
        if (session == null || !session.isOpen()) {
            session = sessionFactory.openSession();
        }
        try {
            preExecute();
        } catch (GenericJDBCException jdbcE) {
            retrieveSessionFactory();
            preExecute();
        } catch (Throwable e) {
            logger.error("CoreTimer throws Exception:" + e.getMessage());
            e.printStackTrace();
        } finally {
            if (session != null) {
                session.close();
            }
            logger.info("CoreTimer executed.");
        }

    }


    private void preExecute() {
        Query listQuery = session.createQuery("from VirtualPlan where status = " + VirtualPlanConstant.planStatusNormal);
        List<VirtualPlan> virtualPlanList = listQuery.list();
        execute(virtualPlanList);
    }

    public void execute(List<VirtualPlan> virtualPlanList) {
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date nowDate = new Date();
        String[] date = dateFormat.format(nowDate).split("-");

//        DateFormat timeFormat = new SimpleDateFormat("HH:mm:ss");
        Calendar startCalendarComparator = Calendar.getInstance();
        Calendar endCalendarComparator = Calendar.getInstance();
        for (VirtualPlan virtualPlan : virtualPlanList) {

            //停掉前一天的
            SubTimer subTimer = SuperTimer.getInstance().getSubTimerMap().remove(virtualPlan);
            if (subTimer != null) {
                subTimer.cancel();
            }

            //转一下日期类型
            Date startDate = null;
            Date endDate = null;
            try {
                startDate = dateFormat.parse(virtualPlan.getStartDate());
                endDate = dateFormat.parse(virtualPlan.getEndDate());
            } catch (Exception e) {
                logger.error("parsing string to date failed.");
                e.printStackTrace();
            }

            //执行日期以外的跳过
            if (startDate.compareTo(nowDate) > 0 || endDate.compareTo(nowDate) < 0) {
                continue;
            }

            //执行时间以外的跳过,当前时间超过startTime的立即启动
            String[] subTaskStartTime = virtualPlan.getStartTime().split(":");
            String[] subTaskEndTime = virtualPlan.getEndTime().split(":");
            startCalendarComparator.set(Integer.parseInt(date[0]), Integer.parseInt(date[1]) - 1, Integer.parseInt(date[2]), Integer.parseInt(subTaskStartTime[0]), Integer.parseInt(subTaskStartTime[1]), Integer.parseInt(subTaskStartTime[2]));
            endCalendarComparator.set(Integer.parseInt(date[0]), Integer.parseInt(date[1]) - 1, Integer.parseInt(date[2]), Integer.parseInt(subTaskEndTime[0]), Integer.parseInt(subTaskEndTime[1]), Integer.parseInt(subTaskEndTime[2]));
            if (endCalendarComparator.getTime().compareTo(nowDate) < 0) {
                continue;
            }

            BaseTimerTask subTimerTask = null;
            try {
                subTimerTask = (BaseTimerTask) Class.forName(virtualPlan.getImplementClass()).newInstance();
                subTimerTask.setVirtualPlan(virtualPlan);
            } catch (Throwable e) {
                e.printStackTrace();
                logger.error("ClassNotFound!!serial :" + virtualPlan.getSerial() + " description:" + virtualPlan.getDescription());
                continue;
            }
            subTimer = new SubTimer(new Timer(), subTimerTask, new Timer(), new SubTaskStopper(virtualPlan));
            SuperTimer.getInstance().getSubTimerMap().put(virtualPlan, subTimer);

            long delay = startCalendarComparator.getTimeInMillis() - nowDate.getTime();
            long stopperDelay = endCalendarComparator.getTimeInMillis() - nowDate.getTime();
            subTimer.getSubTimer().schedule(subTimerTask, delay < 0 ? 0 : delay);
            subTimer.getStopperTimer().schedule(subTimer.getStopTimerTask(), stopperDelay < 0 ? 0 : stopperDelay);
            logger.info(virtualPlan.getSerial() + " timer launch after " + (delay < 0 ? 0 : delay) + " millis seconds");
            logger.info(virtualPlan.getSerial() + " timer off after " + (stopperDelay < 0 ? 0 : stopperDelay) + " millis seconds");
        }
    }

    @Override
    public void setVirtualPlan(VirtualPlan virtualPlan) {
    }

}
