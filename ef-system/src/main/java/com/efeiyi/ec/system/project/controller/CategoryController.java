package com.efeiyi.ec.system.project.controller;

import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by Administrator on 2015/9/15 0015.
 */
@Controller
public class CategoryController {

    @Autowired
    private BaseManager baseManager;


    @RequestMapping({"/category/list/json"})
    @ResponseBody
    public List<Object> listCategory(HttpServletRequest request) throws Exception{
        XQuery categoryQuery = new XQuery("listProjectCategory_json" ,request);
        List<Object> categoryList = baseManager.listObject(categoryQuery);

        return categoryList;

    }

}
