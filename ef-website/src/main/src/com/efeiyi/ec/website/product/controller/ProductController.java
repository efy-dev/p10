package com.efeiyi.ec.website.product.controller;

import com.efeiyi.ec.product.model.Product;
import com.efeiyi.ec.product.model.ProductFavorite;
import com.efeiyi.ec.product.model.ProductModel;
import com.efeiyi.ec.website.organization.util.AuthorizationUtil;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.does.model.XSaveOrUpdate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

/**
 * Created by Administrator on 2015/7/8.
 */
@Controller
@RequestMapping("/product")
public class ProductController {

    @Autowired
    private BaseManager baseManager;

    @RequestMapping(value = "/productList.do")
    public ModelAndView listProduct(HttpServletRequest request, ModelMap model) throws Exception{
        String id= request.getParameter("id");
        XQuery xQuery = new XQuery("listProduct_default",request);
        List productList = baseManager.listObject(xQuery);
        model.addAttribute("productList",productList);
        return  new ModelAndView("/product/productList",model);
    }


    @RequestMapping({"/{productId}"})
    public String viewProduct(@PathVariable String productId, HttpServletRequest request ,Model model){
        ProductModel productModel = (ProductModel)baseManager.getObject(ProductModel.class.getName(),productId);
        model.addAttribute("productModel",productModel);
        return "/product/productView";
    }

    @RequestMapping("/list/{category}")
    public String plistProduct(@PathVariable String category ,HttpServletRequest request, Model model) throws Exception{
        //前端传一组key：value过来，格式
        String conditions = request.getParameter("conditions");
        List<String> conditionItem = Arrays.asList(conditions.split(";"));
        HashMap<String,String> conditionMap = new HashMap<>();
        for (String conditionTemp :conditionItem){
            String[] tempList = conditionTemp.split(":");
            conditionMap.put(tempList[0],tempList[1]);
        }

        XQuery xQuery = new XQuery("plistProductModel_default",request);
        xQuery.put("product_category_id", category);

        int k = 0;
        String qStr = "";
        for (String pid : conditionMap.keySet()){
            qStr+="  (pv.projectProperty.id=:pid"+k+" and pv.projectPropertyValue.id=:pvid"+k+") or ";
            xQuery.put("pid"+k,pid);
            xQuery.put("pvid"+k,conditionMap.get(pid));
            k++;
        }

        qStr = " and ("+qStr.substring(0,qStr.lastIndexOf("or"))+") ";

        xQuery.setHeadHql(xQuery.getHeadHql() + " inner join s.productPropertyValueList pv ");
        xQuery.setQueryHql(xQuery.getQueryHql() + qStr);
        xQuery.updateHql();
        xQuery.addRequestParamToModel(model,request);
        List productList = baseManager.listPageInfo(xQuery).getList();
        model.addAttribute("productList",productList);
        request.setAttribute("conditions",conditions);
        return "/product/productModelList";
    }

    @RequestMapping(value = "/getProduct.do")
    public String getProduct(HttpServletRequest request, Model model) {
        String id = request.getParameter("id");
        Product product = (Product) baseManager.getObject(Product.class.getName(), id);
        model.addAttribute("product", product);
        return "/product/productView";
    }

    /**
     * 产品收藏
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping({"/addProductFavorite.do"})
    @ResponseBody
    public boolean addProductFavorite(HttpServletRequest request) throws Exception{
        String productId =request.getParameter("productId");
        XSaveOrUpdate xSaveOrUpdate = new XSaveOrUpdate("saveOrUpdateProductFavorite" ,request);
        xSaveOrUpdate.getParamMap().put("user_id", AuthorizationUtil.getMyUser().getId());
        xSaveOrUpdate.getParamMap().put("product_id", productId);
        baseManager.saveOrUpdate(xSaveOrUpdate);
        return true;
    }

    /**
     * 删除收藏产品
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping({"/removeProductFavorite.do"})
    @ResponseBody
    public boolean removeProductFavorite(HttpServletRequest request) throws Exception{
        baseManager.remove(ProductFavorite.class.getName(),request.getParameter("productFavoriteId"));
        return true;
    }

    /**
     * 查看收藏产品
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping({"/favorite/list"})
    public List<Object> listProductFavorite(HttpServletRequest request) throws Exception{
        XQuery xQuery = new XQuery("plistProductFavorite_default",request);
        List<Object> objectList = baseManager.listObject(xQuery);
        return objectList;
    }




}
