package com.efeiyi.ec.personal.master.controller;

import com.efeiyi.ec.master.model.Master;
import com.efeiyi.ec.master.model.MasterFollowed;
import com.efeiyi.ec.master.model.MasterProject;
import com.efeiyi.ec.master.model.MasterWork;
import com.efeiyi.ec.organization.model.AddressProvince;
import com.efeiyi.ec.organization.model.MyUser;
import com.efeiyi.ec.personal.AuthorizationUtil;
import com.efeiyi.ec.personal.ConvertMasterModelUtil;
import com.efeiyi.ec.personal.master.model.MasterModel;
import com.efeiyi.ec.project.model.Project;
import com.efeiyi.ec.project.model.ProjectCategory;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.PageInfo;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.taglib.PageEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

/**
 * Created by AC丶man on 2015/9/25.
 */

@Controller
@RequestMapping("/masterCategory")
public class MasterCategoryController {

    @Autowired
    BaseManager baseManager;


    /**
     * 百科大师分类
     *
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/CategoryList.do")
    public String getCategoryList(HttpServletRequest request, Model model) throws Exception {
        MyUser user = AuthorizationUtil.getMyUser();
        if (user != null && user.getId() != null) {
            XQuery xQuery = new XQuery("listMasterFollow_default", request);
            xQuery.put("user_id", user.getId());
            List<MasterFollowed> list = baseManager.listObject(xQuery);
            if (list != null && list.size() > 0) {
                model.addAttribute("result", "show");
            } else {
                model.addAttribute("result", "hide");
            }
        } else {
            model.addAttribute("result", "hide");
        }
        XQuery xQuery = new XQuery("listMasterProject_default", request);
        List<MasterProject> list = baseManager.listObject(xQuery);
        XQuery xQuery2 = new XQuery("listAddressProvince_asc", request);
        List<AddressProvince> list2 = baseManager.listObject(xQuery2);
        model.addAttribute("categoryList", list);
        model.addAttribute("cityList", list2);
        return "/masterCategory/masterCategory";
    }

    @RequestMapping("/getCityList.do")
    public String getClassifyByCity(HttpServletRequest request, Model model) {
        String provinceId = request.getParameter("cityId");
        String queryHql = "from Master m where m.originProvince.id=:provinceId";
        LinkedHashMap<String, Object> queryMap = new LinkedHashMap<>();
        queryMap.put("provinceId", provinceId);
        List<Master> list = baseManager.listObject(queryHql, queryMap);
        MyUser user = AuthorizationUtil.getMyUser();
        if (list != null && list.size() > 0) {
            for (Master master : list) {
                master.setProjectName(mainMasterProject(master.getMasterProjectList()));
//                getMasterFollowedStatus(master, user);
            }
        }
        model.addAttribute("list", list);
        return "/masterCategory/provinceCategory";
    }

    public String mainMasterProject(List<MasterProject> masterProjects) {

        MasterProject masterProject = null;

        if (masterProjects != null && masterProjects.size() > 0) {

            for (MasterProject masterProjectTemp : masterProjects) {
                if (masterProjectTemp.getStatus().equals("1")) {
                    masterProject = masterProjectTemp;
                }
            }
            if (masterProject == null) {
                masterProject = masterProjects.get(0);
            }

            return masterProject.getProject().getName();
        } else {

            return "";
        }
    }

//    @RequestMapping("/getProjectNameList.do")
//    public String getClassifyByProjectName(HttpServletRequest request, Model model) {
//        String projectId = request.getParameter("projectId");
//        String queryHql = "from MasterProject p where p.project.id=:projectId and p.status = '1'";
//        LinkedHashMap<String, Object> queryMap = new LinkedHashMap<>();
//        queryMap.put("projectId", projectId);
//        List<MasterProject> mpList = baseManager.listObject(queryHql, queryMap);
//        MyUser user = AuthorizationUtil.getMyUser();
//        List<Master> list = new ArrayList<>();
//        if (mpList != null && mpList.size() > 0) {
//            for (MasterProject masterProject : mpList) {
//                getMasterFollowedStatus(masterProject.getMaster(), user);
//                list.add(masterProject.getMaster());
//            }
//        }
//        model.addAttribute("list", list);
//        return "/masterCategory/classifyCategory";
//    }

//    @RequestMapping("/getLevelList.do")
//    public String getClassifyByLevel(HttpServletRequest request, Model model) {
//        String level = request.getParameter("level");
//        String queryHql = "from Master m where m.level=:level and m.status='1'";
//        LinkedHashMap<String, Object> queryMap = new LinkedHashMap<>();
//        queryMap.put("level", level);
//        List<Master> list = baseManager.listObject(queryHql, queryMap);
//        MyUser user = AuthorizationUtil.getMyUser();
//        if (list != null && list.size() > 0) {
//            for (Master master : list) {
//                master.setProjectName(mainMasterProject(master.getMasterProjectList()));
//                getMasterFollowedStatus(master, user);
//            }
//        }
//        model.addAttribute("list", list);
//        return "/masterCategory/levelCategory";
//    }

//    public String getMasterFollowedStatus(Master master, MyUser user) {
//        if (user != null && user.getId() != null) {
//            String queryHql = "from MasterFollowed f where f.master.id=:masterId and f.user.id=:userId and f.status='1'";
//            LinkedHashMap<String, Object> queryMap = new LinkedHashMap<>();
//            queryMap.put("masterId", master.getId());
//            queryMap.put("userId", user.getId());
//            List<MasterFollowed> list = baseManager.listObject(queryHql, queryMap);
//            if (list != null && list.size() > 0) {
//                master.setFollowStatus("已关注");
//            } else {
//                master.setFollowStatus("关注");
//            }
//        } else {
//            master.setFollowStatus("关注");
//        }
//        return master.getFollowStatus();
//    }

    @RequestMapping("/forwardPage")
    public String forwardPage() {
        return "/masterCategory/allMaster";
    }

    @RequestMapping("/allMaster/{qm}/{size}/{index}")
    @ResponseBody
    public List getAllMaster(HttpServletRequest request, @PathVariable String qm, @PathVariable String size, @PathVariable String index) throws Exception {
        XQuery xQuery = new XQuery(qm, request);
        PageEntity entity = new PageEntity();
        if (index != null) {
            entity.setSize(Integer.parseInt(size));
            entity.setIndex(Integer.parseInt(index));
        }
        xQuery.setPageEntity(entity);
        PageInfo pageInfo = baseManager.listPageInfo(xQuery);
        MyUser user = AuthorizationUtil.getMyUser();
        List<Master> list = pageInfo.getList();
        if (list != null && list.size() > 0) {
            for (Master master : list) {
//                getMasterFollowedStatus(master, user);
            }
            return list;
        } else {
            return new ArrayList();
        }
    }

    /******
     * PC start
     ******/

