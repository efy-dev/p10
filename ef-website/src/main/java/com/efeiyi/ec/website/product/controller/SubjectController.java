package com.efeiyi.ec.website.product.controller;

import com.efeiyi.ec.product.model.Subject;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by Administrator on 2015/9/16 0016.
*/
@Controller
public class SubjectController {

    @Autowired
    private BaseManager baseManager;

    @RequestMapping({"/subject/{subjectId}"})
    public String viewSubject(@PathVariable String subjectId ,HttpServletRequest request,Model model) throws  Exception{

        Subject subject = (Subject)baseManager.getObject(Subject.class.getName(),subjectId);

        XQuery xQuery = new XQuery("listSubjectProductModel_default",request);
        xQuery.put("subject_id",subjectId);
        List<Object> productModelList = baseManager.listObject(xQuery);

        model.addAttribute("subject",subject);
        model.addAttribute("productModelList",productModelList);
        if (subject.getTemplate().equals("2")){
            return "redirect:/subject/activity/"+subjectId;
        }
        return "/product/subjectView";

    }

    @RequestMapping({"/subject/activity/{subjectId}"})
    public String viewActivity(@PathVariable String subjectId ,HttpServletRequest request,Model model)throws Exception{
        Subject subject = (Subject)baseManager.getObject(Subject.class.getName(),subjectId);
        XQuery xQuery = new XQuery("listSubjectProductModel_default",request);
        xQuery.put("subject_id",subjectId);
        List<Object> productModelList = baseManager.listObject(xQuery);

        model.addAttribute("subject",subject);
        model.addAttribute("productModelList",productModelList);
        return "/product/subjectActivityView";
    }

}
