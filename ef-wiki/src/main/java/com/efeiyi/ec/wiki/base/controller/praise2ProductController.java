package com.efeiyi.ec.wiki.base.controller;

import com.efeiyi.ec.wiki.base.util.projectConvertprojectModelUtil;
import com.efeiyi.ec.wiki.model.Praise2Product;
import com.efeiyi.ec.wiki.model.Praise2ProductModel;
import com.efeiyi.ec.wiki.model.ProductComment;
import com.efeiyi.ec.wiki.model.ProductCommentModel;
import com.efeiyi.ec.wiki.organization.util.AuthorizationUtil;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.PageInfo;
import com.ming800.core.does.model.XQuery;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Administrator on 2015/10/23.
 *
 */
@Controller
@RequestMapping("/praise")
public class praise2ProductController extends WikibaseController {
    private static Logger logger = Logger.getLogger(praise2ProductController.class);
    @Autowired
    BaseManager baseManager;

    @RequestMapping("/getPraiseList.do")
    @ResponseBody
    public List getPraiseList(HttpServletRequest request, Model model) throws Exception {
        List<Praise2ProductModel> list = null;
        if (AuthorizationUtil.getMyUser().getId() != null) {
            XQuery query = new XQuery("plistPraise2Product_ownerPraise", request);
            query.put("moderator_id", AuthorizationUtil.getMyUser().getId());
            PageInfo pageInfo = baseManager.listPageInfo(query);
            list = projectConvertprojectModelUtil.getpraise2ProductModel(pageInfo.getList());
        }else{
            list = new ArrayList<Praise2ProductModel>();
        }
        return list;

    }

    @RequestMapping("/watchPraise.do")
    @ResponseBody
    public String watchPraise(HttpServletRequest request) throws Exception {
        String praise2ProductId = request.getParameter("praise2ProductId");
        Praise2Product praise2Product = (Praise2Product)baseManager.getObject(Praise2Product.class.getName(),praise2ProductId);
        praise2Product.setWatch("1");
        baseManager.saveOrUpdate(Praise2Product.class.getName(),praise2Product);
        return "succ";
    }
}