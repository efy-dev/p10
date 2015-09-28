package com.efeiyi.ec.personal.master.controller;

import com.efeiyi.ec.master.model.MasterComment;
import com.efeiyi.ec.master.model.MasterMessage;
import com.efeiyi.ec.organization.model.Consumer;
import com.efeiyi.ec.organization.model.MyUser;
import com.efeiyi.ec.personal.AuthorizationUtil;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import org.hibernate.envers.internal.tools.StringTools;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
/**
 * Created by AC丶man on 2015/9/21.
 */
@Controller
@RequestMapping("/masterComment")
public class MasterCommentController {

	@Autowired
	BaseManager baseManager;

	@RequestMapping("/forward.do")
	public String forward(HttpServletRequest request , Model model){
		String masterMessageId = request.getParameter("masterMessageId");
		model.addAttribute("masterMessageId",masterMessageId);
		return "/masterComment/masterCommentView";
	}

	@RequestMapping("/commentList.do")
	public String commentList(HttpServletRequest request , Model model) throws Exception {
		String masterId = request.getParameter("masterId");
		XQuery xQuery = new XQuery("listMasterComment_default",request);
		xQuery.put("master_id",masterId);
		List<MasterComment> list = baseManager.listObject(xQuery);
		model.addAttribute("commentList",list);
		return "/masterComment/masterCommentList";
	}

	@RequestMapping("/comment.do")
	public String comment(HttpServletRequest request){
		String masterMessageId = request.getParameter("masterMessageId");
		String content = request.getParameter("content");
		MasterComment comment = new MasterComment();
		comment.setContent(content);
		MasterMessage message = (MasterMessage) baseManager.getObject(MasterMessage.class.getName(),masterMessageId);
		MyUser myUser = AuthorizationUtil.getMyUser();
		comment.setMasterMessage(message);
		comment.setUser(myUser);
		baseManager.saveOrUpdate(MasterComment.class.getName(),comment);
		return "redirect:/masterComment/commentList.do";
	}

}
