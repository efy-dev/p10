package com.efeiyi.ec.system.zero.company.controller;

import com.efeiyi.ec.purchase.model.PurchaseOrderProduct;
import com.efeiyi.ec.system.zero.company.util.BatchLogisticsReactor;
import com.ming800.core.base.service.XdoManager;
import com.ming800.core.does.model.Do;
import com.ming800.core.does.model.DoQuery;
import com.ming800.core.does.service.DoManager;
import com.ming800.core.util.ApplicationContextUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * Created by Administrator on 2015/12/11.
 */
@Controller
@RequestMapping("/batch")
public class BatchLogisticsController {

    @Autowired
    private DoManager doManager;
    @Autowired
    private XdoManager xdoManager;

    @RequestMapping("/deppon.do")
    public ModelAndView submit2Deppon(HttpServletRequest request, ModelMap modelMap) throws Exception {

        String qm = request.getParameter("qm");
        request.setAttribute("qm", qm);
        String conditions = request.getParameter("conditions");

        Do tempDo = doManager.getDoByQueryModel(qm.split("_")[0]);
        DoQuery tempDoQuery = tempDo.getDoQueryByName(qm.split("_")[1]);
        List<PurchaseOrderProduct> list = (List<PurchaseOrderProduct>) xdoManager.list(tempDo, tempDoQuery, conditions);
        if(BatchLogisticsReactor.runningFlag.compareAndSet(BatchLogisticsReactor.idle, BatchLogisticsReactor.busy)){
            new Thread(new BatchLogisticsReactor(list, ApplicationContextUtil.getApplicationContext())).start();
        }
        modelMap.put("objectList", list);

        String resultPage = request.getParameter("result");
        return new ModelAndView(resultPage, modelMap);
    }

    @RequestMapping("/test.do")
    public void test(HttpServletRequest request, HttpServletResponse response) {

        String companyCode = request.getParameter("companyCode");
        System.out.println(companyCode);
//        baseManager.getObject("com.efeiyi.ec.zero.virtual.model.VirtualPlan",)
    }

}
