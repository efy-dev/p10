package com.efeiyi.ec.website.activity.group.service;

import com.efeiyi.ec.organization.model.User;

/**
 * Created by Administrator on 2015/11/18.
 */
public interface GroupManager {
    public String createGroup(User user, String groupProductId, String groupId, String memberId);

    public boolean updateGroup(String groupId, String memberId, String purchaseOrderId);

    public void sendSms(String groupId, String purchaseOrderId);
//
//    public String joinGroup(MyUser currentUser, MyGroup group, GroupMember fatherMember, PurchaseOrder purchaseOrder);
//
//    public Map<String,String> getTimeLeft(MyGroup group, GroupProduct groupProduct);
//
//    public Date getEndTime(MyGroup group);


}
