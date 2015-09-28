package com.efeiyi.association.association.controller;

import com.ming800.core.base.service.XdoManager;
import com.ming800.core.does.model.Do;
import com.ming800.core.does.model.DoQuery;
import com.ming800.core.does.model.PageInfo;
import com.ming800.core.does.service.DoManager;
import com.ming800.core.p.model.Document;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by Administrator on 2015/9/25.
 * 非遗名录 Controller
 */
@Controller
@RequestMapping("/project")
public class ProjectController {

    @Autowired
    private DoManager doManager;
    @Autowired
    private XdoManager xdoManager;

    @RequestMapping("/project.do")
    public ModelAndView getAssIntroByGroupId(ModelMap modelMap, HttpServletRequest request) throws Exception {

        String qm = request.getParameter("qm");
        //先找到配置文件里的entity
        Do tempDo = doManager.getDoByQueryModel(qm.split("_")[0]);
        //再从中找到query的信息
        DoQuery tempDoQuery = tempDo.getDoQueryByName(qm.split("_")[1]);

        modelMap.put("provinceList", xdoManager.list(tempDo, tempDoQuery, null));

        return new ModelAndView("heritageProject/project");
    }

}
