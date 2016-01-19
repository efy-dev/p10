package com.efeiyi.ec.website.activity.group.service.impl;

import com.efeiyi.ec.activity.group.model.GroupMember;
import com.efeiyi.ec.activity.group.model.GroupProduct;
import com.efeiyi.ec.activity.group.model.MyGroup;
import com.efeiyi.ec.activity.group.model.PurchaseOrderGroup;
import com.efeiyi.ec.organization.model.User;
import com.efeiyi.ec.purchase.model.PurchaseOrder;
import com.efeiyi.ec.website.activity.group.service.GroupManager;
import com.efeiyi.ec.website.activity.group.service.PurchaseOrderGroupManager;
import com.efeiyi.ec.website.organization.service.SmsCheckManager;
import com.ming800.core.p.PConst;
import org.springframework.stereotype.Service;

import com.ming800.core.base.service.BaseManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import java.util.Calendar;
import java.util.Date;
import java.util.List;


/**
 * Created by Administrator on 2015/11/18.
 */

@Service
@Transactional
public class GroupManagerImpl implements GroupManager {

    @Autowired
    private BaseManager baseManager;

    @Autowired
    private SmsCheckManager smsCheckManager;

    @Autowired
    private PurchaseOrderGroupManager purchaseOrderGroupManager;

    @Override
    public String  createGroup(User user, String groupProductId, String groupId, String memberId) {
        GroupProduct groupProduct = (GroupProduct) baseManager.getObject(GroupProduct.class.getName(), groupProductId);
        String callback = "";
        String url = "";

        if (groupId == null && memberId == null) {

            //������
            MyGroup group = new MyGroup();
            group.setManUser(user);
            group.setStatus("2");//δ����״̬
            group.setCreateDateTime(new Date());
            group.setGroupProduct(groupProduct);
            baseManager.saveOrUpdate(MyGroup.class.getName(), group);

            //������Ա��Ϣ
            GroupMember member = new GroupMember();
            member.setStatus("2");//δ����״̬
            member.setMyGroup(group);
            member.setLevel("0");
            member.setUser(user);
            baseManager.saveOrUpdate(GroupMember.class.getName(), member);

            //�����Ź�������ز���
            PurchaseOrder purchaseOrder = purchaseOrderGroupManager.createPurchaseOrder(groupProduct);

            //�ص���ַ
            callback = "a.efeiyi.com/group/waitPay" + "?groupId=" + group.getId() + "&memberId=" + member.getId() + "&purchaseOrderId=" + purchaseOrder.getId() + "&groupProductId=" + groupProductId;
            purchaseOrder.setCallback(callback);
            baseManager.saveOrUpdate(PurchaseOrder.class.getName(),purchaseOrder);
            url = "http://www.efeiyi.com/order/saveOrUpdateOrder3.do" + "?purchaseOrderId=" + purchaseOrder.getId();
            return "redirect:" + url;
        } else {
            MyGroup group = (MyGroup) baseManager.getObject(MyGroup.class.getName(), groupId);
            GroupMember supMember = (GroupMember) baseManager.getObject(GroupMember.class.getName(), memberId);
            String level = String.valueOf(Integer.parseInt(supMember.getLevel()) + 1);
            //�����Ź�������ز���
            PurchaseOrder purchaseOrder = purchaseOrderGroupManager.createPurchaseOrder(groupProduct);
            //�ж��Ƿ��Ѿ��μӸ��Ź�
            for (GroupMember groupMember : group.getGroupMemberList()) {
                if (user.getId().equals(groupMember.getUser().getId())) {
                    url = "?groupProductId=" + groupProductId + "&groupId=" + groupId + "&memberId=" + memberId + "&purchaseOrderId=" + purchaseOrder.getId();
                    return "redirect:/group/shareGroup.do" + url;
                }
            }
            //������Ա��Ϣ
            GroupMember member = new GroupMember();
            member.setUser(user);
            member.setLevel(level);
            member.setStatus("2");
            member.setSupGroupMember(supMember);
            baseManager.saveOrUpdate(GroupMember.class.getName(), member);


            //�ص���ַ
            callback = "a.efeiyi.com/group/waitPay" + "?groupId=" + group.getId() + "&memberId=" + member.getId() + "&purchaseOrderId=" + purchaseOrder.getId() + "&groupProductId=" + groupProductId;
            purchaseOrder.setCallback(callback);
            baseManager.saveOrUpdate(PurchaseOrder.class.getName(),purchaseOrder);
            url = "http://www.efeiyi.com/order/saveOrUpdateOrder3.do" + "?purchaseOrderId=" + purchaseOrder.getId();
            return "redirect:" + url;
        }
    }

    @Override
    public boolean updateGroup(String groupId, String memberId, String purchaseOrderId) {
        MyGroup myGroup = (MyGroup) baseManager.getObject(MyGroup.class.getName(), groupId);
        GroupMember groupMember = (GroupMember) baseManager.getObject(GroupMember.class.getName(), memberId);
        PurchaseOrder purchaseOrder = (PurchaseOrder) baseManager.getObject(PurchaseOrder.class.getName(), purchaseOrderId);

        if (purchaseOrder.getOrderStatus().equals("5")) {
            //�����Ź�����
            PurchaseOrderGroup purchaseOrderGroup = (PurchaseOrderGroup) baseManager.getObject(PurchaseOrderGroup.class.getName(), purchaseOrderId);
            purchaseOrderGroup.setMyGroup(myGroup);
            purchaseOrderGroup.setGroupMember(groupMember);
            if (myGroup.getStatus().equals("2") || myGroup.getStatus().equals("1")) {
                purchaseOrderGroup.setOrderStatus("3");
            }
            baseManager.saveOrUpdate(PurchaseOrderGroup.class.getName(), purchaseOrderGroup);

            //��������Ϣ
            if (myGroup != null && "2".equals(myGroup.getStatus())) {
                myGroup.setStatus("1");
                baseManager.saveOrUpdate(MyGroup.class.getName(), myGroup);
            }

            //������Ա��Ϣ
            if (groupMember != null && "2".equals(groupMember.getStatus())) {
                groupMember.setStatus("1");
                groupMember.setMyGroup(myGroup);
                groupMember.setCreateDateTime(new Date());
                baseManager.saveOrUpdate(GroupMember.class.getName(), groupMember);

                myGroup.getGroupMemberList().add(groupMember);
            }

            if (myGroup.getStatus().equals("1") && (myGroup.getGroupMemberList().size() == myGroup.getGroupProduct().getMemberAmount())) {
                myGroup.setStatus("4");
                baseManager.saveOrUpdate(MyGroup.class.getName(), myGroup);
                return true;
            } else {
                return false;
            }
        } else {
            return false;
        }
    }

