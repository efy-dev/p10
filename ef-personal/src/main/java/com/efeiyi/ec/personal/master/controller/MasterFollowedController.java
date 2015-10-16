package com.efeiyi.ec.personal.master.controller;

import com.efeiyi.ec.master.model.Master;
import com.efeiyi.ec.master.model.MasterFollowed;
import com.efeiyi.ec.master.model.MasterRecommended;
import com.efeiyi.ec.organization.model.MyUser;
import com.efeiyi.ec.personal.AuthorizationUtil;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.p.service.ObjectRecommendedManager;
import org.hibernate.envers.internal.tools.StringTools;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;

/**
 * Created by AC丶man on 2015/9/18.
 */
@Controller
@RequestMapping("/masterFollow")
public class MasterFollowedController {
	private static org.apache.log4j.Logger logger = org.apache.log4j.Logger.getLogger(MasterFollowedController.class);

	@Autowired
	private BaseManager baseManager;
	@Autowired
	private ObjectRecommendedManager recommendedManager;

	@ResponseBody
	@RequestMapping("/followed.do")
	public String followed(HttpServletRequest request , Model model){
		String status = request.getParameter("status");
		String masterId = request.getParameter("masterId");
		Master master = (Master) baseManager.getObject(Master.class.getName(),masterId);
		MyUser myUser = AuthorizationUtil.getMyUser();
		String str = "";
		if("1".equals(status)){
			MasterFollowed followed = new MasterFollowed();
			followed.setMaster(master);
			followed.setUser(myUser);
			followed.setStatus(status);
			followed.setCreateDateTime(new Date());
			baseManager.saveOrUpdate(MasterFollowed.class.getName(), followed);
			str = "2";
		}else if("2".equals(status)){
			LinkedHashMap<String , Object> queryMap = new LinkedHashMap<>();
			String queryHql = "from MasterFollowed m where m.user.id=:userId and m.master.id=:masterId";
			queryMap.put("userId",myUser.getId());
			queryMap.put("masterId",masterId);
			MasterFollowed followed = (MasterFollowed) baseManager.getUniqueObjectByConditions(queryHql, queryMap);
			baseManager.delete(MasterFollowed.class.getName(),followed.getId());
			str = "1";
		}
		return str;
	}

	@ResponseBody
	@RequestMapping("/masterFollowedList.do")
	public List masterFollowedAfterList(HttpServletRequest request , Model model) throws Exception {
		if (AuthorizationUtil.getMyUser().getId() != null){
			XQuery xQuery = new XQuery("plistMasterFollowed_default",request);
			xQuery.put("user_id",AuthorizationUtil.getMyUser().getId());
			List<MasterFollowed> list = baseManager.listObject(xQuery);
			if (list.size() < 5){
				model.addAttribute("isShow","no");
			}else{
				model.addAttribute("isShow","yes");
			}
			return list;
		}else {
			XQuery xQuery = new XQuery("plistMasterRecommended_default",request);
			List<MasterRecommended> list = baseManager.listObject(xQuery);
			model.addAttribute("isShow","no");
			return list;
		}
	}

	@ResponseBody
	@RequestMapping("/masterFollowed.do")
	public boolean getMasterFollowed(HttpServletRequest request,Model model)throws Exception{
		String masterId = request.getParameter("masterId");
		MyUser user = AuthorizationUtil.getMyUser();
		if(user == null){
			return false;
		}else{
			String queryHql = "from MasterFollowed m where m.master.id=:masterId and m.user.id=:userId";
			LinkedHashMap<String , Object> queryMap = new LinkedHashMap<>();
			queryMap.put("masterId",masterId);
			queryMap.put("userId",user.getId());
			List<MasterFollowed> list = baseManager.listObject(queryHql,queryMap);
			if(list != null && list.size() >= 1){
				return true;
			}else{
				return false;
			}
		}
	}


	@ResponseBody
	@RequestMapping("/getMasterRecommendList.do")
	public List getMasterRecommendList()throws Exception{
		List list = recommendedManager.getRecommendedList("masterRecommended");
		return list;
	}

}
