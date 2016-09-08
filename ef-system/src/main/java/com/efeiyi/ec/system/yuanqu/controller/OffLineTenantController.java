package com.efeiyi.ec.system.yuanqu.controller;

import com.efeiyi.ec.organization.model.Image;
import com.efeiyi.ec.tenant.model.BigTenant;
import com.efeiyi.ec.tenant.model.EnterpriseTenant;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.p.PConst;
import com.ming800.core.p.service.AliOssUploadManager;
import net.sf.json.JSON;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;
import java.util.Iterator;

/**
 * Created by Administrator on 2016/9/6 0006.
 */
@Controller
@RequestMapping({"/yuanqu"})
public class OffLineTenantController {

    @Autowired
    private BaseManager baseManager;

    @Autowired
    private AliOssUploadManager aliOssUploadManager;

    @RequestMapping({"/tenantForm"})
    public String tenantForm() {
        return "/yuanqu/tenantForm";
    }

    @RequestMapping({"/baseSubmit"})
    @ResponseBody
    public Object baseSubmit(HttpServletRequest request, HttpServletResponse response, MultipartRequest multipartRequest) throws Exception {
        EnterpriseTenant tenant = new EnterpriseTenant();
        tenant.setName(request.getParameter("name"));
        tenant.setAddress(request.getParameter("address"));
        tenant.setLatitude(Double.parseDouble(request.getParameter("latitude")));
        tenant.setLongitude(Double.parseDouble(request.getParameter("longitude")));
        tenant.setContent(request.getParameter("content"));
        tenant.setTenantType(BigTenant.TENANT_TYPE_OFFLINE);
        tenant.setStatus("1");
        tenant.setCreateDateTime(new Date());
        baseManager.saveOrUpdate(EnterpriseTenant.class.getName(), tenant);
        Iterator<String> fileNames = multipartRequest.getFileNames();
        while (fileNames.hasNext()) {
            String filename = fileNames.next();
            MultipartFile multipartFile = multipartRequest.getFile(filename);
            String oName = multipartFile.getOriginalFilename();
            String nName = System.currentTimeMillis() + "" + (int) (Math.random() * 1000000) + "." + oName.split("\\.")[1];
            String url = "image/" + nName;
            aliOssUploadManager.uploadFile(multipartFile, "ef-wiki", url);
            String fullUrl = PConst.OSS_EF_WIKI_HOST + url;
            if (filename.equals("pictureUrl")) {
                tenant.setPictureUrl(fullUrl);
            } else if (filename.equals("logoUrl")) {
                tenant.setLogoUrl(fullUrl);
            }
            Image image = new Image();
            image.setName(filename);
            image.setCreateTime(new Date());
            image.setOwner(tenant.getId());
            image.setSrc(fullUrl);
            image.setStatus("1");
            if (multipartFile.getContentType().contains("audio")) {
                image.setType("2");
            } else {
                image.setType("1");
            }
            baseManager.saveOrUpdate(Image.class.getName(), image);
        }
        return tenant;
    }

    @RequestMapping({"/getTenantById"})
    @ResponseBody
    public Object getTenantById(HttpServletRequest request) {
        String id = request.getParameter("id");
        return baseManager.getObject(EnterpriseTenant.class.getName(), id);
    }

}
