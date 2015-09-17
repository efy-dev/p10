package com.efeiyi.association.controller;

import com.alibaba.fastjson.JSONObject;
import com.efeiyi.association.OrganizationConst;
import com.efeiyi.association.model.IntangibleCulturalOrganization;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.base.service.XdoManager;
import com.ming800.core.base.service.XdoSupportManager;
import com.ming800.core.does.model.Do;
import com.ming800.core.does.model.DoQuery;
import com.ming800.core.does.model.PageInfo;
import com.ming800.core.does.service.DoManager;
import com.ming800.core.p.model.Document;
import com.ming800.core.p.service.AliOssUploadManager;
import com.ming800.core.p.service.AutoSerialManager;
import com.ming800.core.p.service.DocumentManager;
import com.ming800.core.taglib.PageEntity;
import com.ming800.core.util.JsonUtil;
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
import java.io.*;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.TreeSet;
import java.util.concurrent.ExecutionException;

/**
 * Created by Administrator on 2015/7/14.
 */
@Controller
@RequestMapping("/myDocument")
public class MyDocumentController {

    //    private static Logger logger = Logger.getLogger(BannerController.class);

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

    /**
     * 根据group_id查询获取相关document
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("/doc.do")
    public List<Document> getDocByGroupId(ModelMap modelMap, HttpServletRequest request) throws Exception {
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
        return pageInfo.getList();
//        return docs;
        //return new ModelAndView("/",model);
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
            document.setTheDatetime(new Date());
            document.setStatus("1");
            document.setDocumentOrder(Integer.parseInt(autoSerialManager.nextSerial("documentOrder")));
            document.setPublishDate(new Date());
        }
        baseManager.saveOrUpdate(document.getDocumentContent().getClass().getName(), document.getDocumentContent());

        documentManager.saveDocument(document);

//        return null;
        return new ModelAndView("redirect:" + request.getContextPath() + path);
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


        documentManager.deleteDocument(document);


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
        String path = request.getContextPath() + request.getParameter("resultPage");

        documentManager.removeDocument(document);

        return new ModelAndView("redirect:" + request.getContextPath() + path);
    }

    /**
     * 新建页面
     *
     * @param document
     * @return
     */
    @RequestMapping("/newDocument.do")
    public ModelAndView direct2Jsp(ModelMap model, HttpServletRequest request, HttpServletResponse response, Document document) throws Exception {
//        response.setHeader("X-Frame-Options", "SAMEORIGIN");
        String qm = request.getParameter("qm");

        if (qm.split("_").length < 2) {
            throw new Exception("qm:" + qm + "的具体查询部分没有定义即'_'的后半部分没有定义");
        }
        //先找到配置文件里的entity
        Do tempDo = doManager.getDoByQueryModel(qm.split("_")[0]);
        //再从中找到query的信息
//            DoQuery tempDoQuery = tempDo.getDoQueryByName(qm.split("_")[1]);
        //设置保存后的返回页面
        model.addAttribute("qm", request.getParameter("resultPage"));
        if (document.getId() != null && !"".equals(document.getId())) {
            document = (Document) baseManager.getObject(document.getClass().getName(), document.getId());
            model.addAttribute("object", document);
        }
        return new ModelAndView(request.getContextPath() + tempDo.getResult());
    }

    @RequestMapping("/organization.do")
    public List<IntangibleCulturalOrganization> getOrganization(HttpServletRequest request, ModelMap modelMap) throws Exception {

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
        return pageInfo.getList();
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
        //再从中找到query的信息
//            DoQuery tempDoQuery = tempDo.getDoQueryByName(qm.split("_")[1]);
        //设置保存后的返回页面
        model.addAttribute("qm", request.getParameter("resultPage"));
        if (organization.getId() != null && !"".equals(organization.getId())) {
            organization = (IntangibleCulturalOrganization) baseManager.getObject(organization.getClass().getName(), organization.getId());
            model.addAttribute("object", organization);
        }
        return new ModelAndView(request.getContextPath() + tempDo.getResult());
    }

    @RequestMapping("/ckeditorUpload.do")
    @ResponseBody
    public void ckeditorUpload(@RequestParam("upload") MultipartFile multipartFile, HttpServletRequest request, HttpServletResponse response) throws Exception {
        response.setHeader("X-Frame-Options", "SAMEORIGIN");
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
        String identify = sdf.format(new Date());
        String url = "product/" + identify + ".jpg";

        if (!multipartFile.getOriginalFilename().equals("")) {
            aliOssUploadManager.uploadFile(multipartFile, "315pal", url);
        }
        String CKEditorFuncNum = request.getParameter("CKEditorFuncNum");
        PrintWriter out;
        String s = "<script type=\"text/javascript\">window.parent.CKEDITOR.tools.callFunction(" + CKEditorFuncNum + ", '" + OrganizationConst.imgBasePath + url + "','上传成功');</script>";
        try {
            out = response.getWriter();
            out.print(s);
            out.flush();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
