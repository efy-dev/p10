package com.efeiyi.ec.website.activity;

import com.efeiyi.ec.activity.model.SeckillProduct;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.PageInfo;
import com.ming800.core.does.model.XQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by Administrator on 2015/11/17 0017.
 */
    @Controller
    @RequestMapping({"/miaosha"})
    public class SeckillController {

    @Autowired
    private BaseManager baseManager;

    /**
     * 当天秒杀的商品，所有秒杀的商品 以开始时间排序 往期回顾？
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/list")
    public String listSeckillProduct(HttpServletRequest request,Model model) throws Exception {
        XQuery seckillQuery = new XQuery("plistSeckillProduct_default", request);
        PageInfo pageInfo = baseManager.listPageInfo(seckillQuery);
        model.addAttribute("productList",pageInfo.getList());
        model.addAttribute("pageInfo",pageInfo);
        return null;
    }


    /**
     * 秒杀商品分为几个状态 1.已经开始 2.已经结束 3.即将开始
     * @param request
     * @param model
     * @param seckillProductId
     * @return
     * @throws Exception
     */
    @RequestMapping("/{seckillProductId}")
    public String viewSeckillProduct(HttpServletRequest request,Model model,@PathVariable String seckillProductId) throws Exception {
        SeckillProduct seckillProduct = (SeckillProduct)baseManager.getObject(SeckillProduct.class.getName(),seckillProductId);
        model.addAttribute("seckillProduct",seckillProduct);
        return null;
    }

}
