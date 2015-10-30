package com.efeiyi.ec.website.group.controller;

import com.efeiyi.ec.group.model.Group;
import com.efeiyi.ec.group.model.GroupProduct;
import com.efeiyi.ec.group.model.Member;
import com.efeiyi.ec.organization.model.BigUser;
import com.efeiyi.ec.organization.model.MyUser;
import com.efeiyi.ec.purchase.model.PurchaseOrder;
import com.efeiyi.ec.purchase.model.PurchaseOrderProduct;
import com.efeiyi.ec.website.organization.util.AuthorizationUtil;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

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

    //跳转协议
    @RequestMapping(value = "/group.do")
    public String group(HttpServletRequest request,Model model) throws Exception{
        String groupProductId = request.getParameter("groupProductId");
        model.addAttribute("groupProductId",groupProductId);
        return "/illustration";
    }

    //购买
    @RequestMapping(value = "/groupBuy")
    public  String groupBuy(HttpServletRequest request,Model model) throws Exception{
        MyUser currentUser = AuthorizationUtil.getMyUser();
        String groupProductId = request.getParameter("groupProductId");
        String memberId = request.getParameter("memberId");
        String groupId = request.getParameter("groupId");

        XQuery xQuery = new XQuery("listGroup_default4",request);
        xQuery.put("groupProduct_id",groupProductId);
        List<Group> list = baseManager.listObject(xQuery);
        //GroupProduct groupProduct = (GroupProduct) baseManager.getObject(GroupProduct.class.getName(),groupProductId);

        boolean flag = false;
        String url1 = "";
        for(Group group:list){
            for(Member member:group.getMemberList()){
                if(member.getUser().getId().equals(currentUser.getId())){
                    flag = true;
                    url1 = "?groupProductId="+groupProductId+"&groupId="+group.getId()+"&memberId="+member.getId();
                    break;
                }
            }

        }

        String amount = "1";
        String url = "/group/createGroup?groupProductId="+groupProductId+"&groupId="+groupId+"&memberId="+memberId;
        if(!flag){
            return "redirect:" + url;
        }else {
            return "redirect:/group/joinGroup" + url1;
        }


    }

    //购买、建团
    @RequestMapping(value = "/createGroup")
    public String createGroup(HttpServletRequest request, Model model) throws Exception{
        MyUser currentUser = AuthorizationUtil.getMyUser();
        //String purchaseOrderId = request.getParameter("purchaseOrderId");
        String groupProductId = request.getParameter("groupProductId");
        String groupId = request.getParameter("groupId");
        String memberId = request.getParameter("memberId");
        //PurchaseOrder purchaseOrder = (PurchaseOrder) baseManager.getObject(PurchaseOrder.class.getName(),purchaseOrderId);
        GroupProduct groupProduct = (GroupProduct) baseManager.getObject(GroupProduct.class.getName(),groupProductId);

        if (currentUser != null){
            //if(purchaseOrder.getOrderStatus().equals("5")){
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

                    model.addAttribute("groupId",groupbuy.getId());
                    String url = "?groupProductId="+groupProductId+"&groupId="+groupbuy.getId()+"&memberId="+member.getId();
                    return "redirect:/group/joinGroup"+url;
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

                    model.addAttribute("groupId",group.getId());
                    String url = "?groupProductId="+groupProductId+"&groupId="+group.getId()+"&memberId="+member.getId();
                    return "redirect:/group/joinGroup"+url;
                }



           /* }
            else {
                return "/";//未支付成功
            }*/
        }else {
            return "/";//用户未登录
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
    @RequestMapping(value = "/joinGroup")
    public String joinGroup(HttpServletRequest request,Model model) throws Exception{
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

        MyUser user = AuthorizationUtil.getMyUser();
        String groupId = request.getParameter("groupId");
        String memberId = request.getParameter("memberId");
        Group group = (Group) baseManager.getObject(Group.class.getName(),groupId);
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
        //设置参团与否参数
        String url = "";
        if (flag){
            model.addAttribute("flag","1");//已参团
        }else {
            model.addAttribute("flag","0");//未参团
            url = "?groupProductId="+group.getGroupProduct().getId()+"&groupId="+groupId+"&memberId="+memberId;
        }

        //获取团剩余时间
        Date createTime = group.getCreateDateTime();
        int limintDay = group.getGroupProduct().getGroupPurchaseTime();
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(createTime);
        calendar.add(Calendar.DATE,limintDay);
        Date endTime = calendar.getTime();


        model.addAttribute("endTime",df.parse(df.format(endTime)).getTime());
        model.addAttribute("group",group);
        model.addAttribute("url",url);

        return "/personGroup/shareGroup";
    }


    //对所有团进行成团操作并发送红包
    /*@RequestMapping(value = "/sendRedPacket")
    public String sendRedPacket(HttpServletRequest request, Model model) throws Exception{
        XQuery xQuery = new XQuery("listGroup_default3",request);
        List<Group> list = baseManager.listObject(xQuery);
        for(Group group:list){
            Date createTime = group.getCreateDateTime();
            int limintDay = group.getGroupProduct().getGroupPurchaseTime();
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(createTime);
            calendar.add(Calendar.DATE,limintDay);
            Date endTime = calendar.getTime();
            Date date = new Date();
            if((date.getTime()-endTime.getTime())>0){
                if(group.getMemberList().size()-group.getGroupProduct().getMemberAmount()>=0){
                    group.setStatus("3");
                    baseManager.saveOrUpdate(Group.class.getName(),group);

                    for(Member member:group.getMemberList()){
                        String userId = member.getUser().getId();
                        BigUser bigUser = baseManager.getObject(BigUser.class.getName(),)
                    }
                }else {
                    group.setStatus("5");
                    baseManager.saveOrUpdate(Group.class.getName(),group);
                }
            }
        }
    }*/

}
