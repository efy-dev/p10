package com.efeiyi.pal.system.organization.controller;

import com.efeiyi.pal.organization.model.Tenant;
import com.efeiyi.pal.organization.model.TenantSource;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.p.service.AliOssUploadManager;
import com.ming800.core.util.ApplicationContextUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartRequest;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by Administrator on 2015/8/6.
 */

@Controller
@RequestMapping("/tenantSource")
public class TenantSourceController {

    @Autowired
    private BaseManager baseManager;

    private AliOssUploadManager aliOssUploadManager = (AliOssUploadManager) ApplicationContextUtil.getApplicationContext().getBean("aliOssUploadManagerImpl");

    @RequestMapping("/newTenantSource.do")
    public ModelAndView newTenantSource(ModelMap modelMap, HttpServletRequest request) throws Exception{
        String tenantId = request.getParameter("tenantId");
        if (tenantId == null || tenantId.trim().equals("")) {
            throw new Exception("商户id不能为空!");
        }
        Tenant tenant = (Tenant) baseManager.getObject(Tenant.class.getName(), tenantId);

        modelMap.put("tenant", tenant);
        String resultPage = "/tenantSource/tenantSourceForm";
        return new ModelAndView(resultPage);
    }

    @RequestMapping("/saveTenantSource.do")
    public ModelAndView saveTenantSource(ModelMap modelMap, MultipartRequest multipartRequest, HttpServletRequest request) throws Exception {
        TenantSource tenantSource = new TenantSource();

        String tenantSourceId = request.getParameter("id");
        String type = "new";
        if (tenantSourceId != null && !tenantSourceId.equals("")) {
            type = "edit";
            tenantSource = (TenantSource) baseManager.getObject(TenantSource.class.getName(), tenantSourceId);
        }

        tenantSource = setTenantSourceBaseProperty(tenantSource, request);
        tenantSource = getRelationAttributeObject(tenantSource, request);
        tenantSource = upLoadImg(multipartRequest, tenantSource);

        baseManager.saveOrUpdate(tenantSource.getClass().getName(), tenantSource);

        String resultPage = "redirect:/basic/xm.do?qm=viewTenant&id="+tenantSource.getTenant().getId();
        return new ModelAndView(resultPage);
    }

    @RequestMapping("/removeTenantSource.do")
    public ModelAndView removeTenantSource(ModelMap modelMap, HttpServletRequest request) throws Exception{
        String tenantSourceId = request.getParameter("tenantSourceId");
        if (tenantSourceId == null || tenantSourceId.trim().equals("")) {
            throw new Exception("溯源信息id不能为空!");
        }
        TenantSource tenantSource = (TenantSource) baseManager.getObject(TenantSource.class.getName(), tenantSourceId);
        tenantSource.setStatus("0");
        baseManager.saveOrUpdate(tenantSource.getClass().getName(), tenantSource);

        String resultPage = "redirect:/basic/xm.do?qm=viewTenant&id="+tenantSource.getTenant().getId();
        return new ModelAndView(resultPage);
    }

    /**
     * 获取tenantSource的Form表单基本数据
     * @param tenantSource
     * @param request
     * @return
     */
    private TenantSource setTenantSourceBaseProperty(TenantSource tenantSource, HttpServletRequest request) {
        String name = request.getParameter("name");
        String region = request.getParameter("region");
        String status = request.getParameter("status");

        tenantSource.setName(name);
        tenantSource.setRegion(region);
        tenantSource.setStatus(status);

        return tenantSource;
    }

    /**
     * 获取关联属性的对象
     * @param tenantSource
     * @param request
     * @return
     */
    private TenantSource getRelationAttributeObject(TenantSource tenantSource, HttpServletRequest request){
        String tenantId = request.getParameter("tenant.id");
        Tenant tenant = (Tenant) baseManager.getObject(Tenant.class.getName(), tenantId);
        tenantSource.setTenant(tenant);

        return tenantSource;
    }

    /**
     * 上传溯源图片
     * @param multipartRequest
     * @param tenantSource
     * @return
     * @throws Exception
     */
    private TenantSource upLoadImg(MultipartRequest multipartRequest, TenantSource tenantSource) throws Exception{
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
        String identify = sdf.format(new Date());
        String url = "tenantSource/" + identify + ".jpg";

        if (!multipartRequest.getFile("img").getOriginalFilename().equals("")) {
//            aliOssUploadManager.uploadFile(multipartRequest.getFile("logo"), "315pal", "product/logo/" + multipartRequest.getFile("logo").getOriginalFilename());
//            product.setImgUrl("product/logo/" + multipartRequest.getFile("logo").getOriginalFilename());
            aliOssUploadManager.uploadFile(multipartRequest.getFile("img"), "315pal", url);
            tenantSource.setImgUrl(url);
        }

        return tenantSource;
    }

}
