package com.ming800.core.p.controller;

import com.ming800.core.does.model.XSaveOrUpdate;
import com.ming800.core.p.controller.BannerController;
import com.ming800.core.p.model.Document;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.p.model.DocumentAttachment;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by Administrator on 2015/7/14.
 */
@Controller
@RequestMapping("/document")
public class DocumentController {

    private static Logger logger = Logger.getLogger(BannerController.class);
    @Autowired
    private BaseManager baseManager;
    @RequestMapping("/doc.do")
    public ModelAndView getDocById(ModelMap model,HttpServletRequest request)throws Exception{

        List<Document> docs = null;
        XQuery xQuery = null;
        try {
            xQuery = new XQuery("listPCDocument_default",request);
        } catch (Exception e) {
            logger.error("create xQuery error in BannerController.getBannerByModlueId()...");
            e.printStackTrace();
        }
        docs = baseManager.listObject(xQuery);
        if (docs==null || docs.size()<=0){
            logger.info("no banners be found,plase confirm again!");
            throw new Exception("no data be found");
        }else{
            model.addAttribute("docs",docs);
        }
       for (Document c:docs){
           System.out.println(c.getName()+"  "+c.getDocumentContent().getContent());
         for(DocumentAttachment da: c.getDocumentAttachmentList()){
             System.out.println(da.getFileName());
         }
       }
        return new ModelAndView("/",model);
    }
}
