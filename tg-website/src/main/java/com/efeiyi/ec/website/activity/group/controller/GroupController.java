package com.efeiyi.ec.website.activity.group.controller;

import com.efeiyi.ec.activity.group.model.GroupMember;
import com.efeiyi.ec.activity.group.model.GroupProduct;
import com.efeiyi.ec.activity.group.model.MyGroup;
import com.efeiyi.ec.activity.group.model.PurchaseOrderGroup;
import com.efeiyi.ec.organization.model.MyUser;
import com.efeiyi.ec.organization.model.User;
import com.efeiyi.ec.purchase.model.PurchaseOrder;
import com.efeiyi.ec.website.activity.group.service.GroupManager;
import com.efeiyi.ec.website.activity.group.service.PurchaseOrderGroupManager;
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
    @Autowired
    private GroupManager groupManager;


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
        User user = (User) baseManager.getObject(User.class.getName(), userId);
        String groupProductId = request.getParameter("groupProductId");
        String memberId = request.getParameter("memberId");
        String groupId = request.getParameter("groupId");
        String url = "";
        GroupProduct groupProduct = (GroupProduct) baseManager.getObject(GroupProduct.class.getName(), groupProductId);
        if (user != null && !user.equals("") && groupProductId != null && !groupProductId.equals("")) {
            url = groupManager.createGroup(user, groupProductId, groupId, memberId);
        }
        return url;
    }

    @RequestMapping(value = "/waitPay")
    public String waitPay(HttpServletRequest request, Model model) throws Exception {
        String purchaseOrderId = request.getParameter("purchaseOrderId");
        String groupProductId = request.getParameter("groupProductId");
        String groupId = request.getParameter("groupId");
        String memberId = request.getParameter("memberId");
        model.addAttribute("groupProductId", groupProductId);
        model.addAttribute("purchaseOrderId", purchaseOrderId);
        model.addAttribute("groupId", groupId);
        model.addAttribute("memberId", memberId);
        return "/orderDeal";
    }

    //修改订单状态
    @RequestMapping(value = "/createGroup")
    public String createGroup(HttpServletRequest request, Model model) throws Exception {
        String purchaseOrderId = request.getParameter("purchaseOrderId");
        String groupProductId = request.getParameter("groupProductId");
        String groupId = request.getParameter("groupId");
        String memberId = request.getParameter("memberId");
        boolean flag = groupManager.updateGroup(groupId, memberId, purchaseOrderId);
        if (flag) {
            //成团，修改团购订单状态为待发货
            XQuery xQuery = new XQuery("listPurchaseOrderGroup_default2", request);
            xQuery.put("myGroup_id", groupId);
            List<PurchaseOrderGroup> list = baseManager.listObject(xQuery);
            for (PurchaseOrderGroup purchaseOrderGroup : list) {
                purchaseOrderGroup.setOrderStatus("5");
                baseManager.saveOrUpdate(PurchaseOrderGroup.class.getName(), purchaseOrderGroup);
            }
            //发送短信
            groupManager.sendSms(groupId, purchaseOrderId);
        }
        String url = "?groupProductId=" + groupProductId + "&groupId=" + groupId + "&memberId=" + memberId + "&purchaseOrderId=" + purchaseOrderId;
        return "redirect:/group/shareGroup.do" + url;
    }


    //判断是否参团 是团长还是团员或者未参团
    @RequestMapping(value = "/shareGroup.do")
    public String shareGroup(HttpServletRequest request, Model model) throws Exception {
        MyUser user = AuthorizationUtil.getMyUser();
        String groupProductId = request.getParameter("groupProductId");
        String groupId = request.getParameter("groupId");
        String memberId = request.getParameter("memberId");
        String show = request.getParameter("show");
        String purchaseOrderId = request.getParameter("purchaseOrderId");
        String supMan = "";
        if (purchaseOrderId == null || purchaseOrderId == "") {
            XQuery xQuery = new XQuery("listPurchaseOrderGroup_default10", request);
            xQuery.put("myGroup_id", groupId);
            xQuery.put("groupMember_id", memberId);
            List<PurchaseOrderGroup> list = baseManager.listObject(xQuery);
//            purchaseOrderId = list.get(0).getPurchaseOrder().getId();
//            PurchaseOrder purchaseOrder = (PurchaseOrder) baseManager.getObject(PurchaseOrder.class.getName(), purchaseOrderId);
            supMan = list.get(0).getReceiverName();
        } else {
            PurchaseOrder purchaseOrder = (PurchaseOrder) baseManager.getObject(PurchaseOrder.class.getName(), purchaseOrderId);
            supMan = purchaseOrder.getReceiverName();
        }
        MyGroup group = (MyGroup) baseManager.getObject(MyGroup.class.getName(), groupId);

        String url = "?groupProductId=" + groupProductId + "&groupId=" + groupId + "&memberId=" + memberId;
        int flag = 0;//0未参团 1 团长 2 团员
        if (user != null) {
            for (GroupMember member : group.getGroupMemberList()) {
                if (member.getUser().getId().equals(user.getId()) && member.getStatus().equals("1")) {
                    if ("0".equals(member.getLevel())) {
                        flag = 1;
                    } else {
                        flag = 2;
                    }
                    break;
                }
            }
        }

        if (group.getGroupProduct().getMemberAmount() - group.getGroupMemberList().size() > 0) {
            model.addAttribute("number", group.getGroupProduct().getMemberAmount() - group.getGroupMemberList().size());
        } else {
            model.addAttribute("number", 0);
        }
        model.addAttribute("memberId", memberId);
        model.addAttribute("group", group);
        model.addAttribute("url", url);
        model.addAttribute("flag", flag);
        model.addAttribute("supMan", supMan);
        model.addAttribute("purchaseOrderId", purchaseOrderId);
        if (show != null && show.equals("1")) {
            return "forward:/group/joinGroup.do" + url + "&purchaseOrderId=" + purchaseOrderId;
        } else {
            return "/personGroup/shareGroup1";
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


}
