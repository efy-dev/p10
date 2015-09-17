package com.efeiyi.ec.system.master.controller;

import com.ming800.core.does.service.DoHandler;
import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by AC丶man on 2015/9/15.
 */
public class MessageAttachmentHandler implements DoHandler {

	@Override
	public ModelMap handle(ModelMap modelMap, HttpServletRequest request) throws Exception {

		String masterMessageId = request.getParameter("masterMessageId");
		String type = request.getParameter("type");
		modelMap.addAttribute("masterMessage.id",masterMessageId);
		modelMap.addAttribute("masterMessageId",masterMessageId);
		modelMap.addAttribute("type",type);
		return modelMap;
	}
}
