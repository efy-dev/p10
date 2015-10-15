package com.efeiyi.pal.system.product.controller;

import com.efeiyi.pal.product.model.ProductSeries;
import com.efeiyi.pal.product.model.ProductSeriesPropertyName;
import com.efeiyi.pal.system.product.service.ProductSeriesServiceManager;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.util.ApplicationContextUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by Administrator on 2015/7/31.
 * 商品系列(非遗项目)属性名 Controller
 */

@Controller
@RequestMapping("/productSeriesPropertyName")
public class ProductSeriesPropertyNameController {

    @Autowired
    private BaseManager baseManager;

    private ProductSeriesServiceManager productSeriesServiceManager = (ProductSeriesServiceManager) ApplicationContextUtil.getApplicationContext().getBean("productSeriesServiceManagerImpl");

    @RequestMapping("/newPropertyNameList.do")
    public ModelAndView newProductSeriesPropertyNameList(ModelMap modelMap, HttpServletRequest request) throws Exception {

        String productSeriesId = request.getParameter("productSeriesId");
        if (productSeriesId == null || "".equals(productSeriesId.trim())) {
            throw new Exception("productSeriesId不能为空");
        }
        ProductSeries productSeries = (ProductSeries) baseManager.getObject(ProductSeries.class.getName(), productSeriesId);

        modelMap.put("productSeries", productSeries);
        modelMap.put("PSPNListSize", productSeries.getProductSeriesPropertyNameList().size());

        String resultPage = "/productSeriesPropertyName/productSeriesPropertyNameListForm";

        return new ModelAndView(resultPage);
    }

    @RequestMapping("/savePropertyNameList.do")
    public ModelAndView saveProductSeriesPropertyNameList(HttpServletRequest request, HttpServletResponse response) throws Exception {

        response.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");
        request.setCharacterEncoding("utf-8");

        String productSeriesId = request.getParameter("productSeries.id");
        if (productSeriesId == null || "".equals(productSeriesId)) {
            throw new Exception("productSeriesId不能为空");
        }

        ProductSeries productSeries = (ProductSeries) baseManager.getObject(ProductSeries.class.getName(), productSeriesId);
        int count = Integer.parseInt(request.getParameter("count"));
        String resultPage = savePropertyNameList(request, count, productSeries, productSeriesId);

        return new ModelAndView(resultPage);
    }

    /**
     * 循环遍历listForm页面保存PropertyName
     * @param request 获取页面参数
     * @param flag    属性名个数
     * @param productSeries 商品系列
     * @param productSeriesId 商品系列Id
     * @return 跳转链接
     * @throws Exception
     */
    private String savePropertyNameList(HttpServletRequest request, int flag, ProductSeries productSeries, String productSeriesId) throws Exception{

        if (productSeries == null) {
            throw new Exception("Id为" + productSeriesId + "的商品系列不存在!");
        }

        //添加新建系列属性
        for (int i=1; i<=flag; i++){
            ProductSeriesPropertyName propertyName = new ProductSeriesPropertyName();
            String propertyNameId = request.getParameter("propertyNameId"+i);
            if (propertyNameId != null && !propertyNameId.equals("")) {
                propertyName = (ProductSeriesPropertyName) baseManager.getObject(ProductSeriesPropertyName.class.getName(), propertyNameId);
            }

            String name =request.getParameter("name"+i);

            if (name == null || "".equals(name)){
                if (propertyNameId != null && !propertyNameId.trim().equals("")){
                    productSeriesServiceManager.deleteProductPropertyValueByPropertyName(propertyName);
                    baseManager.delete(propertyName.getClass().getName(), propertyName.getId());
                }
                continue;
            }
            String newName = new String (name.getBytes("utf-8"), "utf-8");
            propertyName.setProductSeries(productSeries);
            propertyName.setName(newName);
            propertyName.setStatus("1");

            baseManager.saveOrUpdate(propertyName.getClass().getName(), propertyName);
            propertyName.getName();
        }

        return "redirect:/basic/xm.do?qm=viewProductSeries&ps=ps&id="+ productSeries.getId();
    }

}
