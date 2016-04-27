package com.efeiyi.ec.system.wiki.controller;

import com.efeiyi.ec.project.model.Project;
import com.ming800.core.base.service.BaseManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import javax.servlet.http.HttpServletRequest;


/**
 * Created by Administrator on 2016/4/18.
 */
@Controller
@RequestMapping("/wiki")
public class wikiController {
    @Autowired
    protected BaseManager baseManager;

    @RequestMapping("/saveUpdateWiki.do")
    public String saveAndUpdateWiki(Project project, HttpServletRequest request) {

        System.out.println("12");

        return null;
    }


}
