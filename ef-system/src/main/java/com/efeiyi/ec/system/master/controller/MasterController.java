package com.efeiyi.ec.system.master.controller;

import com.efeiyi.ec.master.model.*;
import com.efeiyi.ec.product.model.Product;
import com.efeiyi.ec.product.model.ProductPicture;
import com.efeiyi.ec.project.model.ProjectTag;
import com.efeiyi.ec.system.master.dao.MasterDao;
import com.efeiyi.ec.system.master.service.MasterManager;
import com.efeiyi.ec.system.master.service.MasterWorkManager;
import com.efeiyi.ec.tenant.model.BigTenant;
import com.efeiyi.ec.tenant.model.Tenant;
import com.efeiyi.ec.tenant.model.TenantMaster;
import com.efeiyi.ec.tenant.model.TenantReview;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.p.service.AliOssUploadManager;
import com.ming800.core.p.service.AutoSerialManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartRequest;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2015/7/20.
 */
@Controller
public class MasterController {


    @Autowired
    private AliOssUploadManager aliOssUploadManager;

    @Autowired
    private BaseManager baseManager;

    @Autowired
    private MasterDao masterDao;

    @Autowired
    private MasterManager masterManager;
    @Autowired
    private MasterWorkManager masterWorkManager;


    @RequestMapping({"/master/list/json"})
    @ResponseBody
    public List<Object> test(HttpServletRequest request) throws Exception {
        XQuery xQuery = new XQuery("listMaster_default", request);
        List<Object> list = this.baseManager.listObject(xQuery);
        return list;
    }


    @RequestMapping({"/masterNews/pictureUpload.do"})
    @ResponseBody
    public String uploadMasterNewsPicture(MultipartRequest multipartRequest) throws Exception {

        MultipartFile multipartFile = multipartRequest.getFile("newsPicture");
        String url = "news/" + multipartFile.getOriginalFilename();
        boolean result = aliOssUploadManager.uploadFile(multipartFile, "tenant", url);

        String resultStr = "";

        if (result) {
            resultStr = "http://tenant.efeiyi.com/" + url;
        }

        return resultStr;

    }


    @RequestMapping({"/masterNews/tagList.do"})
    @ResponseBody
    public List<Object> listMasterNewsTag(HttpServletRequest request) throws Exception {

        XQuery xQuery = new XQuery("listWordValue_default", request);

        List<Object> objectList = baseManager.listObject(xQuery);

        return objectList;

    }


    @RequestMapping({"/masterIntroduction/imageUpload.do"})
    public String uploadIntroductionImage(HttpServletRequest request, MultipartRequest multipartRequest) throws Exception {
        String type = request.getParameter("type");
        MultipartFile multipartFile = multipartRequest.getFile("newsPicture");
        String url = "introduction/" + type + "/" + multipartFile.getOriginalFilename();
        aliOssUploadManager.uploadFile(multipartFile, "tenant", url);
        return "redirect:/basic/xm.do?qm=formMasterIntroduction&masterId="+request.getParameter("master.id");
    }

    //可用图片列表
    @RequestMapping({"/masterIntroduction/imageList.do"})
    @ResponseBody
    public List<String> getUsefulImage(HttpServletRequest request){
        String type = request.getParameter("type");
        String path = "introduction/"+type+"/";
        return aliOssUploadManager.listObjectByPath("tenant",path);
    }

    @RequestMapping("/master/toTenantMaster.do")
    public String toTenantMaster(Model model,String tenantId){
        List<Master> masterList = null;
        try {
          masterList = masterDao.getMasterList(tenantId);
        }catch (Exception e){
            e.printStackTrace();
        }
        model.addAttribute("objectList",masterList);
        model.addAttribute("tenantId",tenantId);
        return "/tenantMaster/masterList";
    }

    @RequestMapping("/master//linkTenant.do")
    @ResponseBody
    public String linkTenant(String tenantId,String masterId,String tenantMasterId,String status){
        String id = "";
        try {

            id = masterManager.linkTenant(tenantId,masterId,tenantMasterId,status);
        }catch (Exception e){

        }
        return  id;
    }

    @RequestMapping("/master/removeMaster.do")
    @ResponseBody
    public String removeMaster(String id){

        try {

            id = masterManager.removeMaster(id);
        }catch (Exception e){

        }
        return  id;
    }


