package com.efeiyi.association.controller;

import com.efeiyi.association.OrganizationConst;
import com.efeiyi.association.model.ApplicationMaterial;
import com.efeiyi.ec.App;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.base.service.XdoManager;
import com.ming800.core.base.service.XdoSupportManager;
import com.ming800.core.does.model.Do;
import com.ming800.core.does.model.DoQuery;
import com.ming800.core.does.model.PageInfo;
import com.ming800.core.does.service.DoManager;
import com.ming800.core.p.model.Document;
import com.ming800.core.p.model.DocumentAttachment;
import com.ming800.core.p.service.AliOssUploadManager;
import com.ming800.core.p.service.AutoSerialManager;
import com.ming800.core.p.service.DocumentManager;
import com.ming800.core.taglib.PageEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by Administrator on 2015/9/18.
 */
@Controller
@RequestMapping("/myAttachment")
public class MyDocumentAttachmentController {

    @Autowired
    private BaseManager baseManager;

    @Autowired
    @Qualifier("autoSerialManager")
    private AutoSerialManager autoSerialManager;

    @Autowired
    private DocumentManager documentManager;

    @Autowired
    private XdoManager xdoManager;

    @Autowired
    private XdoSupportManager xdoSupportManager;

    @Autowired
    private DoManager doManager;

    @Autowired
    @Qualifier("aliOssUploadManagerImpl")
    private AliOssUploadManager aliOssUploadManager;

    @RequestMapping("/attachment.do")
    public List<Document> getAttachByGroupId(ModelMap modelMap, HttpServletRequest request) throws Exception {
        String qm = request.getParameter("qm");
//        XQuery  xQuery = new XQuery(qm,request);
//        List<Document> docs = baseManager.listObject(xQuery);

//        String conditions = request.getParameter("conditions");
//        request.setAttribute("conditions", conditions);
        if (qm.split("_").length < 2) {
            throw new Exception("qm:" + qm + "的具体查询部分没有定义即'_'的后半部分没有定义");
        }
        //先找到配置文件里的entity
        Do tempDo = doManager.getDoByQueryModel(qm.split("_")[0]);
        //再从中找到query的信息
        DoQuery tempDoQuery = tempDo.getDoQueryByName(qm.split("_")[1]);
//        modelMap.put("tempDo", tempDo);
//        modelMap.put("doQueryList", tempDo.getDoQueryList());
//        String resultPage = tempDo.getResult();

        PageEntity pageEntity = new PageEntity();
        String pageIndex = request.getParameter("pageEntity.index");
        String pageSize = request.getParameter("pageEntity.size");
        if (pageIndex != null) {
            pageEntity.setIndex(Integer.parseInt(pageIndex));
            pageEntity.setSize(Integer.parseInt(pageSize));
        }

        modelMap.put("tabTitle", tempDoQuery.getLabel());
//                resultPage = "/pc/choiceness";
        PageInfo pageInfo = xdoManager.listPage(tempDo, tempDoQuery, null, pageEntity);
        modelMap.put("pageInfo", pageInfo);
        modelMap.put("pageEntity", pageInfo.getPageEntity());

//                返回列表
//        Map map = request.getParameterMap();
//        xdoSupportManager.generateTempPageConditions(request.getRequestURI(), map, pageEntity.getIndex() + "", pageEntity.getSize() + "");
        // xdoSupportManager.generateTempPageConditions(request.getRequestURI(), map, 1 + "", 20 + "");


        if (tempDo.getExecute() != null && !tempDo.getExecute().equals("")) {
            modelMap = xdoSupportManager.execute(tempDo, modelMap, request);
        }
        modelMap.put("qm", qm);
        modelMap.put("group", tempDo.getData());
        return pageInfo.getList();
//        return docs;
        //return new ModelAndView("/",model);
    }