    @ResponseBody
    @RequestMapping("/getClassifyData.do")
    public Set getDataByClassify(HttpServletRequest request) throws Exception {
        String qm = request.getParameter("qm");
//        String pageIndex = request.getParameter("pageEntity.index");
//        String pageSize = request.getParameter("pageEntity.size");
//        PageEntity pageEntity = new PageEntity();
//        if (pageIndex != null) {
//            pageEntity.setIndex(Integer.parseInt(pageIndex));
//            pageEntity.setSize(Integer.parseInt(pageSize));
//        }
        Set<Master> masterSet = new TreeSet<Master>();
        List<Master> setList;
        if ("plistMaster_all".equals(qm)) {
            XQuery xQuery = new XQuery("listProjectCategory_default", request);
            List<ProjectCategory> categoryList = baseManager.listObject(xQuery);
            if (categoryList != null && !categoryList.isEmpty()) {
                for (ProjectCategory category : categoryList) {
                    XQuery xQuery1 = new XQuery("listProject_default", request);
                    xQuery1.put("projectCategory_id", category.getId());
                    List<Project> projects = baseManager.listObject(xQuery1);
                    if (projects != null && !projects.isEmpty()) {
                        setList = putMasterList(request,projects);
                        if (!setList.isEmpty()){
                            for (Master master : setList){
                                masterSet.add(master);
                            }
                        }
                    }
                }
            }
        } else if ("plistMasterProject_default".equals(qm)) {
            String conditions = request.getParameter("conditions");
            String categoryId = conditions.split(":")[1].substring(0, conditions.split(":")[1].length() - 1);
            XQuery xQuery = new XQuery("listProject_default", request);
            xQuery.put("projectCategory_id", categoryId);
            List<Project> projectList = baseManager.listObject(xQuery);
            if (projectList != null && !projectList.isEmpty()) {
                setList = putMasterList(request,projectList);
                masterSet = pushSet(setList);
            }
        } else if ("plistMaster_byLevel".equals(qm)) {
//            String conditions = request.getParameter("conditions");
//            String level = conditions.split(":")[1].substring(0, conditions.split(":")[1].length() - 1);
//            XQuery xQuery = new XQuery(qm, request);
//            xQuery.put("level", level);
//            xQuery.setPageEntity(pageEntity);
//            PageInfo pageInfo = baseManager.listPageInfo(xQuery);
//            List<Master> masters = pageInfo.getList();
//            if (masters != null && masters.size() > 0) {
//                for (Master master : masters) {
//                    master.setProjectName(mainMasterProject(master.getMasterProjectList()));
////                    AddressProvince province = (AddressProvince) baseManager.getObject(AddressProvince.class.getName(),master.getOriginProvince().getId());
////                    master.setCityName(province.getName());
//                    masterSet.add(master);
//                }
//            }
        } else if ("plistMaster_byCity".equals(qm)) {
//            String conditions = request.getParameter("conditions");
//            String cityId = conditions.split(":")[1].substring(0, conditions.split(":")[1].length() - 1);
//            XQuery xQuery = new XQuery(qm, request);
//            xQuery.put("originProvince_id", cityId);
//            xQuery.setPageEntity(pageEntity);
//            PageInfo pageInfo = baseManager.listPageInfo(xQuery);
//            List<Master> masters = pageInfo.getList();
//            if (masters != null && masters.size() > 0) {
//                for (Master master : masters) {
//                    master.setProjectName(mainMasterProject(master.getMasterProjectList()));
////                    AddressProvince province = (AddressProvince) baseManager.getObject(AddressProvince.class.getName(),master.getOriginProvince().getId());
////                    master.setCityName(province.getName());
//                    masterSet.add(master);
//                }
//            }
        }
        return masterSet;
    }

