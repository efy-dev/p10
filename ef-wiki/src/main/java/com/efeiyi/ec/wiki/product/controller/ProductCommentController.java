package com.efeiyi.ec.wiki.product.controller;


import com.efeiyi.ec.wiki.base.controller.WikibaseController;
import com.efeiyi.ec.wiki.base.util.projectConvertprojectModelUtil;
import com.efeiyi.ec.wiki.model.ProductComment;
import com.efeiyi.ec.wiki.product.model.ProductCommentModel;
import com.efeiyi.ec.wiki.organization.util.AuthorizationUtil;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.PageInfo;
import com.ming800.core.does.model.XQuery;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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
@RequestMapping("/comment")
public class ProductCommentController extends WikibaseController {
    private static Logger logger = Logger.getLogger(ProductCommentController.class);
    @Autowired
    BaseManager baseManager;

    @RequestMapping("/getCommentList.do")
    @ResponseBody
    public List getCommentList(HttpServletRequest request) throws Exception {
        List<ProductCommentModel> list;
        if (AuthorizationUtil.getMyUser().getId() != null) {
            XQuery query = new XQuery("plistProductComment_ownerComent", request);
            query.put("moderator_id", AuthorizationUtil.getMyUser().getId());
             PageInfo pageInfo = baseManager.listPageInfo(query);
             list = projectConvertprojectModelUtil.getProductCommentModel(pageInfo.getList());
        }else{
            list = new ArrayList<ProductCommentModel>();
        }
        logger.info("getCommentList success");
        return list;

    }

    @RequestMapping("/watchComment.do")
    @ResponseBody
    public String watchComment(HttpServletRequest request) throws Exception {
        String commentId = request.getParameter("commentId");
        ProductComment productComment = (ProductComment)baseManager.getObject(ProductComment.class.getName(),commentId);
        if(productComment!=null && productComment.getId()!=null){
            productComment.setWatch("1");
            baseManager.saveOrUpdate(ProductComment.class.getName(),productComment);
        }
        return "succ";
    }
}