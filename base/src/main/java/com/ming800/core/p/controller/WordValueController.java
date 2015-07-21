package com.ming800.core.p.controller;

import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
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
import java.util.logging.Logger;

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

    private static org.apache.log4j.Logger logger = org.apache.log4j.Logger.getLogger(WordValueController.class);
    @Autowired
    private BaseManager baseManager;

    @Autowired
    private WordValueManager wordValueManager;

    @RequestMapping("/listWordValue.do")
    public ModelAndView listWordValueByGroup(ModelMap modelMap) throws  Exception{
        List<WordValue> wordValues  = wordValueManager.listWordValueByGroup("1");
        modelMap.put("wv",wordValues);
        return  new ModelAndView("/");
    }




}
