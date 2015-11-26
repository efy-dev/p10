package com.efeiyi.ec.website.activity.controller;


import com.efeiyi.ec.group.model.MyGroup;
import com.efeiyi.ec.group.model.GroupMember;
import com.efeiyi.ec.group.model.GroupProduct;
import com.efeiyi.ec.group.model.GroupMember;
import com.efeiyi.ec.group.model.MyGroup;
import com.efeiyi.ec.organization.model.BigUser;
import com.efeiyi.ec.organization.model.MyUser;
import com.efeiyi.ec.organization.model.User;
import com.efeiyi.ec.purchase.model.PurchaseOrder;
import com.efeiyi.ec.group.model.PurchaseOrderGroup;
import com.efeiyi.ec.website.organization.service.SmsCheckManager;
import com.efeiyi.ec.website.organization.util.AuthorizationUtil;
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
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 * Created by Administrator on 2015/10/22.
 */
@Controller
@RequestMapping("/group")
public class GroupController {
    @Autowired
    private BaseManager baseManager;

    @Autowired
    private SmsCheckManager smsCheckManager;

    //跳转协议
    @RequestMapping(value = "/group.do")
    public String group(HttpServletRequest request, Model model) throws Exception {
        String groupProductId = request.getParameter("groupProductId");
        model.addAttribute("groupProductId", groupProductId);
        return "/illustration";
    }

    @RequestMapping({"/checkOrder.do"})
    @ResponseBody
    public boolean checkOrder(HttpServletRequest request) {
        String purchaseOrderId = request.getParameter("purchaseOrderId");
        PurchaseOrder purchaseOrder = (PurchaseOrder) baseManager.getObject(PurchaseOrder.class.getName(), purchaseOrderId);
        if (purchaseOrder.getOrderStatus().equals(PurchaseOrder.ORDER_STATUS_WRECEIVE)) {
            return true;
        } else {
            return false;
        }
    }

    //购买
    @RequestMapping(value = "/groupBuy.do")
    public String groupBuy(HttpServletRequest request, Model model) throws Exception {
        MyUser currentUser = AuthorizationUtil.getMyUser();
        String groupProductId = request.getParameter("groupProductId");
        String memberId = request.getParameter("memberId");
        String groupId = request.getParameter("groupId");

        //XQuery xQuery = new XQuery("listGroup_default4",request);
        //xQuery.put("groupProduct_id",groupProductId);
        //List<Group> list = baseManager.listObject(xQuery);
        //GroupProduct groupProduct = (GroupProduct) baseManager.getObject(GroupProduct.class.getName(),groupProductId);

      /*  boolean flag = false;
        String url1 = "";
        if(groupId==null||groupId.isEmpty()){
            for(Group group:list){
                for(Member member:group.getMemberList()){
                    if(member.getUser().getId().equals(currentUser.getId())&&member.getLevel().equals("0")&&group.getStatus().equals("1")){
                        flag = true;
                        url1 = "?groupProductId="+groupProductId+"&groupId="+group.getId()+"&memberId="+member.getId();
                        break;
                    }
                }

            }
        }else {
            Group group = (Group) baseManager.getObject(Group.class.getName(),groupId);
            if (group.getManUser().getId().equals(currentUser.getId())&&(group.getMemberList().size()<group.getGroupProduct().getMemberAmount())){
                flag = true;
            }
        }*/


        String amount = "1";
        // String url = "/group/createGroup?groupProductId="+groupProductId+"&groupId="+groupId+"&memberId="+memberId+"&callback=http://192.168.1.46:8080/group/createGroup";
        String url = "/order/groupBuy/" + groupProductId + "/" + amount + "?callback=http://a.efeiyi.com/group/createGroup" + "&groupId=" + groupId + "&memberId=" + memberId;
        //if(!flag){
        return "redirect:" + url;
        /*}else {
            return "redirect:/group/joinGroup.do" + url1;
        }*/


    }

