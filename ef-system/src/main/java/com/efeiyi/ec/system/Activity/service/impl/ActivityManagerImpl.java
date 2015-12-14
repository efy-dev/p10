package com.efeiyi.ec.system.Activity.service.impl;

import com.efeiyi.ec.activity.group.model.GroupMember;
import com.efeiyi.ec.activity.group.model.MyGroup;
import com.efeiyi.ec.activity.group.model.PurchaseOrderGroup;
import com.efeiyi.ec.organization.model.User;
import com.efeiyi.ec.purchase.model.PurchaseOrder;
import com.efeiyi.ec.purchase.model.PurchaseOrderProduct;
import com.efeiyi.ec.system.Activity.service.ActivityManager;
import com.ming800.core.base.dao.XdoDao;
import com.ming800.core.p.service.AutoSerialManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

/**
 * Created by IntelliJ IDEA.
 * User: ming
 * Date: 12-8-6
 * Time: 上午11:04
 * To change this template use File | Settings | File Templates.
 */
@Service
public class ActivityManagerImpl implements ActivityManager {

    @Autowired
    private XdoDao xdoDao;

    @Autowired
    private AutoSerialManager autoSerialManager;

    @Override
    public void addGroup(String groupId,Integer amount,Integer length) throws Exception{
        MyGroup myGroup = (MyGroup)xdoDao.getObject(MyGroup.class.getName(),groupId);
        myGroup.setStatus("3");
        xdoDao.saveOrUpdateObject(myGroup);

           if(myGroup.getPurchaseOrderGroupList()!=null){
                for(PurchaseOrderGroup purchaseOrderGroup:myGroup.getPurchaseOrderGroupList()){
                    PurchaseOrder purchaseOrder = purchaseOrderGroup.getPurchaseOrder();
                    purchaseOrder.setOrderStatus("5");
                    xdoDao.saveOrUpdateObject(purchaseOrder);
                }
           }



        if(amount>length){
            List<String> list = getUserList(amount - length);
           for(int i = 0;i<(amount-length);i++){
               User user = new User();
               user.setUsername(list.get(i));
               user.setStatus("9");
               xdoDao.saveOrUpdateObject(user);
               GroupMember groupMember = new GroupMember();
               groupMember.setMyGroup(myGroup);
               groupMember.setStatus("1");
               groupMember.setUser(user);
               xdoDao.saveOrUpdateObject(groupMember);
               PurchaseOrder purchaseOrder = new PurchaseOrder();
               purchaseOrder.setStatus("1");
               purchaseOrder.setUser(user);
               purchaseOrder.setSerial(autoSerialManager.nextSerial("purchaseOrder"));
               purchaseOrder.setOrderStatus("5");
               xdoDao.saveOrUpdateObject(purchaseOrder);
               PurchaseOrderProduct purchaseOrderProduct = new PurchaseOrderProduct();
               purchaseOrderProduct.setPurchaseOrder(purchaseOrder);
               purchaseOrderProduct.setProductModel(myGroup.getGroupProduct().getProductModel());
               xdoDao.saveOrUpdateObject(purchaseOrderProduct);
               PurchaseOrderGroup purchaseOrderGroup = new PurchaseOrderGroup();
               purchaseOrderGroup.setMyGroup(myGroup);
               purchaseOrderGroup.setStatus("1");
               purchaseOrderGroup.setGroupMember(groupMember);
               purchaseOrderGroup.setPurchaseOrder(purchaseOrder);
               xdoDao.saveOrUpdateObject(purchaseOrderGroup);
           }
        }
    }
    public static List<String> getUserList(Integer num){
        String a="13";
        Random random = new  Random();
        List<String> list = new ArrayList<>();
        int i=0;
        while (i<num){
            String number = a+  random.nextInt(10000000);
            if(list.indexOf(a+number)==-1){
                list.add(a+number);
                i++;
            }

        }

             return  list;
    }
}

