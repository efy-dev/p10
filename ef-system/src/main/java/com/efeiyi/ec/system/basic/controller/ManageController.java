package com.efeiyi.ec.system.basic.controller;

import com.alibaba.fastjson.JSONObject;
import com.ming800.core.p.service.AliOssUploadManager;
import com.ming800.core.util.HttpUtil;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;
import java.util.zip.GZIPInputStream;
import java.util.zip.InflaterInputStream;

/**
 * Created by Administrator on 2015/7/13.
 */
@Controller
public class ManageController {

    @Autowired
    private AliOssUploadManager aliOssUploadManager;

    @RequestMapping({"main.do"})
    public String main() {
        return "/main";
    }

    @RequestMapping({"/fetchData.do"})
    @ResponseBody
    public String fetchData(HttpServletRequest request) throws IOException {
        URL url = new URL("http://baike.baidu.com/search/word?word=%E8%8B%8F%E7%BB%A3");
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestProperty("Accept-Charset", "utf-8");
        conn.setRequestProperty("contentType", "utf-8");
        conn.setConnectTimeout(5 * 1000);
        conn.setRequestMethod("GET");
        InputStream inStream = conn.getInputStream();

        BufferedReader in = new BufferedReader(new InputStreamReader(inStream, "utf-8"));
        StringBuffer buffer = new StringBuffer();
        String line;
        while ((line = in.readLine()) != null) {
            buffer.append(line + "\n");
        }
        String str = buffer.toString();
        System.out.println(str);

        //1.首先需要判断是不是我想要的页面，是列表页面或者详情页面  我们要的是详情页面
        //2.去掉没用的元素，导航页尾，推荐按钮等元素 （搜集html标签的class属性来判别内容，需要根据网页实际代码整理一下）
        //3.去掉所有a标签（可以使用java的正则表达式，编辑的按钮）

        return str;

    }


}
