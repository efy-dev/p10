package com.ming800.core.develop.controller;

import com.ming800.core.base.service.BaseManager;
import com.ming800.core.develop.service.ExecuteHqlManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

/**
 * Created with IntelliJ IDEA.
 * User: ming
 * Date: 12-11-5
 * Time: 下午3:24
 * To change this template use File | Settings | File Templates.
 */
@Controller
@RequestMapping("/executeHql")
public class ExecuteHqlController {

    @Autowired
    private BaseManager baseManager;
    @Autowired
    private ExecuteHqlManager executeHqlManager;


    @RequestMapping("/formExecute.do")
    public ModelAndView formExecute() throws Exception {
        return new ModelAndView("/core/base/execute");
    }

    @RequestMapping("/execute.do")
    @ResponseBody
    public String execute(HttpServletRequest request) throws Exception {

        String queryHql = request.getParameter("queryHql");
        String type = request.getParameter("type");

        String result = "";
        if (type.equals("list")) {
            String names = request.getParameter("names");
            result = executeHqlManager.execute(queryHql, names.split(","));
        } else {
            result = baseManager.listObject(queryHql).get(0).toString();
        }

        return result;
    }


}


