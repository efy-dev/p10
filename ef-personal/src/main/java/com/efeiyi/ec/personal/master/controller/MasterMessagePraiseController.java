package com.efeiyi.ec.personal.master.controller;

import com.ming800.core.base.service.BaseManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by AC丶man on 2015/9/21.
 */
@Controller
@RequestMapping("/masterMessagePraise")
public class MasterMessagePraiseController {

	@Autowired
	BaseManager baseManager;

	@RequestMapping("/changePraiseNum.do")
	public String changePraiseNum(HttpServletRequest request , Model model){
		String messageId = request.getParameter("masterMessageId");

		return null;
	}
}
