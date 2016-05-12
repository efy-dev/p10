package com.efeiyi.ec.gift.productgift.controller;

import com.efeiyi.ec.gift.model.ProductGift;
import com.efeiyi.ec.gift.model.ProductGiftTag;
import com.efeiyi.ec.gift.model.ProductGiftTagValue;
import com.efeiyi.ec.product.model.Subject;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.p.service.BannerManager;
import com.ming800.core.p.service.ObjectRecommendedManager;
import com.ming800.core.taglib.PageEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.math.BigDecimal;
import java.util.*;

/**
 * Created by Administrator on 2016/4/19.
 */
@Controller
public class ProductGiftController {
    @Autowired
    private BannerManager bannerManager;
    @Autowired
    private ObjectRecommendedManager objectRecommendedManager;
    @Autowired
    private BaseManager baseManager;

    @RequestMapping({"/getProductGiftpList"})
    public String getProductGiftpList(HttpServletRequest request, Model model) throws Exception{

        String minPrice = request.getParameter("minPrice");
        String maxPrice = request.getParameter("maxPrice");
        String value = request.getParameter("value");
        Map<String, List<ProductGiftTagValue>> map = new HashMap<>();
        Map<String, List<ProductGiftTagValue>> map1 = new HashMap<>();
        XQuery xQuery = new XQuery("listProductGiftTagValue_default", request);
        List<ProductGiftTagValue> list = baseManager.listObject(xQuery);
        try {
            for(ProductGiftTagValue productGiftTagValue:list){
                String group = productGiftTagValue.getGroup();
                String type = productGiftTagValue.getType();
                if (map.containsKey(group)){
                    map.get(group).add(productGiftTagValue);
                }else {
                    List<ProductGiftTagValue> productGiftTagValueList = new ArrayList<>();
                    productGiftTagValueList.add(productGiftTagValue);
                    map.put(group,productGiftTagValueList);
                }
                if (map1.containsKey(type)){
                    map1.get(type).add(productGiftTagValue);
                }else {
                    List<ProductGiftTagValue> productGiftTagValueList = new ArrayList<>();
                    productGiftTagValueList.add(productGiftTagValue);
                    map1.put(type,productGiftTagValueList);
                }
            }
        }catch (Exception e){}

        LinkedHashMap<String, Object> queryParamMap = new LinkedHashMap<>();
        PageEntity pageEntity = getPageEntity(request);
        String hql = "";
        if(value != null && value != ""){
            hql = "from ProductGiftTag p where p.status=1";
            if(value != null && value != ""){
                queryParamMap.put("value", value);
                hql+=" and p.productGiftTagValue.value=:value";
            }
            if(minPrice != null && minPrice != ""){
                queryParamMap.put("minPrice", new BigDecimal(minPrice));
                hql+=" and p.productGift.productModel.price>=:minPrice";
            }
            if(maxPrice != null && maxPrice != ""){
                queryParamMap.put("maxPrice", new BigDecimal(maxPrice));
                hql+=" and p.productGift.productModel.price<=:maxPrice";
            }
            List<ProductGiftTag> productGiftTaglist = baseManager.listPageInfo(hql, pageEntity, queryParamMap).getList();
            model.addAttribute("productGiftTagList", productGiftTaglist);
        }else {
            hql = "from ProductGift p where p.status=1";
            if(minPrice != null && minPrice != ""){
                queryParamMap.put("minPrice", new BigDecimal(minPrice));
                hql+=" and p.productModel.price>=:minPrice";
            }
            if(maxPrice != null && maxPrice != ""){
                queryParamMap.put("maxPrice", new BigDecimal(maxPrice));
                hql+=" and p.productModel.price<=:maxPrice";
            }
            List<ProductGift> productGiftList = baseManager.listPageInfo(hql, pageEntity,queryParamMap).getList();
            model.addAttribute("productGiftList", productGiftList);
        }
        model.addAttribute("map", map);
        model.addAttribute("map1", map1);
        model.addAttribute("pageInfo", baseManager.listPageInfo(hql,pageEntity,queryParamMap));
        model.addAttribute("pageEntity", pageEntity);
        return "/gift/productGiftpList";
    }

    @RequestMapping({"/viewSubject/{subjectId}"})
         public String viewSubject(@PathVariable String subjectId, Model model) throws Exception{
        Subject subject = (Subject) baseManager.getObject(Subject.class.getName(),subjectId);
        model.addAttribute("subject", subject);
        return "/gift/subjectView";
    }

    @RequestMapping({"/searchProductGift"})
    public String searchProductGift(HttpServletRequest request, Model model) throws Exception{
        XQuery xQuery = new XQuery("listProductGiftTagValue_default", request);
        List productGiftTagValuelist = baseManager.listObject(xQuery);
        model.addAttribute("productGiftTagValuelist",productGiftTagValuelist);
        return "/gift/searchProductGift";
    }

    @RequestMapping({"/searchProductGiftList"})
    public String searchProductGiftList(HttpServletRequest request, Model model) throws Exception{
        String value = request.getParameter("value");
        String minPrice = request.getParameter("minPrice");
        String maxPrice = request.getParameter("maxPrice");
        LinkedHashMap<String, Object> queryParamMap = new LinkedHashMap<>();
        List<ProductGift> productGiftList = new ArrayList();
        String hql = "from ProductGiftTag p where p.status=1";
        if(value != null && value != ""){
            queryParamMap.put("value", value);
            hql+=" and p.productGiftTagValue.value=:value";
        }
        if(minPrice != null && minPrice != ""){
            queryParamMap.put("minPrice", new BigDecimal(minPrice));
            hql+=" and p.productGift.productModel.price>=:minPrice";
        }
        if(maxPrice != null && maxPrice != ""){
            queryParamMap.put("maxPrice", new BigDecimal(maxPrice));
            hql+=" and p.productGift.productModel.price<=:maxPrice";
        }
        List<ProductGiftTag> productGiftTaglist = baseManager.listObject(hql,queryParamMap);
        for(ProductGiftTag productGiftTag:productGiftTaglist){
            if(!productGiftList.contains(productGiftTag.getProductGift())){
                productGiftList.add(productGiftTag.getProductGift());
            }
        }
        model.addAttribute("productGiftList", productGiftList);
        return "/gift/searchProductGiftList";
    }

    protected PageEntity getPageEntity(HttpServletRequest request) {
        String index = request.getParameter(PageEntity.PARAM_NAME_PAGEINDEX);
        String size = request.getParameter(PageEntity.PARAM_NAME_PAGERECORDS);
        PageEntity pageEntity = new PageEntity();
        pageEntity.setIndex(1);
        pageEntity.setSize(12);
        if (index != null && !index.equals("")) {
            pageEntity.setIndex(Integer.parseInt(index));
        }
        if (size != null && !size.equals("")) {
            pageEntity.setSize(Integer.parseInt(size));
        }
        return pageEntity;
    }

}
