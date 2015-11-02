package com.ming800.core.p.controller;

import com.ming800.core.p.model.Document;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.p.model.DocumentPicture;
import com.ming800.core.p.service.AliOssUploadManager;
import com.ming800.core.p.service.DocumentManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

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

    @Autowired
    private AliOssUploadManager aliOssUploadManager;
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
    @RequestMapping("/saveECDocument.do")
    public String saveDocument(Document document,
                               String[] flag, String[] spId, String[] documentPicture,
                               HttpServletRequest request){

        try{
            documentManager.saveDocument(document,flag,spId,documentPicture);
        }catch (Exception e){

            e.printStackTrace();
        }
        System.out.print(document.getId());
        return  request.getParameter("url");
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

    @RequestMapping("/documentUploadify.do")
    @ResponseBody
    public String documentUploadifyImg(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String data = "";


        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
        Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();
        // String ctxPath = request.getSession().getServletContext().getRealPath("/")+ File.separator+"uploadFiles";
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
        String identify = sdf.format(new Date());
        String url = "";
        for (Map.Entry<String, MultipartFile> entry : fileMap.entrySet()) {
            DocumentPicture documentPicture = new DocumentPicture();
            //上传文件
            MultipartFile mf = entry.getValue();
            String fileName = mf.getOriginalFilename();//获取原文件名
            Integer index = 0;
            String hz = fileName.substring(fileName.indexOf("."),fileName.length());
            String imgName = fileName.substring(0, fileName.indexOf(hz));
            url = "document/" + fileName.substring(0, fileName.indexOf(hz)) + identify + hz;

            try {
                aliOssUploadManager.uploadFile(mf, "ec-efeiyi", url);
//
            } catch (Exception e) {
                e.printStackTrace();
            }

        }
        System.out.print(url);
        return url;


    }
}
