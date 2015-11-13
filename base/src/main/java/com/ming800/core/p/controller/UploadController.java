package com.ming800.core.p.controller;

import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.p.model.Banner;
import com.ming800.core.p.service.AliOssUploadManager;
import com.ming800.core.p.service.BannerManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * Created by kayson_yang on 2015/7/13.
 *
 */

@Controller
@RequestMapping("/UploadDOC")
public class UploadController {
    private static Logger logger = Logger.getLogger(UploadController.class);
    @Autowired
    private AliOssUploadManager aliOssUploadManager;

    @Autowired
    private BannerManager bannerManager;

    @RequestMapping("/UploadDocument.do")
    @ResponseBody
    public String UploadDocument(HttpServletRequest request){
        String url = "";
        try{
            MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
            Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();
            // String ctxPath = request.getSession().getServletContext().getRealPath("/")+ File.separator+"uploadFiles";
            SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
            String identify = sdf.format(new Date());

            for (Map.Entry<String, MultipartFile> entry : fileMap.entrySet()) {

                //上传文件
                MultipartFile mf = entry.getValue();
                String fileName = mf.getOriginalFilename();//获取原文件名
                Integer index = 0;
                String hz = fileName.substring(fileName.indexOf("."), fileName.length());
                String imgName = fileName.substring(0, fileName.indexOf(hz));
                url = "attachment/" + fileName.substring(0, fileName.indexOf(hz)) + identify + hz;
                aliOssUploadManager.uploadFile(mf, "tenant", url);
            }
        }catch (Exception e){

            e.printStackTrace();
        }
        return  "http://tenant.efeiyi.com/"+url;
    }
}
