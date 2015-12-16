package com.efeiyi.ec.system.zero.virtual.model.task;

import com.efeiyi.ec.zero.virtual.model.VirtualPlan;
import com.ming800.core.util.ApplicationContextUtil;
import org.apache.log4j.Logger;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import java.util.List;
import java.util.TimerTask;

/**
 * Created by Administrator on 2015/11/25.
 */
public abstract class BaseTimerTask extends TimerTask {

    protected SessionFactory sessionFactory = ((SessionFactory) ApplicationContextUtil.getApplicationContext().getBean("scheduleSessionFactory"));
    protected Session session;
    protected static Logger logger = Logger.getLogger(BaseTimerTask.class);

    public abstract void setVirtualPlan(VirtualPlan virtualPlan);

    public abstract void execute(List<VirtualPlan> virtualPlanList);

    protected void retrieveSessionFactory() {
        logger.error("retrieving sessionFactory.");
        sessionFactory = ((SessionFactory) ApplicationContextUtil.getApplicationContext().getBean("scheduleSessionFactory"));
        session = sessionFactory.openSession();
    }

}
