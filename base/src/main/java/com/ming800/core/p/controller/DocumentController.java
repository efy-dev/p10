package com.ming800.core.p.controller;

import com.ming800.core.p.model.Document;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.p.service.DocumentManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by Administrator on 2015/7/14.
 *
 */
@Controller
@RequestMapping("/document")
public class DocumentController {

    private static Logger logger = Logger.getLogger(BannerController.class);
    @Autowired
    private BaseManager baseManager;

    @Autowired
    private DocumentManager documentManager;
    /**
     *根据group_id查询获取相关document
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("/doc.do")
    public List<Document> getDocByGroupId(HttpServletRequest request)throws Exception{
        logger.debug("getDocByGroupId begin ...");
        XQuery  xQuery = new XQuery("listPCDocument_default",request);
        List<Document> docs = baseManager.listObject(xQuery);
        logger.debug("getDocByGroupId end ...");
        return docs;
        //return new ModelAndView("/",model);
    }

    /**
     * 保存
     * @param document
     * @return
     */
    @RequestMapping("/saveDocument.do")
    @ResponseBody
    public String saveDocument(Document document){

        try{
            documentManager.saveDocument(document);
        }catch (Exception e){

            e.printStackTrace();
        }
        System.out.print(document.getId());
        return  document.getId();
    }

    /**
     * 真删
     * @param document
     * @return
     */
    @RequestMapping("/deleteDocument.do")
    @ResponseBody
    public String deleteDocument(Document document){

        try {

            documentManager.deleteDocument(document);

        }catch (Exception e){
            e.printStackTrace();
        }

        return  document.getId();
    }

    /**
     * 假删
     * @param document
     * @return
     */
    @RequestMapping("/removeDocument.do")
    @ResponseBody
    public String removeDocument(Document document){

        try {

            documentManager.removeDocument(document);

        }catch (Exception e){
            e.printStackTrace();
        }

        return  document.getId();
    }

}
