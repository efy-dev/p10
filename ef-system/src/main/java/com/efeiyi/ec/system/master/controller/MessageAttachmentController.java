package com.efeiyi.ec.system.master.controller;

import com.efeiyi.ec.master.model.MasterMessage;
import com.efeiyi.ec.master.model.MessageAttachment;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.util.StringUtil;
import org.hibernate.envers.internal.tools.StringTools;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by AC丶man on 2015/9/18.
 */
@Controller
@RequestMapping("/attachment")
public class MessageAttachmentController {



	@Autowired
	private BaseManager baseManager;


	@RequestMapping("/saveAttachment.do")
	public String saveMessageAttachment(HttpServletRequest request , Model model){
		String messageId = request.getParameter("masterMessageId");
		String fileName = request.getParameter("content");
		MasterMessage message = (MasterMessage) baseManager.getObject(MasterMessage.class.getName(),messageId);
		if (!StringTools.isEmpty(fileName)){
			MessageAttachment attachment = new MessageAttachment();
			attachment.setFileName(fileName);
			attachment.setMasterMessage(message);
			baseManager.saveOrUpdate(MessageAttachment.class.getName(),attachment);
		}
		return "redirect:/basic/xm.do?qm=plistMasterMessage_default&conditions=master.id:"+message.getMaster().getId()+"&masterId="+message.getMaster().getId();
	}

}
