package com.efeiyi.controller;

import com.efeiyi.PalConst;
import com.efeiyi.pal.product.model.Product;
import com.efeiyi.service.ILabelCheckManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
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
public class LabelCheckController {

    @Autowired
    @Qualifier("labelCheckManagerImpl")
    private ILabelCheckManager iLabelCheckService;

//    //判断请求来源pc或wap的标记
//    private boolean pcMark = false;


    @RequestMapping(value = "/checkLabel.do")
    public ModelAndView checkLabelWap(HttpServletRequest request) throws Exception {

        ModelMap model = new ModelMap();
        String serial = request.getParameter(PalConst.getInstance().checkLabelParam1);
        Label label = iLabelCheckService.getUniqueLabel(serial);
        Boolean pcMark = request.getAttribute("pcMark") == null ? false : true;

        //label不存在
        if (label == null) {
            model.addAttribute(PalConst.getInstance().resultLabel, PalConst.getInstance().fakeBean);
        }
        //label存在
        else {
            model.addAttribute(PalConst.getInstance().ip, request.getRemoteHost());
            //判断请求来自pc
//            System.out.println("是否来自微信点击：" + !pcMark);
            if (pcMark ) {
                iLabelCheckService.updateRecord(model, label,true);
            }else{
                iLabelCheckService.updateRecord(model, label,false);
            }
        }
        return new ModelAndView(PalConst.getInstance().resultView, model);
    }


    @RequestMapping(value = "/checkLabelPc.do")
    public ModelAndView checkLabelPc(HttpServletRequest request) throws Exception {
        request.setAttribute("pcMark","");
        return checkLabelWap(request);
    }

    @RequestMapping(value = "/viewCertificate.do")
    public ModelAndView viewCertificate(HttpServletRequest request) throws Exception {

        ModelMap model = getProductModel(request);

        return new ModelAndView(PalConst.getInstance().certificateView, model);
    }

    @RequestMapping(value = "/viewProduct.do")
    public ModelAndView viewProduct(HttpServletRequest request) throws Exception {

        ModelMap model = getProductModel(request);

        return new ModelAndView(PalConst.getInstance().productView, model);
    }

    @RequestMapping(value = "/viewSource.do")
    public ModelAndView viewSource(HttpServletRequest request) throws Exception {

        ModelMap model = getProductModel(request);

        return new ModelAndView(PalConst.getInstance().sourceView, model);
    }


    private ModelMap getProductModel(HttpServletRequest request) {

        ModelMap model = new ModelMap();

        String productId = request.getParameter(PalConst.getInstance().productId);
        LinkedHashMap<String, Object> queryLabParaMap = new LinkedHashMap<>();
        queryLabParaMap.put(PalConst.getInstance().productId, productId);

        Product product = iLabelCheckService.getUniqueProduct(productId);
        model.addAttribute(PalConst.getInstance().resultProduct, product);
        return model;
    }

}
