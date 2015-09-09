package com.efeiyi.ec.system.master.controller;

import com.efeiyi.ec.master.model.Master;
import com.efeiyi.ec.master.model.MasterProject;
import com.efeiyi.ec.product.model.Product;
import com.efeiyi.ec.system.master.dao.MasterDao;
import com.efeiyi.ec.tenant.model.Tenant;
import com.efeiyi.ec.tenant.model.TenantMaster;
import com.efeiyi.ec.tenant.model.TenantProject;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.p.service.AliOssUploadManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

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

    @RequestMapping({"/master/list/json"})
    @ResponseBody
    public List<Object> test(HttpServletRequest request) throws Exception {
        XQuery xQuery = new XQuery("listMaster_default", request);
        List<Object> list = this.baseManager.listObject(xQuery);
        return list;
    }


    @RequestMapping({"/masterNews/pictureUpload.do"})
    @ResponseBody
    public String uploadMasterNewsPicture(MultipartRequest multipartRequest, HttpServletRequest request) throws Exception {

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
    public String linkTenant(HttpServletRequest request, String tenantId,String masterId,String tenantMasterId,String status){
        TenantMaster tenantMaster = null;
        try {
            tenantMaster = (TenantMaster)baseManager.getObject(TenantMaster.class.getName(),tenantMasterId);
            if(tenantMaster == null){
                tenantMaster = new TenantMaster();
                tenantMaster.setTenant((Tenant)baseManager.getObject(Tenant.class.getName(),tenantId));
                tenantMaster.setMaster((Master)baseManager.getObject(Master.class.getName(),masterId));
                tenantMaster.setStatus("1");
            }else {
                if("0".equals(status)){
                    tenantMaster.setStatus("1");
                }
                if("1".equals(status)){
                    tenantMaster.setStatus("0");
                }
            }
            baseManager.saveOrUpdate(TenantMaster.class.getName(),tenantMaster);
            XQuery xQuery = new XQuery("listMasterProject_default",request);
            xQuery.put("master_id",masterId);
            List<MasterProject> masterProjectList = baseManager.listObject(xQuery);
            Tenant tenant = (Tenant)baseManager.getObject(Tenant.class.getName(),tenantId);
            if(masterProjectList!=null){
                for (MasterProject masterProject :masterProjectList){
                    TenantProject tenantProject = null;
                       xQuery = new XQuery("listTenantProject_default2",request);
                    xQuery.put("tenant_id",tenantId);
                    xQuery.put("project_id",masterProject.getProject().getId());
                    List<TenantProject> mp = baseManager.listObject(xQuery);
                    if(mp.size()!=0){
                        tenantProject = mp.get(0);
                        if("0".equals(status)) {
                            tenantProject.setStatus("1");
                        }
                        if("1".equals(status)) {
                            tenantProject.setStatus("0");
                        }
                    }else{
                        if("0".equals(status)) {
                            tenantProject = new TenantProject();
                            tenantProject.setStatus("1");
                            tenantProject.setProject(masterProject.getProject());
                            tenantProject.setTenant(tenant);
                        }
                    }
                    baseManager.saveOrUpdate(TenantProject.class.getName(),tenantProject);
                }
            }



        }catch (Exception e){
            e.printStackTrace();
        }
        return  tenantMaster.getId();
    }

}
