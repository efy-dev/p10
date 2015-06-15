package com.ming800.core.develop.controller;

import com.ming800.core.base.controller.BaseController;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.ResourceUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;


/**
 * Created with IntelliJ IDEA.
 * User: han
 * Date: 12-7-30
 * Time: 下午1:33
 * To change this template use File | Settings | File Templates.
 */
@Controller
@RequestMapping("/operation")
public class ManagerController extends BaseController {

    @RequestMapping("/main.do")
    public ModelAndView main(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        File file = ResourceUtils.getFile("classpath:/database");
        File[] files = file.listFiles();
        modelMap.put("files", files);
        return new ModelAndView("/core/operation/main", modelMap);
    }

    @RequestMapping("/viewSql.do")
    public ModelAndView viewSql(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        String path = request.getParameter("path");
        File file = ResourceUtils.getFile(path);
        StringBuilder stringBuilder = new StringBuilder();
        BufferedReader in = null;
        in = new BufferedReader(new InputStreamReader(new FileInputStream(file), "UTF-8"));
        String line = "";
        try {
            while ((line = in.readLine()) != null) {
                stringBuilder.append(line).append("</br>");
            }
        } catch (IOException e) {
            e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
        }
        modelMap.put("message", stringBuilder.toString());
        return new ModelAndView("/core/operation/sqlView", modelMap);
    }


    @RequestMapping("/executeSql.do")
    @ResponseBody
    public String executeSql(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        String message = "success";
        String password = request.getParameter("password");
        if (!"newrace2002".equals(password)) {
            message = "无执行权限";
            return message;
        }

        String sql = request.getParameter("sql");

        String[] sqlArray = sql.split(";");
        for (String s : sqlArray) {
            try {
                baseManager.executeSql("", s, null);
            } catch (Exception e) {
                message = e.toString();
                break;
            }
        }
        return message;
    }
}
