package com.efeiyi.ec.personal.master.controller;

import com.efeiyi.ec.master.model.Master;
import com.efeiyi.ec.master.model.MasterMessage;
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
		List<MasterMessage> messageList = baseManager.listObject(xQuery);
		for (MasterMessage message : messageList){
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
			model.addAttribute("object",message);
		}
		return "/masterMessage/masterMessageView";
	}


}
