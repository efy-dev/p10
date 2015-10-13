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

    /**
     * 直接转入非遗名录子的项目页面
     * @param modelMap
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping("/project.do")
    public ModelAndView getProject(ModelMap modelMap, HttpServletRequest request) throws Exception {

        modelMap.addAttribute("provinceid", request.getParameter("provinceid"));
        modelMap.addAttribute("type", request.getParameter("type"));
        return new ModelAndView("/heritageProject/project");
    }

    /**
     *转入非遗名录的传承人页面
     * @param modelMap
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping("/project.master.do")
    public ModelAndView getMasterProject(ModelMap modelMap, HttpServletRequest request) throws Exception {

        modelMap.addAttribute("provinceid", request.getParameter("provinceid"));
        modelMap.addAttribute("type", request.getParameter("type"));
        return new ModelAndView("/heritageProject/project.master");
    }

    /**
     * 非遗名录项目页面下的技艺类型子页面
     * @param modelMap
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping("/project.type.do")
    public Set<String> getProjectType(ModelMap modelMap, HttpServletRequest request) throws Exception {
        String qm = request.getParameter("qm");

        //先找到配置文件里的entity
        Do tempDo = doManager.getDoByQueryModel(qm.split("_")[0]);
        //再从中找到query的信息
        DoQuery tempDoQuery = tempDo.getDoQueryByName(qm.split("_")[1]);

        List<Project> list = (List<Project>) xdoManager.list(tempDo, tempDoQuery, null);

        modelMap.addAttribute("provinceid", request.getParameter("provinceid"));
        modelMap.addAttribute("type", request.getParameter("type"));

        //因group by配置无效，自己去重
        Set<String> typeSet = new TreeSet<String>();
        for(Project project : list){
            typeSet.add(project.getType() == null ? "-1" : project.getType());
        }
        return typeSet;
    }

    /**
     * 非遗名录传承人页面下的技艺类型子页面
     * @param modelMap
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping("/project.master.type.do")
    public Set<String> getMasterProjectType(ModelMap modelMap, HttpServletRequest request) throws Exception {

        String qm = request.getParameter("qm");

        //先找到配置文件里的entity
        Do tempDo = doManager.getDoByQueryModel(qm.split("_")[0]);
        //再从中找到query的信息
        DoQuery tempDoQuery = tempDo.getDoQueryByName(qm.split("_")[1]);

        List<MasterProject> list = (List<MasterProject>) xdoManager.list(tempDo, tempDoQuery, null);

        //因group by配置无效，自己去重
        Set<String> typeSet = new TreeSet<String>();
        for(MasterProject masterProject : list){
            try {
                typeSet.add(masterProject.getProject().getType() == null ? "-1" : masterProject.getProject().getType());
            } catch (NullPointerException e) {
                continue;
            }
        }

        modelMap.addAttribute("provinceid", request.getParameter("provinceid"));
        modelMap.addAttribute("type", request.getParameter("type"));

        return typeSet;
    }

    /**
     * 非遗名录项目页面和传承人也面的地区子页面
     * @param modelMap
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping({"/provinceList.do"})
    public List<Object> getProvinceList(ModelMap modelMap, HttpServletRequest request) throws Exception {
        XQuery xQuery = new XQuery("listAddressProvince_default", request);
        List<Object> list = baseManager.listObject(xQuery);

        modelMap.addAttribute("provinceid", request.getParameter("provinceid"));
        modelMap.addAttribute("type", request.getParameter("type"));
        return list;
    }

    /**
     * 非遗名录的项目页面和传承人页面的查询结果列表子页面
     * @param request
     * @param modelMap
     * @return
     * @throws Exception
     */
    @RequestMapping({"/projectMaster.List.do", "/project.List.do","/project.home.list.do"})
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

        //根据页面选择，动态加入新查询condition
        //首先记录原condition，查询结束时替换回原condition
        List<QueryCondition> originList = tempDoQuery.getConditionList();

        //技艺类型condition
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

        //记录更新后的condition
        List<QueryCondition> firstList = tempDoQuery.getConditionList();

        //地区condition
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

        //替换回有原condition
        tempDoQuery.setConditionList(originList);
        return pageInfo.getList();

    }
}
