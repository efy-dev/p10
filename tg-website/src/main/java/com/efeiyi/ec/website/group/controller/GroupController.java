package com.efeiyi.ec.website.group.controller;

import com.efeiyi.ec.group.model.Group;
import com.efeiyi.ec.group.model.GroupProduct;
import com.efeiyi.ec.group.model.Member;
import com.efeiyi.ec.organization.model.BigUser;
import com.efeiyi.ec.organization.model.MyUser;
import com.efeiyi.ec.purchase.model.PurchaseOrder;
import com.efeiyi.ec.purchase.model.PurchaseOrderGroup;
import com.efeiyi.ec.website.organization.service.SmsCheckManager;
import com.efeiyi.ec.website.organization.util.AuthorizationUtil;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.p.PConst;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

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
    public String group(HttpServletRequest request,Model model) throws Exception{
        String groupProductId = request.getParameter("groupProductId");
        model.addAttribute("groupProductId",groupProductId);
        return "/illustration";
    }

    //购买
    @RequestMapping(value = "/groupBuy.do")
    public  String groupBuy(HttpServletRequest request,Model model) throws Exception{
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
        String url = "http://www.efeiyi.com/order/groupBuy/"+groupProductId+"/"+amount+"?callback=http://a.efeiyi.com/group/createGroup"+"&groupId="+groupId+"&memberId="+memberId;
        //if(!flag){
            return "redirect:" + url;
        /*}else {
            return "redirect:/group/joinGroup.do" + url1;
        }*/


    }

    //购买、建团
    @RequestMapping(value = "/createGroup")
    public String createGroup(HttpServletRequest request, Model model) throws Exception{
        MyUser currentUser = AuthorizationUtil.getMyUser();
        String purchaseOrderId = request.getParameter("purchaseOrderId");
        String groupProductId = request.getParameter("groupProductId");
        String groupId = request.getParameter("groupId");
        String memberId = request.getParameter("memberId");
        PurchaseOrder purchaseOrder = (PurchaseOrder) baseManager.getObject(PurchaseOrder.class.getName(),purchaseOrderId);
        GroupProduct groupProduct = (GroupProduct) baseManager.getObject(GroupProduct.class.getName(),groupProductId);

        if(purchaseOrder.getOrderStatus().equals("5")){
            purchaseOrder.setOrderStatus("3");
            baseManager.saveOrUpdate(PurchaseOrder.class.getName(),purchaseOrder);
            if (groupId.equals("null")||groupId.isEmpty()){
                Group groupbuy = new Group();
                groupbuy.setManUser(currentUser);
                groupbuy.setStatus("1");
                groupbuy.setCreateDateTime(new Date());
                groupbuy.setGroupProduct(groupProduct);
                baseManager.saveOrUpdate(Group.class.getName(),groupbuy);

                Member member = new Member();
                member.setStatus("1");
                member.setGroup(groupbuy);
                member.setLevel("0");
                member.setUser(currentUser);
                baseManager.saveOrUpdate(Member.class.getName(),member);

                PurchaseOrderGroup purchaseOrderGroup = new PurchaseOrderGroup();
                purchaseOrderGroup.setStatus("1");
                purchaseOrderGroup.setGroup(groupbuy);
                purchaseOrderGroup.setMember(member);
                purchaseOrderGroup.setPurchaseOrder(purchaseOrder);
                baseManager.saveOrUpdate(PurchaseOrderGroup.class.getName(),purchaseOrderGroup);

                model.addAttribute("groupId",groupbuy.getId());
                String url = "?groupProductId="+groupProductId+"&groupId="+groupbuy.getId()+"&memberId="+member.getId();
                return "redirect:/group/shareGroup.do"+url;
            }else {
                Group group = (Group) baseManager.getObject(Group.class.getName(),groupId);
                Member fatherMember = (Member) baseManager.getObject(Member.class.getName(),memberId);
                String fatherLevel = fatherMember.getLevel();
                String level = String.valueOf(Integer.parseInt(fatherLevel)+1);

                Member member = new Member();
                member.setStatus("1");
                member.setGroup(group);
                member.setLevel(level);
                member.setUser(currentUser);
                member.setSupMember(fatherMember);
                baseManager.saveOrUpdate(Member.class.getName(),member);

                PurchaseOrderGroup purchaseOrderGroup = new PurchaseOrderGroup();
                purchaseOrderGroup.setStatus("1");
                purchaseOrderGroup.setGroup(group);
                purchaseOrderGroup.setMember(member);
                purchaseOrderGroup.setPurchaseOrder(purchaseOrder);
                baseManager.saveOrUpdate(PurchaseOrderGroup.class.getName(),purchaseOrderGroup);

                //发送短信
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
                    left = leftDay+"天"+leftHour+"时"+leftMin+"分";
                }else {
                    if(leftHour>0){
                        left = leftHour+"时"+leftMin+"分";
                    }else {
                        if(leftMin>0){
                            left = leftMin+"分";
                        }else {
                            left = "0分";
                        }

                    }
                }
                if(groupProduct.getMemberAmount()-group.getMemberList().size()>0){
                    memberLeft = String.valueOf(groupProduct.getMemberAmount()-group.getMemberList().size());
                }else {
                    memberLeft = "0";
                }
                this.smsCheckManager.send(group.getManUser().getUsername(), "#userName#="+purchaseOrder.getReceiverName()+"&#timeLeft#="+left+"&#memberLeft#="+memberLeft, "1108985", PConst.TIANYI);

                /*if(group.getMemberList().size()==group.getGroupProduct().getMemberAmount()){
                    group.setStatus("3");
                    baseManager.saveOrUpdate(Group.class.getName(),group);
                    for(Member member1:group.getMemberList()){
                        String userId = member1.getUser().getId();
                        BigUser bigUser = (BigUser) baseManager.getObject(BigUser.class.getName(),userId);
                        int i = 0;
                        if(member1.getSubMemberList()!=null&&member1.getSubMemberList().size()>0){
                            i = i + member1.getSubMemberList().size();
                            for(Member member2:member1.getSubMemberList()){
                                if(member2.getSubMemberList()!=null&&member2.getSubMemberList().size()>0){
                                    i = i + member2.getSubMemberList().size();
                                }
                            }
                        }
                        if(bigUser.getRedPacket()==null){
                            bigUser.setRedPacket(new BigDecimal("0"));
                        }else {
                            bigUser.setRedPacket(bigUser.getRedPacket().add(group.getGroupProduct().getBonus().multiply(new BigDecimal(i))));
                        }
                        if (member1.getRedPacket()==null){
                            member1.setRedPacket(new BigDecimal("0"));
                        }else {
                            member1.setRedPacket(group.getGroupProduct().getBonus().multiply(new BigDecimal(i)));
                        }

                        baseManager.saveOrUpdate(Member.class.getName(),member1);
                        baseManager.saveOrUpdate(BigUser.class.getName(),bigUser);

                    }
                    XQuery xQuery = new XQuery("listPurchaseOrderGroup_default3",request);
                    xQuery.put("group_id",group.getId());
                    List<PurchaseOrderGroup> list = baseManager.listObject(xQuery);
                    for(PurchaseOrderGroup purchaseOrderGroup1:list){
                        PurchaseOrder purchaseOrder1 = purchaseOrderGroup1.getPurchaseOrder();
                        purchaseOrder1.setOrderStatus("5");
                        baseManager.saveOrUpdate(PurchaseOrder.class.getName(),purchaseOrder1);
                    }
                }*/

                model.addAttribute("groupId",group.getId());
                String url = "?groupProductId="+groupProductId+"&groupId="+group.getId()+"&memberId="+member.getId();
//                    return "redirect:/group/joinGroup.do"+url;
                return "redirect:/group/shareGroup"+url;
            }



        }
        else {
            return "/zhifushibai";//未支付成功
        }

    }
    @RequestMapping(value = "/shareGroup")
    public String shareGroup(HttpServletRequest request,Model model) throws Exception{
        MyUser user = AuthorizationUtil.getMyUser();
        String groupProductId = request.getParameter("groupProductId");
        String groupId = request.getParameter("groupId");
        String memberId = request.getParameter("memberId");
        Group group = (Group) baseManager.getObject(Group.class.getName(),groupId);
        String url = "?groupProductId="+groupProductId+"&groupId="+groupId+"&memberId="+memberId;
        boolean flag = false;
        for (Member member:group.getMemberList()){
            if(member.getUser().getId().equals(user.getId())){
                flag = true;
                break;
            }
        }
        if(flag){
            model.addAttribute("group",group);
            model.addAttribute("url",url);
            return "/personGroup/sharePage";

        }else {
            return "redirect:/group/joinGroup.do"+url;
        }
    }


    @RequestMapping(value = "/listGroup")
    public String listGroup(HttpServletRequest request, Model model) throws Exception{
        MyUser user = AuthorizationUtil.getMyUser();
        XQuery xQuery = new XQuery("listGroup_default1",request);
        xQuery.put("manUser_id",user.getId());
        List<Group> list = baseManager.listObject(xQuery);

        XQuery xQuery1 = new XQuery("listMember_default",request);
        xQuery1.put("user_id",user.getId());
        List<Member> list1 = baseManager.listObject(xQuery1);
        List list2 = new ArrayList();
        for(Member member:list1){
            list2.add(member.getGroup());
        }
        model.addAttribute("groupList1",list);
        model.addAttribute("groupList2",list2);
        return "/";
    }

    //说明
    @RequestMapping(value = "/protocol")
    public String protocol(HttpServletRequest request, Model model) throws Exception{
        return "/protocolDetails";
    }

    //参团
    @RequestMapping(value = "/joinGroup.do")
    public String joinGroup(HttpServletRequest request,Model model) throws Exception{
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

        MyUser user = AuthorizationUtil.getMyUser();
        String groupId = request.getParameter("groupId");
        String memberId = request.getParameter("memberId");
        Group group = (Group) baseManager.getObject(Group.class.getName(),groupId);

        XQuery purchaseOrderProductQuery = new XQuery("listPurchaseOrderProduct_default",request);
        purchaseOrderProductQuery.put("productModel_id", group.getGroupProduct().getProductModel().getId());
        List<Object> purchaseOrderProductList = baseManager.listObject(purchaseOrderProductQuery);

        XQuery xQuery = new XQuery("listPurchaseOrderGroup_default0",request);
        xQuery.put("member_user_id",group.getManUser().getId());
        xQuery.put("group_id",group.getId());
        String manUserName = "";
        List<PurchaseOrderGroup> purchaseOrderGroupList = baseManager.listObject(xQuery);
        if(purchaseOrderGroupList.size()>0){
            manUserName = purchaseOrderGroupList.get(0).getPurchaseOrder().getReceiverName();
        }
        model.addAttribute("manUserName",manUserName);

        int memberAmount = group.getGroupProduct().getMemberAmount();
        int a = (int)((float)group.getMemberList().size()*100/memberAmount);
        if (a<=100){
            model.addAttribute("bil",a);
        }else {
            model.addAttribute("bil",100);
        }
        boolean flag = false;
        for(Member member:group.getMemberList()){
            if(member.getUser().getId().equals(user.getId())){
                flag = true;
                break;
            }
        }
        /*if(group.getMemberList().size()==group.getGroupProduct().getMemberAmount()){
            flag = true;
        }*/
        //设置参团与否参数
        String url = "";
        if (flag){
            model.addAttribute("flag","1");//已参团
        }else {
            model.addAttribute("flag","0");//未参团或者团已满
            url = "?groupProductId="+group.getGroupProduct().getId()+"&groupId="+groupId+"&memberId="+memberId;
        }

        //获取团剩余时间
        Date createTime = group.getCreateDateTime();
        int limintDay = group.getGroupProduct().getGroupPurchaseTime();
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(createTime);
        //calendar.add(Calendar.DATE,limintDay);
        calendar.add(Calendar.MINUTE,10);
        Date endTime = calendar.getTime();


        model.addAttribute("endTime",df.parse(df.format(endTime)).getTime());
        model.addAttribute("group",group);
        model.addAttribute("url",url);
        model.addAttribute("purchaseOrderProductList",purchaseOrderProductList);

        return "/personGroup/shareGroup";
    }


    //对所有团进行成团操作并发送红包
    @RequestMapping(value = "/sendRedPacket")
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
