package com.ming800.core.p.controller;

import com.ming800.core.p.service.DictionaryDataManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: ming
 * Date: 12-11-6
 * Time: 下午2:32
 * To change this template use File | Settings | File Templates.
 */
@Controller
@RequestMapping("/data")
public class DictionaryDataController {


    @Autowired
    private DictionaryDataManager dictionaryDataManager;


    @RequestMapping("/loadDictionaryData.do")
    @ResponseBody
    public List loadDictionaryData(HttpServletRequest request) {

        String sid = request.getParameter("sid");

        return dictionaryDataManager.getDictionaryDataList(sid);
    }


    @RequestMapping("/loadWindow.do")
    public ModelAndView loadWindow(HttpServletRequest request) {

        String modelName = request.getParameter("modelName");
        String url = "redirect:";

        if (modelName.equals("clazzInstance")) {
            url += "/clazzInstance/listClazzInstanceWindow.do";
        } else if (modelName.equals("user")) {
            url += "/user/listBigUserWindow.do";
        }

        url += "?single=" + request.getParameter("single") + "&idNames=" + request.getParameter("idNames") + "&textNames=" + request.getParameter("textNames");

        return new ModelAndView(url);

    }


}