    //购买、建团
    @RequestMapping(value = "/createGroup")
    public String createGroup(HttpServletRequest request, Model model) throws Exception {
//        MyUser currentUser = AuthorizationUtil.getMyUser();
        String purchaseOrderId = request.getParameter("purchaseOrderId");
        String groupProductId = request.getParameter("groupProductId");
        String groupId = request.getParameter("groupId");
        String memberId = request.getParameter("memberId");
        PurchaseOrder purchaseOrder = (PurchaseOrder) baseManager.getObject(PurchaseOrder.class.getName(), purchaseOrderId);
        User currentUser = purchaseOrder.getUser();

//        String orderStatus = "0";
//        if (purchaseOrder != null && purchaseOrder.getOrderStatus() != null && purchaseOrder.getOrderStatus().equals(PurchaseOrder.ORDER_STATUS_WRECEIVE)) {
//            orderStatus = "1";
//        }

//        if (orderStatus.equals("1")) {

            GroupProduct groupProduct = (GroupProduct) baseManager.getObject(GroupProduct.class.getName(), groupProductId);

            if (purchaseOrder.getOrderStatus().equals("5")) {
                purchaseOrder.setOrderStatus("3");
                baseManager.saveOrUpdate(PurchaseOrder.class.getName(), purchaseOrder);
                if (groupId.equals("null") || groupId.isEmpty()) {
                    MyGroup groupbuy = new MyGroup();
                    groupbuy.setManUser(currentUser);
                    groupbuy.setStatus("1");
                    groupbuy.setCreateDateTime(new Date());
                    groupbuy.setGroupProduct(groupProduct);
                    baseManager.saveOrUpdate(MyGroup.class.getName(), groupbuy);

                    GroupMember member = new GroupMember();
                    member.setStatus("1");
                    member.setMyGroup(groupbuy);
                    member.setLevel("0");
                    member.setUser(currentUser);
                    baseManager.saveOrUpdate(GroupMember.class.getName(), member);

                    PurchaseOrderGroup purchaseOrderGroup = new PurchaseOrderGroup();
                    purchaseOrderGroup.setStatus("1");
                    purchaseOrderGroup.setMyGroup(groupbuy);
                    purchaseOrderGroup.setGroupMember(member);
                    purchaseOrderGroup.setPurchaseOrder(purchaseOrder);
                    baseManager.saveOrUpdate(PurchaseOrderGroup.class.getName(), purchaseOrderGroup);

                    model.addAttribute("groupId", groupbuy.getId());
                    String url = "?groupProductId=" + groupProductId + "&groupId=" + groupbuy.getId() + "&memberId=" + member.getId();
                    return "redirect:/group/shareGroup.do" + url;
                } else {
                    MyGroup group = (MyGroup) baseManager.getObject(MyGroup.class.getName(), groupId);
                    GroupMember fatherMember = (GroupMember) baseManager.getObject(GroupMember.class.getName(), memberId);
                    String fatherLevel = fatherMember.getLevel();
                    String level = String.valueOf(Integer.parseInt(fatherLevel) + 1);

                    GroupMember member = new GroupMember();
                    member.setStatus("1");
                    member.setMyGroup(group);
                    member.setLevel(level);
                    member.setUser(currentUser);
                    member.setSupGroupMember(fatherMember);
                    baseManager.saveOrUpdate(GroupMember.class.getName(), member);

                    PurchaseOrderGroup purchaseOrderGroup = new PurchaseOrderGroup();
                    purchaseOrderGroup.setStatus("1");
                    purchaseOrderGroup.setMyGroup(group);
                    purchaseOrderGroup.setGroupMember(member);
                    purchaseOrderGroup.setPurchaseOrder(purchaseOrder);
                    baseManager.saveOrUpdate(PurchaseOrderGroup.class.getName(), purchaseOrderGroup);

                    //发送短信
                    Date createTime = group.getCreateDateTime();
                    int limintDay = group.getGroupProduct().getGroupPurchaseTime();
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
                        left = leftDay + "天" + leftHour + "时" + leftMin + "分";
                    } else {
                        if (leftHour > 0) {
                            left = leftHour + "时" + leftMin + "分";
                        } else {
                            if (leftMin > 0) {
                                left = leftMin + "分";
                            } else {
                                left = "0分";
                            }

                        }
                    }
                    if (groupProduct.getMemberAmount() - group.getGroupMemberList().size() > 0) {
                        memberLeft = String.valueOf(groupProduct.getMemberAmount() - group.getGroupMemberList().size());
                    } else {
                        memberLeft = "0";
                    }
                    this.smsCheckManager.send(group.getManUser().getUsername(), "#userName#=" + purchaseOrder.getReceiverName() + "&#timeLeft#=" + left + "&#memberLeft#=" + memberLeft, "1108985", PConst.TIANYI);

                    model.addAttribute("groupId", group.getId());
                    String url = "?groupProductId=" + groupProductId + "&groupId=" + group.getId() + "&memberId=" + member.getId();
//                    return "redirect:/group/joinGroup.do"+url;
                    return "redirect:/group/shareGroup" + url;
                }
            } else {
                return "redirect:/tuan";//未支付成功
            }
//        } else {
//            model.addAttribute("purchaseOrderId",purchaseOrderId);
//            model.addAttribute("groupProductId",groupProductId);
//            model.addAttribute("groupId",groupId);
//            model.addAttribute("memberId",memberId);
//            return "/orderDeal";
//        }
    }

    @RequestMapping(value = "/shareGroup")
    public String shareGroup(HttpServletRequest request, Model model) throws Exception {
        MyUser user = AuthorizationUtil.getMyUser();
        String groupProductId = request.getParameter("groupProductId");
        String groupId = request.getParameter("groupId");
        String memberId = request.getParameter("memberId");
        MyGroup group = (MyGroup) baseManager.getObject(MyGroup.class.getName(), groupId);
        String url = "?groupProductId=" + groupProductId + "&groupId=" + groupId + "&memberId=" + memberId;
        boolean flag = false;
        for (GroupMember member : group.getGroupMemberList()) {
            if (member.getUser().getId().equals(user.getId())) {
                flag = true;
                break;
            }
        }
        if (flag) {
            model.addAttribute("group", group);
            model.addAttribute("url", url);
            return "/personGroup/sharePage";

        } else {
            return "redirect:/group/joinGroup.do" + url;
        }
    }


    @RequestMapping(value = "/listGroup")
    public String listGroup(HttpServletRequest request, Model model) throws Exception {
        MyUser user = AuthorizationUtil.getMyUser();
        XQuery xQuery = new XQuery("listGroup_default1", request);
        xQuery.put("manUser_id", user.getId());
        List<MyGroup> list = baseManager.listObject(xQuery);

        XQuery xQuery1 = new XQuery("listMember_default", request);
        xQuery1.put("user_id", user.getId());
        List<GroupMember> list1 = baseManager.listObject(xQuery1);
        List list2 = new ArrayList();
        for (GroupMember member : list1) {
            list2.add(member.getMyGroup());
        }
        model.addAttribute("groupList1", list);
        model.addAttribute("groupList2", list2);
        return "/";
    }

    //说明
    @RequestMapping(value = "/protocol")
    public String protocol(HttpServletRequest request, Model model) throws Exception {
        return "/protocolDetails";
    }

    //参团
    @RequestMapping(value = "/joinGroup.do")
    public String joinGroup(HttpServletRequest request, Model model) throws Exception {
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

        MyUser user = AuthorizationUtil.getMyUser();
        String groupId = request.getParameter("groupId");
        String memberId = request.getParameter("memberId");
        MyGroup group = (MyGroup) baseManager.getObject(MyGroup.class.getName(), groupId);

        XQuery purchaseOrderProductQuery = new XQuery("listPurchaseOrderProduct_default", request);
        purchaseOrderProductQuery.put("productModel_id", group.getGroupProduct().getProductModel().getId());
        List<Object> purchaseOrderProductList = baseManager.listObject(purchaseOrderProductQuery);

        XQuery xQuery = new XQuery("listPurchaseOrderGroup_default0", request);
        xQuery.put("groupMember_user_id", group.getManUser().getId());
        xQuery.put("myGroup_id", group.getId());
        String manUserName = "";
        List<PurchaseOrderGroup> purchaseOrderGroupList = baseManager.listObject(xQuery);
        if (purchaseOrderGroupList.size() > 0) {
            manUserName = purchaseOrderGroupList.get(0).getPurchaseOrder().getReceiverName();
        }
        model.addAttribute("manUserName", manUserName);

        int memberAmount = group.getGroupProduct().getMemberAmount();
        int a = (int) ((float) group.getGroupMemberList().size() * 100 / memberAmount);
        if (a <= 100) {
            model.addAttribute("bil", a);
        } else {
            model.addAttribute("bil", 100);
        }
        boolean flag = false;
        for (GroupMember member : group.getGroupMemberList()) {
            if (member.getUser().getId().equals(user.getId())) {
                flag = true;
                break;
            }
        }
        /*if(group.getMemberList().size()==group.getGroupProduct().getMemberAmount()){
            flag = true;
        }*/
        //设置参团与否参数
        String url = "";
        if (flag) {
            model.addAttribute("flag", "1");//已参团
        } else {
            model.addAttribute("flag", "0");//未参团或者团已满
            url = "?groupProductId=" + group.getGroupProduct().getId() + "&groupId=" + groupId + "&memberId=" + memberId;
        }

        //获取团剩余时间
        Date createTime = group.getCreateDateTime();
        int limintDay = group.getGroupProduct().getGroupPurchaseTime();
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(createTime);
        calendar.add(Calendar.DATE, limintDay);
        //calendar.add(Calendar.MINUTE,10);
        Date endTime = calendar.getTime();


        model.addAttribute("endTime", df.parse(df.format(endTime)).getTime());
        model.addAttribute("group", group);
        model.addAttribute("url", url);
        model.addAttribute("purchaseOrderProductList", purchaseOrderProductList);

        return "/personGroup/shareGroup";
    }


    //对所有团进行成团操作并发送红包
    @RequestMapping(value = "/sendRedPacket")
    public void sendRedPacket(HttpServletRequest request, Model model) throws Exception {
        XQuery xQuery = new XQuery("listGroup_default3", request);
        List<MyGroup> list = baseManager.listObject(xQuery);
        for (MyGroup group : list) {
            Date createTime = group.getCreateDateTime();
            int limintDay = group.getGroupProduct().getGroupPurchaseTime();
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(createTime);
            calendar.add(Calendar.DATE, limintDay);
            //calendar.add(Calendar.MINUTE,10);
            Date endTime = calendar.getTime();
            Date date = new Date();
            if (date.after(endTime)) {
                if (group.getGroupMemberList().size() - group.getGroupProduct().getMemberAmount() >= 0) {
                    group.setStatus("3");
                    baseManager.saveOrUpdate(MyGroup.class.getName(), group);

                    for (GroupMember member : group.getGroupMemberList()) {
                        String userId = member.getUser().getId();
                        BigUser bigUser = (BigUser) baseManager.getObject(BigUser.class.getName(), userId);
                        int i = 0;
                        if (member.getSubGroupMemberList() != null && member.getSubGroupMemberList().size() > 0) {
                            i = i + member.getSubGroupMemberList().size();
                            for (GroupMember member1 : member.getSubGroupMemberList()) {
                                if (member1.getSubGroupMemberList() != null && member1.getSubGroupMemberList().size() > 0) {
                                    i = i + member1.getSubGroupMemberList().size();
                                }
                            }

                        }
                        if (bigUser.getRedPacket() == null) {
                            bigUser.setRedPacket(group.getGroupProduct().getBonus().multiply(new BigDecimal(i)));
                        } else {
                            bigUser.setRedPacket(bigUser.getRedPacket().add(group.getGroupProduct().getBonus().multiply(new BigDecimal(i))));
                        }
                        if (member.getRedPacket() == null) {
                            member.setRedPacket(group.getGroupProduct().getBonus().multiply(new BigDecimal(i)));
                        } else {
                            member.setRedPacket(group.getGroupProduct().getBonus().multiply(new BigDecimal(i)));
                        }
                        baseManager.saveOrUpdate(BigUser.class.getName(), bigUser);
                        baseManager.saveOrUpdate(GroupMember.class.getName(), member);

                        //发送短信
                        this.smsCheckManager.send(member.getUser().getUsername(), "#redPacket#=" + group.getGroupProduct().getBonus().multiply(new BigDecimal(i)), "1109007", PConst.TIANYI);

                    }

                    XQuery xQuery1 = new XQuery("listPurchaseOrderGroup_default3", request);
                    xQuery.put("group_id", group.getId());
                    List<PurchaseOrderGroup> list1 = baseManager.listObject(xQuery1);
                    for (PurchaseOrderGroup purchaseOrderGroup1 : list1) {
                        PurchaseOrder purchaseOrder1 = purchaseOrderGroup1.getPurchaseOrder();
                        purchaseOrder1.setOrderStatus("5");
                        baseManager.saveOrUpdate(PurchaseOrder.class.getName(), purchaseOrder1);
                    }
                } else {
                    group.setStatus("5");
                    baseManager.saveOrUpdate(MyGroup.class.getName(), group);
                }
            }
        }
    }

}
