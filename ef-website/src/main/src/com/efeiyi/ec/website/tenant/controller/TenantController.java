package com.efeiyi.ec.website.tenant.controller;

import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.Page;
import com.ming800.core.does.model.PageInfo;
import com.ming800.core.does.model.XQuery;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by Administrator on 2015/8/18.
 */
@Controller
public class TenantController {

    @Autowired
    private BaseManager baseManager;

    @RequestMapping({"/tenant/view"})
    public String listProduct(HttpServletRequest request,Model model) throws Exception {
         XQuery xQuery = new XQuery("plistProduct_default", request,20);
        String conditions = request.getParameter("conditions");
        String sort = request.getParameter("sort");
        xQuery.addRequestParamToModel(model,request);
        PageInfo pageInfo =baseManager.listPageInfo(xQuery);
        model.addAttribute("productList", pageInfo.getList());
        return "/tenant/productPList";
    }

}
