package com.efeiyi.ec.system.couponBatch.controller;

import com.efeiyi.ec.organization.model.Consumer;
import com.efeiyi.ec.product.model.Product;
import com.efeiyi.ec.purchase.model.Coupon;
import com.efeiyi.ec.purchase.model.CouponBatch;
import com.efeiyi.ec.system.product.model.ProductDateModel;
import com.efeiyi.ec.system.util.ExportExcel;
import com.efeiyi.ec.tenant.model.BigTenant;
import com.efeiyi.ec.tenant.model.Tenant;
import com.efeiyi.ec.tenant.model.TenantProject;
import com.ming800.core.base.controller.BaseController;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.p.service.AutoSerialManager;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Random;

@Controller
@RequestMapping("/couponBatch")
public class CouponBatchController extends BaseController {

    @Autowired
    private BaseManager baseManager;
    @Autowired
    private AutoSerialManager autoSerialManager;

    @RequestMapping("/createCoupon.do")
    @ResponseBody
    public String createCoupon(String id, int amount) throws Exception {
        Coupon coupon = null;
        CouponBatch couponBatch = (CouponBatch) super.baseManager.getObject("com.efeiyi.ec.purchase.model.CouponBatch", id);
        List<Coupon> couponList = couponBatch.getCouponList();
        int createdCouponAmount = 0;
        if(null != couponList && couponList.size()>0){
            createdCouponAmount = couponList.size();
        }
        for (int i = 0; i < amount-createdCouponAmount; i++) {
            coupon = new Coupon();
            coupon.setStatus("1");
            coupon.setCouponBatch(couponBatch);
            String serial = autoSerialManager.nextSerial("systemAutoSerial");
            coupon.setSerial(serial);
            coupon.setWhetherBind("1");


            StringBuffer randomValidateCode = new StringBuffer();
            for(int j = 0;j <8;j++){
                Random random = new Random();
                randomValidateCode.append(random.nextInt(10));
            }

            coupon.setUniqueKey(randomValidateCode+serial);
            baseManager.saveOrUpdate(Coupon.class.getName(), coupon);
        }

        couponBatch.setIsCreatedCoupon(2);
        baseManager.saveOrUpdate(CouponBatch.class.getName(), couponBatch);
        return id;
    }

    @RequestMapping("/saveAndCreateCoupon.do")
    public String saveAndCreateCoupon(HttpServletRequest request) throws Exception {

        CouponBatch couponBatch = new CouponBatch();
        couponBatch.setName(request.getParameter("name"));
        couponBatch.setAmount(Integer.parseInt(request.getParameter("amount")));
        couponBatch.setPrice(Float.parseFloat(request.getParameter("price")));
        couponBatch.setPriceLimit(Float.parseFloat(request.getParameter("priceLimit")));
        couponBatch.setStatus("1");

        SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd");
        try {
            couponBatch.setStartDate(sd.parse(request.getParameter("startDate")));
            couponBatch.setEndDate(sd.parse(request.getParameter("endDate")));
        } catch (ParseException e) {
            e.printStackTrace();
        }

        couponBatch.setIsCreatedCoupon(2);

        baseManager.saveOrUpdate(CouponBatch.class.getName(), couponBatch);

        Coupon coupon = null;
        for (int i = 0; i < couponBatch.getAmount(); i++) {
            coupon = new Coupon();
            coupon.setStatus("1");
            coupon.setCouponBatch(couponBatch);
//            String serial = RandomStringUtils.randomNumeric(10);
            String serial = autoSerialManager.nextSerial("systemAutoSerial");
            coupon.setSerial(serial);
            baseManager.saveOrUpdate(Coupon.class.getName(), coupon);
        }
        return "redirect:/basic/xm.do?qm=plistCouponBatch_default&view=Batch";
    }

    @RequestMapping("/getAllProjectCategory.do")
    @ResponseBody
    public List<Object> getAllProjectCategory(Model model, HttpServletRequest request) throws Exception {
        XQuery xQuery = new XQuery("listProjectCategory_default", request);
        List<Object> list = baseManager.listObject(xQuery);
        return list;
    }

