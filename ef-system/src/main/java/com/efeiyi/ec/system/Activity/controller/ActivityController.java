package com.efeiyi.ec.system.Activity.controller;

import com.efeiyi.ec.group.model.Group;
import com.efeiyi.ec.group.model.Member;
import com.efeiyi.ec.organization.model.BigUser;
import com.efeiyi.ec.purchase.model.PurchaseOrder;
import com.efeiyi.ec.purchase.model.PurchaseOrderGroup;
import com.efeiyi.ec.system.purchaseOrder.service.SmsCheckManager;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.p.PConst;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

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

    //对所有团进行成团操作并发送红包
    @RequestMapping(value = "/sendRedPacket.do")
    public void sendRedPacket(HttpServletRequest request, Model model) throws Exception{
        XQuery xQuery = new XQuery("listGroup_default3",request);
        List<Group> list = baseManager.listObject(xQuery);
        for(Group group:list){
            Date createTime = group.getCreateDateTime();
            int limintDay = group.getGroupProduct().getGroupPurchaseTime();
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(createTime);
            //calendar.add(Calendar.DATE,limintDay);
            calendar.add(Calendar.MINUTE,10);
            Date endTime = calendar.getTime();
            Date date = new Date();
            if(date.after(endTime)){
                if(group.getMemberList().size()-group.getGroupProduct().getMemberAmount()>=0){
                    group.setStatus("3");
                    baseManager.saveOrUpdate(Group.class.getName(),group);

                    for(Member member:group.getMemberList()){
                        String userId = member.getUser().getId();
                        BigUser bigUser = (BigUser) baseManager.getObject(BigUser.class.getName(),userId);
                        int i = 0;
                        if(member.getSubMemberList()!=null&&member.getSubMemberList().size()>0){
                            i = i + member.getSubMemberList().size();
                            for(Member member1:member.getSubMemberList()){
                                if(member1.getSubMemberList()!=null&&member1.getSubMemberList().size()>0){
                                    i = i + member1.getSubMemberList().size();
                                }
                            }

                        }
                        if(bigUser.getRedPacket()==null){
                            bigUser.setRedPacket(group.getGroupProduct().getBonus().multiply(new BigDecimal(i)));
                        }else {
                            bigUser.setRedPacket(bigUser.getRedPacket().add(group.getGroupProduct().getBonus().multiply(new BigDecimal(i))));
                        }
                        if (member.getRedPacket()==null){
                            member.setRedPacket(group.getGroupProduct().getBonus().multiply(new BigDecimal(i)));
                        }else {
                            member.setRedPacket(group.getGroupProduct().getBonus().multiply(new BigDecimal(i)));
                        }
                        baseManager.saveOrUpdate(BigUser.class.getName(),bigUser);
                        baseManager.saveOrUpdate(Member.class.getName(),member);

                        //发送短信
                        this.smsCheckManager.send(member.getUser().getUsername(), "#redPacket#="+group.getGroupProduct().getBonus().multiply(new BigDecimal(i)), "1109007", PConst.TIANYI);

                    }

                    XQuery xQuery1 = new XQuery("listPurchaseOrderGroup_default3",request);
                    xQuery.put("group_id",group.getId());
                    List<PurchaseOrderGroup> list1 = baseManager.listObject(xQuery1);
                    for(PurchaseOrderGroup purchaseOrderGroup1:list1){
                        PurchaseOrder purchaseOrder1 = purchaseOrderGroup1.getPurchaseOrder();
                        purchaseOrder1.setOrderStatus("5");
                        baseManager.saveOrUpdate(PurchaseOrder.class.getName(),purchaseOrder1);
                    }
                }else {
                    group.setStatus("5");
                    baseManager.saveOrUpdate(Group.class.getName(),group);
                }
            }
        }
    }

}
