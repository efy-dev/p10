package com.efeiyi.ec.system.organization.controller;

import com.efeiyi.ec.master.model.Master;
import com.efeiyi.ec.organization.model.Permission;
import com.efeiyi.ec.organization.model.Role;
import com.efeiyi.ec.system.organization.service.TenantManager;
import com.efeiyi.ec.system.organization.util.AuthorizationUtil;
import com.efeiyi.ec.tenant.model.*;
import com.ming800.core.base.controller.BaseController;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.Module;
import com.ming800.core.does.service.ModuleManager;
import com.ming800.core.p.service.AliOssUploadManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by IntelliJ IDEA.
 * User: ming
 * Date: 12-10-15
 * Time: 下午4:56
 * To change this template use File | Settings | File Templates.
 */

@Controller
@RequestMapping("/tenant")
public class TenantController extends BaseController {

    @Autowired
    private TenantManager tenantManager;

    @Autowired
    private AliOssUploadManager aliOssUploadManager;

    @RequestMapping("/viewTenant.do")
    public String viewTenant(Model model){
        BigTenant tenant = (BigTenant) AuthorizationUtil.getMyUser().getBigTenant();

        return "redirect:/basic/xm.do?qm=viewTenant&id="+tenant.getId();
    }

    @RequestMapping("/linkMaster.do")
    @ResponseBody
    public String linkMaster(String tenantId,String masterId,String tenantMasterId,String status){
        String id = "";
        try {

            id = tenantManager.linkMaster(tenantId,masterId,tenantMasterId,status);
        }catch (Exception e){

        }
        return  id;
    }

    @RequestMapping("/linkProject.do")
    @ResponseBody
    public String linkProject(String tenantId,String projectId,String tenantProjectId,String status){
        String id = "";
        try {

            id =  tenantManager.linkProject(tenantId,projectId,tenantProjectId,status);
        }catch (Exception e){
            e.printStackTrace();
        }
        return  id;
    }


    @RequestMapping("/linkProduct.do")
    @ResponseBody
    public String linkProduct(String tenantCategoryId,String productId,String tenantProductId,String status){
        String id = "";
        try {

            id =  tenantManager.linkProduct(tenantCategoryId,productId,tenantProductId,status);
        }catch (Exception e){
            e.printStackTrace();
        }
        return  id;
    }


    @RequestMapping("/viewTenant1.do")
    public String viewTenant1(Model model){
        BigTenant tenant = (BigTenant) AuthorizationUtil.getMyUser().getBigTenant();

        return "redirect:/basic/xm.do?qm=viewTenant1&id="+tenant.getId();
    }


    @RequestMapping("/uploadify.do")
    @ResponseBody
    public String uploadProductImg(HttpServletRequest request,String dataType) throws Exception{
        String data = "";

        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
        Map<String,MultipartFile> fileMap = multipartRequest.getFileMap();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
        String identify = sdf.format(new Date());
        String url = "" ;
        for (Map.Entry<String,MultipartFile> entry : fileMap.entrySet()){
            //上传文件

            MultipartFile mf = entry.getValue();
            String fileName = mf.getOriginalFilename();//获取原文件名
            url = "tenant/"+identify+fileName;

            try {
                aliOssUploadManager.uploadFile(mf, "ec-efeiyi", url);
                data = url;
            }catch (Exception e){
                e.printStackTrace();
            }
        }
        System.out.print(url);
        return data;


    }


    @RequestMapping("/toCheck.do")
    public String toCheck(Model model,String tenantType,String id,String flag,
                          EnterpriseTenant enterpriseTenant,
                          PrivateTenant privateTenant,
                          PersonalTenant personalTenant){

        if("11".equals(tenantType)){
            enterpriseTenant.setReview(flag);
            baseManager.saveOrUpdate(EnterpriseTenant.class.getName(),enterpriseTenant);
        }
        if("12".equals(tenantType)){
            privateTenant.setReview(flag);
         baseManager.saveOrUpdate(PrivateTenant.class.getName(),privateTenant);
        }
        if("13".equals(tenantType)){
            personalTenant.setReview(flag);
            baseManager.saveOrUpdate(PersonalTenant.class.getName(),personalTenant);
        }

        return "redirect:/basic/xm.do?qm=viewTenant1&id="+id;
    }

}
