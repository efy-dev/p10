package com.efeiyi.association.controller;

import com.efeiyi.ec.association.model.IntangibleCulturalOrganization;
import com.ming800.core.base.service.BaseManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;

/**
 * Created by Administrator on 2015/9/14.
 */
@RestController
@RequestMapping("/myOrganization")
public class MyOrganizationController {
    @Autowired
    private BaseManager baseManager;


    @RequestMapping("/saveOrganization.do")
    public String saveOrganization(ModelMap model, HttpServletRequest request, IntangibleCulturalOrganization intangibleCulturalOrganization) throws Exception {

        //新建内容
        String path = request.getParameter("qm");
        intangibleCulturalOrganization.setTheDatetime(new Date());
        if (intangibleCulturalOrganization.getId() == null || "".equals(intangibleCulturalOrganization.getId())) {
            //新建内容传入原页面地址
            intangibleCulturalOrganization.setStatus("1");
            intangibleCulturalOrganization.setId(null);

        }
        baseManager.saveOrUpdate(intangibleCulturalOrganization.getClass().getName(),intangibleCulturalOrganization);

        return request.getContextPath() + path;
    }

    @RequestMapping("/removeOrganization.do")
    @ResponseBody
    public ModelAndView removeDocument(HttpServletRequest request, IntangibleCulturalOrganization organization) throws Exception {
        String path =/* request.getContextPath() +*/ request.getParameter("resultPage");

        baseManager.remove(organization.getClass().getName(), organization.getId());

        return new ModelAndView("redirect:"/* + request.getContextPath()*/ + path);
    }
}
