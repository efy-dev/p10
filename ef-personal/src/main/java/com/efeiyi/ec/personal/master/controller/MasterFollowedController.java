package com.efeiyi.ec.personal.master.controller;

import com.efeiyi.ec.master.model.*;
import com.efeiyi.ec.organization.model.MyUser;
import com.efeiyi.ec.organization.model.User;
import com.efeiyi.ec.personal.AuthorizationUtil;
import com.efeiyi.ec.personal.ConvertMasterModelUtil;
import com.efeiyi.ec.personal.master.model.MasterListModel;
import com.efeiyi.ec.personal.master.model.MasterModel;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.p.service.ObjectRecommendedManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
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
	public String followed(HttpServletRequest request) {
		String masterId = request.getParameter("masterId");
		Master master = (Master) baseManager.getObject(Master.class.getName(), masterId);
		MyUser user = AuthorizationUtil.getMyUser();
		if (user == null || user.getId() == null){
			return "noRole";
		}
		LinkedHashMap<String, Object> queryMap = new LinkedHashMap<>();
		String queryHql = "from MasterFollowed m where m.user.id=:userId and m.master.id=:masterId and m.status = '1'";
		queryMap.put("userId", user.getId());
		queryMap.put("masterId", masterId);
		MasterFollowed followed = (MasterFollowed) baseManager.getUniqueObjectByConditions(queryHql, queryMap);
		if (followed != null){
			baseManager.delete(MasterFollowed.class.getName(), followed.getId());
			master.setFsAmount(master.getFsAmount()==null?0:master.getFsAmount() - 1);
			baseManager.saveOrUpdate(Master.class.getName(),master);
			return "del";
		}else{
			MasterFollowed follow = new MasterFollowed();
			follow.setMaster(master);
			follow.setUser((User)baseManager.getObject(User.class.getName(),user.getId()));
			follow.setStatus("1");
			follow.setCreateDateTime(new Date());
			baseManager.saveOrUpdate(MasterFollowed.class.getName(), follow);
			master.setFsAmount(master.getFsAmount() == null?1:master.getFsAmount() + 1);
			baseManager.saveOrUpdate(Master.class.getName(),master);
			return "add";
		}
	}

	@ResponseBody
	@RequestMapping("/masterFollowedList.do")
	public Object masterFollowedAfterList(HttpServletRequest request) throws Exception {
		MasterListModel masterListModel = new MasterListModel();
		MyUser user = AuthorizationUtil.getMyUser();
		List<MasterModel> models = new ArrayList<>();
		List<MasterModel> msgLists = new ArrayList<>();
		if (user.getId() != null) {
			XQuery xQuery = new XQuery("listMasterFollow_byUser", request);
			xQuery.put("user_id", user.getId());
			List<MasterFollowed> list = baseManager.listObject(xQuery);
			if (list != null && list.size() < 5){
				for (MasterFollowed followed : list){
					XQuery query = new XQuery("listMasterMessage_default",request);
					query.put("master_id",followed.getMaster().getId());
					List<MasterMessage> msgList = baseManager.listObject(query);
					if (msgList != null && msgList.size() > 0){
						msgList.get(0).setFollowStatus("已关注");
						msgList.get(0).setStoreStatus(getStorePraiseStatus(msgList.get(0),(User)baseManager.getObject(User.class.getName(),user.getId())));
						MasterModel msg = ConvertMasterModelUtil.convertMasterModel(msgList.get(0));
						msgLists.add(msg);
					}
				}
				List<MasterRecommended> recommendList = getMasterRecommendList(request);
				if (recommendList != null && recommendList.size() > 0){
					for (MasterRecommended recommended : recommendList){
						Master master = (Master) baseManager.getObject(Master.class.getName(),recommended.getMaster().getId());
						master.setFollowStatus(getFollowStatus(master,(User)baseManager.getObject(User.class.getName(),user.getId())));
						MasterModel masterModel = ConvertMasterModelUtil.convertMaster(master);
						models.add(masterModel);
					}
				}
				masterListModel.setMrModelList(models);
				masterListModel.setMsgModelList(msgLists);
			}else{
				List<MasterModel> modelList = getMessageList(request,list,user);
				masterListModel.setMsgModelList(modelList);
			}
			return masterListModel;
		} else {
			List<MasterRecommended> list = getMasterRecommendList(request);
			if (list != null && list.size() > 0){
				for (MasterRecommended recommended : list){
					Master master = (Master) baseManager.getObject(Master.class.getName(),recommended.getMaster().getId());
					master.setFollowStatus("关注");
					MasterModel masterModel = ConvertMasterModelUtil.convertMaster(master);
					models.add(masterModel);
				}
				masterListModel.setMrModelList(models);
			}
			return masterListModel;
		}
	}

	public String getStorePraiseStatus(MasterMessage message, User user){
		String queryHql = "from MasterMessageStore p where p.masterMessage.id=:messageId and p.user.id=:userId";
		LinkedHashMap<String, Object> queryMap = new LinkedHashMap<>();
		queryMap.put("messageId", message.getId());
		queryMap.put("userId", user.getId());
		List<MasterMessageStore> list = baseManager.listObject(queryHql, queryMap);
		if (list != null && list.size() > 0) {
			message.setStoreStatus("已收藏");
		} else {
			message.setStoreStatus("收藏");
		}
		return message.getStoreStatus();
	}

	public String getFollowStatus(Master master , User user){
		if (user != null && user.getId() != null){
			String queryHql = "from MasterFollowed f where f.master.id=:masterId and f.user.id=:userId";
			LinkedHashMap<String,Object> queryMap = new LinkedHashMap<>();
			queryMap.put("masterId",master.getId());
			queryMap.put("userId",user.getId());
			MasterFollowed followed = (MasterFollowed) baseManager.getUniqueObjectByConditions(queryHql,queryMap);
			if (followed != null){
				master.setFollowStatus("已关注");
			}else{
				master.setFollowStatus("关注");
			}
		}else{
			master.setFollowStatus("关注");
		}
		return master.getFollowStatus();
	}

	public List getMessageList(HttpServletRequest request ,List<MasterFollowed> followeds,MyUser user)throws Exception{
		List<MasterModel> models = new ArrayList<>();
		for (MasterFollowed followed : followeds){
			XQuery query = new XQuery("listMasterMessage_default",request);
			query.put("master_id",followed.getMaster().getId());
			List<MasterMessage> msgList = baseManager.listObject(query);
			if (msgList != null && msgList.size() > 0){
				msgList.get(0).setFollowStatus("已关注");
				msgList.get(0).setStoreStatus(getStorePraiseStatus(msgList.get(0),(User)baseManager.getObject(User.class.getName(),user.getId())));
				MasterModel msg = ConvertMasterModelUtil.convertMasterModel(msgList.get(0));
				models.add(msg);
			}
		}
		return models;
	}

	public List getMasterRecommendList(HttpServletRequest request)throws Exception{
		XQuery xQuery = new XQuery("plistMasterRecommended_byMaster", request);
		List<MasterRecommended> list = baseManager.listObject(xQuery);
		return list;
	}

	@ResponseBody
	@RequestMapping("/masterFollowed.do")
	public boolean getMasterFollowed(HttpServletRequest request, Model model) throws Exception {
		String masterId = request.getParameter("masterId");
		MyUser user = AuthorizationUtil.getMyUser();
		if (user == null || user.getId() == null) {
			return false;
		} else {
			String queryHql = "from MasterFollowed m where m.master.id=:masterId and m.user.id=:userId and m.status = '1'";
			LinkedHashMap<String, Object> queryMap = new LinkedHashMap<>();
			queryMap.put("masterId", masterId);
			queryMap.put("userId", user.getId());
			List<MasterFollowed> list = baseManager.listObject(queryHql, queryMap);
			if (list != null && list.size() >= 1) {
				return true;
			} else {
				return false;
			}
		}
	}

	@ResponseBody
	@RequestMapping("/getMasterRecommendList.do")
	public List getMasterRecommendList() throws Exception {
		List list = recommendedManager.getRecommendedList("masterRecommended");
		return list;
	}

}
