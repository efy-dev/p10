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
import java.security.acl.Group;
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

    //建团
    @RequestMapping(value = "/groupBuy.do")
    public String groupBuy(HttpServletRequest request, Model model) throws Exception {
        String userId = AuthorizationUtil.getMyUser().getId();
        User currentUser = (User) baseManager.getObject(User.class.getName(),userId);
        String groupProductId = request.getParameter("groupProductId");
        String memberId = request.getParameter("memberId");
        String groupId = request.getParameter("groupId");
        String url = "";
        String callback = "";
        if(groupId==null&&memberId==null){
            GroupProduct groupProduct = (GroupProduct) baseManager.getObject(GroupProduct.class.getName(),groupProductId);
            MyGroup group = new MyGroup();
            group.setManUser(currentUser);
            group.setStatus("2");
            group.setCreateDateTime(new Date());
            group.setGroupProduct(groupProduct);
            baseManager.saveOrUpdate(MyGroup.class.getName(),group);
            GroupMember member = new GroupMember();
            member.setStatus("2");
            member.setMyGroup(group);
            member.setLevel("0");
            member.setUser(currentUser);
            baseManager.saveOrUpdate(GroupMember.class.getName(),member);
            callback = "www2.efeiyi.com/tg-website/group/waitPay" + "?groupId=" + group.getId() + "&memberId=" + member.getId() +"&groupProductId=" +groupProductId;
            String callback1 = java.net.URLEncoder.encode(callback,"UTF-8");
            url = "http://www2.efeiyi.com/order/saveOrUpdateOrder2.do" + "?productModelId="+groupProduct.getProductModel().getId()+"&amount="+1+"&price="+groupProduct.getGroupPrice()+"&callback="+callback1;
            return "redirect:" + url;
        }else {
            MyGroup group = (MyGroup) baseManager.getObject(MyGroup.class.getName(),groupId);
            GroupMember supMember = (GroupMember) baseManager.getObject(GroupMember.class.getName(),memberId);
            String level = String.valueOf(Integer.parseInt(supMember.getLevel())+1);
            GroupMember member = new GroupMember();
            member.setUser(currentUser);
            member.setLevel(level);
            member.setMyGroup(group);
            member.setStatus("2");
            member.setRedPacket(new BigDecimal(0));
            member.setSupGroupMember(supMember);
            baseManager.saveOrUpdate(GroupMember.class.getName(),member);

            //url = "?groupProductId="+groupProductId+"&groupId="+groupId+"&memberId="+memberId;
            url = "http://www2.efeiyi.com/order/saveOrUpdateOrder2.do" + "?callback=www2.efeiyi.com/tg-website/group/createGroup" + "&groupId=" + group.getId() + "&memberId=" + member.getId();
            return "redirect:" + url;
        }
    }
    @RequestMapping(value = "/waitPay")
    public String waitPay(HttpServletRequest request, Model model) throws Exception{
        String purchaseOrderId = request.getParameter("purchaseOrderId");
        String groupProductId = request.getParameter("groupProductId");
        String groupId = request.getParameter("groupId");
        String memberId = request.getParameter("memberId");
        model.addAttribute("groupProductId",groupProductId);
        model.addAttribute("purchaseOrderId",purchaseOrderId);
        model.addAttribute("groupId",groupId);
        model.addAttribute("memberId",memberId);
        return "/orderDeal";
    }

    //修改订单状态
    @RequestMapping(value = "/createGroup")
    public String createGroup(HttpServletRequest request, Model model) throws Exception {
//        MyUser currentUser = AuthorizationUtil.getMyUser();
        String purchaseOrderId = request.getParameter("purchaseOrderId");
        String groupProductId = request.getParameter("groupProductId");
        String groupId = request.getParameter("groupId");
        String memberId = request.getParameter("memberId");
        PurchaseOrder purchaseOrder = (PurchaseOrder) baseManager.getObject(PurchaseOrder.class.getName(), purchaseOrderId);
        MyGroup myGroup = (MyGroup) baseManager.getObject(MyGroup.class.getName(),groupId);
        GroupMember member = (GroupMember) baseManager.getObject(GroupMember.class.getName(),memberId);
        GroupProduct groupProduct = (GroupProduct) baseManager.getObject(GroupProduct.class.getName(), groupProductId);

        PurchaseOrderGroup purchaseOrderGroup = new PurchaseOrderGroup();
        purchaseOrderGroup.setPurchaseOrder(purchaseOrder);
        purchaseOrderGroup.setMyGroup(myGroup);
        purchaseOrderGroup.setGroupMember(member);
        //判断是否成团未关闭或者未开启
        if(myGroup.getStatus().equals("2")||myGroup.getStatus().equals("1")){
            purchaseOrderGroup.setStatus("3");
        }
        baseManager.saveOrUpdate(PurchaseOrderGroup.class.getName(),purchaseOrderGroup);

        if(myGroup!=null&&"2".equals(myGroup.getStatus())){
            myGroup.setStatus("1");
            baseManager.saveOrUpdate(MyGroup.class.getName(),myGroup);
        }
        if (member!=null&&"2".equals(member.getStatus())){
            member.setStatus("1");
            baseManager.saveOrUpdate(GroupMember.class.getName(),member);
        }
        //人数够，成团操作
        if(myGroup.getStatus().equals("1")&&(myGroup.getGroupMemberList().size()==myGroup.getGroupProduct().getMemberAmount())){
            myGroup.setStatus("4");
            baseManager.saveOrUpdate(MyGroup.class.getName(),myGroup);

            XQuery xQuery = new XQuery("listPurchaseOrderGroup_default2", request);
            xQuery.put("group_id", myGroup.getId());
            List<PurchaseOrderGroup> list1 = baseManager.listObject(xQuery);
            for (PurchaseOrderGroup purchaseOrderGroup1:list1){
                purchaseOrderGroup1.setStatus("5");
                baseManager.saveOrUpdate(PurchaseOrderGroup.class.getName(),purchaseOrderGroup1);
            }
        }
        model.addAttribute("groupId", myGroup.getId());
        String url = "?groupProductId=" + groupProductId + "&groupId=" + myGroup.getId() + "&memberId=" + member.getId();

        //发送短信
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
        if (groupProduct.getMemberAmount() - myGroup.getGroupMemberList().size() > 0) {
            memberLeft = String.valueOf(groupProduct.getMemberAmount() - myGroup.getGroupMemberList().size());
        } else {
            memberLeft = "0";
        }
        this.smsCheckManager.send(myGroup.getManUser().getUsername(), "#userName#=" + purchaseOrder.getReceiverName() + "&#timeLeft#=" + left + "&#memberLeft#=" + memberLeft, "1108985", PConst.TIANYI);

        return "redirect:http://www2.efeiyi.com/tg-website/group/shareGroup.do" + url;
    }

    //判断是否参团 是团长还是团员或者未参团
    @RequestMapping(value = "/shareGroup.do")
    public String shareGroup(HttpServletRequest request, Model model) throws Exception {
        MyUser user = AuthorizationUtil.getMyUser();
        String groupProductId = request.getParameter("groupProductId");
        String groupId = request.getParameter("groupId");
        String memberId = request.getParameter("memberId");
        MyGroup group = (MyGroup) baseManager.getObject(MyGroup.class.getName(), groupId);
        String url = "?groupProductId=" + groupProductId + "&groupId=" + groupId + "&memberId=" + memberId;
        int flag = 0;//0未参团 1 团长 2 团员
        for (GroupMember member : group.getGroupMemberList()) {
            if (member.getUser().getId().equals(user.getId())&&member.getStatus().equals("1")) {
                if("0".equals(member.getLevel())){
                    flag = 1;
                }else{
                    flag = 2;
                }
                break;
            }
        }
        model.addAttribute("memberId",memberId);
        model.addAttribute("group", group);
        model.addAttribute("url", url);
        model.addAttribute("flag",flag);
        return "/personGroup/shareGroup1";
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

                   /* for (GroupMember member : group.getGroupMemberList()) {
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

                    }*/

                } else {
                    group.setStatus("5");
                    baseManager.saveOrUpdate(MyGroup.class.getName(), group);
                }
            }
        }
    }


}
