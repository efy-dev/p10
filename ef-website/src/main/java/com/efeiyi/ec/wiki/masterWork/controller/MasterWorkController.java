package com.efeiyi.ec.wiki.masterWork.controller;

import com.efeiyi.ec.master.model.MasterWork;
import com.efeiyi.ec.project.model.Project;
import com.efeiyi.ec.wiki.masterWork.model.MasterWorkModel;
import com.efeiyi.ec.wiki.masterWork.utils.ConvertWorkModel;
import com.efeiyi.ec.wiki.model.Artistry;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by Administrator on 2016/4/13.
 */
@Controller
@RequestMapping({"minglu"})
public class MasterWorkController {
    @Autowired
    private BaseManager baseManager;

    @RequestMapping("/masterWork/{id}")
    public String getMasterWork(@PathVariable String id, Model model, HttpServletRequest request) throws Exception {
        if (id != null && !"".equals(id)) {
            MasterWork work = (MasterWork) baseManager.getObject(MasterWork.class.getName(), id);
            Project project = work.getProject();
            Artistry projectWiki = project.getArtistry();
            MasterWorkModel workModel;
            List<MasterWork> workList = null;
            if (work.getProject() != null && work.getProject().getId() != null) {
                XQuery xQuery = new XQuery("listMasterWork_default", request);
                xQuery.put("project_id", work.getProject().getId());
                workList = baseManager.listObject(xQuery);
            }
            workModel = ConvertWorkModel.convertMasterWorkModel(work, workList);
            model.addAttribute("masterWork",work);
            model.addAttribute("projectWiki",projectWiki);
            model.addAttribute("work",workModel);
        }
        return "/masterWork/masterWorkView";
    }

}
