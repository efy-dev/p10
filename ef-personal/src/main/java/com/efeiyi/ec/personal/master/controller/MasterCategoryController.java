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
		MyUser user = AuthorizationUtil.getMyUser();
		if (user != null && user.getId() != null){
			XQuery xQuery = new XQuery("listMasterFollow_default",request);
			xQuery.put("user_id",user.getId());
			List<MasterFollowed> list = baseManager.listObject(xQuery);
			if (list != null && list.size() > 0){
				model.addAttribute("result","show");
			}else{
				model.addAttribute("result","hide");
			}
		}else{
			model.addAttribute("result","hide");
		}
		XQuery xQuery = new XQuery("listMasterProject_default",request);
		List<MasterProject> list = baseManager.listObject(xQuery);
		XQuery xQuery2 = new XQuery("listAddressProvince_asc",request);
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
		MyUser user = AuthorizationUtil.getMyUser();
		if (list != null && list.size() > 0){
			for (Master master : list){
				master.setProjectName(mainMasterProject(master.getMasterProjectList()));
				getMasterFollowedStatus(master,user);
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
		String queryHql = "from MasterProject p where p.project.id=:projectId and p.status = '1'";
		LinkedHashMap<String,Object> queryMap = new LinkedHashMap<>();
		queryMap.put("projectId",projectId);
		List<MasterProject> mpList = baseManager.listObject(queryHql,queryMap);
		MyUser user = AuthorizationUtil.getMyUser();
		List<Master> list = new ArrayList<>();
		if (mpList != null && mpList.size() > 0){
			for (MasterProject masterProject : mpList){
				getMasterFollowedStatus(masterProject.getMaster(),user);
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
		MyUser user = AuthorizationUtil.getMyUser();
		if (list != null && list.size() > 0){
			for (Master master : list){
				master.setProjectName(mainMasterProject(master.getMasterProjectList()));
				getMasterFollowedStatus(master,user);
			}
		}
		model.addAttribute("list",list);
		return "/masterCategory/levelCategory";
	}

	public String getMasterFollowedStatus(Master master , MyUser user){
		if (user != null && user.getId() != null){
			String queryHql = "from MasterFollowed f where f.master.id=:masterId and f.user.id=:userId and f.status='1'";
			LinkedHashMap<String,Object> queryMap = new LinkedHashMap<>();
			queryMap.put("masterId",master.getId());
			queryMap.put("userId",user.getId());
			List<MasterFollowed> list = baseManager.listObject(queryHql,queryMap);
			if (list != null && list.size() > 0){
				master.setFollowStatus("已关注");
			}else{
				master.setFollowStatus("关注");
			}
		}else{
			master.setFollowStatus("关注");
		}
		return master.getFollowStatus();
	}

	@RequestMapping("/forwardPage")
	public String forwardPage(){
		return "/masterCategory/allMaster";
	}

	@RequestMapping("/allMaster/{qm}/{size}/{index}")
	@ResponseBody
	public List getAllMaster(HttpServletRequest request ,@PathVariable String qm , @PathVariable String size , @PathVariable String index) throws Exception {
		XQuery xQuery = new XQuery(qm,request);
		PageEntity entity = new PageEntity();
		if (index != null){
			entity.setSize(Integer.parseInt(size));
			entity.setIndex(Integer.parseInt(index));
		}
		xQuery.setPageEntity(entity);
		PageInfo pageInfo = baseManager.listPageInfo(xQuery);
		MyUser user = AuthorizationUtil.getMyUser();
		List<Master> list = pageInfo.getList();
		if (list != null && list.size() > 0){
			for (Master master : list){
				getMasterFollowedStatus(master , user);
			}
			return list;
		}else{
			return new ArrayList();
		}
	}

	/******PC start******/

	@ResponseBody
	@RequestMapping("/getClassifyData.do")
	public List getDataByClassify(HttpServletRequest request)throws Exception{
		String qm = request.getParameter("qm");
		MyUser user = AuthorizationUtil.getMyUser();
		List<MasterModel> list = new ArrayList<>();
		if ("plistMaster_all".equals(qm)){
			XQuery query = new XQuery(qm,request);
			PageEntity pageEntity = new PageEntity();
			String pageIndex = request.getParameter("pageEntity.index");
			String pageSize = request.getParameter("pageEntity.size");
			if (pageIndex != null) {
				pageEntity.setIndex(Integer.parseInt(pageIndex));
				pageEntity.setSize(Integer.parseInt(pageSize));
			}
			query.setPageEntity(pageEntity);
			PageInfo pageInfo = baseManager.listPageInfo(query);
//			List<MasterModel> list = new ArrayList<>();
			List<Master> masters = pageInfo.getList();
			if (masters != null && masters.size() > 0){
				for (Master master : masters){
					MasterModel masterModel = convert(master,user);
					list.add(masterModel);
				}
			}
			return list;
		}else if("plistMasterProject_default".equals(qm)){
			String conditions = request.getParameter("conditions");
			String projectId = conditions.split(":")[1].substring(0,conditions.split(":")[1].length() - 1);
			XQuery xQuery = new XQuery(qm,request);
			xQuery.put("project_id",projectId);
			PageEntity entity = new PageEntity();
			String pageIndex = request.getParameter("pageEntity.index");
			String pageSize = request.getParameter("pageEntity.size");
			if (pageIndex != null) {
				entity.setIndex(Integer.parseInt(pageIndex));
				entity.setSize(Integer.parseInt(pageSize));
			}
			xQuery.setPageEntity(entity);
			PageInfo pageInfo = baseManager.listPageInfo(xQuery);
			List<MasterProject> masterProjects = pageInfo.getList();
			if (masterProjects != null && masterProjects.size() > 0){
				for (MasterProject masterProject : masterProjects){
					MasterModel masterModel = convert(masterProject.getMaster(),user);
					list.add(masterModel);
				}
			}
			return list;
		}else if("plistMaster_byLevel".equals(qm)){
			String conditions = request.getParameter("conditions");
			String level = conditions.split(":")[1].substring(0,conditions.split(":")[1].length() - 1);
			XQuery xQuery = new XQuery(qm,request);
			xQuery.put("level",level);
			PageEntity pageEntity = new PageEntity();
			String pageIndex = request.getParameter("pageEntity.index");
			String pageSize = request.getParameter("pageEntity.size");
			if (pageIndex != null) {
				pageEntity.setIndex(Integer.parseInt(pageIndex));
				pageEntity.setSize(Integer.parseInt(pageSize));
			}
			xQuery.setPageEntity(pageEntity);
			PageInfo pageInfo = baseManager.listPageInfo(xQuery);
			List<Master> masters = pageInfo.getList();
//			List<MasterModel> list = new ArrayList<>();
			if (masters != null && masters.size() > 0){
				for (Master master : masters){
					MasterModel masterModel = convert(master,user);
					list.add(masterModel);
				}
			}
			return list;
		}else if("plistMaster_byCity".equals(qm)){
			String conditions = request.getParameter("conditions");
			String cityId = conditions.split(":")[1].substring(0,conditions.split(":")[1].length() - 1);
			XQuery xQuery = new XQuery(qm,request);
			xQuery.put("originProvince_id",cityId);
			PageEntity pageEntity = new PageEntity();
			String pageIndex = request.getParameter("pageEntity.index");
			String pageSize = request.getParameter("pageEntity.size");
			if (pageIndex != null) {
				pageEntity.setIndex(Integer.parseInt(pageIndex));
				pageEntity.setSize(Integer.parseInt(pageSize));
			}
			xQuery.setPageEntity(pageEntity);
			PageInfo pageInfo = baseManager.listPageInfo(xQuery);
			List<Master> masters = pageInfo.getList();
//			List<MasterModel> list = new ArrayList<>();
			if (masters != null && masters.size() > 0){
				for (Master master : masters){
					MasterModel masterModel = convert(master,user);
					list.add(masterModel);
				}
			}
			return list;
		}
		return list;
	}

	public MasterModel convert(Master master , MyUser user){
		String querySql = "from MasterWork w where w.master.id=:masterId and w.status='1'";
		LinkedHashMap<String,Object> map = new LinkedHashMap<>();
		map.put("masterId", master.getId());
		List<MasterWork> works = baseManager.listObject(querySql,map);
		if (user != null && user.getId() != null){
			String querySql1 = "from MasterFollowed f where f.master.id=:masterId and f.user.id=:userId and f.status = '1'";
			LinkedHashMap<String,Object> map1 = new LinkedHashMap<>();
			map1.put("masterId",master.getId());
			map1.put("userId",user.getId());
			MasterFollowed followed = (MasterFollowed) baseManager.getUniqueObjectByConditions(querySql1,map1);
			if (followed != null){
				master.setFollowStatus("已关注");
			}else{
				master.setFollowStatus("关注");
			}
		}else{
			master.setFollowStatus("关注");
		}
		master.setProjectName(mainMasterProject(master.getMasterProjectList()));
		MasterModel masterModel = ConvertMasterModelUtil.convertMasterWork(master,works);
		return masterModel;
	}
}