    @RequestMapping("/saveAttachment.do")
    @ResponseBody
    public ModelAndView saveAttachment(@RequestParam("file") MultipartFile multipartFile, HttpServletRequest request, HttpServletResponse response, Document document) throws Exception {
        String url = "product/" + multipartFile.getOriginalFilename();
        if (!multipartFile.getOriginalFilename().equals("")) {
            aliOssUploadManager.uploadFile(multipartFile, "315pal", url);
        }
        if (document.getId() == null || "".equals(document.getId())) {
            //新建内容传入原页面地址
            document.setDocumentContent(null);
            document.setId(null);
            document.setTheDatetime(new Date());
            document.setStatus("1");
            document.setPublishDate(new Date());
        }
        DocumentAttachment attachment = new DocumentAttachment();
        attachment.setDocument(document);
        attachment.setPath(url);
        if (document.getDocumentAttachmentList() == null) {
            document.setDocumentAttachmentList(new ArrayList<DocumentAttachment>());
        }
        documentManager.saveDocument(document);
        if (!multipartFile.getOriginalFilename().equals("")) {
            document.getDocumentAttachmentList().add(attachment);
            baseManager.saveOrUpdate(attachment.getClass().getName(), attachment);
        }

        String path = request.getParameter("qm");
        return new ModelAndView("redirect:" + request.getContextPath() + path);
    }

    @RequestMapping("/attachmentDownload")
    public List<ApplicationMaterial> getAttachDownloadByGroupId(HttpServletRequest request, ModelMap modelMap) throws Exception {
        String qm = request.getParameter("qm");
        if (qm.split("_").length < 2) {
            throw new Exception("qm:" + qm + "的具体查询部分没有定义即'_'的后半部分没有定义");
        }
        //先找到配置文件里的entity
        Do tempDo = doManager.getDoByQueryModel(qm.split("_")[0]);
        //再从中找到query的信息
        DoQuery tempDoQuery = tempDo.getDoQueryByName(qm.split("_")[1]);

        PageEntity pageEntity = new PageEntity();
        String pageIndex = request.getParameter("pageEntity.index");
        String pageSize = request.getParameter("pageEntity.size");
        if (pageIndex != null) {
            pageEntity.setIndex(Integer.parseInt(pageIndex));
            pageEntity.setSize(Integer.parseInt(pageSize));
        }

        modelMap.put("tabTitle", tempDoQuery.getLabel());
//                resultPage = "/pc/choiceness";
        PageInfo pageInfo = xdoManager.listPage(tempDo, tempDoQuery, null, pageEntity);
        modelMap.put("pageInfo", pageInfo);
        modelMap.put("pageEntity", pageInfo.getPageEntity());

        if (tempDo.getExecute() != null && !tempDo.getExecute().equals("")) {
            modelMap = xdoSupportManager.execute(tempDo, modelMap, request);
        }
        modelMap.put("qm", qm);
        modelMap.put("group", tempDo.getData());
        return pageInfo.getList();
    }

    /**
     * 假删
     *
     * @param material
     * @return
     */
    @RequestMapping("/removeAttachment.do")
    @ResponseBody
    public ModelAndView removeDocument(HttpServletRequest request, ApplicationMaterial material) throws Exception {
        String path = request.getContextPath() + request.getParameter("resultPage");

        baseManager.remove(material.getClass().getName(), material.getId());

        return new ModelAndView("redirect:" + request.getContextPath() + path);
    }

    /**
     * @param material
     * @return
     */
    @RequestMapping("/saveAttachmentDownload.do")
    @ResponseBody
    public ModelAndView saveAttachmentDownload(HttpServletRequest request, ApplicationMaterial material) throws Exception {


        String path = request.getParameter("resultPage");
        ApplicationMaterial newMaterial = (ApplicationMaterial) baseManager.getObject(material.getClass().getName(), material.getId());

        newMaterial.setStatus(material.getStatus());
        baseManager.saveOrUpdate(newMaterial.getClass().getName(), newMaterial);
        return new ModelAndView("redirect:" + request.getContextPath() + path);
    }

    /**
     * @param
     * @return
     */
    @RequestMapping("/batchSaveAttachmentDownload.do")
    @ResponseBody
    public void batchSaveAttachmentDownload( @RequestBody List<ApplicationMaterial> materialList) throws Exception {

        ApplicationMaterial newMaterial = null;

        for (ApplicationMaterial material : materialList) {
            newMaterial = (ApplicationMaterial) baseManager.getObject(material.getClass().getName(), material.getId());
            newMaterial.setStatus(material.getStatus());
            baseManager.saveOrUpdate(material.getClass().getName(),newMaterial);
        }
    }

}
