package com.efeiyi.ec.personal.master.controller;

import com.efeiyi.ec.master.model.Master;
import com.efeiyi.ec.master.model.MasterReview;
import com.efeiyi.ec.master.model.MasterUser;
import com.efeiyi.ec.personal.AuthorizationUtil;
import com.efeiyi.ec.tenant.model.TenantReview;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.LinkedHashMap;
import java.util.List;

/**
 * Created by Administrator on 2015/7/14.
 */
@Controller
public class SecurityController {

    @Autowired
    private BaseManager baseManager;

    @RequestMapping({"/login.do"})
    public String login(HttpServletRequest request,Model model){
        model.addAttribute("username",request.getParameter("username"));
        return "/login";

    }

    @RequestMapping({"/main.do"})
    public String main(Model model,HttpServletRequest request){
        String hql = "from MasterUser m where m.user.id =:userId and m.status = '1'";
        LinkedHashMap<String, Object> map = new LinkedHashMap<>();
        map.put("userId", AuthorizationUtil.getMyUser().getId());
        List<MasterUser> list = baseManager.listObject(hql, map);
        if (!list.isEmpty()) {
            Master master = list.get(0).getMaster();
            if (master == null) {
                model.addAttribute("review", "1");
            } else {
                model.addAttribute("review", master.getReview());
                model.addAttribute("master", master);
                try {
                    XQuery xQuery = new XQuery("listMasterReview_default", request);
                    xQuery.put("master_id",master.getId());
                    List<MasterReview> masterReviewList = baseManager.listObject(xQuery);
                    model.addAttribute("masterReviewList", masterReviewList);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
        return "/main";
    }
    @RequestMapping({"/help.do"})
    public String help(Model model,HttpServletRequest request){
        return "/help";
    }
}
