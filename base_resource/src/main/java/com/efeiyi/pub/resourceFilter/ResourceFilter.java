package com.efeiyi.pub.resourceFilter;


import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;
import org.apache.commons.io.IOUtils;

@WebFilter(urlPatterns = "/*", asyncSupported = true)
public class ResourceFilter implements Filter{

    /**
     * @Fields serialVersionUID : 111111111111111l
     *
     */
    private static final long serialVersionUID = 1L;
    private static Logger logger = Logger.getLogger(ResourceFilter.class);




    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse)response;
        String url = req.getRequestURI();
        String fileType = url.substring(url.lastIndexOf(".")+1);
        PrintWriter pw=null ;
        if (url.startsWith("/base_resource/p/")||url.contains("/base_resource/p/")) {

            InputStream in = this.getClass().getClassLoader()
                    .getResourceAsStream(url.substring((url.indexOf("base_resource/p/"))).substring("base_resource/p/".length()));
            if (in == null) {
                logger.info(url.substring((url.indexOf("base_resource/p/"))).substring("base_resource/p/".length()) + " is not exists");
                resp.setContentType("text/html;charset=utf-8");
                pw = resp.getWriter();
                pw.println("can not find this file");
            } else {

                try {

                    switch (fileType){
                        case "css" :
                            resp.setContentType("text/css;charset=utf-8");break;
                        case "js" :
                            resp.setContentType("text/javascript;charset=utf-8");break;
                        case "html" :
                            resp.setContentType("text/html;charset=utf-8");break;
                        default:break;

                    }
//                    pw = resp.getWriter();
//                    byte b[] = new byte[2048];
//
//                    while((in.read(b))!=-1){
//                        pw.write();
//                    }
//                    pw.flush();

                    pw = resp.getWriter();
                    byte b[] = new byte[1024*1024];
                    int len = 0;
                    int temp=0;          //所有读取的内容都使用temp接收
                    while((temp=in.read())!=-1){    //当没有读取完时，继续读取
                        b[len]=(byte)temp;
                        len++;
                    }

                    pw.write(new String(b,0,len));
                    pw.flush();

                } finally {
                    in.close();
                    pw.close();
                }
            }
        }
        chain.doFilter(req,resp);
    }

    public void destroy() {
    }

}