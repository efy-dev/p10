package com.ming800.core.p.controller;

import com.ming800.core.p.model.WordValue;
import com.ming800.core.p.service.DictionaryDataManager;
import com.ming800.core.p.service.WordValueManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
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
@RequestMapping("/WordValue")
public class WordValueController {


    @Autowired
    private WordValueManager wordValueManager;


    @RequestMapping("/listWordValue.do")
    public ModelAndView listWordValueByGroup(WordValue wordValue,ModelMap modelMap){
        List list = wordValueManager.listWordValueByGroup(wordValue);
        modelMap.put("wordValueList",list);
        return  new ModelAndView("/");
    }



}
