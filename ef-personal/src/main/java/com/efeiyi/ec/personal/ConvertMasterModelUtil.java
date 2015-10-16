package com.efeiyi.ec.personal;

import com.efeiyi.ec.master.model.Master;
import com.efeiyi.ec.master.model.MasterIntroductionAttachment;
import com.efeiyi.ec.master.model.MasterMessage;
import com.efeiyi.ec.master.model.MessageAttachment;
import com.efeiyi.ec.personal.master.model.MasterModel;
import com.efeiyi.ec.project.model.Project;

import java.util.Date;
import java.util.List;

/**
 * Created by AC丶man on 2015/10/14.
 */
public class ConvertMasterModelUtil {

	public static MasterModel converMasterModel(MasterMessage message){
		MasterModel masterModel = new MasterModel();
		if (message != null){
			masterModel.setMasterId(message.getMaster().getId()==null?"":message.getMaster().getId());
			masterModel.setId(message.getId()==null?"":message.getId());
			masterModel.setFsAmount(message.getFsAmount() == null ? 0 : message.getFsAmount());
			masterModel.setAmount(message.getAmount() == null ? 0 : message.getAmount());
			masterModel.setCreateDateTime(message.getCreateDateTime() == null ? new Date() : message.getCreateDateTime());
			masterModel.setContent(message.getContent() == null ? "" : message.getContent());
			masterModel.setDataSource(message.getDataSource() == null ? "" : message.getDataSource());
			masterModel.setFavicon(message.getMaster().getFavicon() == null ? "" : message.getMaster().getFavicon());
			masterModel.setLevel(message.getMaster().getLevel() == null ? "0" : message.getMaster().getLevel());
			masterModel.setId(message.getId() == null ? "0" : message.getId());
			masterModel.setMasterName(message.getMaster().getFullName() == null ? message.getMaster().getName():message.getMaster().getFullName());
			Project project = message.getProject();
			if (project != null){
				masterModel.setProjectName(project.getName() == null ? "" : project.getName());
			}
			masterModel.setPraiseNum(message.getPraiseNum()==null?0:message.getPraiseNum());
			masterModel.setFollowStatus(message.getPraiseStatus() == null ? "" : message.getPraiseStatus());
			masterModel.setMessageAttachmentLists(message.getMessageAttachmentLists()==null? null :message.getMessageAttachmentLists());

		}
		return masterModel;
	}

	public static MasterModel converMaster(Master master){
		MasterModel masterModel = new MasterModel();
		masterModel.setId(master.getId()==null?"":master.getId());
		masterModel.setMasterName(master.getFullName()==null?master.getName():master.getFullName());
		masterModel.setProjectName(master.getProjectName()==null?"":master.getProjectName());
		masterModel.setLevel(master.getLevel()==null?"":master.getLevel());
		masterModel.setFavicon(master.getFavicon()==null?"":master.getFavicon());
		masterModel.setFollowStatus(master.getFollowStatus()==null?"关注":master.getFollowStatus());
		return masterModel;
	}
}
