package com.ming800.core.p.controller;

import com.ming800.core.p.PConst;
import com.ming800.core.p.model.FileData;
import com.ming800.core.p.service.FileDataManager;
import com.ming800.core.util.ApplicationContextUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URLEncoder;

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
