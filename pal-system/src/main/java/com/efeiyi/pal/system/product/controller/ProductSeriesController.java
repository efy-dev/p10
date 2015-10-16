package com.efeiyi.pal.system.product.controller;

import com.efeiyi.pal.product.model.ProductSeries;
import com.efeiyi.pal.product.model.ProductSeriesPropertyName;
import com.efeiyi.pal.product.model.TenantProductSeries;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.p.service.AutoSerialManager;
import com.ming800.core.util.ApplicationContextUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Administrator on 2015/7/30.
 * 商品系列(非遗项目) Controller
 */

@Controller
@RequestMapping("/productSeries")
public class ProductSeriesController {

    @Autowired
    private AutoSerialManager autoSerialManager;

    private BaseManager baseManager = (BaseManager) ApplicationContextUtil.getApplicationContext().getBean("baseManagerImpl");

    @RequestMapping("/saveProductSeries.do")
    public ModelAndView saveProductSeries(HttpServletRequest request) throws Exception {
        ProductSeries productSeries = new ProductSeries();

        String productSeriesId = request.getParameter("id");
        String type = "new";
        if (productSeriesId != null && !productSeriesId.equals("")) {
            type = "edit";
            productSeries = (ProductSeries) baseManager.getObject(ProductSeries.class.getName(), productSeriesId);
        }
        productSeries = setProductSeriesProperty(productSeries, request);

        productSeries = getRelationAttributeObject(productSeries, request, type);
        baseManager.saveOrUpdate(productSeries.getClass().getName(), productSeries);

        String resultPage = "redirect:/basic/xm.do?qm=viewProductSeries&ps=ps&id=" + productSeries.getId();
        return new ModelAndView(resultPage);
    }

    /**
     * 获取关联属性的对象
     * @param productSeries 商品系列
     * @param request 获取页面参数
     * @param type 新建"new"; 修改"edit"
     * @return productSeries 商品系列
     */
    private ProductSeries getRelationAttributeObject(ProductSeries productSeries, HttpServletRequest request, String type) throws Exception {

        if ("new".equals(type)){
            List<ProductSeriesPropertyName> productSeriesPropertyNameList = new ArrayList<>();
            productSeries.setProductSeriesPropertyNameList(productSeriesPropertyNameList);
            productSeries.setTenantProductSeriesList(new ArrayList<TenantProductSeries>());
            String serial = autoSerialManager.nextSerial("serial");
            productSeries.setSerial(serial);
            productSeries.setStatus("1");
        }else {
            String status = request.getParameter("status");
            productSeries.setStatus(status);
        }
        return productSeries;

    }

    /**
     * 获取Form表单基本数据
     * @param productSeries 商品系列
     * @param request 获取页面参数
     * @return productSeries 商品系列
     */
    private ProductSeries setProductSeriesProperty(ProductSeries productSeries, HttpServletRequest request) {
        String name = request.getParameter("name");
        productSeries.setName(name);

        return productSeries;
    }

}
