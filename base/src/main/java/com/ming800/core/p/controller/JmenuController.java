package com.ming800.core.p.controller;

import com.ming800.core.base.controller.BaseController;
import com.ming800.core.p.model.Jmenu;
import com.ming800.core.p.model.Jnode;
import com.ming800.core.p.service.impl.JmenuManagerImpl;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 * Created with IntelliJ IDEA.
 * User: han
 * Date: 12-7-30
 * Time: 下午1:33
 * To change this template use File | Settings | File Templates.
 */
@Controller
public class JmenuController extends BaseController {

    @RequestMapping({"/getXPage.do"})
    public String getXPage(HttpServletRequest request, HttpServletResponse response) {
        response.setHeader("X-Frame-Options", "");
        return "forward:/basic/xm.do?qm=" + request.getParameter("qm");
    }


    @RequestMapping("/getMenu.do")
    public String getManageJmenuHeader(HttpServletRequest request, Model model) {

        String match = request.getParameter("match"); //用来得到menuId，筛选jmenu
//        System.out.println("======================================");
//        System.out.println(match);
//        System.out.println("======================================");
        String resultPage = request.getParameter("resultPage");
        String jnodeId = request.getParameter("jnodeId");
        String jmenuId = request.getParameter("jmenuId");
        Jmenu jmenu = JmenuManagerImpl.getJmenu(jmenuId);
//        System.out.println("startTime: " + System.currentTimeMillis());
        Jnode currentJnode = getCurrentJnode(jmenu, match);
//        System.out.println("endTime: " + System.currentTimeMillis());
        model.addAttribute("jmenu", jmenu);
        if (currentJnode != null) {
            model.addAttribute("currentJnode", currentJnode);
            model.addAttribute("jnode", currentJnode.getRootFather());
        } else if (jnodeId != null) {
            for (Jnode jnodeTemp : jmenu.getChildren()) {
                if (jnodeTemp.getId().equals(jnodeId)) {
                    model.addAttribute("jnode", jnodeTemp);
                    break;
                }
            }
        } else {
            model.addAttribute("jnode", jmenu.getChildren().get(0));
        }
        if(request.getParameter("tenantName")!=null&&!"".equals(request.getParameter("tenantName"))){
            model.addAttribute("tenantName",request.getParameter("tenantName"));
        }
        return resultPage;

    }


    private Jnode getCurrentJnode(Jmenu jmenu, String match) {
        if (match == null || match.equals("")) {
            return null;
        }
        Jnode resultJnode = null;
        for (Jnode jnodeTemp : jmenu.getChildren()) {
            if (resultJnode == null) {
                resultJnode = findJnode(jnodeTemp, match);
            }
        }
        return resultJnode;
    }

    private Jnode findJnode(Jnode jnode, String match) {
        Jnode resultJnode = null;
        if (jnode.getChildren() != null && jnode.getChildren().size() > 0) {
            for (Jnode jnodeTemp : jnode.getChildren()) {
                if (jnodeTemp.contain(match)) {
                    resultJnode = jnodeTemp;
                    break;
                } else {
                    resultJnode = findJnode(jnodeTemp, match);
                    if (resultJnode != null) {
                        break;
                    }
                }
            }
        }
        return resultJnode;
    }


   /* @RequestMapping({"/test/jmenutest"})
    public String testJmenu(HttpServletRequest request) {
        return "/test/jmenuTest";
    }*/

}
