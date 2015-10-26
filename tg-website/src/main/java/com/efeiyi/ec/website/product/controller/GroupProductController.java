package com.efeiyi.ec.website.product.controller;

import com.efeiyi.ec.group.model.Group;
import com.efeiyi.ec.group.model.GroupProduct;
import com.efeiyi.ec.organization.model.MyUser;
import com.efeiyi.ec.product.model.Product;
import com.efeiyi.ec.website.organization.util.AuthorizationUtil;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.math.BigDecimal;
import java.util.List;

/**
 * Created by Administrator on 2015/10/20.
 */
@Controller
@RequestMapping("/product")
public class GroupProductController {
    @Autowired
    private BaseManager baseManager;

    /**
     * 团购产品列表
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/groupProduct.do")
    public String listProduct(HttpServletRequest request, Model model) throws Exception {
        XQuery xQuery = new XQuery("listGroupProduct_default",request);
        xQuery.put("status","1");
        List<Object> groupProductList = baseManager.listObject(xQuery);
        model.addAttribute("groupProductList",groupProductList);
        return "/groupProduct/groupProductList";
    }
    /**
     * 开团详情页
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/groupProduct/{groupProductId}")
    public String groupProductDetails(@PathVariable String groupProductId ,HttpServletRequest request, Model model) throws Exception {
        GroupProduct groupProduct = (GroupProduct) baseManager.getObject(GroupProduct.class.getName(), groupProductId);
        model.addAttribute("groupProduct", groupProduct);
        return "/groupProduct/groupProductDetails";
    }
    /**
     *  我的开团
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/groupBuyStatus.do")
    public String groupBuyStatus(HttpServletRequest request, Model model) throws Exception {
        XQuery xQuery = new XQuery("listCreateProduct_default",request);
        List<Object> myCreateProductList = baseManager.listObject(xQuery);
        model.addAttribute("myCreateProductList", myCreateProductList);
        return "/personGroup/myCreateGroup";
    }

    /**
     *  我的参团
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/joinGroupStatus.do")
    public String groupJoinList(HttpServletRequest request, Model model) throws Exception {
        XQuery xQuery = new XQuery("listJoinGroup_default",request);
        List<Object> groupJoinList = baseManager.listObject(xQuery);
        model.addAttribute("groupJoinList", groupJoinList);
        return "/personGroup/myJoinGroup";
    }
    /**
     *  我的红包
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/bonusTotal.do")
    public String groupBonusTotal(HttpServletRequest request, Model model) throws Exception {
        XQuery xQuery = new XQuery("listCreateProduct_default",request);
        xQuery.put("status","1");
        List<Object> myCreateProductList = baseManager.listObject(xQuery);
        BigDecimal totalBonus = new BigDecimal(0.0);
        for(Object obj:myCreateProductList) {
            totalBonus.add(((Group)obj).getGroupProduct().getBonus());
        }
        model.addAttribute("totalBonus",totalBonus);
        return "/personGroup/myBonus";
    }
    /**
     *  个人中心
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/personInfoView.do")
    public String personInfoView(HttpServletRequest request, Model model) throws Exception {
        MyUser currentUser = AuthorizationUtil.getMyUser();
        Boolean flag = true;
        if (currentUser.getId() != null) {
            return "/personGroup/personGroupInfo";
        } else {
            //返回登陆页面
            return "/personGroup/personGroupInfo";
        }
    }
}
