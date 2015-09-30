package com.efeiyi.association.controller;

import com.efeiyi.association.OrganizationConst;
import com.efeiyi.ec.association.model.ApplicationMaterial;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.p.model.Document;
import com.ming800.core.p.model.DocumentAttachment;
import com.ming800.core.p.service.AliOssUploadManager;
import com.ming800.core.p.service.DocumentManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.Date;

/**
 * Created by Administrator on 2015/9/29.
 */
@Controller
@RequestMapping("/attachment")
public class AttachmentController {

    @Autowired
    private BaseManager baseManager;


    @Autowired
    private DocumentManager documentManager;


    @Autowired
    @Qualifier("aliOssUploadManagerImpl")
    private AliOssUploadManager aliOssUploadManager;

    @RequestMapping("/attachmentUpload.do")
    @ResponseBody
    public ModelAndView saveAttachment(@RequestParam("file") MultipartFile multipartFile, HttpServletRequest request, HttpServletResponse response, ApplicationMaterial material) throws Exception {
        String url = "attachment/" + multipartFile.getOriginalFilename();
        if (!multipartFile.getOriginalFilename().equals("")) {
            aliOssUploadManager.uploadFile(multipartFile, "association", url);
            url = OrganizationConst.imgBasePath + url;
        }
            //新建内容传入原页面地址
        String group = request.getParameter("group");
        material.setGroup(group);
        material.setDocumentContent(null);
        material.setTheDatetime(new Date());
        material.setStatus("1");
        material.setPublishDate(new Date());

        DocumentAttachment attachment = new DocumentAttachment();
        attachment.setDocument(material);
        attachment.setPath(url);
        if (material.getDocumentAttachmentList() == null) {
            material.setDocumentAttachmentList(new ArrayList<DocumentAttachment>());
        }
        documentManager.saveDocument(material);
        if (!multipartFile.getOriginalFilename().equals("")) {
            material.getDocumentAttachmentList().add(attachment);
            baseManager.saveOrUpdate(attachment.getClass().getName(), attachment);
        }

        String path = request.getParameter("qm");
        return new ModelAndView("redirect:" /*+ request.getContextPath()*/ + path);
    }
}
