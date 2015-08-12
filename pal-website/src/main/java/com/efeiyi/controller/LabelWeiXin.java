package com.efeiyi.controller;

import com.efeiyi.PalConst;
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
    @RequestMapping(value = "/contact.do",method = RequestMethod.POST)
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        InputStream is = request.getInputStream();
        byte [] b = new byte[request.getContentLength()];
        is.read(b);
        String inXml = new String(b);
        System.out.println(new Date(System.currentTimeMillis()) + "--inXml:\n" + inXml + "\n");


        Document document = null;
        try {
            document = DocumentHelper.parseText(inXml);
        } catch (DocumentException e) {
            e.printStackTrace();
            throw new IOException(e.getMessage());
        }
        Element root = document.getRootElement();
        String serial = root.element("EventKey").getText();
        String event = root.element("Event").getText();
        System.out.println("Event=\'"+event+"\'");
        if(PalConst.getInstance().weiXinSubscribeEvent.equals(event)){
            serial = serial.substring(8).trim();
        }
        System.out.println("serial=\'"+serial+"\'");

        Label label = iLabelCheckService.getUniqueLabel(serial);
        String url =  request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/checkLabel.do?serial="+serial;
        String outXml = "";
        String toUserName = root.element("ToUserName").getText();
        String fromUserName = root.element("FromUserName").getText();


        if(label != null)
        {
            String content = "查询的序列号对应商品是：" + label.getProduct().getName();
            outXml =iLabelCheckService.constructWeiXinMsg(fromUserName, toUserName, content, url);
        }else{
            outXml = iLabelCheckService.constructWeiXinMsg(fromUserName, toUserName, "查询的序列号不存在", url);
        }

        System.out.println(new Date(System.currentTimeMillis()) + "--outXml:\n" + outXml + "\n");
        PrintWriter pw = response.getWriter();
        pw.write(outXml);

    }
}
