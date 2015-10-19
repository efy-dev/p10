package com.efeiyi.controller;

import com.efeiyi.util.MsgService;
import com.efeiyi.util.PalConst;
import com.efeiyi.service.ILabelCheckManager;
import com.efeiyi.util.WebServiceClient;
import com.ming800.core.util.JsonUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import com.efeiyi.pal.label.model.Label;


import javax.servlet.http.HttpServletRequest;
import java.util.Map;

/**
 * Created by Administrator on 2015/7/27.
 * 验证防伪码的真伪֤controller
 */
@Controller
public class LabelCheckController {

    @Autowired
    @Qualifier("labelCheckManagerImpl")
    private ILabelCheckManager iLabelCheckService;


    @RequestMapping(value = "/checkLabelNfc.do")
    public ModelAndView checkLabelNfc(HttpServletRequest request) throws Exception {
        ModelMap model = new ModelMap();
        String code = request.getParameter(PalConst.getInstance().checkLabelParam2);
        Label label = iLabelCheckService.getUniqueLabel(code);

        // label不存在
        if (label == null) {
            model.addAttribute(PalConst.getInstance().resultLabel, PalConst.getInstance().fakeBean);
        }
        //label存在
        else {
//            String ip = request.getRemoteHost();
            String ip = null;

            model.addAttribute(PalConst.getInstance().ip, ip);

            String chk = request.getParameter("chk");
            Integer apoid = Integer.parseInt(request.getParameter("apoid"));

            MsgService service = (MsgService) WebServiceClient.getFactory().create();
            String json = (String) service.chkVerify(chk, apoid, ip);
            Map map = JsonUtil.parseJsonStringToMap(json);
            if (map == null || !(Boolean)map.get("verifyResult")) {
                model.addAttribute(PalConst.getInstance().resultLabel, PalConst.getInstance().fakeBean);
            } else {
                iLabelCheckService.updateRecord(model, label);
//                model.addAttribute(PalConst.getInstance().resultLabel, PalConst.getInstance().trueBean);
            }
        }
        return new ModelAndView(PalConst.getInstance().resultView, model);

    }

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
                iLabelCheckService.updateRecord(model, label, true);
            } else {
                System.out.println("已扫二维码");
                iLabelCheckService.updateRecord(model, label, false);
            }
            model.addAttribute(PalConst.getInstance().code, code);
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

    @RequestMapping(value = "/aboutUs.do")
    public ModelAndView aboutUs(ModelMap model, HttpServletRequest request) throws Exception {
        return new ModelAndView(PalConst.getInstance().aboutUsView, model);
    }

    @RequestMapping(value = "/userManual.do")
    public ModelAndView userManual(ModelMap model, HttpServletRequest request) throws Exception {
        return new ModelAndView(PalConst.getInstance().userManualView, model);
    }

}
