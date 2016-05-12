package com.efeiyi.ec.system.basic.controller;

import com.alibaba.fastjson.JSONObject;
import com.efeiyi.ec.system.basic.model.UEditor;
import com.efeiyi.ec.wiki.model.Artistry;
import com.efeiyi.ec.wiki.model.ArtistryPicture;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.base.util.ReflectUtil;
import com.ming800.core.p.service.AliOssUploadManager;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.Map;

/**
 * Created by Administrator on 2016/5/10 0010.
 */
@Controller
public class EditorController {

    @Autowired
    private BaseManager baseManager;

    @Autowired
    private AliOssUploadManager aliOssUploadManager;

    @RequestMapping({"/ueditor/config.do"})
    @ResponseBody
    public ResponseEntity<byte[]> ueditorConfig(HttpServletRequest request) throws IOException {
        String realPath = request.getServletContext().getRealPath("/");
        String filePath = realPath + "/scripts/utf8-jsp/jsp/config.json";
        System.out.println(realPath);
        File file = new File(filePath);
        HttpHeaders headers = new HttpHeaders();
        String fileName = "config.json";
        headers.setContentDispositionFormData("attachment", fileName);
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
        return new ResponseEntity<>(FileUtils.readFileToByteArray(file),
                headers, HttpStatus.OK);
    }

    @RequestMapping({"/ueditor/use.do"})
    public String useUeditor(UEditor uEditor, HttpServletRequest request, Model model) throws Exception {
        if (uEditor.getObjectId() != null && !uEditor.getObjectId().equals("")) {
            Object object = baseManager.getObject(uEditor.getObjectClassType(), uEditor.getObjectId());
            String textContent = (String) ReflectUtil.invokeGetterMethod(object, uEditor.getName());
            model.addAttribute("textContent", textContent);
        }
        model.addAttribute("uEditor", uEditor);
        return "/ueditor";
    }

    //上传图图片的接口 (单图片上传接口)
    @RequestMapping({"/ueditor/image/upload.do"})
    @ResponseBody
    public ResponseEntity uploadDescriptionImage(HttpServletRequest request) {
        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
        Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();
        String url;
        Map.Entry<String, MultipartFile> entry = fileMap.entrySet().iterator().next();
        MultipartFile mf = entry.getValue();
        String fileName = mf.getOriginalFilename();//获取原文件名
        url = "common/content/" + fileName;
        try {
            aliOssUploadManager.uploadFile(mf, "ef-wiki", url);
        } catch (Exception e) {
            e.printStackTrace();
        }
        String imgPath = "wiki-oss.efeiyi.com/" + url;
        String result = "{\"original\":\"" + fileName + "\",\"name\":\"" + fileName + "\",\"url\":\"" + imgPath + "\",\"size\":\"" + mf.getSize() + "\",\"type\":\"" + mf.getContentType() + "\",\"state\":\"SUCCESS\"}";
        JSONObject jsonObject = JSONObject.parseObject(result);
        return new ResponseEntity(jsonObject, HttpStatus.OK);
    }


}

