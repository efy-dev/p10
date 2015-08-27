package com.efeiyi.controller;

import com.efeiyi.util.PalConst;
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


    @RequestMapping(value = "/checkLabel.do")
    public ModelAndView checkLabelWap(HttpServletRequest request) throws Exception {

        ModelMap model = new ModelMap();
        String code = request.getParameter(PalConst.getInstance().checkLabelParam1);
        Label label = iLabelCheckService.getUniqueLabel(code);

        // label不存在
        if (label == null) {
            model.addAttribute(PalConst.getInstance().resultLabel, PalConst.getInstance().fakeBean);
        }
        //label存在
        else {
            model.addAttribute(PalConst.getInstance().ip, request.getRemoteHost());

            //请求来自pc
            if (PalConst.getInstance().labelCache.remove(code) == null) {
                System.out.println("未扫二维码");
                iLabelCheckService.updateRecord(model, label,true);
            }else{
                System.out.println("已扫二维码");
                iLabelCheckService.updateRecord(model, label,false);
            }
            model.addAttribute(PalConst.getInstance().code,code);
        }
        return new ModelAndView(PalConst.getInstance().resultView, model);
    }


    @RequestMapping(value = "/checkLabelPc.do")
    public ModelAndView checkLabelPc(HttpServletRequest request) throws Exception {
//        request.setAttribute("pcMark","");
        return checkLabelWap(request);
    }

    @RequestMapping(value = "/viewCertificate.do")
    public ModelAndView viewCertificate(HttpServletRequest request) throws Exception {

        ModelMap model = iLabelCheckService.getProductModel(request);

        return new ModelAndView(PalConst.getInstance().certificateView, model);
    }

    @RequestMapping(value = "/viewProduct.do")
    public ModelAndView viewProduct(HttpServletRequest request) throws Exception {

        ModelMap model = iLabelCheckService.getProductModel(request);

        return new ModelAndView(PalConst.getInstance().productView, model);
    }

    @RequestMapping(value = "/viewSource.do")
    public ModelAndView viewSource(HttpServletRequest request) throws Exception {

        ModelMap model = iLabelCheckService.getProductModel(request);

        return new ModelAndView(PalConst.getInstance().sourceView, model);
    }


}
