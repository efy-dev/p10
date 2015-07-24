package com.efeiyi.ec.system.tenant.controller;

import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.p.service.AliOssUploadManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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
public class TenantController {


    @Autowired
    private AliOssUploadManager aliOssUploadManager;

    @Autowired
    private BaseManager baseManager;

    @RequestMapping({"/tenant/list/json"})
    @ResponseBody
    public List<Object> test(HttpServletRequest request) throws Exception {
        XQuery xQuery = new XQuery("listTenant_default", request);
        List<Object> list = this.baseManager.listObject(xQuery);
        return list;
    }


    @RequestMapping({"/tenantNews/pictureUpload.do"})
    @ResponseBody
    public String uploadTenantNewsPicture(MultipartRequest multipartRequest, HttpServletRequest request) throws Exception {

        MultipartFile multipartFile = multipartRequest.getFile("newsPicture");
        String url = "news/" + multipartFile.getOriginalFilename();
        boolean result = aliOssUploadManager.uploadFile(multipartFile, "tenant", url);

        String resultStr = "";

        if (result) {
            resultStr = "http://tenant.efeiyi.com/" + url;
        }

        return resultStr;

    }


    @RequestMapping({"/tenantNews/tagList.do"})
    @ResponseBody
    public List<Object> listTenantNewsTag(HttpServletRequest request) throws Exception {

        XQuery xQuery = new XQuery("listWordValue_default", request);

        List<Object> objectList = baseManager.listObject(xQuery);

        return objectList;

    }


    @RequestMapping({"/tenantIntroduction/imageUpload.do"})
    public String uploadIntroductionImage(HttpServletRequest request, MultipartRequest multipartRequest) throws Exception {
        String type = request.getParameter("type");
        MultipartFile multipartFile = multipartRequest.getFile("newsPicture");
        String url = "introduction/" + type + "/" + multipartFile.getOriginalFilename();
        aliOssUploadManager.uploadFile(multipartFile, "tenant", url);
        return "redirect:/basic/xm.do?qm=formTenantIntroduction&tenantId="+request.getParameter("tenant.id");
    }

    //可用图片列表
    @RequestMapping({"/tenantIntroduction/imageList.do"})
    @ResponseBody
    public List<String> getUsefulImage(HttpServletRequest request){
        String type = request.getParameter("type");
        String path = "introduction/"+type+"/";
        return aliOssUploadManager.listObjectByPath("tenant",path);
    }

}
