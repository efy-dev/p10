package com.efeiyi.association.association.controller;

import com.efeiyi.ec.master.model.MasterProject;
import com.efeiyi.ec.project.model.Project;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.base.service.XdoManager;
import com.ming800.core.base.service.XdoSupportManager;
import com.ming800.core.does.model.*;
import com.ming800.core.does.service.DoManager;
import com.ming800.core.taglib.PageEntity;
import org.apache.commons.beanutils.BeanUtils;
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

        String provinceId = request.getParameter("provinceid");
        String type = request.getParameter("type");
        modelMap.addAttribute("provinceid", provinceId);
        modelMap.addAttribute("type", type);
        return new ModelAndView("heritageProject/project");
    }

    @RequestMapping("/project.master.do")
    public ModelAndView getMasterProject(ModelMap modelMap, HttpServletRequest request) throws Exception {

        String provinceId = request.getParameter("provinceid");
        String type = request.getParameter("type");
        modelMap.addAttribute("provinceid", provinceId);
        modelMap.addAttribute("type", type);
        return new ModelAndView("heritageProject/project.master");
    }

    @RequestMapping("/project.type.do")
    public List<Project> getProjectType(ModelMap modelMap, HttpServletRequest request) throws Exception {

        String qm = request.getParameter("qm");

        //先找到配置文件里的entity
        Do tempDo = doManager.getDoByQueryModel(qm.split("_")[0]);
        //再从中找到query的信息
        DoQuery tempDoQuery = tempDo.getDoQueryByName(qm.split("_")[1]);

        List<Project> list = (List<Project>) xdoManager.list(tempDo, tempDoQuery, null);
        Map<String, Project> map = new HashMap<String, Project>();
        for (Project project : list) {
            map.put(project.getType(), project);
        }
        list = new ArrayList<Project>();
        for (Map.Entry<String, Project> entry : map.entrySet()) {
            list.add(entry.getValue());
        }
        String provinceId = request.getParameter("provinceid");
        String type = request.getParameter("type");
        modelMap.addAttribute("provinceid", provinceId);
        modelMap.addAttribute("type", type);
        return list;
    }

    @RequestMapping("/project.master.type.do")
    public List<MasterProject> getMasterProjectType(ModelMap modelMap, HttpServletRequest request) throws Exception {

        String qm = request.getParameter("qm");

        //先找到配置文件里的entity
        Do tempDo = doManager.getDoByQueryModel(qm.split("_")[0]);
        //再从中找到query的信息
        DoQuery tempDoQuery = tempDo.getDoQueryByName(qm.split("_")[1]);

        List<MasterProject> list = (List<MasterProject>) xdoManager.list(tempDo, tempDoQuery, null);
        Map<String, MasterProject> map = new HashMap<String, MasterProject>();
        for (MasterProject masterProject : list) {
            try {
                map.put(masterProject.getProject().getType(), masterProject);
            } catch (NullPointerException e) {
                continue;
            }
        }
        list = new ArrayList<MasterProject>();
        for (Map.Entry<String, MasterProject> entry : map.entrySet()) {
            list.add(entry.getValue());
        }
        String provinceId = request.getParameter("provinceid");
        String type = request.getParameter("type");
        modelMap.addAttribute("provinceid", provinceId);
        modelMap.addAttribute("type", type);
        return list;
    }


    @RequestMapping({"/provinceList.do"})
    public List<Object> getProvinceList(ModelMap modelMap, HttpServletRequest request) throws Exception {
        XQuery xQuery = new XQuery("listAddressProvince_default", request);
        List<Object> list = baseManager.listObject(xQuery);
        String provinceId = request.getParameter("provinceid");
        String type = request.getParameter("type");
        modelMap.addAttribute("provinceid", provinceId);
        modelMap.addAttribute("type", type);
        return list;
    }

    @RequestMapping({"/projectMaster.List.do", "/project.List.do"})
    public List<Object> getMasterProjectList(HttpServletRequest request, ModelMap modelMap) throws Exception {

        String qm = request.getParameter("qm");
        if (qm.split("_").length < 2) {
            throw new Exception("qm:" + qm + "的具体查询部分没有定义即'_'的后半部分没有定义");
        }
        //先找到配置文件里的entity
        Do tempDo = doManager.getDoByQueryModel(qm.split("_")[0]);
        //再从中找到query的信息

        PageEntity pageEntity = new PageEntity();
        String pageIndex = request.getParameter("pageEntity.index");
        String pageSize = request.getParameter("pageEntity.size");
        if (pageIndex != null) {
            pageEntity.setIndex(Integer.parseInt(pageIndex));
            pageEntity.setSize(Integer.parseInt(pageSize));
        }

        String provinceId = request.getParameter("provinceid");
        String type = request.getParameter("type");

        DoQuery tempDoQuery = tempDo.getDoQueryByName(qm.split("_")[1]);
        List<QueryCondition> originList = tempDoQuery.getConditionList();

        if (type != null && !"-1".equals(type)) {
            QueryCondition condition = new QueryCondition();
            BeanUtils.copyProperties(condition, originList.get(0));
            if ("plistTenant_default".equals(qm)) {
                condition.setName("project.type");
            } else if ("plistProject_default".equals(qm)) {
                condition.setName("type");
            }
            condition.setValue(type);
            condition.setOperation("eq");

            tempDoQuery.setConditionList(new ArrayList<QueryCondition>());
            tempDoQuery.getConditionList().addAll(originList);
            tempDoQuery.getConditionList().add(condition);
        }
        List<QueryCondition> firstList = tempDoQuery.getConditionList();

        if (provinceId != null && !"-1".equals(provinceId)) {
            QueryCondition condition = new QueryCondition();
            BeanUtils.copyProperties(condition, originList.get(0));

            if ("plistTenant_default".equals(qm)) {
                condition.setName("project.addressDistrict.addressCity.addressProvince.id");
            } else if ("plistProject_default".equals(qm)) {
                condition.setName("addressDistrict.addressCity.addressProvince.id");
            }
            condition.setValue(provinceId);
            condition.setOperation("eq");

            tempDoQuery.setConditionList(new ArrayList<QueryCondition>());
            tempDoQuery.getConditionList().addAll(firstList);
            tempDoQuery.getConditionList().add(condition);
        }
        PageInfo pageInfo = xdoManager.listPage(tempDo, tempDoQuery, null, pageEntity);
        modelMap.put("tabTitle", tempDoQuery.getLabel());
        modelMap.put("pageInfo", pageInfo);
        modelMap.put("pageEntity", pageInfo.getPageEntity());

        if (tempDo.getExecute() != null && !tempDo.getExecute().equals("")) {
            modelMap = xdoSupportManager.execute(tempDo, modelMap, request);
        }
        modelMap.put("qm", qm);
        modelMap.put("group", tempDo.getData());
        tempDoQuery.setConditionList(originList);
        return pageInfo.getList();

    }

    @RequestMapping({"/project.home.list.do"})
    public List<Object> getProjectList(HttpServletRequest request, ModelMap modelMap) throws Exception {

        String qm = request.getParameter("qm");

        if (qm.split("_").length < 2) {
            throw new Exception("qm:" + qm + "的具体查询部分没有定义即'_'的后半部分没有定义");
        }
        //先找到配置文件里的entity
        Do tempDo = doManager.getDoByQueryModel(qm.split("_")[0]);
        //再从中找到query的信息

        PageEntity pageEntity = new PageEntity();
        String pageIndex = request.getParameter("pageEntity.index");
        String pageSize = request.getParameter("pageEntity.size");
        if (pageIndex != null) {
            pageEntity.setIndex(Integer.parseInt(pageIndex));
            pageEntity.setSize(Integer.parseInt(pageSize));
        }

        String provinceId = request.getParameter("provinceid");
        String type = request.getParameter("type");

        DoQuery tempDoQuery = tempDo.getDoQueryByName(qm.split("_")[1]);
//        List<QueryCondition> originList = tempDoQuery.getConditionList();
//
//        QueryCondition condition = new QueryCondition();
//        BeanUtils.copyProperties(condition, originList.get(0));
//        condition.setName("picture_url");
//        condition.setValue("");
//        condition.setOperation("ne");
//
//        tempDoQuery.setConditionList(new ArrayList<QueryCondition>());
//        tempDoQuery.getConditionList().addAll(originList);
//        tempDoQuery.getConditionList().add(condition);

        PageInfo pageInfo = xdoManager.listPage(tempDo, tempDoQuery, null, pageEntity);
        modelMap.put("tabTitle", tempDoQuery.getLabel());
        modelMap.put("pageInfo", pageInfo);
        modelMap.put("pageEntity", pageInfo.getPageEntity());

        if (tempDo.getExecute() != null && !tempDo.getExecute().equals("")) {
            modelMap = xdoSupportManager.execute(tempDo, modelMap, request);
        }
        modelMap.put("qm", qm);
        modelMap.put("group", tempDo.getData());
//        tempDoQuery.setConditionList(originList);
        return pageInfo.getList();

    }


}
