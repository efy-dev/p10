package com.efeiyi.pub.resourceFilter;


import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;
import org.apache.commons.io.IOUtils;

@WebServlet(urlPatterns = "/base_resource/p/*", asyncSupported = true)
public class ResourceFilter extends HttpServlet {

    /**
     * @Fields serialVersionUID : 111111111111111l
     *
     */
    private static final long serialVersionUID = 1L;
    private static Logger logger = Logger.getLogger(ResourceFilter.class);

    public static void init2() {

    }

    public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        // HttpServletRequest request = (HttpServletRequest) req;
        String url = req.getRequestURI();
        if (url.startsWith("/base_resource/p/")) {

            InputStream in = this.getClass().getClassLoader()
                    .getResourceAsStream(url.substring("/base_resource/p/".length()));
            if (in == null) {
                logger.info(url.substring("/base_resource/p/".length()) + " is not exists");
                resp.setContentType("text/javascript;charset=utf-8");
                PrintWriter pw = resp.getWriter();
                pw.println("can not find this js file");
            } else {
                try {
                    IOUtils.copy(in, resp.getOutputStream());
                } finally {
                    IOUtils.closeQuietly(in);
                }
            }
        }
    }

    public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {

        doGet(req, resp);
    }

    public void destroy() {
    }

}