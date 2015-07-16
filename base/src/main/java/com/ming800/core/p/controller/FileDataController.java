package com.ming800.core.p.controller;

import com.ming800.core.base.service.BaseManager;
import com.ming800.core.p.PConst;
import com.ming800.core.p.model.FileData;
import com.ming800.core.p.service.AliOssUploadManager;
import com.ming800.core.p.service.FileDataManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URLEncoder;
import java.util.LinkedHashMap;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: ming
 * Date: 12-11-6
 * Time: 下午2:32
 * To change this template use File | Settings | File Templates.
 */
@Controller
@RequestMapping("/fileData")
public class FileDataController {
    @Autowired
    FileDataManager fileDataManager;

    @Autowired
    private BaseManager baseManager;
    @Autowired
    private AliOssUploadManager aliOssUploadManager;

    @RequestMapping("/deleteFile.do")
    @ResponseBody
    public Object deleteFile(HttpServletRequest request) throws Exception {

        String attachmentId = request.getParameter("attachmentId");

        String queryStr = "select store_type, data_id, path from core_p_attachment where id =:attachmentId";
        LinkedHashMap<String, Object> queryParamMap = new LinkedHashMap<>();
        queryParamMap.put("attachmentId", attachmentId);
        List<Object[]> attachmentArrayList = (List<Object[]>) baseManager.executeSql("list", queryStr, queryParamMap);

        if (attachmentArrayList != null && attachmentArrayList.size() > 0) {

            for (Object[] attachmentArray : attachmentArrayList) {
                String storeType = attachmentArray[0].toString();

                if (storeType.equals(PConst.ATTACHMENT_STORETYPE_DATABASE)) {
                    String fileDataId = attachmentArray[1].toString();
                    baseManager.delete(FileData.class.getName(), fileDataId);
                } else if (storeType.equals(PConst.ATTACHMENT_STORETYPE_DISK)) {
                    // 获取路径
                    File file = new File(attachmentArray[2].toString());
                    if (file.exists()) {
                        file.delete();
                    }
                  /*  String fileDataId = attachmentArray[1].toString();
                    FileData fileData = (FileData)baseManager.getObject(FileData.class.getName(), fileDataId);
                    // 获取路径
                    File file = new File(fileData.getPath());
                    if (file.exists()) {
                        file.delete();
                    }
                    baseManager.delete(FileData.class.getName(), fileDataId);*/
                } else if (storeType.equals(PConst.ATTACHMENT_STORETYPE_ALI_CLOUD)) {
                    String path = attachmentArray[2].toString();
                    aliOssUploadManager.deleteFile("m80", path);
                }
            }

            StringBuilder queryStrBuilder = new StringBuilder("delete s from core_p_attachment as s where s.id =:attachmentId");
            LinkedHashMap<String, Object> paramMap = new LinkedHashMap<>();
            paramMap.put("attachmentId", attachmentId);
            baseManager.executeSql("delete", queryStrBuilder.toString(), paramMap);
        }

        return true;
    }

    /**
     * 下载数据库中的附件
     */
    @RequestMapping("/downLoad.do")
    public void downLoad(FileData fileData, HttpServletResponse response) throws Exception {
        fileData = fileDataManager.getFileData(fileData.getId());

        //1.设置文件ContentType类型，这样设置，会自动判断下载文件类型
        response.setContentType("multipart/form-data");
        //2.设置文件头：最后一个参数是设置下载文件名(假如我们叫a.pdf)
        response.setHeader("Content-Disposition", "attachment;fileName=" + "a.txt");
        ServletOutputStream out;
        //通过文件路径获得File对象(假如此路径中有一个download.pdf文件)
        try {
            //3.通过response获取ServletOutputStream对象(out)
            out = response.getOutputStream();
            out.write(fileData.getData());
            out.close();
            out.flush();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    /**
     * 下载本地磁盘里的附件
     *
     * @param request
     * @param response
     * @throws Exception
     */
    @RequestMapping("/downLoadByPath.do")
    public void downLoadByPath(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String fileName = request.getParameter("fileName");
        if (fileName != null) {
            fileName = URLEncoder.encode(fileName, "UTF-8");
        }
        String path = request.getParameter("path");
        //1.设置文件ContentType类型，这样设置，会自动判断下载文件类型
        response.setContentType("multipart/form-data");
        //2.设置文件头：最后一个参数是设置下载文件名(假如我们叫a.pdf)
//        String fileName = path.substring(path.lastIndexOf("/")+1,path.length());
        response.setHeader("Content-Disposition", "attachment;fileName=" + fileName);
        ServletOutputStream out;
        //通过文件路径获得File对象(假如此路径中有一个download.pdf文件)
        try {
            //3.通过response获取ServletOutputStream对象(out)
            out = response.getOutputStream();

            InputStream in = new FileInputStream(path);
            response.setHeader("Content-Length", in.available() + "");                     //响应内容长度 文件大小
            int bt = 0;      //每次读入字节内容
            //每次读入一个字节，存放到变量bt中，直到读完整个文件
            while ((bt = in.read()) != -1) {
                out.write(bt);  //将字节写入输出流中，实现文件的copy功能
            }
            in.close();
            out.close();
            out.flush();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
