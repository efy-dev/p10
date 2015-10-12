package com.efeiyi.ec.personal.master.controller;

import com.efeiyi.ec.master.model.*;
import com.efeiyi.ec.organization.model.MyUser;
import com.efeiyi.ec.personal.AuthorizationUtil;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import org.hibernate.envers.internal.tools.StringTools;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.List;

/**
 * Created by AC丶man on 2015/9/21.
 */

@Controller
@RequestMapping("/masterMessage")
public class MasterMessageController {

	@Autowired
	private BaseManager baseManager;

	@RequestMapping("/index.do")
	public String mainPage(){
		return "/masterMessage/index";
	}

	@RequestMapping("/forwardIndex.do")
	public String indexPage(){
		return "/masterMessage/masterMessageList";
	}

	@ResponseBody
	@RequestMapping("/masterMessageList.do")
	public List MasterMessageList(HttpServletRequest request) throws Exception {
		XQuery xQuery = new XQuery("plistMasterMessage_default",request);
		MyUser user = AuthorizationUtil.getMyUser();
		List<MasterMessage> messageList = baseManager.listObject(xQuery);
		for (MasterMessage message : messageList){
			getPraiseStatus(message,user);
			message.setMasterId(message.getMaster().getId());
			message.setMasterName(message.getMaster().getFullName());
		}
		return messageList;
	}

	@RequestMapping("/getOnlyMasterMessageList.do")
	public String getMaster(HttpServletRequest request,Model model){
		String masterId = request.getParameter("masterId");
		String queryHql = "from MasterMessage m where m.master.id=:masterId";
		LinkedHashMap<String,Object> queryMap = new LinkedHashMap<>();
		queryMap.put("masterId",masterId);
		List<MasterMessage> list = baseManager.listObject(queryHql,queryMap);
		Master master = (Master) baseManager.getObject(Master.class.getName(),masterId);
		model.addAttribute("objectList",list);
		model.addAttribute("object",master);
		return "/masterMessage/masterMessageListView";
	}

	@RequestMapping("/getMasterMessage.do")
	public String getMasterMessage(HttpServletRequest request,Model model){
		String messageId = request.getParameter("messageId");
		if (!StringTools.isEmpty(messageId)){
			MasterMessage message = (MasterMessage) baseManager.getObject(MasterMessage.class.getName(),messageId);
			getMasterFollowedStatus(message.getMaster());
			model.addAttribute("object",message);
		}
		return "/masterMessage/masterMessageView";
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


	public String getPraiseStatus(MasterMessage message , MyUser user){
		String queryHql = "from MasterMessagePraise p where p.message.id=:messageId and p.user.id=:userId";
		LinkedHashMap<String , Object> queryMap = new LinkedHashMap<>();
		queryMap.put("messageId",message.getId());
		queryMap.put("userId",user.getId());
		List<MasterMessagePraise> list = baseManager.listObject(queryHql,queryMap);
		if (list != null && list.size() > 0){
			message.setPraiseStatus("取消赞");
		}else{
			message.setPraiseStatus("赞");
		}
		return message.getPraiseStatus();
	}

	@ResponseBody
	@RequestMapping("/collected.do")
	public boolean collected(HttpServletRequest request){
		String messageId = request.getParameter("messageId");
		MyUser user = AuthorizationUtil.getMyUser();
		String queryHql = "from MasterMessageStore s where s.masterMessage.id=:messageId and s.user.id=:userId";
		LinkedHashMap<String , Object> queryMap = new LinkedHashMap<>();
		queryMap.put("messageId",messageId);
		queryMap.put("userId",user.getId());
		List<MasterMessageStore> list = baseManager.listObject(queryHql,queryMap);
		if (list == null || list.size() <= 0){
			MasterMessage message = (MasterMessage) baseManager.getObject(MasterMessage.class.getName(),messageId);
			MasterMessageStore store = new MasterMessageStore();
			store.setUser(user);
			store.setMasterMessage(message);
			baseManager.saveOrUpdate(MasterMessageStore.class.getName(),store);
			return true;
		}else {
			MasterMessageStore store = list.get(0);
			baseManager.delete(MasterMessageStore.class.getName(),store.getId());
			return false;
		}
	}


	@RequestMapping("/forwardMasterDetails.do")
	public String forwardDetails(HttpServletRequest request, Model model) {
		String masterId = request.getParameter("masterId");
		Master master = (Master) baseManager.getObject(Master.class.getName(),masterId);
		model.addAttribute("object",master);
		return "/masterMessage/masterMessageDetails";
	}

	@ResponseBody
	@RequestMapping("/getMasterDetails.do")
	public List getMasterDetails(HttpServletRequest request){
		String masterId = request.getParameter("masterId");
		Master master = (Master) baseManager.getObject(Master.class.getName(),masterId);
		master.setProjectName(mainMasterProject(master.getMasterProjectList()));
		String queryHql = "from MasterMessage m where m.master.id=:masterId";
		LinkedHashMap<String,Object> queryMap = new LinkedHashMap<>();
		queryMap.put("masterId",master.getId());
		List<MasterMessage> list = baseManager.listObject(queryHql,queryMap);
		MyUser user = AuthorizationUtil.getMyUser();
		if (list != null && list.size() > 0){
			for (MasterMessage message : list){
				String queryHql1 = "from MasterMessagePraise m where m.message.id=:messageId and m.user.id=:userId";
				LinkedHashMap<String,Object> queryMap1 = new LinkedHashMap<>();
				queryMap1.put("messageId",message.getId());
				queryMap1.put("userId",user.getId());
				List<MasterMessage> praiseList = baseManager.listObject(queryHql1,queryMap1);
				if (praiseList != null && praiseList.size() > 0){
					message.setPraiseStatus("取消赞");
				}else{
					message.setPraiseStatus("赞");
				}
			}
		}
		return list;
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
}
