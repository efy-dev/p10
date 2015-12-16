package com.efeiyi.ec.website.tenant.controller;

import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by Administrator on 2015/10/26.
 */
@Controller
@RequestMapping("/document")
public class RichTextController {
    @Autowired
    private BaseManager baseManager;

    @RequestMapping("/helpCenter")
    public String getHelpCenter(HttpServletRequest request,Model model) throws Exception {
        XQuery xQuery=new XQuery("listDocument_default",request);
        xQuery.put("group",request.getParameter("group"));
        List<Object> list=baseManager.listObject(xQuery);
        model.addAttribute("document",list);

        return "/tenant/documentView";
    }
    @RequestMapping("/aboutUs")
    public String getAboutUs(HttpServletRequest request,Model model) throws Exception {
        XQuery xquery=new XQuery("listDocument_default",request);
        xquery.put("group",request.getParameter("group"));
        List<Object> list=baseManager.listObject(xquery);
        model.addAttribute("document",list);
        return "/tenant/aboutUs";
    }

}
