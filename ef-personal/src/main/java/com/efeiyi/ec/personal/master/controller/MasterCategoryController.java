package com.efeiyi.ec.personal.master.controller;

import com.efeiyi.ec.master.model.Master;
import com.efeiyi.ec.master.model.MasterFollowed;
import com.efeiyi.ec.master.model.MasterProject;
import com.efeiyi.ec.organization.model.AddressProvince;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

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
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/CategoryList.do")
	public String getCategoryList(HttpServletRequest request , Model model)throws Exception{
		XQuery xQuery = new XQuery("listMasterProject_default",request);
		List<MasterProject> list = baseManager.listObject(xQuery);
		XQuery xQuery2 = new XQuery("listAddressProvince_default",request);
		List<AddressProvince> list2 = baseManager.listObject(xQuery2);
		model.addAttribute("categoryList",list);
		model.addAttribute("cityList",list2);
		return "/masterCategory/masterCategory";
	}


	@RequestMapping("/getCityList.do")
	public String getClassifyByCity(HttpServletRequest request , Model model){
		String provinceId = request.getParameter("cityId");
		String queryHql = "from Master m where m.originProvince.id=:provinceId";
		LinkedHashMap<String , Object> queryMap = new LinkedHashMap<>();
		queryMap.put("provinceId",provinceId);
		List<Master> list = baseManager.listObject(queryHql,queryMap);
		if (list != null && list.size() > 0){
			for (Master master : list){
				master.setProjectName(mainMasterProject(master.getMasterProjectList()));
				getMasterFollowedStatus(master);
			}
		}
		model.addAttribute("list",list);
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


	@RequestMapping("/getProjectNameList.do")
	public String getClassifyByProjectName(HttpServletRequest request , Model model){
		String projectId = request.getParameter("projectId");
		String queryHql = "from MasterProject p where p.project.id=:projectId";
		LinkedHashMap<String,Object> queryMap = new LinkedHashMap<>();
		queryMap.put("projectId",projectId);
		List<MasterProject> mpList = baseManager.listObject(queryHql,queryMap);
		List<Master> list = new ArrayList<>();
		if (mpList != null && mpList.size() > 0){
			for (MasterProject masterProject : mpList){
				getMasterFollowedStatus(masterProject.getMaster());
				list.add(masterProject.getMaster());
			}
		}
		model.addAttribute("list",list);
		return "/masterCategory/classifyCategory";
	}


	@RequestMapping("/getLevelList.do")
	public String getClassifyByLevel(HttpServletRequest request , Model model){
		String level = request.getParameter("level");
		String queryHql = "from Master m where m.level=:level and m.status='1'";
		LinkedHashMap<String,Object> queryMap = new LinkedHashMap<>();
		queryMap.put("level",level);
		List<Master> list = baseManager.listObject(queryHql,queryMap);
		if (list != null && list.size() > 0){
			for (Master master : list){
				master.setProjectName(mainMasterProject(master.getMasterProjectList()));
				getMasterFollowedStatus(master);
			}
		}
		model.addAttribute("list",list);
		return "/masterCategory/levelCategory";
	}


	public String getMasterFollowedStatus(Master master){
		String queryHql = "from MasterFollowed f where f.master.id=:masterId and f.status=1";
		LinkedHashMap<String,Object> queryMap = new LinkedHashMap<>();
		queryMap.put("masterId",master.getId());
		List<MasterFollowed> list = baseManager.listObject(queryHql,queryMap);
		if (list != null && list.size() > 0){
			master.setFollowStatus("已关注");
		}else{
			master.setFollowStatus("关注");
		}
		return master.getFollowStatus();
	}

}