    @RequestMapping("/getAllProject.do")
    @ResponseBody
    public List<Object> getAllProject(Model model, HttpServletRequest request) throws Exception {
        String id = request.getParameter("projectCategory_id");
        XQuery xQuery = new XQuery("listProject_default", request);
        xQuery.put("projectCategory_id", id);
        List<Object> list = baseManager.listObject(xQuery);
        return list;
    }

    @RequestMapping("/getTenantByProject.do")
    @ResponseBody
    public List<BigTenant> getTenantByProject(Model model, HttpServletRequest request) throws Exception {
        String id = request.getParameter("project_id");
        XQuery xQuery = new XQuery("listTenantProject_default3", request);
        xQuery.put("project_id", id);
        List<Object> list = baseManager.listObject(xQuery);

        List<BigTenant> tList = new ArrayList<>();
        TenantProject tenantProject = null;
        for (int i = 0; i < list.size(); i++) {
            tenantProject = (TenantProject) list.get(i);
            tList.add(tenantProject.getTenant());
        }

        return tList;
    }

    @RequestMapping("/getProductByProject.do")
    @ResponseBody
    public List<ProductDateModel> getProductByProject(Model model, HttpServletRequest request) throws Exception {
        String id = request.getParameter("project_id");
        XQuery xQuery = new XQuery("listProduct_default1", request);
        xQuery.put("project_id", id);
        List<Product> list = baseManager.listObject(xQuery);
        List<ProductDateModel> list2 = new ArrayList<ProductDateModel>();
        for (Product product : list) {
            ProductDateModel productDateModel = new ProductDateModel();
            productDateModel.setId(product.getId());
            productDateModel.setName(product.getName());
            list2.add(productDateModel);
        }
        return list2;
    }

    @RequestMapping("/setDefaultFlag.do")
    @ResponseBody
    public int setDefaultFlag(HttpServletRequest request) throws Exception {
        String couponBatchId = request.getParameter("id");
        String ftext = request.getParameter("ftext");

        CouponBatch couponBatch = (CouponBatch) baseManager.getObject(CouponBatch.class.getName(), couponBatchId);

        int flag;
        if ("设置新注册送券".equals(ftext)) {
            couponBatch.setDefaultFlag("1");
            baseManager.saveOrUpdate(CouponBatch.class.getName(), couponBatch);
            flag = 1;
        } else {
            couponBatch.setDefaultFlag("2");
            baseManager.saveOrUpdate(CouponBatch.class.getName(), couponBatch);
            flag = 2;
        }
        return flag;
    }


    @RequestMapping("/sendCoupon.do")
    @ResponseBody
    public String sendCoupon(HttpServletRequest request) throws Exception {
        String username = request.getParameter("username");
        String startBindDate = request.getParameter("startBindDate");
        String endBindDate = request.getParameter("endBindDate");
        String couponBatchId = request.getParameter("couponBatchId");

        CouponBatch couponBatch = (CouponBatch) baseManager.getObject(CouponBatch.class.getName(), couponBatchId);
        List<Coupon> list = couponBatch.getCouponList();

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        String hql = "from Consumer c where c.status<>0 ";
        LinkedHashMap<String, Object> hm = new LinkedHashMap<>();
        if (!"".equals(username)) {
            hql += " and c.username=:username ";
            hm.put("username", username);
        }
        if (!"".equals(startBindDate)) {
            hql += " and c.createDatetime>=:startBindDate ";
            hm.put("startBindDate", sdf.parse(startBindDate));
        }
        if (!"".equals(endBindDate)) {
            hql += " and c.createDatetime<=:endBindDate ";
            hm.put("endBindDate", sdf.parse(endBindDate));
        }

        List<Consumer> consumersList = baseManager.listObject(hql, hm);

        int availableCoupon = 0;
        for (Coupon coupon : list) {//优惠券可用数量比要发放优惠券的用户少
            if ("1".equals(coupon.getWhetherBind())) {
                availableCoupon++;
            }
        }
        if (consumersList.size() > availableCoupon) {
            return "Less";
        } else {
            for (int i = 0; i < consumersList.size(); i++) {
                Consumer tempConsumer = consumersList.get(i);
                Coupon tempCoupon = null;
                for (int j = 0; j < list.size(); j++) {
                    tempCoupon = list.get(j);
                    if ("2".equals(tempCoupon.getWhetherBind())) {
                        continue;
                    } else {
                        tempCoupon.setConsumer(tempConsumer);
                        tempCoupon.setWhetherBind("2");
                        baseManager.saveOrUpdate(Coupon.class.getName(), tempCoupon);
                        break;
                    }
                }
            }
            return consumersList.size() + "";
        }
    }

