package com.efeiyi.ec.website.group.controller;

import com.efeiyi.ec.group.model.Group;
import com.efeiyi.ec.group.model.GroupProduct;
import com.efeiyi.ec.group.model.Member;
import com.efeiyi.ec.organization.model.MyUser;
import com.efeiyi.ec.website.organization.util.AuthorizationUtil;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
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

    @RequestMapping(value = "/createGroup.do")
    public String CreateGroup(HttpServletRequest request, Model model) throws Exception{
        MyUser currentUser = AuthorizationUtil.getMyUser();
        String groupProductId = request.getParameter("groupProductId");
        GroupProduct groupProduct = (GroupProduct) baseManager.getObject(GroupProduct.class.getName(),groupProductId);
        if (currentUser != null){
            XQuery xQuery = new XQuery("listGroup_default",request);
            xQuery.put("manUser_id",currentUser.getBigUser().getId());
            xQuery.put("groupProduct_id",groupProductId);
            List<Group> list = baseManager.listObject(xQuery);
            if (list.size() > 0){
                Group group = new Group();
//                group.setManUser(currentUser.getBigUser());
                group.setStatus("1");
                group.setCreateDateTime(new Date());
                group.setGroupProduct(groupProduct);
                baseManager.saveOrUpdate(Group.class.getName(),group);

                model.addAttribute("group",group);
                return "/";
            }

        }
        return "/";
    }

    /*@RequestMapping(value = "/groupBuy")
    public String GroupBuy(HttpServletRequest request,Model model) throws Exception{
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
}
