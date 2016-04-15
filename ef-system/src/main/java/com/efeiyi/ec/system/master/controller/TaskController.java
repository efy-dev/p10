package com.efeiyi.ec.system.master.controller;


import com.ming800.core.base.controller.BaseController;
import com.ming800.core.base.service.BaseManager;

import com.ming800.core.p.service.AliOssUploadManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.*;


/**
 * Created by Administrator on 2015/6/18.
 */
@Controller
@RequestMapping("/task")
public class TaskController extends BaseController {
    @Autowired
    private BaseManager baseManager;
    @Autowired
    private AliOssUploadManager aliOssUploadManager;

    @RequestMapping("/img.do")
    @ResponseBody
    public String img(HttpServletRequest request){
        System.out.print("ok");
        String data = "";

        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
        Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
        String identify = sdf.format(new Date());
        String url = "";
        String fname = "";
        for (Map.Entry<String, MultipartFile> entry : fileMap.entrySet()) {

            //上传文件
            MultipartFile mf = entry.getValue();
            String fileName = mf.getOriginalFilename();//获取原文件名
            if(fileName.indexOf(".")==-1){
                url = "Work/jietu"+identify+".jpg";
            }else {
                String hz = fileName.substring(fileName.indexOf("."), fileName.length());
                String imgName = fileName.substring(0, fileName.indexOf(hz));
                url = "Work/" + fileName.substring(0, fileName.indexOf(hz)) + identify + hz;
            }

            try {

                if(request.getParameter("project").equals("craft")){
                    aliOssUploadManager.uploadFile(mf, "ef-wiki", url);
                    data = "{\"success\":\"" + true + "\",\"file_path\":\"wiki-oss.efeiyi.com/" +url + "\"}";
                }else {
                    aliOssUploadManager.uploadFile(mf, "tenant", url);
                    data = "{\"success\":\"" + true + "\",\"file_path\":\"http://tenant.efeiyi.com/" +url + "\"}";
                }


            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return  data;
    }


}
