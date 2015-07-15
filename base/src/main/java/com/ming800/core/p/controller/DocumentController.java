package com.ming800.core.p.controller;

import com.ming800.core.p.model.Document;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

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
}
