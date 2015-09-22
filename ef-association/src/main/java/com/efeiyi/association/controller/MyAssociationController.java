package com.efeiyi.association.controller;

import com.ming800.core.base.service.BaseManager;
import com.ming800.core.base.service.XdoManager;
import com.ming800.core.base.service.XdoSupportManager;
import com.ming800.core.does.model.Do;
import com.ming800.core.does.model.DoQuery;
import com.ming800.core.does.model.PageInfo;
import com.ming800.core.does.service.DoManager;
import com.ming800.core.p.model.Document;
import com.ming800.core.p.model.DocumentAttachment;
import com.ming800.core.p.service.DocumentManager;
import com.ming800.core.taglib.PageEntity;
import org.htmlparser.Node;
import org.htmlparser.NodeFilter;
import org.htmlparser.Parser;
import org.htmlparser.filters.TagNameFilter;
import org.htmlparser.tags.ImageTag;
import org.htmlparser.util.NodeList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.Date;

/**
 * Created by Administrator on 2015/9/18.
 * 协会概况 Controller
 */

@Controller
@RequestMapping("/myAssociation")
public class MyAssociationController {

    @Autowired
    private BaseManager baseManager;
    @Autowired
    private DocumentManager documentManager;
    @Autowired
    private XdoManager xdoManager;
    @Autowired
    private XdoSupportManager xdoSupportManager;
    @Autowired
    private DoManager doManager;

    @RequestMapping("/assContact.do")
    public Document getAssContact(HttpServletRequest request, ModelMap modelMap) throws Exception {

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
        modelMap.put("resultPage", request.getParameter("resultPage"));
        modelMap.put("group", tempDo.getData());
        Document document = new Document();
        if (pageInfo.getList() != null && pageInfo.getList().size() >0){
            document = (Document) pageInfo.getList().get(0);
        }
        return document;
    }

    @RequestMapping("/saveAssContact.do")
    @ResponseBody
    public ModelAndView saveAssContact(HttpServletRequest request, Document document) throws Exception {

        document.getDocumentContent().setDocument(document);
        //新建内容
        if (document.getId() == null || "".equals(document.getId())) {
            //新建内容传入原页面地址
            document.setId(null);
            document.getDocumentContent().setId(null);
            document.setTheDatetime(new Date());
            document.setStatus("1");
            document.setPublishDate(new Date());
        }

        baseManager.saveOrUpdate(document.getDocumentContent().getClass().getName(), document.getDocumentContent());
        documentManager.saveDocument(document);
        return new ModelAndView("redirect:" + request.getContextPath() + request.getParameter("qm") + "&resultPage=/myAssociation/assContact.do?qm=plistContact_default");
    }

    @RequestMapping("/assIntroOrStatute.do")
    public Document getAssIntroOrStatute(HttpServletRequest request, ModelMap modelMap) throws Exception {

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
        modelMap.put("resultPage", request.getParameter("resultPage"));
        modelMap.put("group", tempDo.getData());
        Document document = new Document();
        if (pageInfo.getList() != null && pageInfo.getList().size() >0){
            document = (Document) pageInfo.getList().get(0);
        }
        return document;
    }

    @RequestMapping("/saveAssIntroOrStatute.do")
    @ResponseBody
    public ModelAndView saveAssIntroOrStatute(HttpServletRequest request, Document document) throws Exception {

        String group = document.getGroup();
        String path = request.getParameter("qm");
        document.getDocumentContent().setDocument(document);
        //新建内容
        if (document.getId() == null || "".equals(document.getId())) {
            //新建内容传入原页面地址
            document.setId(null);
            document.getDocumentContent().setId(null);
            document.setStatus("1");
        } else {
            documentManager.deleteDocument(document);
            document.setId(null);
        }
        if (document.getDocumentContent().getContent() != null) {
            Parser parser = new Parser(document.getDocumentContent().getContent());
            NodeFilter filter = new TagNameFilter("img");
            NodeList nodes = parser.extractAllNodesThatMatch(filter);

            if (nodes != null) {
                Node eachNode = null;
                ImageTag imageTag = null;
                String srcPath = null;
                DocumentAttachment documentAttachment = null;
                document.setDocumentAttachmentList(new ArrayList<DocumentAttachment>());

                //遍历所有的img节点
                for (int i = 0; i < nodes.size(); i++) {
                    eachNode = (Node) nodes.elementAt(i);
                    if (eachNode instanceof ImageTag) {
                        imageTag = (ImageTag) eachNode;

                        //获得html文本的原来的src属性
                        srcPath = imageTag.getAttribute("src");
                        documentAttachment = new DocumentAttachment();
                        documentAttachment.setPath(srcPath);
                        documentAttachment.setDocument(document);
                        document.getDocumentAttachmentList().add(documentAttachment);
                    }
                }
            }
        }
        baseManager.saveOrUpdate(document.getDocumentContent().getClass().getName(), document.getDocumentContent());
        documentManager.saveDocument(document);
        String resultPage = "redirect:" + request.getContextPath() + path;
        if ("assIntro".equals(group)){
            resultPage += "&resultPage=/myAssociation/assIntroOrStatute.do?qm=plistAssociationIntroduction_default";
        }else {
            resultPage += "&resultPage=/myAssociation/assIntroOrStatute.do?qm=plistStatute_default";
        }
        return new ModelAndView(resultPage);
    }

}
