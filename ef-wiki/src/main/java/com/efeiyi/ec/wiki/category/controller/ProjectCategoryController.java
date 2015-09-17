package com.efeiyi.ec.wiki.category.controller;

import com.efeiyi.ec.organization.model.AddressProvince;
import com.efeiyi.ec.project.model.ProjectCategory;
import com.ming800.core.base.controller.BaseController;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.p.service.ObjectRecommendedManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.List;


/**
 * Created by Administrator on 2015/9/16.
 *
 */
@Controller
public class ProjectCategoryController extends BaseController {
    private static Logger logger = Logger.getLogger(ProjectCategoryController.class);
    @Autowired
    BaseManager baseManager;
    @Autowired
    ObjectRecommendedManager objectRecommendedManager;

    /**
     * 非遗项目分类类型
     * @param  request is HttpServletRequest
     * @return projectList
     * @throws Exception
     */
    @RequestMapping("/category.do")
    public ModelAndView getProjectCategoryList(HttpServletRequest request, Model model)throws Exception{
           XQuery xQuery = new XQuery("plistProjectCategory_byType",request);
           List<ProjectCategory> list = baseManager.listObject(xQuery);
           model.addAttribute("ProjectCategoryList",list);
           XQuery xQuery2 = new XQuery("listAddressProvince_default",request);
           List<AddressProvince> list2 = baseManager.listObject(xQuery2);
           model.addAttribute("AddressProvinceList",list2);
        return  new ModelAndView("/classify/projectClassify");
    }





}
