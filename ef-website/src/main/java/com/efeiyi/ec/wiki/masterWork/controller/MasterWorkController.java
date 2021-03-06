package com.efeiyi.ec.wiki.masterWork.controller;

import com.efeiyi.ec.master.model.*;
import com.efeiyi.ec.product.model.Product;
import com.efeiyi.ec.project.model.Project;
import com.efeiyi.ec.wiki.masterWork.model.MasterWorkModel;
import com.efeiyi.ec.wiki.masterWork.utils.ConvertWorkModel;
import com.efeiyi.ec.wiki.model.Artistry;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.net.URLEncoder;
import java.util.LinkedHashMap;
import java.util.List;

/**
 * Created by Administrator on 2016/4/13.
 */
@Controller
@RequestMapping({"minglu"})
public class MasterWorkController {
    @Autowired
    private BaseManager baseManager;

    @RequestMapping("/masterWork/{id}")
    public String getMasterWork(@PathVariable String id, Model model, HttpServletRequest request) throws Exception {
        if (id != null && !"".equals(id)) {
            MasterWork work = (MasterWork) baseManager.getObject(MasterWork.class.getName(), id);
            Product product = getProductByMasterWork(work);
            if (null != product) {
                return "redirect:/app/product_details.html?productId=" + product.getProductModelList().get(0).getId() + "&title=" + URLEncoder.encode( product.getProductModelList().get(0).getName(), "UTF-8");
            }
            Project project = work.getProject();
            Artistry projectWiki = project.getArtistry();
            MasterWorkModel workModel;
            List<MasterWork> workList = null;
            if (work.getProject() != null && work.getProject().getId() != null) {
                XQuery xQuery = new XQuery("listMasterWork_default", request);
                xQuery.put("project_id", work.getProject().getId());
                workList = baseManager.listObject(xQuery);
            }
            workModel = ConvertWorkModel.convertMasterWorkModel(work, workList);
            model.addAttribute("masterWork", work);
            model.addAttribute("projectWiki", projectWiki);
            model.addAttribute("work", workModel);
        }
        return "/masterWork/masterWorkView";
    }
    /**
     *
     * *
     * @param masterId
     * @param model
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping("/master/{masterId}")
    public String getMasterInfo(@PathVariable String masterId, Model model,HttpServletRequest request) throws Exception {
        Master master = (Master) baseManager.getObject(Master.class.getName(),masterId);
        List<MasterProject> masterProjectList = null;
        if(master!=null){
            masterProjectList = master.getMasterProjectList();
        }

        MasterProject masterProject = null;
        Artistry artistry = null;
        if(masterProjectList!=null&&masterProjectList.size()>0){
            masterProject = masterProjectList.get(0);
            artistry = masterProject.getProject().getArtistry();
        }

        XQuery mwXQuery = new XQuery("listMasterWork_default1", request);
        //相关作品
        mwXQuery.put("master_id",masterId);
        List<MasterWork> masterWorkList = baseManager.listObject(mwXQuery);
        model.addAttribute("workList",masterWorkList);
        model.addAttribute("artistry",artistry);
        XQuery xQuery = new XQuery("listMasterIntroduction_default",request);
        xQuery.put("master_id",masterId);
        List<MasterIntroduction> introductionList = baseManager.listObject(xQuery);
        model.addAttribute("introductionList",introductionList);
        model.addAttribute("masterProject",masterProject);
        model.addAttribute("master",master);
        return "/masterWork/masterIntroduction";
    }
    /**
     * 描述:技艺主页相关作品列表是否与商品有关联关系
     *
     * @param masterwork
     *
     */
    public Product getProductByMasterWork(MasterWork masterwork) throws Exception {
        if (null != masterwork) {
            List<MasterWorkProduct> masterWorkProducts = masterwork.getMasterWorkProductList();
            if (null != masterWorkProducts && masterWorkProducts.size() > 0) {
                for (MasterWorkProduct masterWorkProduct : masterWorkProducts) {
                    if (null != masterWorkProduct) {
                        Product product = masterWorkProduct.getProduct();
                        return product;
                    }
                }
            }
        }
        return null;
    }
}
