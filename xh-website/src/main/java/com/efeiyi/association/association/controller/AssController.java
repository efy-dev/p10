package com.efeiyi.association.association.controller;

import com.ming800.core.base.service.XdoManager;
import com.ming800.core.does.model.Do;
import com.ming800.core.does.model.DoQuery;
import com.ming800.core.does.model.PageInfo;
import com.ming800.core.does.service.DoManager;
import com.ming800.core.p.model.Document;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by Administrator on 2015/9/24.
 * 前台协会 Controller
 */
@Controller
@RequestMapping("/association")
public class AssController {

    @Autowired
    private DoManager doManager;
    @Autowired
    private XdoManager xdoManager;

    @RequestMapping("/association.do")
    public ModelAndView getAssIntroByGroupId(ModelMap modelMap, HttpServletRequest request) throws Exception {

        String qm = request.getParameter("qm");
        //先找到配置文件里的entity
        Do tempDo = doManager.getDoByQueryModel(qm.split("_")[0]);
        //再从中找到query的信息
        DoQuery tempDoQuery = tempDo.getDoQueryByName(qm.split("_")[1]);
        PageInfo pageInfo = xdoManager.listPage(tempDo, tempDoQuery, null, null);

        Document document = new Document();
        if (pageInfo.getList() != null && pageInfo.getList().size() >0){
            document = (Document) pageInfo.getList().get(0);
        }
        modelMap.put("object", document);

        String group = tempDo.getData();
        modelMap.put("group", group);
        //协会介绍
        if ("assIntro".equals(group)){
            return new ModelAndView("association/assIntro");
        }
        //协会章程
        if ("assStatute".equals(group)){
            return new ModelAndView("association/assStatute");
        }
        //联系方式
        return new ModelAndView("association/assContact");
    }

}
