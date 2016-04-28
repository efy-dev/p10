package com.efeiyi.ec.gift.productgift.controller;

import com.efeiyi.ec.gift.model.IndustrySolution;
import com.efeiyi.ec.gift.model.ProductGiftIndustrySolution;
import com.efeiyi.ec.gift.model.ProductGiftTagValue;
import com.efeiyi.ec.product.model.Subject;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.does.model.XSaveOrUpdate;
import com.ming800.core.p.model.Banner;
import com.ming800.core.p.service.BannerManager;
import com.ming800.core.p.service.ObjectRecommendedManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2016/4/20.
 */
@Controller
public class IndustrySolutionController {
    @Autowired
    private BannerManager bannerManager;
    @Autowired
    private ObjectRecommendedManager objectRecommendedManager;
    @Autowired
    private BaseManager baseManager;

    @RequestMapping({"/industrySolution"})
    public String industrySolution(HttpServletRequest request, Model model) throws Exception{
        Map<String, List<ProductGiftTagValue>> map = new HashMap<>();
        Map<IndustrySolution, List<ProductGiftIndustrySolution>> industrySolutionMap = new HashMap<>();

        //获取轮播图
        List<Banner> bannerList = bannerManager.getBannerList("industrySolutionList");
        //获取推荐专题
        List<Subject> subjectList = objectRecommendedManager.getRecommendedList("industrySolutionRecommended");
        //获取方案列表
        XQuery industrySolutionXQuery = new XQuery("listIndustrySolution_default", request);
        List<IndustrySolution> industrySolutionList = baseManager.listObject(industrySolutionXQuery);
        for(IndustrySolution industrySolution:industrySolutionList){
            XQuery xQuery = new XQuery("listProductGiftIndustrySolution_default", request);
            xQuery.put("industry_solution_id", industrySolution.getId());
            List<ProductGiftIndustrySolution> productGiftIndustrySolutionList = baseManager.listObject(xQuery);
            industrySolutionMap.put(industrySolution, productGiftIndustrySolutionList);
        }
        //获取标签
        XQuery productGiftTagValueQuery = new XQuery("listProductGiftTagValue_default", request);//场合标签组
        List<ProductGiftTagValue> list = baseManager.listObject(productGiftTagValueQuery);
        try {
            for(ProductGiftTagValue productGiftTagValue:list){
                String group = productGiftTagValue.getGroup();
                if (map.containsKey(group)){
                    map.get(group).add(productGiftTagValue);
                }else {
                    List<ProductGiftTagValue> productGiftTagValueList = new ArrayList<>();
                    productGiftTagValueList.add(productGiftTagValue);
                    map.put(group,productGiftTagValueList);
                }
            }
        }catch (Exception e){}

        model.addAttribute("bannerList", bannerList);
        model.addAttribute("subjectList", subjectList);
        model.addAttribute("map", map);
        model.addAttribute("industrySolutionMap", industrySolutionMap);
        return "/gift/industrySolutionList";
    }

    @RequestMapping({"/industrySolutionRequest"})
    public String IndustrySolutionRequest(HttpServletRequest request, Model model) throws Exception{
        return "/gift/industrySolutionRequest";
    }

    @RequestMapping({"/submitIndustrySolutionRequest"})
    public String SubmitIndustrySolutionRequest(HttpServletRequest request, Model model) throws Exception{
        XSaveOrUpdate xSaveOrUpdate = new XSaveOrUpdate("saveOrUpdateCustomProductGiftMessage", request);
        baseManager.saveOrUpdate(xSaveOrUpdate);
        return "redirect:/industrySolution";
    }
}
