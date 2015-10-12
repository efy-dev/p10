package com.efeiyi.ec.personal.master.controller;

import com.efeiyi.ec.master.model.*;
import com.ming800.core.base.service.BaseManager;
import com.sun.org.apache.xpath.internal.operations.Mod;
import org.hibernate.envers.internal.tools.StringTools;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

/**
 * Created by AC丶man on 2015/10/9.
 */
@Controller
@RequestMapping("/masterBrief")
public class MasterBriefController {

	@Autowired
	private BaseManager baseManager;

	@ResponseBody
	@RequestMapping("/getMasterBrief.do")
	public List getMasterBrief(HttpServletRequest request){
		String masterId = request.getParameter("masterId");
		String type = request.getParameter("type");
		LinkedHashMap<String , Object> queryMap = new LinkedHashMap<>();
		queryMap.put("masterId",masterId);
		queryMap.put("type",type);
		String queryHql = "from MasterIntroduction i where i.master.id=:masterId and i.type=:type";
		List<MasterIntroduction> list = baseManager.listObject(queryHql,queryMap);
		return list;
	}

	@ResponseBody
	@RequestMapping("/getMasterProjectList.do")
	public List getMasterProjectList(HttpServletRequest request){
		String masterId = request.getParameter("masterId");
		String queryHql = "from MasterProject p where p.master.id=:masterId and p.status='1'";
		LinkedHashMap<String , Object> queryMap = new LinkedHashMap<>();
		queryMap.put("masterId",masterId);
		List<MasterProject> list = baseManager.listObject(queryHql,queryMap);
		return list;
	}

	@ResponseBody
	@RequestMapping("/getMasterWorkList.do")
	public List getMasterWorkList(HttpServletRequest request){
		String masterId = request.getParameter("masterId");
		String projectId = request.getParameter("projectId");
		String queryHql;
		LinkedHashMap<String , Object> queryMap = new LinkedHashMap<>();
		queryMap.put("masterId",masterId);
		if (!StringTools.isEmpty(projectId) && !"0".equals(projectId)){
			queryHql = "from MasterWork p where p.master.id=:masterId and p.status='1' and p.project.id=:projectId";
			queryMap.put("projectId",projectId);
		}else{
			queryHql = "from MasterWork p where p.master.id=:masterId and p.status='1'";
		}
		List<MasterWork> list = baseManager.listObject(queryHql,queryMap);
		return list;
	}


	@RequestMapping("/getMasterWork.do")
	public String getMasterWork(HttpServletRequest request , Model model){
		String workId = request.getParameter("workId");
		MasterWork work = (MasterWork) baseManager.getObject(MasterWork.class.getName(),workId);
		model.addAttribute("work",work);
		return "/master";
	}
}