    @RequestMapping("/master/addWork.do")
    public String addWork(String name, HttpServletRequest request, ModelMap modelMap){
        try {
            if(!StringUtils.isEmpty(name)) {
                XQuery xQuery = new XQuery("listMasterTemp_default", request);
                xQuery.put("name", name);
                List<Master> masterList = baseManager.listObject(xQuery);
                if (masterList != null) {
                    modelMap.put("id", masterList.get(0).getId());
                    xQuery = new XQuery("listMasterBanner_default", request);
                    xQuery.put("master_id", masterList.get(0).getId());
                    modelMap.put("masterBannerList", baseManager.listObject(xQuery));
                    modelMap.put("name", name);
                    return "/masterWork";
                }
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return  "/errorMasterWork";
    }

    @RequestMapping("/master/uploadify.do")
    @ResponseBody
    public String uploadProductImg(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String data = "";
        Master master = null;
        if(!StringUtils.isEmpty(request.getParameter("id"))) {
            master = (Master)baseManager.getObject(Master.class.getName(),request.getParameter("id"));
        }
        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
        Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
        String identify = sdf.format(new Date());
        String url = "";
        Integer sort = 0;
        for (Map.Entry<String, MultipartFile> entry : fileMap.entrySet()) {
            //上传文件
            MultipartFile mf = entry.getValue();
            String fileName = mf.getOriginalFilename();//获取原文件名
            Integer index = 0;
            String hz = fileName.substring(fileName.indexOf("."),fileName.length());
            String imgName = fileName.substring(0, fileName.indexOf(hz));
            url = "banner/" + fileName.substring(0, fileName.indexOf(hz)) + identify + hz;
            MasterBanner masterBanner = new MasterBanner();
                try {
                    masterBanner.setImageUrl(url);
                    masterBanner.setMaster(master);
                    masterBanner.setStatus("1");
                    masterBanner.setGroup("tenant");
                    masterBanner.setTitle(imgName);
                    aliOssUploadManager.uploadFile(mf, "tenant", url);
                    baseManager.saveOrUpdate(MasterBanner.class.getName(),masterBanner);

                    data = masterBanner.getId() + ":" + url + ":" + imgName+hz+":"+sort;
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }

        System.out.print(url);
        return data;


    }

    @RequestMapping("/master/removeMasterBannerPicture.do")
    @ResponseBody
    public boolean removeMasterBannerPicture(String id){

        try {
            baseManager.remove(MasterBanner.class.getName(),id);
            return  true;
        }catch (Exception e){
            e.printStackTrace();

            return false;
        }

    }

    @RequestMapping("/master/saveMasterWork.do")
    public String saveMasterWork(HttpServletRequest request,MultipartRequest multipartRequest,ModelMap modelMap){
        modelMap.put("result","false");
        modelMap.put("name",request.getParameter("name"));
        try {
            if(masterWorkManager.saveMasterWork(request,multipartRequest))
                modelMap.put("result","true");

        }catch (Exception e){
            e.printStackTrace();


        }
        return  "/masterWorkSaveSuccess";

    }


    /**
     * 大师审核
     * @param masterReview
     * @param masterId
     * @return
     */
    @RequestMapping("/master/toSubmitReview.do")
    @ResponseBody
    public String toSubmitReview(MasterReview masterReview, String masterId){
        try {
            Master master = (Master) baseManager.getObject(Master.class.getName(),masterId);
            masterReview.setCreateDateTime(new Date());
            masterReview.setMaster(master);
            baseManager.saveOrUpdate(MasterReview.class.getName(),masterReview);
            master.setReview(masterReview.getReview());
            baseManager.saveOrUpdate(Master.class.getName(),master);

        }catch (Exception e){
            e.printStackTrace();
        }
        return  masterReview.getReview();
    }


    @RequestMapping("/master/masterReviewList.do")
    public String masterReviewList(HttpServletRequest request,ModelMap modelMap){

        try {
            XQuery xQuery = new XQuery("",request);
            xQuery.put("master_id",request.getParameter("masterId"));
             modelMap.put("objectList",(List<MasterReview>)baseManager.listObject(xQuery));

        }catch (Exception e){
            e.printStackTrace();


        }
        return  "/masterReview/masterReviewList";

    }

}
