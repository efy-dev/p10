package com.efeiyi.ec.system.product.controller;

import com.efeiyi.ec.product.model.Subject;
import com.efeiyi.ec.product.model.SubjectDescription;
import com.efeiyi.ec.product.model.SubjectPicture;
import com.efeiyi.ec.wiki.model.Artistry;
import com.efeiyi.ec.wiki.model.ArtistryDescription;
import com.efeiyi.ec.wiki.model.ArtistryPicture;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.p.service.AliOssUploadManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

/**
 * Created by Administrator on 2016/5/9 0009.
 */
@Controller
public class SubjectController {

    @Autowired
    private BaseManager baseManager;

    @Autowired
    private AliOssUploadManager aliOssUploadManager;

    //礼品专题富文本
    @RequestMapping({"/giftSubject/update.do"})
    public String giftUpdateSubject(HttpServletRequest request, MultipartRequest multipartRequest) throws Exception {
        Subject subject = (Subject) baseManager.getObject(Subject.class.getName(), request.getParameter("subjectId"));
        //得到上传的图片文件并且上传到aliyun 并且保存ProjectPictrue对象
        CommonsMultipartFile multipartFile = (CommonsMultipartFile) multipartRequest.getFile("pictureUrl");
        if (multipartFile.getFileItem().getSize() > 0) {
            String url = "subject/" + multipartFile.getOriginalFilename();
            boolean result = aliOssUploadManager.uploadFile(multipartFile, "ef-gift", url);
            if (result) {
                SubjectPicture subjectPicture = new SubjectPicture();
                subjectPicture.setPictureUrl(url);
                subjectPicture.setSubject(subject);
                subject.setPictureUrl(url);
                baseManager.saveOrUpdate(SubjectPicture.class.getName(), subjectPicture);
                baseManager.saveOrUpdate(Subject.class.getName(), subject);
            }
        }
        return "redirect:/basic/xm.do?qm=plistGiftSubject_default"; //返回列表页面
    }

//    //上传礼品专题图片文件
//    @RequestMapping({"/giftSubject/img.do"})
//    @ResponseBody
//    public String giftUploadSubjectImage(HttpServletRequest request) {
//        String data = "";
//        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
//        Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();
//        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
//        String identify = sdf.format(new Date());
//        String url;
//        for (Map.Entry<String, MultipartFile> entry : fileMap.entrySet()) {
//            MultipartFile mf = entry.getValue();
//            String fileName = mf.getOriginalFilename();//获取原文件名
//            String hz = fileName.substring(fileName.indexOf("."), fileName.length());
//            url = "giftSubject/content/" + fileName.substring(0, fileName.indexOf(hz)) + identify + hz;
//
//            try {
//                aliOssUploadManager.uploadFile(mf, "ef-gift", url);
//                data = "{\"success\":\"" + true + "\",\"file_path\":\"gift-oss.efeiyi.com/" + url + "\"}";
//            } catch (Exception e) {
//                e.printStackTrace();
//            }
//        }
//
//        return data;
//    }

}

