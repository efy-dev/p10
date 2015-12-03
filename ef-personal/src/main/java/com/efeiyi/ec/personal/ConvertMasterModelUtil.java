package com.efeiyi.ec.personal;

import com.efeiyi.ec.master.model.*;
import com.efeiyi.ec.personal.master.model.MasterModel;
import com.efeiyi.ec.personal.master.model.MasterRecommendedModel;
import com.efeiyi.ec.project.model.Project;

import java.util.Date;
import java.util.List;

/**
 * Created by AC丶man on 2015/10/14.
 */
public class ConvertMasterModelUtil {

	public static MasterModel convertMasterModel(MasterMessage message){
		MasterModel masterModel = new MasterModel();
		if (message != null){
			masterModel.setMasterId(message.getMaster().getId()==null?"":message.getMaster().getId());
			masterModel.setPraiseStatus(message.getPraiseStatus()==null?"赞":message.getPraiseStatus());
			masterModel.setStoreStatus(message.getStoreStatus()==null?"收藏":message.getStoreStatus());
			masterModel.setFsAmount(message.getFsAmount() == null ? 0 : message.getFsAmount());
			masterModel.setAmount(message.getAmount() == null ? 0 : message.getAmount());
			masterModel.setCreateDateTime(message.getCreateDateTime() == null ? new Date() : message.getCreateDateTime());
			masterModel.setContent(message.getContent() == null ? "" : message.getContent());
			masterModel.setDataSource(message.getDataSource() == null ? "" : message.getDataSource());
			masterModel.setFavicon(message.getMaster().getFavicon() == null ? "" : message.getMaster().getFavicon());
			masterModel.setLevel(message.getMaster().getLevel() == null ? "0" : message.getMaster().getLevel());
			masterModel.setId(message.getId() == null ? "0" : message.getId());
			masterModel.setMasterName(message.getMaster().getFullName() == null ? message.getMaster().getName():message.getMaster().getFullName());
			masterModel.setRemark(message.getRemark()==null?"":message.getRemark());
			Project project = message.getProject();
			if (project != null){
				masterModel.setProjectName(project.getName() == null ? "" : project.getName());
			}
			masterModel.setPraiseNum(message.getPraiseNum()==null?0:message.getPraiseNum());
			masterModel.setFollowStatus(message.getFollowStatus() == null ? "关注" : message.getFollowStatus());
			masterModel.setMessageAttachmentLists(message.getMessageAttachmentLists()==null? null :message.getMessageAttachmentLists());
		}
		return masterModel;
	}

	public static MasterModel convertMaster(Master master){
		MasterModel masterModel = new MasterModel();
		masterModel.setAmount(master.getFsAmount()==null?1: (int) (master.getFsAmount() + 1));
		masterModel.setId(master.getId()==null?"":master.getId());
		masterModel.setMasterName(master.getFullName() == null ? master.getName():master.getFullName());
		masterModel.setProjectName(master.getProjectName() == null?"":master.getProjectName());
		masterModel.setLevel(master.getLevel()==null?"":master.getLevel());
		masterModel.setFavicon(master.getFavicon() ==null?"":master.getFavicon());
		masterModel.setContent(master.getBrief() == null ? "" : master.getBrief());
		masterModel.setFollowStatus(master.getFollowStatus()==null?"关注":master.getFollowStatus());
		return masterModel;
	}

	public static MasterModel convertMasterWork(Master master,List<MasterWork> works){
		MasterModel masterModel = new MasterModel();
		masterModel.setId(master.getId()==null?"0":master.getId());
		masterModel.setMasterName(master.getFullName()==null?master.getName():master.getFullName());
		masterModel.setLevel(master.getLevel()==null?"":master.getLevel());
		masterModel.setFollowStatus(master.getFollowStatus()==null?"关注":master.getFollowStatus());
		masterModel.setContent(master.getBrief()==null?"":master.getBrief());
		masterModel.setFavicon(master.getFavicon()==null?"":master.getFavicon());
		if (master.getOriginProvince() != null){
			masterModel.setCityName(master.getOriginProvince().getName()==null?"":master.getOriginProvince().getName());
		}else{
			masterModel.setCityName("");
		}
		masterModel.setProjectName(master.getProjectName()==null?"":master.getProjectName());
		if (works != null && works.size() > 0){
			masterModel.setWorks(works);
		}
		return masterModel;
	}

	public static MasterModel convertWork(MasterWork work){
		MasterModel workModel = new MasterModel();
		workModel.setMasterId(work.getMaster().getId());
		workModel.setStoreStatus(work.getStoreStatus()==null?"收藏":work.getStoreStatus());
		workModel.setProjectName(work.getName()==null?"":work.getName());
		workModel.setContent(work.getProductDescription().getContent()==null?"":work.getProductDescription().getContent());
		workModel.setId(work.getId());
		workModel.setCreateDateTime(work.getCreateDateTime());
		workModel.setPraiseNum(Long.valueOf(String.valueOf(work.getFsAmount()==null?0:work.getFsAmount())));
		workModel.setFavicon(work.getPictureUrl()==null?"":work.getPictureUrl());
		workModel.setAmount(work.getAmount()==null?0:work.getAmount());
		workModel.setFsAmount(work.getFsAmount()==null?0:work.getFsAmount());
		workModel.setStoreAmount(work.getStoreAmount()==null?0:work.getStoreAmount());
		return workModel;
	}

}
