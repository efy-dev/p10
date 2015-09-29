package com.efeiyi.association.controller;

import com.ming800.core.base.service.BaseManager;
import com.ming800.core.p.model.Document;
import com.ming800.core.p.model.Jmenu;
import com.ming800.core.p.model.Jnode;
import com.ming800.core.p.service.impl.JmenuManagerImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by Administrator on 2015/9/29.
 */
@Controller
@RequestMapping("/view")
public class ViewController {
    @Autowired
    BaseManager baseManager;

    @RequestMapping("/viewDefault.do")
    public Document getContentView(HttpServletRequest request, ModelMap modelMap) {
        Document document = new Document();
        document.setId(request.getParameter("id"));
        document = (Document) baseManager.getObject(document.getClass().getName(), request.getParameter("id"));
        String jmenuId = request.getParameter("jmenu");
        String currentJnodeId = request.getParameter("currentJnode");
        String matchJnodeId = request.getParameter("matchJnode");
        Jmenu jmenu = JmenuManagerImpl.getJmenu(jmenuId);
        Jnode currentJnode = getCurrentJnode(jmenu,currentJnodeId);
        Jnode matchJnode = getMatchJnode(currentJnode, matchJnodeId);
        modelMap.addAttribute("currentJnode", currentJnode);
        modelMap.addAttribute("matchJnode",matchJnode);
        return document;
    }

    private Jnode getCurrentJnode(Jmenu jmenu, String match) {
        if (match == null || match.equals("") || jmenu == null) {
            return null;
        }
        Jnode resultJnode = null;
        for (Jnode jnodeTemp : jmenu.getChildren()) {
            if (resultJnode == null) {
                resultJnode = jnodeTemp.getId().trim().equals(match.trim())?jnodeTemp:null;
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
            if (resultJnode == null && jnodeTemp.getId().trim().equals(match.trim())) {
                resultJnode = jnodeTemp;
            }
        }
        return resultJnode;
    }
}