    public Set<Master> pushSet(List<Master> masterList){
        Set<Master> setList = new HashSet<>();
        for (Master master : masterList){
            setList.add(master);
        }
        return setList;
    }

    public List<Master> putMasterList(HttpServletRequest request, List<Project> projects) throws Exception {
        List<Master> masterSet = new ArrayList<>();
        if (projects != null && !projects.isEmpty()) {
            for (Project project : projects) {
                XQuery query = new XQuery("listMasterProject_byProject", request);
                query.put("project_id", project.getId());
                List<MasterProject> masterProjects = baseManager.listObject(query);
                if (masterProjects != null && !masterProjects.isEmpty()) {
                    for (MasterProject masterProject : masterProjects) {
                        Master master = masterProject.getMaster();
                        master.setProjectName(mainMasterProject(master.getMasterProjectList()));
                        if (master.getOriginProvince() != null && master.getOriginProvince().getId() != null){
                            AddressProvince province = (AddressProvince) baseManager.getObject(AddressProvince.class.getName(), master.getOriginProvince().getId());
                            master.setCityName(province.getName());
                        }else{
                            master.setCityName("");
                        }
                        masterSet.add(masterProject.getMaster());
                    }
                }
            }
        }
        return masterSet;
    }


//    public Set<Master> putMaster(HttpServletRequest request, List<Project> projects) throws Exception {
//        Set<Master> masterSet = new HashSet<>();
//        if (projects != null && !projects.isEmpty()) {
//            for (Project project : projects) {
//                XQuery query = new XQuery("listMasterProject_byProject", request);
//                query.put("project_id", project.getId());
//                List<MasterProject> masterProjects = baseManager.listObject(query);
//                if (masterProjects != null && !masterProjects.isEmpty()) {
//                    for (MasterProject masterProject : masterProjects) {
//                        Master master = masterProject.getMaster();
//                        master.setProjectName(mainMasterProject(master.getMasterProjectList()));
//                        if (master.getOriginProvince() != null && master.getOriginProvince().getId() != null){
//                            AddressProvince province = (AddressProvince) baseManager.getObject(AddressProvince.class.getName(), master.getOriginProvince().getId());
//                            master.setCityName(province.getName());
//                        }else{
//                            master.setCityName("");
//                        }
//                        masterSet.add(masterProject.getMaster());
//                    }
//                }
//            }
//        }
//        return masterSet;
//    }

//    public MasterModel convert(Master master) {
//
//        master.setProjectName(mainMasterProject(master.getMasterProjectList()));
//        return masterModel;
//    }
}
