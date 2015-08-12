package com.efeiyi.controller;

import com.efeiyi.PalConst;
import com.efeiyi.ResultBean;
import com.efeiyi.pal.check.model.LabelCheckRecord;
import com.efeiyi.pal.product.model.Product;
import com.efeiyi.service.ILabelCheckManager;
import com.ming800.core.base.service.BaseManager;
import org.apache.commons.beanutils.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import com.efeiyi.pal.label.model.Label;


import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.LinkedHashMap;

/**
 * Created by Administrator on 2015/7/27.
 * 验证防伪码的真伪֤controller
 */
@Controller
public class LabelCheckController  {

    @Autowired
    private ILabelCheckManager iLabelCheckService;

    @Autowired
    BaseManager baseManager;

    @RequestMapping(value = "/checkLabel.do")
    public ModelAndView checkLabel(HttpServletRequest request)throws Exception {

        ModelMap model = new ModelMap();
        Label label = getLabel(request);

        //label不存在
        if(label == null){
            model.addAttribute(PalConst.getInstance().resultLabel, PalConst.getInstance().fakeBean);
        }
        //label存在
        else {
            model.addAttribute(PalConst.getInstance().ip,request.getRemoteHost());
            model = iLabelCheckService.updateRecord(model, label);
        }
        return new ModelAndView(PalConst.getInstance().resultView, model);
    }

    @RequestMapping(value = "viewCertificate.do")
    public ModelAndView viewCertificate(HttpServletRequest request) throws Exception{

        ModelMap model = getProductModel(request);

        return new ModelAndView(PalConst.getInstance().certificateView, model);
    }

    @RequestMapping(value = "viewProduct.do")
    public ModelAndView viewProduct(HttpServletRequest request) throws Exception{

        ModelMap model = getProductModel(request);

        return new ModelAndView(PalConst.getInstance().productView, model);
    }

    @RequestMapping(value = "viewSource.do")
    public ModelAndView viewSource(HttpServletRequest request) throws Exception{

        ModelMap model = getProductModel(request);

        return new ModelAndView(PalConst.getInstance().sourceView, model);
    }



    private ModelMap getProductModel(HttpServletRequest request){

        ModelMap model = new ModelMap();

        String productId = request.getParameter(PalConst.getInstance().productId);
        LinkedHashMap<String, Object> queryLabParaMap = new LinkedHashMap<>();
        queryLabParaMap.put(PalConst.getInstance().productId, productId);

        Product product = (Product)baseManager.getUniqueObjectByConditions(PalConst.getInstance().viewProduct, queryLabParaMap);
        model.addAttribute(PalConst.getInstance().resultProduct, product);

        return model;
    }

    private Label getLabel(HttpServletRequest request){

        //查label是否存在
        String serial = request.getParameter(PalConst.getInstance().checkLabelParam1);
        LinkedHashMap<String, Object> qryLabParaMap = new LinkedHashMap<>();
        qryLabParaMap.put(PalConst.getInstance().checkLabelParam1, serial);
        return (Label)baseManager.getUniqueObjectByConditions(PalConst.getInstance().checkLabel, qryLabParaMap);
    }
}
