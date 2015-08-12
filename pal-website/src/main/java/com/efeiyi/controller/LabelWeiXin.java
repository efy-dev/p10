package com.efeiyi.controller;

import com.efeiyi.PalConst;
import com.efeiyi.WeiXinMessageDigest;
import com.efeiyi.pal.label.model.Label;
import com.efeiyi.service.ILabelCheckManager;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.Date;

/**
 * Created by Administrator on 2015/8/6.
 */
@Controller
public class LabelWeiXin extends HttpServlet {
    @Autowired
    ILabelCheckManager iLabelCheckService;

    @Override
    @RequestMapping(value = "/contact.do", method = RequestMethod.POST)
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String signature = request.getParameter("signature");
        String timestamp = request.getParameter("timestamp");
        String nonce = request.getParameter("nonce");

        System.out.println("signature:" + signature);
        System.out.println("timestamp:"+timestamp);
        System.out.println("nonce:"+nonce);
        System.out.println("echostr:" + request.getParameter("echostr"));


        //验证签名
        if(WeiXinMessageDigest.getInstance().validate(signature,timestamp,nonce)) {

            InputStream is = request.getInputStream();
            byte[] b = new byte[request.getContentLength()];
            is.read(b);
            String inXml = new String(b);
            System.out.println(new Date(System.currentTimeMillis()) + "--inXml:\n" + inXml + "\n");

            String outXml = iLabelCheckService.treatWeiXinMsg(request, inXml);

            PrintWriter pw = response.getWriter();
            pw.write(outXml);
        }else{
            response.getWriter().write("");
        }
    }
}
