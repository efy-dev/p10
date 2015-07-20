package com.efeiyi.ec.personal.tenantProduct;

import com.efeiyi.ec.product.model.Product;
import com.efeiyi.ec.tenant.model.Tenant;
import com.ming800.core.base.service.BaseManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.LinkedHashMap;
import java.util.List;

/**
 * Created by AC丶man on 2015/7/17.
 */

@Controller
@RequestMapping("/tenantProduct")
public class TenantProductController {

    @Autowired
    private BaseManager baseManager;


    /**
     * 获取传承人作品列表
     * @param model
     * @return
     */
    @RequestMapping("/tenantProductList.do")
    public ModelAndView listTenantProduct(HttpServletRequest request ,ModelMap model){
        String condition = request.getParameter("condition");
        LinkedHashMap<String, Object> queryParamMap = new LinkedHashMap<>();
        String tenantId = request.getParameter("tenantId");
        Tenant tenant = (Tenant) baseManager.getObject(Tenant.class.getName(),tenantId);
        model.addAttribute("tenant",tenant);
        StringBuffer sb = new StringBuffer("from TenantProduct p where p.tenant.id = :tenantId");
        queryParamMap.put("tenantId",tenantId);
        /**
         * 根据页面传递查询参数来选择展示的数据
         */
        if(condition != null && Long.valueOf(condition) > 0){
            sb.append(" and YEAR(p.createDateTime) = "+ Integer.valueOf(condition));
        }
        sb.append(" order by p.createDateTime DESC");
        List productList = baseManager.listObject(sb.toString(), queryParamMap);
        model.addAttribute("productList",productList);
        return new ModelAndView("/tenantProduct/tenantProductList",model);

    }
    /**
     * 获取传承人作品详情
     * @param model
     * @return
     */
    @RequestMapping("/getProduct.do")
    public ModelAndView getProduct(HttpServletRequest request ,ModelMap model){
        String tenantId = request.getParameter("tenantId");
        String productId = request.getParameter("productId");
        Tenant tenant = (Tenant) baseManager.getObject(Tenant.class.getName(),tenantId);
        Product product = (Product)baseManager.getObject(Product.class.getName(), productId);
        model.addAttribute("tenant",tenant);
        model.addAttribute("product", product);
        return new ModelAndView("/tenantProduct/tenantProductView",model);

    }

}
