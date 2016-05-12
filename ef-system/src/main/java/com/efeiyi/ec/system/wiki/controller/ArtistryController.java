package com.efeiyi.ec.system.wiki.controller;

import com.alibaba.fastjson.JSONObject;
import com.efeiyi.ec.project.model.Project;
import com.efeiyi.ec.wiki.model.Artistry;
import com.efeiyi.ec.wiki.model.ArtistryDescription;
import com.efeiyi.ec.wiki.model.ArtistryPicture;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.p.service.AliOssUploadManager;
import org.apache.tools.ant.taskdefs.condition.Http;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import javax.smartcardio.ATR;
import java.text.SimpleDateFormat;
import java.util.Map;


/**
 * Created by Administrator on 2016/4/18.
 */
@Controller
public class ArtistryController {
    @Autowired
    protected BaseManager baseManager;

    @Autowired
    private AliOssUploadManager aliOssUploadManager;

    @RequestMapping("/saveUpdateWiki.do")
    public String saveAndUpdateWiki(Project project, HttpServletRequest request) {

        System.out.println("12");

        return null;
    }


    //提交富文本修改的接口
    @RequestMapping({"/artistryDescription/saveOrUpdate.do"})
    public String saveOrUpdatePCArtistryDescription(HttpServletRequest request) {
        String content = request.getParameter("descriptionPC");
        String contentWap = request.getParameter("descriptionWap");
        String objectId = request.getParameter("objectId");
        String callbackUrl = request.getParameter("callbackUrl");
        String artistryId = request.getParameter("artistryId");
        Artistry artistry = (Artistry) baseManager.getObject(Artistry.class.getName(), artistryId);
        ArtistryDescription artistryDescription;
        if (objectId != null && !objectId.equals("")) {
            artistryDescription = (ArtistryDescription) baseManager.getObject(ArtistryDescription.class.getName(), objectId);
            if (content != null) {
                artistryDescription.setDescriptionPC(content);
            }
            if (contentWap != null) {
                artistryDescription.setDescriptionWap(contentWap);
            }
            baseManager.saveOrUpdate(ArtistryDescription.class.getName(), artistryDescription);
        } else {
            artistryDescription = new ArtistryDescription();
            artistryDescription.setDescriptionPC(content);
            baseManager.saveOrUpdate(ArtistryDescription.class.getName(), artistryDescription);
        }
        artistry.setArtistryDescription(artistryDescription);
        baseManager.saveOrUpdate(Artistry.class.getName(), artistry);
        return "redirect:" + callbackUrl;
    }


    //上传图图片的接口 (单图片上传接口)
    @RequestMapping({"/artistryDescription/image/upload.do"})
    @ResponseBody
    public ResponseEntity uploadDescriptionImage(HttpServletRequest request) {
        String artistryId = request.getParameter("artistryId");
        Artistry artistry = (Artistry) baseManager.getObject(Artistry.class.getName(), artistryId);
        ArtistryPicture artistryPicture = new ArtistryPicture();
        artistryPicture.setArtistry(artistry);
        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
        Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();
        String url;
        Map.Entry<String, MultipartFile> entry = fileMap.entrySet().iterator().next();
        MultipartFile mf = entry.getValue();
        String fileName = mf.getOriginalFilename();//获取原文件名
        url = "artistry/content/" + fileName;
        artistryPicture.setPictureUrl(url);
        artistryPicture.setStatus("1");
        artistryPicture.setSort(1);
        baseManager.saveOrUpdate(ArtistryPicture.class.getName(), artistryPicture);
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
