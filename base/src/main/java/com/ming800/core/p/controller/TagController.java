package com.ming800.core.p.controller;

import com.ming800.core.base.service.BaseManager;
import com.ming800.core.p.model.Banner;
import com.ming800.core.p.model.ObjectRecommended;
import com.ming800.core.p.model.Tag;
import com.ming800.core.p.service.BannerManager;
import com.ming800.core.p.service.DocumentManager;
import com.ming800.core.p.service.TagManager;
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
@RequestMapping("/Tag")
public class TagController {

    private static org.apache.log4j.Logger logger = org.apache.log4j.Logger.getLogger(TagController.class);
    @Autowired
    private BaseManager baseManager;

    @Autowired
    private TagManager tagManager;

    /***
     * 字典列表
     * @param modelMap
     * @return
     * @throws Exception
     */
    @RequestMapping("/listTag.do")
    public ModelAndView getListRecommended(ModelMap modelMap,String groupName,String resultPage,HttpServletRequest request) throws Exception {
        request.setAttribute("qm",request.getParameter("qm"));
        modelMap.put("objectList",tagManager.getTagList(groupName));
        return  new ModelAndView("/"+resultPage);
    }

    /**
     * 保存
     * @param tag
     * @return
     */
    @RequestMapping("/saveTag.do")
    @ResponseBody
    public String saveTag(Tag tag){

        try{
            tagManager.saveTag(tag);
        }catch (Exception e){

            e.printStackTrace();
        }
        System.out.print(tag.getId());
        return  tag.getId();
    }

    /**
     * 真删
     * @param tag
     * @return
     */
    @RequestMapping("/deleteTag.do")
    @ResponseBody
    public String deleteTag(Tag tag){

        try {

            tagManager.deleteTag(tag);

        }catch (Exception e){
            e.printStackTrace();
        }

        return  tag.getId();
    }

    /**
     * 假删
     * @param tag
     * @return
     */
    @RequestMapping("/removeTag.do")
    @ResponseBody
    public String removeTag(Tag tag){

        try {

            tagManager.removeTag(tag);

        }catch (Exception e){
            e.printStackTrace();
        }

        return  tag.getId();
    }


    public void test() {
    }
}
