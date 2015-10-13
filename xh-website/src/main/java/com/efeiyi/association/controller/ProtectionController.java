package com.efeiyi.association.controller;

import com.efeiyi.association.service.ProtectionServiceManager;
import com.efeiyi.ec.association.model.ApplicationMaterial;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.base.service.XdoManager;
import com.ming800.core.base.service.XdoSupportManager;
import com.ming800.core.does.model.Do;
import com.ming800.core.does.model.DoQuery;
import com.ming800.core.does.model.PageInfo;
import com.ming800.core.does.service.DoManager;
import com.ming800.core.p.model.Document;
import com.ming800.core.taglib.PageEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by Administrator on 2015/9/14.
 */
@Controller
@RequestMapping("/protection")
public class ProtectionController {

    @Autowired
    private DoManager doManager;
    @Autowired
    private XdoManager xdoManager;
    @Autowired
    private XdoSupportManager xdoSupportManager;

    @Autowired
    @Qualifier("protectionServiceManager")
    private ProtectionServiceManager protectionServiceManager;

    @RequestMapping({"/protection.do"})
    public List<Document> protection(HttpServletRequest request, ModelMap modelMap) throws Exception {
        String qm = request.getParameter("qm");
        if (qm.split("_").length < 2) {
            throw new Exception("qm:" + qm + "的具体查询部分没有定义即'_'的后半部分没有定义");
        }
        //先找到配置文件里的entity
        Do tempDo = doManager.getDoByQueryModel(qm.split("_")[0]);
        //再从中找到query的信息
        DoQuery tempDoQuery = tempDo.getDoQueryByName(qm.split("_")[1]);

        PageEntity pageEntity = new PageEntity();
        String pageIndex = request.getParameter("pageEntity.index");
        String pageSize = request.getParameter("pageEntity.size");
        if (pageIndex != null) {
            pageEntity.setIndex(Integer.parseInt(pageIndex));
        }
        pageEntity.setSize(1);

        modelMap.put("tabTitle", tempDoQuery.getLabel());
//                resultPage = "/pc/choiceness";
        PageInfo pageInfo = xdoManager.listPage(tempDo, tempDoQuery, null, pageEntity);
        modelMap.put("pageInfo", pageInfo);
        modelMap.put("pageEntity", pageInfo.getPageEntity());

        if (tempDo.getExecute() != null && !tempDo.getExecute().equals("")) {
            modelMap = xdoSupportManager.execute(tempDo, modelMap, request);
        }
        modelMap.put("qm", qm);
        modelMap.put("group", tempDo.getData());
        return pageInfo.getList();
    }

    @RequestMapping({"/protection.declare.do"})
    public ModelAndView declare(HttpServletRequest request, ModelMap modelMap) throws Exception {
        String qm = request.getParameter("qm");
        if (qm.split("_").length < 2) {
            throw new Exception("qm:" + qm + "的具体查询部分没有定义即'_'的后半部分没有定义");
        }
        //先找到配置文件里的entity
        Do tempDo = doManager.getDoByQueryModel(qm.split("_")[0]);
        //再从中找到query的信息
        DoQuery tempDoQuery = tempDo.getDoQueryByName(qm.split("_")[1]);

        List list = (List) xdoManager.list(tempDo, tempDoQuery, null);
        if (list != null && list.size()>1){
            modelMap.put("object", list.get(0));
            modelMap.put("object2", list.get(1));
        }

        return new ModelAndView("/protection/declare");
    }

    @RequestMapping({"/protection.checkDeclare.do"})
    public ModelAndView checkDeclare(){
        return new ModelAndView("protection/checkDeclare");
    }

    @RequestMapping({"/protection.checkDeclareState.do"})
    public ModelAndView checkDeclareState(HttpServletRequest request, ModelMap modelMap){
        String type = request.getParameter("type");
        String name = request.getParameter("name");
        ApplicationMaterial applicationMaterial = (ApplicationMaterial) protectionServiceManager.CheckDeclareState(name, type);
        modelMap.put("type", type);
        modelMap.put("object", applicationMaterial);
        return new ModelAndView("protection/checkDeclareState");
    }

}
