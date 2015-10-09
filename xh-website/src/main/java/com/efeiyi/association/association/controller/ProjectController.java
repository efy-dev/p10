package com.efeiyi.association.association.controller;

import com.efeiyi.association.core.DatabaseContextHolder;
import com.efeiyi.ec.project.model.Project;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.base.service.XdoManager;
import com.ming800.core.base.service.XdoSupportManager;
import com.ming800.core.does.model.Do;
import com.ming800.core.does.model.DoQuery;
import com.ming800.core.does.model.PageInfo;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.does.service.DoManager;
import com.ming800.core.taglib.PageEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

/**
 * Created by Administrator on 2015/9/25.
 * 非遗名录 Controller
 */
@Controller
@RequestMapping("/project")
public class ProjectController {

    @Autowired
    private DoManager doManager;
    @Autowired
    private XdoManager xdoManager;
    @Autowired
    private BaseManager baseManager;
    @Autowired
    private XdoSupportManager xdoSupportManager;

    @RequestMapping("/project.do")
    public ModelAndView getProject(ModelMap modelMap, HttpServletRequest request) throws Exception {

//        String qm = request.getParameter("qm");
//        //先找到配置文件里的entity
//        Do tempDo = doManager.getDoByQueryModel(qm.split("_")[0]);
//        //再从中找到query的信息
//        DoQuery tempDoQuery = tempDo.getDoQueryByName(qm.split("_")[1]);
//
//        DatabaseContextHolder.setDataSource("dataSource");
//        List<Project> list= (List<Project>)xdoManager.list(tempDo, tempDoQuery, null);
//        Map<String,Project> map = new HashMap<String,Project>();
//        for(Project project : list){
//            map.put(project.getType(),project);
//        }
//        list = new ArrayList<Project>();
//        for(Map.Entry<String,Project> entry : map.entrySet()){
//            list.add(entry.getValue());
//        }
//        modelMap.put("projectList", list);
//        DatabaseContextHolder.setDataSource("associationDataSource");
        return new ModelAndView("heritageProject/project");
    }

    @RequestMapping("/project.type.do")
    public List<Project> getProjectType(ModelMap modelMap, HttpServletRequest request) throws Exception {

        String qm = request.getParameter("qm");
        //先找到配置文件里的entity
        Do tempDo = doManager.getDoByQueryModel(qm.split("_")[0]);
        //再从中找到query的信息
        DoQuery tempDoQuery = tempDo.getDoQueryByName(qm.split("_")[1]);

//        DatabaseContextHolder.setDataSource("dataSource");
        List<Project> list= (List<Project>)xdoManager.list(tempDo, tempDoQuery, null);
        Map<String,Project> map = new HashMap<String,Project>();
        for(Project project : list){
            map.put(project.getType(),project);
        }
        list = new ArrayList<Project>();
        for(Map.Entry<String,Project> entry : map.entrySet()){
            list.add(entry.getValue());
        }
//        modelMap.put("projectList", list);
//        DatabaseContextHolder.setDataSource("associationDataSource");
//        return new ModelAndView("heritageProject/project");
        return list;
    }

//    @RequestMapping("/project.do")
//    public ModelAndView getAssIntroByGroupId(ModelMap modelMap, HttpServletRequest request) throws Exception {
//
//        String qm = request.getParameter("qm");
//        //先找到配置文件里的entity
//        Do tempDo = doManager.getDoByQueryModel(qm.split("_")[0]);
//        //再从中找到query的信息
//        DoQuery tempDoQuery = tempDo.getDoQueryByName(qm.split("_")[1]);
//
//        DatabaseContextHolder.setDataSource("dataSource");
//        modelMap.put("provinceList", xdoManager.list(tempDo, tempDoQuery, null));
//        DatabaseContextHolder.setDataSource("associationDataSource");
//        return new ModelAndView("heritageProject/project");
//    }

    @RequestMapping({"/provinceList.do"})
    public List<Object> getProvinceList(HttpServletRequest request) throws Exception {
        XQuery xQuery = new XQuery("listAddressProvince_default", request);
        List<Object> list = baseManager.listObject(xQuery);
        return list;
    }

    @RequestMapping({"/project.List.do"})
    public List<Object> getProjectList(HttpServletRequest request,ModelMap modelMap) throws Exception {

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
        return pageInfo.getList();

//        XQuery xQuery = new XQuery("listAddressProvince_default", request);
//        List<Object> list = baseManager.listObject(xQuery);
//        return list;
    }

}
