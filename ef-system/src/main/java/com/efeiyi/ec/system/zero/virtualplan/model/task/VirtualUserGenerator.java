package com.efeiyi.ec.system.zero.virtualplan.model.task;

import com.efeiyi.ec.organization.model.User;
import com.efeiyi.ec.system.zero.virtualplan.util.VirtualPlanConstant;
import com.efeiyi.ec.zero.virtual.model.VirtualPlan;
import com.efeiyi.ec.zero.virtual.model.VirtualUser;
import com.efeiyi.ec.zero.virtual.model.VirtualUserPlan;

import java.util.List;
import java.util.Random;

/**
 * Created by Administrator on 2015/11/26.
 */
public class VirtualUserGenerator extends BaseTimerTask {
    private VirtualUserPlan virtualUserPlan;
    private String[] prefixes = {"134", "135", "136", "137", "138", "139", "150", "151", "152", "158", "159", "157", "182", "187", "188", "147", "130", "131", "132", "155", "156", "185", "186", "133", "153", "180", "189"};


    public void execute(List<VirtualPlan> virtualPlanList) {
        //瞬时任务已启动
        virtualUserPlan = (VirtualUserPlan) session.get(VirtualUserPlan.class, virtualUserPlan.getId());
        virtualUserPlan.setStatus(VirtualPlanConstant.planStatusStarted);
        session.saveOrUpdate(virtualUserPlan);
        session.flush();

        Random random = new Random();
        for (int x = 0; x < virtualUserPlan.getCount(); x++) {
            User user = new User();
            String prefix = prefixes[random.nextInt(prefixes.length)];
            String suffix = leftPad(Integer.toString(random.nextInt(10000)), 4, "0");
            user.setUsername(prefix + "****" + suffix);
            user.setStatus(VirtualPlanConstant.virtualUserIdentifier);
            VirtualUser virtualUser = new VirtualUser();
            virtualUser.setUser(user);
            virtualUser.setVirtualUserPlan(virtualUserPlan);
            virtualUserPlan.getVirtualUserList().add(virtualUser);
            session.saveOrUpdate(user);
            session.saveOrUpdate(virtualUser);
        }
        //瞬时任务已完成
        virtualUserPlan.setStatus(VirtualPlanConstant.planStatusFinished);
        session.saveOrUpdate(virtualUserPlan);
        session.flush();
    }

    @Override
    public void run() {
        if(session == null || !session.isOpen()) {
            session = sessionFactory.openSession();
        }
        try {
            execute(null);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
    }

    private String leftPad(String stringBefore, int length, String appender) {
        int len = stringBefore.getBytes().length;
        StringBuilder stringAfter = new StringBuilder(stringBefore);
        while (len++ < length) {
            stringAfter.insert(0, appender);
        }
        return stringAfter.toString();
    }

    @Override
    public void setVirtualPlan(VirtualPlan virtualPlan) {
        virtualUserPlan = (VirtualUserPlan)virtualPlan;
    }
}
