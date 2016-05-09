package com.efeiyi.ec.system.basic.controller;

import com.alibaba.fastjson.JSONObject;
import com.ming800.core.p.service.AliOssUploadManager;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

/**
 * Created by Administrator on 2015/7/13.
 */
@Controller
public class ManageController {

    @Autowired
    private AliOssUploadManager aliOssUploadManager;

    @RequestMapping({"main.do"})
    public String main() {
        return "/main";
    }


    @RequestMapping({"ueditor.do"})
    public String ueditor() {
        return "/ueditor";
    }


    @RequestMapping({"/ueditorConfig.do"})
    @ResponseBody
    public ResponseEntity ueditorConfig(HttpServletRequest request) throws IOException {
        String action = request.getParameter("action");
        if (action.equals("config")) {
            String realPath = request.getServletContext().getRealPath("/");
            String filePath = realPath + "/scripts/utf8-jsp/jsp/config.json";
            System.out.println(realPath);
            File file = new File(filePath);
            HttpHeaders headers = new HttpHeaders();
            String fileName = "config.json";//为了解决中文名称乱码问题
            headers.setContentDispositionFormData("attachment", fileName);
            headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
            return new ResponseEntity<>(FileUtils.readFileToByteArray(file),
                    headers, HttpStatus.OK);
        } else if (action.equals("img.do")) {
            String data = "";
            String testValue = request.getParameter("test");
            System.out.println(testValue);
            MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
            Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
            String url;
            Map.Entry<String, MultipartFile> entry = fileMap.entrySet().iterator().next();
//            for (Map.Entry<String, MultipartFile> entry : fileMap.entrySet()) {
            //上传文件
            MultipartFile mf = entry.getValue();
            String fileName = mf.getOriginalFilename();//获取原文件名
            url = "test/" + fileName;
            try {
                aliOssUploadManager.uploadFile(mf, "ef-wiki", url);
            } catch (Exception e) {
                e.printStackTrace();
            }
            String result = "{\"original\":\""+fileName+"\",\"name\":\""+fileName+"\",\"url\":\"/"+url+"\",\"size\":\""+mf.getSize()+"\",\"type\":\""+mf.getContentType()+"\",\"state\":\"SUCCESS\"}";
            String result2 = "/" + url;
            JSONObject jsonObject = JSONObject.parseObject(result);
//            }
            return new ResponseEntity(jsonObject, HttpStatus.OK);
        }
        return null;
    }

    @RequestMapping("/img.do")
    @ResponseBody
    public String img(HttpServletRequest request) {
        String data = "";
        String testValue = request.getParameter("test");
        System.out.println(testValue);
        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
        Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
        String url;
        for (Map.Entry<String, MultipartFile> entry : fileMap.entrySet()) {
            //上传文件
            MultipartFile mf = entry.getValue();
            String fileName = mf.getOriginalFilename();//获取原文件名
            url = "test/" + fileName;
            try {
                aliOssUploadManager.uploadFile(mf, "ef-wiki", url);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return data;
    }


    @RequestMapping({"/config"})
    @ResponseBody
    public ResponseEntity<byte[]> download(HttpServletRequest request) throws IOException {
        String realPath = request.getServletContext().getRealPath("/");
        String filePath = realPath + "/scripts/utf8-jsp/jsp/config.json";
        System.out.println(realPath);
        File file = new File(filePath);
        HttpHeaders headers = new HttpHeaders();
        String fileName = "config.json";//为了解决中文名称乱码问题
        headers.setContentDispositionFormData("attachment", fileName);
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
        return new ResponseEntity<>(FileUtils.readFileToByteArray(file),
                headers, HttpStatus.OK);
    }

}
