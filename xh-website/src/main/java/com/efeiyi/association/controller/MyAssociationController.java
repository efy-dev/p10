package com.efeiyi.association.controller;

import com.ming800.core.base.service.XdoManager;
import com.ming800.core.does.model.Do;
import com.ming800.core.does.model.DoQuery;
import com.ming800.core.does.model.PageInfo;
import com.ming800.core.does.service.DoManager;
import com.ming800.core.p.model.Document;
import com.ming800.core.taglib.PageEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by Administrator on 2015/9/18.
 * 协会概况 Controller
 */

@Controller
@RequestMapping("/myAssociation")
public class MyAssociationController {

    @Autowired
    private XdoManager xdoManager;
    @Autowired
    private DoManager doManager;

    @RequestMapping({"/assContact.do","/assIntroOrStatute.do"})
    public Document getAssContact(HttpServletRequest request, ModelMap modelMap) throws Exception {

        String qm = request.getParameter("qm");
        if (qm.split("_").length < 2) {
            throw new Exception("qm:" + qm + "的具体查询部分没有定义即'_'的后半部分没有定义");
        }
        //先找到配置文件里的entity
        Do tempDo = doManager.getDoByQueryModel(qm.split("_")[0]);
        //再从中找到query的信息
        DoQuery tempDoQuery = tempDo.getDoQueryByName(qm.split("_")[1]);

        PageEntity pageEntity = new PageEntity();
        PageInfo pageInfo = xdoManager.listPage(tempDo, tempDoQuery, null, pageEntity);

        Document document = new Document();
        if (pageInfo.getList() != null && pageInfo.getList().size() >0){
            document = (Document) pageInfo.getList().get(0);
        }
        return document;
    }

}
