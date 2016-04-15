package com.efeiyi.ec.wiki.masterWork.controller;

import com.efeiyi.ec.master.model.MasterIntroduction;
import com.efeiyi.ec.master.model.MasterProject;
import com.efeiyi.ec.master.model.MasterWork;
import com.efeiyi.ec.master.model.MasterWorkPraise;
import com.efeiyi.ec.organization.model.MyUser;
import com.efeiyi.ec.organization.model.User;
import com.efeiyi.ec.wiki.masterWork.model.MasterWorkModel;
import com.efeiyi.ec.wiki.masterWork.utils.ConvertWorkModel;
import com.efeiyi.ec.wiki.organization.util.AuthorizationUtil;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import org.hibernate.envers.internal.tools.StringTools;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

/**
 * Created by Administrator on 2016/4/13.
 */
@Controller
public class MasterWorkController {
    @Autowired
    private BaseManager baseManager;

   /*BaseManager @ResponseBody
    @RequestMapping("/getMasterBrief.do")
    public List getMasterBrief(HttpServletRequest request) {
        String masterId = request.getParameter("masterId");
        String type = request.getParameter("type");
        LinkedHashMap<String, Object> queryMap = new LinkedHashMap<>();
        queryMap.put("masterId", masterId);
        queryMap.put("type", type);
        String queryHql = "from MasterIntroduction i where i.master.id=:masterId and i.type=:type";
        List<MasterIntroduction> list = baseManager.listObject(queryHql, queryMap);
        return list;
    }

    @ResponseBody
    @RequestMapping("/getMasterProjectList.do")
    public List getMasterProjectList(HttpServletRequest request) {
        String masterId = request.getParameter("masterId");
        String queryHql = "from MasterProject p where p.master.id=:masterId and p.status='1'";
        LinkedHashMap<String, Object> queryMap = new LinkedHashMap<>();
        queryMap.put("masterId", masterId);
        List<MasterProject> list = baseManager.listObject(queryHql, queryMap);
        return list;
    }

    @ResponseBody
    @RequestMapping("/getMasterWorkList.do")
    public List getMasterWorkList(HttpServletRequest request) {
        String masterId = request.getParameter("masterId");
        String projectId = request.getParameter("projectId");
        String queryHql;
        LinkedHashMap<String, Object> queryMap = new LinkedHashMap<>();
        queryMap.put("masterId", masterId);
        if (!StringTools.isEmpty(projectId) && !"0".equals(projectId)) {
            queryHql = "from MasterWork p where p.master.id=:masterId and p.status='1' and p.project.id=:projectId";
            queryMap.put("projectId", projectId);
        } else {
            queryHql = "from MasterWork p where p.master.id=:masterId and p.status='1'";
        }
        List<MasterWork> list = baseManager.listObject(queryHql, queryMap);
        MyUser user = AuthorizationUtil.getMyUser();
        if (!StringTools.isEmpty(list)) {
            for (MasterWork work : list) {
                if (user != null && user.getId() != null) {
                    work.setPraiseStatus(getPraiseStatus(work, (User) baseManager.getObject(User.class.getName(), user.getId())));
                } else {
                    work.setPraiseStatus("赞");
                }
            }
            return list;
        } else {
            return new ArrayList();
        }
    }
*/
    @RequestMapping("/masterWork/{id}")
    public String getMasterWork(@PathVariable String id, Model model, HttpServletRequest request) throws Exception {
        if (id != null && !"".equals(id)) {
            MasterWork work = (MasterWork) baseManager.getObject(MasterWork.class.getName(), id);
            MasterWorkModel workModel;
            List<MasterWork> workList = null;
            if (work.getProject() != null && work.getProject().getId() != null) {
                XQuery xQuery = new XQuery("listMasterWork_default", request);
                xQuery.put("project_id", work.getProject().getId());
                workList = baseManager.listObject(xQuery);
            }
            workModel = ConvertWorkModel.convertMasterWorkModel(work, workList);
            model.addAttribute("masterWork",work);
            model.addAttribute("work",workModel);
        }
        return "/masterWork/masterWorkView";
    }

   /* public String getPraiseStatus(MasterWork work, User user) {
        String queryHql = "from MasterWorkPraise f where f.work.id=:workId and f.user.id=:userId and f.status='1'";
        LinkedHashMap<String, Object> queryMap = new LinkedHashMap<>();
        queryMap.put("workId", work.getId());
        queryMap.put("userId", user.getId());
        MasterWorkPraise workPraise = (MasterWorkPraise) baseManager.getUniqueObjectByConditions(queryHql, queryMap);
        if (workPraise != null && workPraise.getId() != null) {
            work.setPraiseStatus("取消赞");
        } else {
            work.setPraiseStatus("赞");
        }
        return work.getPraiseStatus();
    }*/
}
