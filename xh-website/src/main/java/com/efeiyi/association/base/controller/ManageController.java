package com.efeiyi.association.base.controller;

import com.ming800.core.base.service.BaseManager;
import com.ming800.core.base.service.XdoManager;
import com.ming800.core.base.service.XdoSupportManager;
import com.ming800.core.does.model.Do;
import com.ming800.core.does.model.DoQuery;
import com.ming800.core.does.model.PageInfo;
import com.ming800.core.does.service.DoManager;
import com.ming800.core.p.model.Document;
import com.ming800.core.p.model.Jmenu;
import com.ming800.core.p.model.Jnode;
import com.ming800.core.p.service.AliOssUploadManager;
import com.ming800.core.p.service.AutoSerialManager;
import com.ming800.core.p.service.DocumentManager;
import com.ming800.core.p.service.impl.JmenuManagerImpl;
import com.ming800.core.taglib.PageEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by Administrator on 2015/7/13.
 */
@Controller
public class ManageController {
    @Autowired
    private BaseManager baseManager;

    @Autowired
    @Qualifier("autoSerialManager")
    private AutoSerialManager autoSerialManager;

    @Autowired
    private DocumentManager documentManager;

    @Autowired
    private XdoManager xdoManager;

    @Autowired
    private XdoSupportManager xdoSupportManager;

    @Autowired
    private DoManager doManager;

    @RequestMapping({"/news.do","/news.Bulletin.do"})
    public List<Document> news(HttpServletRequest request,ModelMap modelMap) throws Exception{
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
            pageEntity.setSize(Integer.parseInt(pageSize));
        }

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
        modelMap.put("group", tempDo.getData());
        return pageInfo.getList();
    }


    @RequestMapping("/getSubMenu.do")
    public String getSubMenu(ModelMap modelMap, HttpServletRequest request) throws Exception {
        String match = request.getParameter("match"); //用来得到menuId，筛选jmenu
        String matchUrl = match;
        match = match.substring(0,match.indexOf("."));
//        System.out.println("======================================");
//        System.out.println(match);
//        System.out.println("======================================");
        String resultPage = request.getParameter("resultPage");
        String jnodeId = request.getParameter("jnodeId");
        String jmenuId = request.getParameter("jmenuId");
        Jmenu jmenu = JmenuManagerImpl.getJmenu(jmenuId);
//        System.out.println("startTime: " + System.currentTimeMillis());
        Jnode currentJnode = getCurrentJnode(jmenu, match);
        Jnode matchJnode = getMatchJnode(currentJnode, matchUrl);
//        System.out.println("endTime: " + System.currentTimeMillis());
        modelMap.addAttribute("jmenu", jmenu);
        if (currentJnode != null) {
            modelMap.addAttribute("currentJnode", currentJnode);
            modelMap.addAttribute("matchJnode",matchJnode);
            modelMap.addAttribute("jnode", currentJnode.getRootFather());
        } else if (jnodeId != null) {
            for (Jnode jnodeTemp : jmenu.getChildren()) {
                if (jnodeTemp.getId().equals(jnodeId)) {
                    modelMap.addAttribute("jnode", jnodeTemp);
                    break;
                }
            }
        } else {
            modelMap.addAttribute("jnode", jmenu.getChildren().get(0));
        }
        return resultPage;

    }
    private Jnode getCurrentJnode(Jmenu jmenu, String match) {
        if (match == null || match.equals("")) {
            return null;
        }
        Jnode resultJnode = null;
        for (Jnode jnodeTemp : jmenu.getChildren()) {
            if (resultJnode == null) {
                resultJnode = jnodeTemp.getUrl().trim().startsWith(match.trim())?jnodeTemp:null;
            }
        }
        return resultJnode;
    }
    private Jnode getMatchJnode(Jnode jnode, String match) {
        if (match == null || match.equals("")) {
            return null;
        }
        Jnode resultJnode = null;
        for (Jnode jnodeTemp : jnode.getChildren()) {
            if (resultJnode == null && jnodeTemp.getUrl().trim().startsWith(match.trim())) {
                resultJnode = jnodeTemp;
            }
        }
        return resultJnode;
    }
}
