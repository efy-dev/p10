package com.efeiyi.ec.system.zero.company.controller;

import com.efeiyi.ec.purchase.model.PurchaseOrderProduct;
import com.efeiyi.ec.system.zero.company.service.BatchPrintManager;
import com.efeiyi.ec.system.zero.company.service.CompanyOrderBatchServiceManager;
import com.efeiyi.ec.system.zero.company.util.BatchLogisticsReactor;
import com.efeiyi.ec.system.zero.company.util.BatchPrintReactor;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.base.service.XdoManager;
import com.ming800.core.does.model.Do;
import com.ming800.core.does.model.DoQuery;
import com.ming800.core.does.service.DoManager;
import com.ming800.core.util.ApplicationContextUtil;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.util.ArrayList;
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
    @Autowired
    private BaseManager baseManager;
    @Autowired
    private BatchPrintManager batchPrintManager;

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

    @RequestMapping("/deppon2.do")
    public ModelAndView submit2Deppon2(HttpServletRequest request, ModelMap modelMap) throws Exception {

        String idList = request.getParameter("idList");
        List<PurchaseOrderProduct> list = getPOPList(idList);

        if(BatchLogisticsReactor.runningFlag.compareAndSet(BatchLogisticsReactor.idle, BatchLogisticsReactor.busy)){
            new Thread(new BatchLogisticsReactor(list, ApplicationContextUtil.getApplicationContext())).start();
        }

        return new ModelAndView("redirect:/basic/xm.do?qm=plistBatchGift_default");
    }

    @RequestMapping("/test.do")
    public void test(HttpServletRequest request, HttpServletResponse response) {

        String companyCode = request.getParameter("companyCode");
        System.out.println(companyCode);
//        baseManager.getObject("com.efeiyi.ec.zero.virtual.model.VirtualPlan",)
    }

    private List getPOPList(String idList){
        List<PurchaseOrderProduct> popList = new ArrayList<>();
        String[] ids = idList.split(",");
        for (String id: ids){
            PurchaseOrderProduct pop = (PurchaseOrderProduct) baseManager.getObject(PurchaseOrderProduct.class.getName(), id);
            if (pop == null){
                continue;
            }
            popList.add(pop);
        }
        return popList;
    }

    @Deprecated
    @RequestMapping("/batchPrint.do")
    public ModelAndView printWaybill(HttpServletRequest request,ModelMap modelMap) throws Exception{
        String qm = request.getParameter("qm");
        request.setAttribute("qm", qm);
        String conditions = request.getParameter("conditions");

        Do tempDo = doManager.getDoByQueryModel(qm.split("_")[0]);
        DoQuery tempDoQuery = tempDo.getDoQueryByName(qm.split("_")[1]);
        List<PurchaseOrderProduct> list = (List<PurchaseOrderProduct>) xdoManager.list(tempDo, tempDoQuery, conditions);
        if(BatchPrintReactor.runningFlag.compareAndSet(BatchPrintReactor.idle, BatchPrintReactor.busy)){
            new Thread(new BatchPrintReactor(list)).start();
        }
        modelMap.put("objectList", list);

        String resultPage = request.getParameter("result");
        return new ModelAndView(resultPage, modelMap);
    }

    @Deprecated
    @RequestMapping("/batchPrint2.do")
    public ModelAndView printWaybill2(HttpServletRequest request) throws Exception {

        String idList = request.getParameter("idList");
        List<PurchaseOrderProduct> list = getPOPList(idList);

        if(BatchPrintReactor.runningFlag.compareAndSet(BatchPrintReactor.idle, BatchPrintReactor.busy)){
            new Thread(new BatchPrintReactor(list)).start();
        }

        return new ModelAndView("redirect:/basic/xm.do?qm=plistGiftBatchPrint_default");
    }

    @RequestMapping("/batchPrint3.do")
    public ResponseEntity<byte[]> downLoadWayBill(HttpServletRequest request) throws Exception{

        String qm = request.getParameter("qm");
        request.setAttribute("qm", qm);
        String conditions = request.getParameter("conditions");

        Do tempDo = doManager.getDoByQueryModel(qm.split("_")[0]);
        DoQuery tempDoQuery = tempDo.getDoQueryByName(qm.split("_")[1]);
        List<PurchaseOrderProduct> list = (List<PurchaseOrderProduct>) xdoManager.list(tempDo, tempDoQuery, conditions);

        File downloadFile = batchPrintManager.downloadFiles(list);

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
        headers.setContentDispositionFormData("attachment", downloadFile.getName());
        byte[] bytes = FileUtils.readFileToByteArray(downloadFile);

        return new ResponseEntity<byte[]>(bytes,headers, HttpStatus.OK);
    }

    @RequestMapping("/batchPrint4.do")
    public ResponseEntity<byte[]> downLoadWayBill2(HttpServletRequest request) throws Exception {

        String idList = request.getParameter("idList");
        List<PurchaseOrderProduct> list = getPOPList(idList);
        File downloadFile = batchPrintManager.downloadFiles(list);

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
        headers.setContentDispositionFormData("attachment", downloadFile.getName());
        byte[] bytes = FileUtils.readFileToByteArray(downloadFile);

        return new ResponseEntity<byte[]>(bytes,headers, HttpStatus.OK);
    }
}