    @Override
    public void sendSms(String groupId, String purchaseOrderId) {
        MyGroup myGroup = (MyGroup) baseManager.getObject(MyGroup.class.getName(), groupId);
        PurchaseOrder purchaseOrder = (PurchaseOrder) baseManager.getObject(PurchaseOrder.class.getName(), purchaseOrderId);

        Date createTime = myGroup.getCreateDateTime();
        int limintDay = myGroup.getGroupProduct().getGroupPurchaseTime();
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(createTime);
        calendar.add(Calendar.DATE, limintDay);
        Date endTime = calendar.getTime();
        Date dateNow = new Date();
        long min = endTime.getTime() - dateNow.getTime();
        long leftDay = min / (1000 * 60 * 60 * 24);
        long leftHour = (min / (1000 * 60 * 60)) % 24;
        long leftMin = (min / (1000 * 60)) % 60;
        String left = "";
        String memberLeft = "";
        if (leftDay > 0) {
            left = leftDay + "��" + leftHour + "ʱ" + leftMin + "��";
        } else {
            if (leftHour > 0) {
                left = leftHour + "ʱ" + leftMin + "��";
            } else {
                if (leftMin > 0) {
                    left = leftMin + "��";
                } else {
                    left = "0��";
                }

            }
        }
        if (myGroup.getGroupProduct().getMemberAmount() - myGroup.getGroupMemberList().size() > 0) {
            memberLeft = String.valueOf(myGroup.getGroupProduct().getMemberAmount() - myGroup.getGroupMemberList().size());
        } else {
            memberLeft = "0";
        }
        if (myGroup != null && myGroup.getGroupMemberList().size() > 1) {
            this.smsCheckManager.send(myGroup.getManUser().getUsername(), "#userName#=" + purchaseOrder.getReceiverName() + "&#timeLeft#=" + left + "&#memberLeft#=" + memberLeft, "1108985", PConst.TIANYI);
        }
    }

    /*@Override
    public String joinGroup(MyUser currentUser,MyGroup group, GroupMember fatherMember,PurchaseOrder purchaseOrder) {
        String fatherLevel = fatherMember.getLevel();
        String level = String.valueOf(Integer.parseInt(fatherLevel)+1);

        GroupMember member = new GroupMember();
        member.setStatus("1");
        member.setGroup(group);
        member.setLevel(level);
        member.setUser(currentUser);
        member.setSupMember(fatherMember);
        baseManager.saveOrUpdate(GroupMember.class.getName(),member);

        PurchaseOrderGroup purchaseOrderGroup = new PurchaseOrderGroup();
        purchaseOrderGroup.setStatus("1");
        purchaseOrderGroup.setGroup(group);
        purchaseOrderGroup.setMember(member);
        purchaseOrderGroup.setPurchaseOrder(purchaseOrder);
        baseManager.saveOrUpdate(PurchaseOrderGroup.class.getName(),purchaseOrderGroup);

        return "?groupProductId="+group.getGroupProduct().getId()+"&groupId="+group.getId()+"&memberId="+member.getId();
    }

    @Override
    public Map<String,String> getTimeLeft(MyGroup group,GroupProduct groupProduct) {
        Date createTime = group.getCreateDateTime();
        int limintDay = group.getGroupProduct().getGroupPurchaseTime();
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(createTime);
        calendar.add(Calendar.DATE,limintDay);
        Date endTime = calendar.getTime();
        Date dateNow = new Date();
        long min = endTime.getTime()-dateNow.getTime();
        long leftDay = min/(1000*60*60*24);
        long leftHour = (min/(1000*60*60))%24;
        long leftMin = (min/(1000*60))%60;
        String left = "";
        String memberLeft = "";
        if(leftDay>0){
            left = leftDay+"�?"+leftHour+"�?"+leftMin+"�?";
        }else {
            if(leftHour>0){
                left = leftHour+"�?"+leftMin+"�?";
            }else {
                if(leftMin>0){
                    left = leftMin+"�?";
                }else {
                    left = "0�?";
                }

            }
        }
        if(groupProduct.getMemberAmount()-group.getMemberList().size()>0){
            memberLeft = String.valueOf(groupProduct.getMemberAmount()-group.getMemberList().size());
        }else {
            memberLeft = "0";
        }
        Map<String,String> map = new HashMap<String,String>();
        map.put("left",left);
        map.put("memberLeft",memberLeft);
        return map;
    }

    @Override
    public Date getEndTime(MyGroup group) {
        Date createTime = group.getCreateDateTime();
        int limintDay = group.getGroupProduct().getGroupPurchaseTime();
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(createTime);
        //calendar.add(Calendar.DATE,limintDay);
        calendar.add(Calendar.MINUTE,10);
        Date endTime = calendar.getTime();
        return endTime;
    }*/
}


