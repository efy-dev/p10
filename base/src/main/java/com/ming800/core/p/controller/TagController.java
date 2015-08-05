package com.ming800.core.p.controller;

import com.ming800.core.base.service.BaseManager;
import com.ming800.core.p.model.Tag;
import com.ming800.core.p.service.TagManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
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
public class TagController {

    private static org.apache.log4j.Logger logger = org.apache.log4j.Logger.getLogger(TagController.class);
    @Autowired
    private BaseManager baseManager;

    @Autowired
    private TagManager tagManager;

    @RequestMapping("/listWordValue.do")
    public ModelAndView listWordValueByGroup(ModelMap modelMap,String group) throws  Exception{
        List<Tag> wordValues  = tagManager.listWordValueByGroup(group);
        modelMap.put("wv",wordValues);
        return  new ModelAndView("/wordValue/wordValuePList");
    }
    @RequestMapping("/test.do")
   public List test(){
       List list = tagManager.listWordValueByGroup("1");
       return  list;
   }
}