    @RequestMapping("/searchUserNum.do")
    @ResponseBody
    public int searchUserNum(HttpServletRequest request) throws Exception {
        String username = request.getParameter("username");
        String startBindDate = request.getParameter("startBindDate");
        String endBindDate = request.getParameter("endBindDate");

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        String hql = "from Consumer c where c.status<>0 ";
        LinkedHashMap<String, Object> hm = new LinkedHashMap<>();
        if (!"".equals(username)) {
            hql += " and c.username=:username ";
            hm.put("username", username);
        }
        if (!"".equals(startBindDate)) {
            hql += " and c.createDatetime>=:startBindDate ";
            hm.put("startBindDate", sdf.parse(startBindDate));
        }
        if (!"".equals(endBindDate)) {
            hql += " and c.createDatetime<=:endBindDate ";
            hm.put("endBindDate", sdf.parse(endBindDate));
        }

        List<Consumer> consumersList = baseManager.listObject(hql, hm);

        return consumersList.size();
    }

    @RequestMapping("/removeCouponBatch.do")
    @ResponseBody
    public String removeCouponBatch(HttpServletRequest request) throws Exception {
        String couponBatchId = request.getParameter("id");

        CouponBatch couponBatch = (CouponBatch) baseManager.getObject(CouponBatch.class.getName(), couponBatchId);

        couponBatch.setStatus("0");
        baseManager.saveOrUpdate(CouponBatch.class.getName(),couponBatch);
        List<Coupon> list = couponBatch.getCouponList();
        for(Coupon coupon : list){
            coupon.setStatus("0");
            baseManager.saveOrUpdate(Coupon.class.getName(),coupon);
        }
        return couponBatchId;
    }


    @RequestMapping("/download.do")
    @ResponseBody
    public ResponseEntity<byte[]> download(HttpServletRequest request) throws Exception {
        String couponBatchId = request.getParameter("id");

        CouponBatch couponBatch = (CouponBatch) baseManager.getObject(CouponBatch.class.getName(), couponBatchId);

        String fileName = couponBatch.getName();

        ExportExcel exportExcel = new ExportExcel();
        List<Coupon> couponList = couponBatch.getCouponList();
        List<String> uniqueKeyList = new ArrayList<>();
        for(Coupon coupon : couponList){
            uniqueKeyList.add(coupon.getUniqueKey());
        }

        String[] title = {"兑换码"};

        String path = this.getClass().getResource("/").getPath().toString() + "com/efeiyi/ec/system/download";
        File downloadFile = new File(path);

        if(!downloadFile.exists()){
            downloadFile.mkdir();
        }
        String resultFileName = exportExcel.exportExcel(path, fileName, title, uniqueKeyList);
        HttpHeaders headers = new HttpHeaders();

        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
        File file = new File(path+"/"+resultFileName);
        headers.setContentDispositionFormData("attachment", new String(resultFileName.getBytes("UTF-8"),"iso-8859-1"));
        byte[] bytes = FileUtils.readFileToByteArray(file);
        return new ResponseEntity<byte[]>(bytes,headers, HttpStatus.OK);
    }

}
