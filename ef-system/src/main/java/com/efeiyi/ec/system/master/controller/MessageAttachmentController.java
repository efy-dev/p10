package com.efeiyi.ec.system.master.controller;

import com.efeiyi.ec.master.model.MasterMessage;
import com.efeiyi.ec.master.model.MessageAttachment;
import com.efeiyi.ec.tenant.model.EnterpriseTenant;
import com.efeiyi.ec.tenant.model.PersonalTenant;
import com.efeiyi.ec.tenant.model.PrivateTenant;
import com.efeiyi.ec.tenant.model.Tenant;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.p.service.AliOssUploadManager;
import com.ming800.core.util.StringUtil;
import org.hibernate.envers.internal.tools.StringTools;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

/**
 * Created by AC丶man on 2015/9/18.
 */
@Controller
@RequestMapping("/attachment")
public class MessageAttachmentController {



	@Autowired
	private BaseManager baseManager;
	@Autowired
	private AliOssUploadManager aliOssUploadManager;

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

	@RequestMapping("/uploadify.do")
	@ResponseBody
	public String uploadProductImg(HttpServletRequest request) throws Exception{
		String data = "";
		String msgId = request.getParameter("msgId");
		MasterMessage msg = (MasterMessage) baseManager.getObject(MasterMessage.class.getName(),msgId);
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		Map<String,MultipartFile> fileMap = multipartRequest.getFileMap();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String identify = sdf.format(new Date());
		String url = "" ;
		for (Map.Entry<String,MultipartFile> entry : fileMap.entrySet()){
			//上传文件
			MultipartFile mf = entry.getValue();
			String fileName = mf.getOriginalFilename();//获取原文件名
			url = "messageAttachment/"+fileName.substring(0,fileName.indexOf(".jpg"))+identify+".jpg";
			MessageAttachment attachment = new MessageAttachment();
			attachment.setPictureUrl(url);
			attachment.setMasterMessage(msg);
			attachment.setFileName(fileName.substring(0,fileName.indexOf(".jpg")));
			baseManager.saveOrUpdate(MessageAttachment.class.getName(),attachment);
			try {
				aliOssUploadManager.uploadFile(mf, "tenant", url);
				data = msg.getId() + ":" + url;
			}catch (Exception e){
				e.printStackTrace();
			}
		}
		System.out.print(url);
		return data;


	}

}
