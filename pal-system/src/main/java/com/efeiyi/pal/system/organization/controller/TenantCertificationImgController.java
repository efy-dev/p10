package com.efeiyi.pal.system.organization.controller;

import com.efeiyi.pal.organization.model.TenantCertification;
import com.efeiyi.pal.organization.model.TenantCertificationImg;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.p.service.AliOssUploadManager;
import com.ming800.core.util.ApplicationContextUtil;
import org.apache.commons.lang.RandomStringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

/**
 * Created by Administrator on 2015/8/24.
 * 认证图片 Controller
 */

@RestController
@RequestMapping("/certificationImg")
public class TenantCertificationImgController {

    private BaseManager baseManager = (BaseManager) ApplicationContextUtil.getApplicationContext().getBean("baseManagerImpl");
    private AliOssUploadManager aliOssUploadManager = (AliOssUploadManager) ApplicationContextUtil.getApplicationContext().getBean("aliOssUploadManagerImpl");

    @RequestMapping("/saveCertificationImg.do")
    public String saveCertificationImg(HttpServletRequest request, MultipartRequest multipartRequest) throws Exception{

        TenantCertificationImg certificationImg = new TenantCertificationImg();

        String certificationId = request.getParameter("certificationId");
        if (certificationId == null || certificationId.trim().equals("")){
            throw new Exception("class com.efeiyi.pal.system.organization.controller.TenantCertificationImgController saveCertificationImg method: certificationId is null !");
        }
        TenantCertification tenantCertification = (TenantCertification)baseManager.getObject(TenantCertification.class.getName(), certificationId);
        certificationImg.setTenantCertification(tenantCertification);
        certificationImg.setStatus("1");

        Map<String,MultipartFile> fileMap = multipartRequest.getFileMap();
        // String ctxPath = request.getSession().getServletContext().getRealPath("/")+ File.separator+"uploadFiles";
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
        String url = "" ;
        for (Map.Entry<String,MultipartFile> entry : fileMap.entrySet()){
            //上传文件
            String identify = sdf.format(new Date());
            url = "tenantCertification/" + RandomStringUtils.randomNumeric(10) + identify + ".jpg";
            MultipartFile mf = entry.getValue();
            aliOssUploadManager.uploadFile(mf, "315pal", url);
            certificationImg.setImgUrl(url);
            baseManager.saveOrUpdate(TenantCertificationImg.class.getName(), certificationImg);

        }
        System.out.print(url);
        return url;
    }

    @RequestMapping("/removeCertificationImg.do")
    public ModelAndView removeCertificationImg(HttpServletRequest request) throws Exception{
        String certificationId = request.getParameter("certificationId");
        String ImgId = request.getParameter("ImgId");
        if (certificationId == null || certificationId.trim().equals("")){
            throw new Exception("class com.efeiyi.pal.system.organization.controller.TenantCertificationImgController removeCertificationImg method: certificationId is null !");
        }
        if (ImgId == null || ImgId.trim().equals("")){
            throw new Exception("class com.efeiyi.pal.system.organization.controller.TenantCertificationImgController removeCertificationImg method: ImgId is null !");
        }
        TenantCertification tenantCertification = (TenantCertification)baseManager.getObject(TenantCertification.class.getName(), certificationId);
        TenantCertificationImg certificationImg = (TenantCertificationImg) baseManager.getObject(TenantCertificationImg.class.getName(), ImgId);
        certificationImg.setStatus("0");
        baseManager.saveOrUpdate(TenantCertificationImg.class.getName(), certificationImg);

        String resultPage = "redirect:/basic/xm.do?qm=viewTenantCertification&id=" + tenantCertification.getId();

        return new ModelAndView(resultPage);
    }

    private TenantCertificationImg upLoadImg(MultipartRequest multipartRequest, TenantCertificationImg certificationImg) throws Exception{
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
        String identify = sdf.format(new Date());
        String url = "tenantCertification/" + identify + ".jpg";

        if (!multipartRequest.getFile("Img").getOriginalFilename().equals("")) {
            aliOssUploadManager.uploadFile(multipartRequest.getFile("Img"), "315pal", url);
            certificationImg.setImgUrl(url);
        }

        return certificationImg;
    }

}
