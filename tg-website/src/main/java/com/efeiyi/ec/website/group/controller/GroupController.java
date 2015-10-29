package com.efeiyi.ec.website.group.controller;

import com.efeiyi.ec.group.model.Group;
import com.efeiyi.ec.group.model.GroupProduct;
import com.efeiyi.ec.group.model.Member;
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

    //跳转协议
    @RequestMapping(value = "/group.do")
    public String group(HttpServletRequest request,Model model) throws Exception{
        String groupProductId = request.getParameter("groupProductId");
        model.addAttribute("groupProductId",groupProductId);
        return "/illustration";
    }

    @RequestMapping(value = "/groupBuy")
    public  String groupBuy(HttpServletRequest request,Model model) throws Exception{
        MyUser currentUser = AuthorizationUtil.getMyUser();
        String groupProductId = request.getParameter("groupProductId");
        GroupProduct groupProduct = (GroupProduct) baseManager.getObject(GroupProduct.class.getName(),groupProductId);
        String amount = "1";
        return "";

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

        if (currentUser != null){
            if(purchaseOrder.getOrderStatus().equals("5")){
                if (groupId == null && memberId ==null){
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
                    return "redirect:/group/joinGroup";
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
                    return "redirect:/group/joinGroup";
                }



            }
            else {
                return "/";//未支付成功
            }
        }else {
            return "/";//用户未登录
        }

    }


    /*@RequestMapping(value = "/groupBuy")
    public String groupBuy(HttpServletRequest request,Model model) throws Exception{
        String groupProductId = request.getParameter("groupProductId");
        GroupProduct groupProduct = (GroupProduct) baseManager.getObject(GroupProduct.class.getName(),groupProductId);
        String productModelId = groupProduct.getProductModel().getId();
        return "redirect:www2.efeiyi.com/easyBuy/"+productModelId+"?amount=1";
    }*/

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
        Group group = (Group) baseManager.getObject(Group.class.getName(),groupId);
        int memberAmount = group.getGroupProduct().getMemberAmount();
        int a = (int)((float)group.getMemberList().size()/memberAmount);
        if (a<=memberAmount){
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
        if (flag){
            model.addAttribute("flag","1");//已参团
        }else {
            model.addAttribute("flag","0");//未参团
        }

        //获取团剩余时间
        Date createTime = group.getCreateDateTime();
        int limintDay = group.getGroupProduct().getGroupPurchaseTime();
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(createTime);
        calendar.add(Calendar.DATE,limintDay);
        Date endTime = calendar.getTime();
        /*Date dateNow = new Date();

        long result = (df.parse(df.format(endTime)).getTime() - df.parse(df.format(dateNow)).getTime())/1000;
        if(result>0){
            int hour = (int)result/3600;
            int min = (int)(result%3600)/60;
            int ss = (int)((result%3600)%60);
            String h = null;
            String m = null;
            String s = null;
            if(hour<10){
                h = "0"+hour;
            }else {
                h = String.valueOf(hour);
            }
            if(min<10){
                m = "0"+min;
            }else {
                m = String.valueOf(min);
            }
            if(ss<10){
                s = "0"+ss;
            }else {
                s = String.valueOf(ss);
            }
            String data = h+":"+m+":"+s;
            return data;
        }else {
            return "00:00:00";
        }*/
        model.addAttribute("endTime",df.parse(df.format(endTime)).getTime());
        model.addAttribute("group",group);
        return "/personGroup/shareGroup";
    }

/*    @RequestMapping(value = "/restTime")
    @ResponseBody
    public String restTime(HttpServletRequest request ,Model model) throws Exception{
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

        String groupId = request.getParameter("groupId");
        Group group = (Group) baseManager.getObject(Group.class.getName(),groupId);
        Date createTime = group.getCreateDateTime();
        int limintDay = group.getGroupProduct().getGroupPurchaseTime();
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(createTime);
        calendar.add(Calendar.DATE,limintDay);
        Date endTime = calendar.getTime();
        Date dateNow = new Date();

        long result = (df.parse(df.format(endTime)).getTime() - df.parse(df.format(dateNow)).getTime())/1000;
        if(result>0){
            int hour = (int)result/3600;
            int min = (int)(result%3600)/60;
            int ss = (int)((result%3600)%60);
            String h = null;
            String m = null;
            String s = null;
            if(hour<10){
                h = "0"+hour;
            }else {
                h = String.valueOf(hour);
            }
            if(min<10){
                m = "0"+min;
            }else {
                m = String.valueOf(min);
            }
            if(ss<10){
                s = "0"+ss;
            }else {
                s = String.valueOf(ss);
            }
            String data = h+":"+m+":"+s;
            return data;
        }else {
            return "00:00:00";
        }

    }*/
}
