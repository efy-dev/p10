package com.efeiyi.ec.website.product.controller;

import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by Administrator on 2015/10/20.
 */
@Controller
@RequestMapping("/group")
public class GroupController {
    @Autowired
    private BaseManager baseManager;

    /**
     * 团购产品列表
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/groupProduct.do")
    @ResponseBody
    public List<Object> listProduct(HttpServletRequest request, Model model) throws Exception {
        XQuery xQuery = new XQuery("",request);
        List<Object> productModelList = baseManager.listPageInfo(xQuery).getList();
        return productModelList;
    }

}
