package com.efeiyi.ec.website.base.controller;

import com.efeiyi.ec.project.model.Project;
import com.efeiyi.ec.project.model.ProjectCategory;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.p.model.Banner;
import com.ming800.core.p.service.BannerManager;
import com.ming800.core.p.service.ObjectRecommendedManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;

/**
 * Created by Administrator on 2015/8/17.
 */
@Controller
public class HomeController {

    @RequestMapping({"/500"})
    public String show500(){
        return "/common/500";
    }

    @RequestMapping({"/404"})
    public String show404(){
        return "/common/404";
    }

}
