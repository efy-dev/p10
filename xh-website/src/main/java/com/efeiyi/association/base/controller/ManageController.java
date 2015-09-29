package com.efeiyi.association.base.controller;

import com.ming800.core.base.service.BaseManager;
import com.ming800.core.base.service.XdoManager;
import com.ming800.core.base.service.XdoSupportManager;
import com.ming800.core.does.model.Do;
import com.ming800.core.does.model.DoQuery;
import com.ming800.core.does.model.PageInfo;
import com.ming800.core.does.service.DoManager;
import com.ming800.core.p.model.Document;
import com.ming800.core.p.model.Jmenu;
import com.ming800.core.p.model.Jnode;
import com.ming800.core.p.service.AliOssUploadManager;
import com.ming800.core.p.service.AutoSerialManager;
import com.ming800.core.p.service.DocumentManager;
import com.ming800.core.p.service.impl.JmenuManagerImpl;
import com.ming800.core.taglib.PageEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by Administrator on 2015/7/13.
 */
@Controller
@RequestMapping("/xh")
public class ManageController {
    @RequestMapping("/getMenu.do")
    public String getManageJmenuHeader(HttpServletRequest request, Model model) {

        String match = request.getParameter("match"); //用来得到menuId，筛选jmenu
        String matchUrl = match;
        match = match.substring(0,match.indexOf("."));
//        System.out.println("======================================");
//        System.out.println(match);
//        System.out.println("======================================");
        String resultPage = request.getParameter("resultPage");
        String jnodeId = request.getParameter("jnodeId");
        String jmenuId = request.getParameter("jmenuId");
        Jmenu jmenu = JmenuManagerImpl.getJmenu(jmenuId);
//        System.out.println("startTime: " + System.currentTimeMillis());
        Jnode currentJnode = getCurrentJnode(jmenu, match);
        Jnode matchJnode = getMatchJnode(currentJnode, matchUrl);
//        System.out.println("endTime: " + System.currentTimeMillis());
        model.addAttribute("jmenu", jmenu);
        if (currentJnode != null) {
            model.addAttribute("currentJnode", currentJnode);
            model.addAttribute("jnode", currentJnode.getRootFather());
            model.addAttribute("matchJnode",matchJnode);
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
        return resultPage;

    }
    @RequestMapping("/getSubMenu.do")
    public String getSubMenu(ModelMap modelMap, HttpServletRequest request) throws Exception {
        String match = request.getParameter("match"); //用来得到menuId，筛选jmenu
        String matchUrl = match;
        match = match.substring(0,match.indexOf("."));
//        System.out.println("======================================");
//        System.out.println(match);
//        System.out.println("======================================");
        String resultPage = request.getParameter("resultPage");
        String jnodeId = request.getParameter("jnodeId");
        String jmenuId = request.getParameter("jmenuId");
        Jmenu jmenu = JmenuManagerImpl.getJmenu(jmenuId);
//        System.out.println("startTime: " + System.currentTimeMillis());
        Jnode currentJnode = getCurrentJnode(jmenu, match);
        Jnode matchJnode = getMatchJnode(currentJnode, matchUrl);
//        System.out.println("endTime: " + System.currentTimeMillis());
        modelMap.addAttribute("jmenu", jmenu);
        if (currentJnode != null) {
            modelMap.addAttribute("currentJnode", currentJnode);
            modelMap.addAttribute("matchJnode",matchJnode);
            modelMap.addAttribute("jnode", currentJnode.getRootFather());
        } else if (jnodeId != null) {
            for (Jnode jnodeTemp : jmenu.getChildren()) {
                if (jnodeTemp.getId().equals(jnodeId)) {
                    modelMap.addAttribute("jnode", jnodeTemp);
                    break;
                }
            }
        } else {
            modelMap.addAttribute("jnode", jmenu.getChildren().get(0));
        }
        return resultPage;

    }
    private Jnode getCurrentJnode(Jmenu jmenu, String match) {
        if (match == null || match.equals("") || jmenu == null) {
            return null;
        }
        Jnode resultJnode = null;
        for (Jnode jnodeTemp : jmenu.getChildren()) {
            if (resultJnode == null) {
                if(jnodeTemp.getChildren() != null &&jnodeTemp.getChildren().size()!=0){
                    resultJnode = getCurrentJnode(jnodeTemp,match);
                }
                resultJnode = jnodeTemp.getUrl().trim().startsWith(match.trim())?jnodeTemp:null;
            }
        }
        return resultJnode;
    }
    private Jnode getCurrentJnode(Jnode jmenu, String match) {
        if (match == null || match.equals("") || jmenu == null) {
            return null;
        }
        Jnode resultJnode = null;
        for (Jnode jnodeTemp : jmenu.getChildren()) {
            if (resultJnode == null) {
                if(jnodeTemp.getChildren() != null &&jnodeTemp.getChildren().size()!=0){
                    resultJnode = getCurrentJnode(jnodeTemp,match);
                }
                resultJnode = jnodeTemp.getUrl().trim().startsWith(match.trim())?jnodeTemp:null;
            }
        }
        return resultJnode;
    }
    private Jnode getMatchJnode(Jnode jnode, String match) {
        if (match == null || match.equals("")||jnode == null) {
            return null;
        }
        Jnode resultJnode = null;
        for (Jnode jnodeTemp : jnode.getChildren()) {
            if (resultJnode == null && jnodeTemp.getUrl().trim().startsWith(match.trim())) {
                resultJnode = jnodeTemp;
            }else if(resultJnode == null){
                if(jnodeTemp.getChildren() != null &&jnodeTemp.getChildren().size()!=0){
                    resultJnode = getCurrentJnode(jnodeTemp,match);
                }
            }
        }
        return resultJnode;
    }
}
