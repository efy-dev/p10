package com.efeiyi.ec.website.group.controller;

import com.efeiyi.ec.group.model.Group;
import com.efeiyi.ec.group.model.GroupProduct;
import com.efeiyi.ec.organization.model.MyUser;
import com.efeiyi.ec.website.organization.util.AuthorizationUtil;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;

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
            //xQuery.put("");
            Group group = new Group();
            group.setManUser(currentUser.getBigUser());
            group.setStatus("1");
            group.setCreateDateTime(new Date());
            group.setGroupProduct(groupProduct);
            baseManager.saveOrUpdate(Group.class.getName(),group);

            model.addAttribute("group",group);
            return "";
        }
        return "";
    }
}
