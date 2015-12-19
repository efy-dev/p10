package com.efeiyi.ec.system.zero.virtual.listener;

import com.efeiyi.ec.system.zero.virtual.model.task.CoreTaskScheduler;
import com.efeiyi.ec.system.zero.virtual.model.timer.SuperTimer;
import com.efeiyi.ec.system.zero.virtual.util.VirtualPlanConstant;
import com.efeiyi.ec.zero.virtual.model.VirtualPlan;
import com.ming800.core.util.ApplicationContextUtil;
import org.apache.log4j.Logger;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 * Created by Administrator on 2015/11/24.
 */
public class VirtualPlanInitListener implements ServletContextListener {

    private Logger logger = Logger.getLogger(VirtualPlanInitListener.class);

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        try {
            //刚启动执行一次
            CoreTaskScheduler coreTaskScheduler = CoreTaskScheduler.getInstance();
//            coreTaskScheduler.run();//刚启动不执行了，手动启动

            Calendar todayStartTime = Calendar.getInstance();
            DateFormat dateFormat = new SimpleDateFormat("yyyy,MM,dd,HH,mm,ss");
            String[] dateString = dateFormat.format(new Date()).split(",");
            //Calendar的月从0-11
            todayStartTime.set(Integer.parseInt(dateString[0]), Integer.parseInt(dateString[1]) - 1, Integer.parseInt(dateString[2]), 00, 00, 00);
            Date tomorrowStartTime = new Date(todayStartTime.getTimeInMillis() + SuperTimer.getInstance().getTaskExecutionCycle());

            //定时到明日0时每24小时一次
            SuperTimer.getInstance().getCoreTaskTimer().scheduleAtFixedRate(coreTaskScheduler, tomorrowStartTime, SuperTimer.getInstance().getTaskExecutionCycle());

        } catch (Exception e) {
            logger.info("CoreTimer & SubTimerTask failed to set.");
            e.printStackTrace();
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        resetTaskStatus();
        stopCoreScheduler();
        logger.info("CoreTimer & SubTimerTask destroyed.");
    }

    private void stopCoreScheduler() {
        SuperTimer.getInstance().cancel();
        //task不必另外cancel
//        CoreTaskScheduler.getInstance().cancel();
    }

    private void resetTaskStatus() {
        SessionFactory sessionFactory = ((SessionFactory) ApplicationContextUtil.getApplicationContext().getBean("scheduleSessionFactory"));
        Session session = sessionFactory.openSession();
        Query listQuery = session.createQuery("from VirtualPlan where status = " + VirtualPlanConstant.planStatusStarted);
        List<VirtualPlan> virtualPlanList = listQuery.list();
        for (VirtualPlan virtualPlan : virtualPlanList) {
            virtualPlan.setStatus(VirtualPlanConstant.planStatusInit);
            session.saveOrUpdate(virtualPlan);
        }
        session.flush();
        session.close();
    }
}
