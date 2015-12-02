package com.efeiyi.ec.system.Activity.controller;

import com.efeiyi.ec.group.model.MyGroup;
import com.efeiyi.ec.group.model.GroupMember;
import com.efeiyi.ec.organization.model.BigUser;
import com.efeiyi.ec.purchase.model.PurchaseOrder;
import com.efeiyi.ec.group.model.PurchaseOrderGroup;
import com.efeiyi.ec.system.Activity.service.ActivityManager;
import com.efeiyi.ec.system.purchaseOrder.service.SmsCheckManager;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.p.PConst;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.math.BigDecimal;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 * Created by AC丶man on 2015/8/31.
 */
@Controller
@RequestMapping("/tuan")
public class ActivityController {

	@Autowired
	private BaseManager baseManager;

    @Autowired
    private SmsCheckManager smsCheckManager;

    @Autowired
    private ActivityManager activityManager;

    //对所有团进行成团操作并发送红包
    @RequestMapping(value = "/sendRedPacket.do")
    @ResponseBody
    public void sendRedPacket(HttpServletRequest request, Model model) throws Exception {
        XQuery xQuery = new XQuery("listGroup_default3", request);
        List<MyGroup> list = baseManager.listObject(xQuery);
        for (MyGroup group : list) {
            Date createTime = group.getCreateDateTime();
            int limintDay = group.getGroupProduct().getGroupPurchaseTime();
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(createTime);
            calendar.add(Calendar.DATE, limintDay);
            Date endTime = calendar.getTime();
            Date date = new Date();
            if (date.after(endTime)) {
                if (group.getGroupMemberList().size() - group.getGroupProduct().getMemberAmount() >= 0) {
                    group.setStatus("3");
                    baseManager.saveOrUpdate(MyGroup.class.getName(), group);

                } else {
                    group.setStatus("5");
                    baseManager.saveOrUpdate(MyGroup.class.getName(), group);
                }
            }
        }
    }

    @RequestMapping("/addGroup.do")
    @ResponseBody
    public String addGroup(String groupId,Integer amount,Integer length,HttpServletRequest request){
        String f = "1";
        try {
            activityManager.addGroup(groupId,amount,length);
        }catch (Exception e){
            f="0";
        }

        return f;
    }
}
