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
    public String sendRedPacket(HttpServletRequest request, Model model) throws Exception{
        XQuery xQuery = new XQuery("listGroup_default3",request);
        List<MyGroup> list = baseManager.listObject(xQuery);
        for(MyGroup myGroup :list){
            Date createTime = myGroup.getCreateDateTime();
            int limintDay = myGroup.getGroupProduct().getGroupPurchaseTime();
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(createTime);
            calendar.add(Calendar.DATE,limintDay);
            Date endTime = calendar.getTime();
            Date date = new Date();
            if(date.after(endTime)){
                if(myGroup.getGroupMemberList().size()- myGroup.getGroupProduct().getMemberAmount()>=0){
                    myGroup.setStatus("3");
                    baseManager.saveOrUpdate(MyGroup.class.getName(), myGroup);

                    for(GroupMember groupMember : myGroup.getGroupMemberList()){
                        String userId = groupMember.getUser().getId();
                        BigUser bigUser = (BigUser) baseManager.getObject(BigUser.class.getName(),userId);
                        int i = 0;
                        if(groupMember.getSubGroupMemberList()!=null&& groupMember.getSubGroupMemberList().size()>0){
                            i = i + groupMember.getSubGroupMemberList().size();
                            for(GroupMember groupMember1 : groupMember.getSubGroupMemberList()){
                                if(groupMember1.getSubGroupMemberList()!=null&& groupMember1.getSubGroupMemberList().size()>0){
                                    i = i + groupMember1.getSubGroupMemberList().size();
                                }
                            }

                        }
                        if(bigUser.getRedPacket()==null){
                            bigUser.setRedPacket(myGroup.getGroupProduct().getBonus().multiply(new BigDecimal(i)));
                        }else {
                            bigUser.setRedPacket(bigUser.getRedPacket().add(myGroup.getGroupProduct().getBonus().multiply(new BigDecimal(i))));
                        }
                        if (groupMember.getRedPacket()==null){
                            groupMember.setRedPacket(myGroup.getGroupProduct().getBonus().multiply(new BigDecimal(i)));
                        }else {
                            groupMember.setRedPacket(myGroup.getGroupProduct().getBonus().multiply(new BigDecimal(i)));
                        }
                        baseManager.saveOrUpdate(BigUser.class.getName(),bigUser);
                        baseManager.saveOrUpdate(GroupMember.class.getName(), groupMember);

                        //发送短信
                        this.smsCheckManager.send(groupMember.getUser().getUsername(), "#redPacket#="+ myGroup.getGroupProduct().getBonus().multiply(new BigDecimal(i)), "1109007", PConst.TIANYI);

                    }

                    XQuery xQuery1 = new XQuery("listPurchaseOrderGroup_default3",request);
                    xQuery.put("group_id", myGroup.getId());
                    List<PurchaseOrderGroup> list1 = baseManager.listObject(xQuery1);
                    for(PurchaseOrderGroup purchaseOrderGroup1:list1){
                        PurchaseOrder purchaseOrder1 = purchaseOrderGroup1.getPurchaseOrder();
                        purchaseOrder1.setOrderStatus("5");
                        baseManager.saveOrUpdate(PurchaseOrder.class.getName(),purchaseOrder1);
                    }
                }else {
                    myGroup.setStatus("5");
                    baseManager.saveOrUpdate(MyGroup.class.getName(), myGroup);
                }
            }
        }
        return  "";
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
