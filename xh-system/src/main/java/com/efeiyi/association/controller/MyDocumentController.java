package com.efeiyi.association.controller;

import com.efeiyi.association.OrganizationConst;
import com.efeiyi.association.service.MyDocumentManager;
import com.efeiyi.association.util.SavePicsOfDocUtil;
import com.efeiyi.ec.association.model.IntangibleCulturalOrganization;
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
import com.ming800.core.taglib.PageEntity;
import org.htmlparser.Node;
import org.htmlparser.NodeFilter;
import org.htmlparser.Parser;
import org.htmlparser.filters.TagNameFilter;
import org.htmlparser.tags.ImageTag;
import org.htmlparser.util.NodeList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
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
 * Created by Administrator on 2015/7/14.
 */
@Controller
@RequestMapping("/myDocument")
public class MyDocumentController {

    @Autowired
    private BaseManager baseManager;

    @Autowired
    @Qualifier("autoSerialManager")
    private AutoSerialManager autoSerialManager;

    @Autowired
    @Qualifier("myDocumentManagerImpl")
    private MyDocumentManager myDocumentManager;

    @Autowired
    private XdoManager xdoManager;

    @Autowired
    private XdoSupportManager xdoSupportManager;

    @Autowired
    private DoManager doManager;

    @Autowired
    @Qualifier("aliOssUploadManagerImpl")
    private AliOssUploadManager aliOssUploadManager;

    /**
     * 根据group_id查询获取相关document
     */
    @SuppressWarnings("unchecked")
    @RequestMapping({"/doc.do","/organization.do"})
    public List<Document> getDocByGroupId(ModelMap modelMap, HttpServletRequest request) throws Exception {
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
     * 保存
     *
     * @param document
     * @return
     */
    @RequestMapping("/saveDocument.do")
    @ResponseBody
    public ModelAndView saveDocument(HttpServletRequest request, Document document) throws Exception {

        String path = request.getParameter("qm");
        document.getDocumentContent().setDocument(document);
        //新建内容
        if (document.getId() == null || "".equals(document.getId())) {
            //新建内容传入原页面地址
            document.setId(null);
            document.getDocumentContent().setId(null);
            document.setTheDatetime(new Date());
            document.setStatus("1");
            document.setDocumentOrder(Integer.parseInt(autoSerialManager.nextSerial("documentOrder")));
            document.setPublishDate(new Date());
        } else {
            myDocumentManager.deleteDocument(document);
            document.setId(null);
        }

        SavePicsOfDocUtil.savePicsOfDoc(document);

        baseManager.saveOrUpdate(document.getDocumentContent().getClass().getName(), document.getDocumentContent());
        myDocumentManager.saveDocument(document);
        return new ModelAndView("redirect:" /*+ request.getContextPath()*/ + path);
    }
    @RequestMapping("/recommendDocument.do")
    @ResponseBody
    public ModelAndView recommendDocument(HttpServletRequest request, Document document) throws Exception {
        String path = request.getParameter("qm");
        Document newDocument = (Document)baseManager.getObject(document.getClass().getName(),document.getId());
        newDocument.setStatus(document.getStatus());
        myDocumentManager.saveDocument(newDocument);
        return new ModelAndView("redirect:" /*+ request.getContextPath()*/ + path);
    }
    /**
     * 真删
     *
     * @param document
     * @return
     */
    @RequestMapping("/deleteDocument.do")
    @ResponseBody
    public String deleteDocument(Document document) {
        myDocumentManager.deleteDocument(document);
        return document.getId();
    }

    /**
     * 假删
     *
     * @param document
     * @return
     */
    @RequestMapping("/removeDocument.do")
    @ResponseBody
    public ModelAndView removeDocument(HttpServletRequest request, Document document) throws Exception {
        String path = /*request.getContextPath() +*/ request.getParameter("resultPage");
        myDocumentManager.removeDocument(document);
        return new ModelAndView("redirect:" /*+ request.getContextPath()*/ + path);
    }

    /**
     * 新建页面
     *
     * @param document
     * @return
     */
    @RequestMapping("/newDocument.do")
    public ModelAndView direct2Jsp(ModelMap model, HttpServletRequest request, Document document) throws Exception {
        String qm = request.getParameter("qm");

        if (qm.split("_").length < 2) {
            throw new Exception("qm:" + qm + "的具体查询部分没有定义即'_'的后半部分没有定义");
        }
        //先找到配置文件里的entity
        Do tempDo = doManager.getDoByQueryModel(qm.split("_")[0]);
        //设置保存后的返回页面
        model.addAttribute("qm", request.getParameter("resultPage"));
        if (document.getId() != null && !"".equals(document.getId())) {
            document = (Document) baseManager.getObject(document.getClass().getName(), document.getId());
            model.addAttribute("object", document);
        }

        if (document.getDocumentAttachmentList() != null && document.getDocumentAttachmentList().size()>0){
            DocumentAttachment documentAttachment = document.getDocumentAttachmentList().get(0);
            String path = documentAttachment.getPath();
            String url = path.substring(path.lastIndexOf("/")+1, path.length());
            model.addAttribute("url", url);
        }

        model.addAttribute("group", document.getGroup());
        return new ModelAndView(/*request.getContextPath() +*/ tempDo.getResult());
    }

    /**
     * 新建页面
     *
     * @param organization
     * @return
     */
    @RequestMapping("/newOrganization.do")
    public ModelAndView direct2JspOrganization(ModelMap model, HttpServletRequest request, IntangibleCulturalOrganization organization) throws Exception {
        String qm = request.getParameter("qm");

        if (qm.split("_").length < 2) {
            throw new Exception("qm:" + qm + "的具体查询部分没有定义即'_'的后半部分没有定义");
        }
        //先找到配置文件里的entity
        Do tempDo = doManager.getDoByQueryModel(qm.split("_")[0]);
        //设置保存后的返回页面
        model.addAttribute("qm", request.getParameter("resultPage"));
        if (organization.getId() != null && !"".equals(organization.getId())) {
            organization = (IntangibleCulturalOrganization) baseManager.getObject(organization.getClass().getName(), organization.getId());
            model.addAttribute("object", organization);
        }
        model.addAttribute("group", organization.getGroup());
        return new ModelAndView(/*request.getContextPath() +*/ tempDo.getResult());
    }

    /**
     * ckediotr上传图片
     * @param multipartFile
     * @param request
     * @param response
     * @throws Exception
     */
    @RequestMapping("/ckeditorUpload.do")
    @ResponseBody
    public void ckeditorUpload(@RequestParam("upload") MultipartFile multipartFile, HttpServletRequest request, HttpServletResponse response) throws Exception {
        response.setHeader("X-Frame-Options", "SAMEORIGIN");
        response.setContentType("text/html;charset=UTF-8");
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
        String identify = sdf.format(new Date());
        String url = "document/" + identify + ".jpg";

        if (!multipartFile.getOriginalFilename().equals("")) {
            aliOssUploadManager.uploadFile(multipartFile, "association", url);
        }
        String CKEditorFuncNum = request.getParameter("CKEditorFuncNum");
        PrintWriter out;
        String s = "<script type=\"text/javascript\">window.parent.CKEDITOR.tools.callFunction(" + CKEditorFuncNum + ", '" + OrganizationConst.imgBasePath + url + "');</script>";
//        String s = "window.parent.CKEDITOR.tools.callFunction(" + CKEditorFuncNum + ", '" + OrganizationConst.imgBasePath + url + "');";

        try {
            out = response.getWriter();
            out.print(s);
            out.flush();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
