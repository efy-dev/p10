package com.efeiyi.ec.personal.master.controller;

import com.efeiyi.ec.master.model.MasterMessage;
import com.efeiyi.ec.master.model.MasterMessagePraise;
import com.efeiyi.ec.organization.model.MyUser;
import com.efeiyi.ec.personal.AuthorizationUtil;
import com.ming800.core.base.service.BaseManager;
import org.springframework.beans.factory.annotation.Autowired;
import com.efeiyi.ec.organization.model.User;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.LinkedHashMap;
import java.util.List;

/**
 * Created by AC丶man on 2015/9/21.
 */
@Controller
@RequestMapping("/masterMessagePraise")
public class MasterMessagePraiseController {

	@Autowired
	BaseManager baseManager;

	@ResponseBody
	@RequestMapping("/changePraiseNum.do")
	public String changePraiseNum(HttpServletRequest request) {
		String messageId = request.getParameter("messageId");
		MyUser user = AuthorizationUtil.getMyUser();
		if (user == null || user.getId() == null) {
			return "noRole";
		}
		LinkedHashMap<String, Object> queryMap = new LinkedHashMap<>();
		String queryHql = "from MasterMessagePraise m where m.user.id=:userId and m.message.id=:messageId";
		queryMap.put("userId", user.getId());
		queryMap.put("messageId", messageId);
		List<MasterMessagePraise> list = baseManager.listObject(queryHql, queryMap);
		if (list != null && list.size() > 0) {
			MasterMessagePraise praise = list.get(0);
			MasterMessage message = praise.getMessage();
			message.setPraiseStatus("赞");
			baseManager.delete(MasterMessagePraise.class.getName(), praise.getId());
			message.setPraiseNum(message.getPraiseNum() == null ? 0 : message.getPraiseNum() - 1);
			baseManager.saveOrUpdate(MasterMessage.class.getName(), message);
			return "del";
		} else {
			MasterMessagePraise praise = new MasterMessagePraise();
			MasterMessage message = (MasterMessage) baseManager.getObject(MasterMessage.class.getName(), messageId);
			praise.setUser((User)baseManager.getObject(User.class.getName(),user.getId()));
			praise.setMessage(message);
			message.setPraiseStatus("取消赞");
			baseManager.saveOrUpdate(MasterMessagePraise.class.getName(), praise);
			message.setPraiseNum(message.getPraiseNum() == null ? 1 : message.getPraiseNum() + 1);
			baseManager.saveOrUpdate(MasterMessage.class.getName(), message);
			return "add";
		}
	}
}
