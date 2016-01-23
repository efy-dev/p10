package com.efeiyi.ec.art.master.model;

import com.efeiyi.ec.master.model.MasterComment;
import com.efeiyi.ec.master.model.MasterWork;
import com.efeiyi.ec.master.model.MessageAttachment;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * Created by AC丶man on 2015/10/14.
 */
public class MasterModel implements Serializable{
	private String id;
	private String masterId;
	private String masterName;
	private String favicon;//project图片
	private String projectName;
	private String level;
	private String followStatus;
	private String content;// 动态内容
	private Date createDateTime;//发布时间
	private String dataSource;
	private Integer amount;//评论数
	private Integer fsAmount;//关注数
	private Integer storeAmount;//收藏数
	private String praiseStatus;
	private String storeStatus;//收藏状态
	private Long praiseNum;
	private String remark;
	private String cityName;
	private List<MessageAttachment> messageAttachmentLists;
	private List<MasterWork> works;
	private List<MasterComment> comments;
	private List<MasterModel> msgList;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getMasterId() {
		return masterId;
	}

	public void setMasterId(String masterId) {
		this.masterId = masterId;
	}

	public String getMasterName() {
		return masterName;
	}

	public void setMasterName(String masterName) {
		this.masterName = masterName;
	}

	public String getFavicon() {
		return favicon;
	}

	public void setFavicon(String favicon) {
		this.favicon = favicon;
	}

	public String getProjectName() {
		return projectName;
	}

	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}

	public String getLevel() {
		return level;
	}

	public void setLevel(String level) {
		this.level = level;
	}

	public String getPraiseStatus() {
		return praiseStatus;
	}

	public void setPraiseStatus(String praiseStatus) {
		this.praiseStatus = praiseStatus;
	}

	public String getStoreStatus() {
		return storeStatus;
	}

	public void setStoreStatus(String storeStatus) {
		this.storeStatus = storeStatus;
	}

	public String getFollowStatus() {
		return followStatus;
	}

	public void setFollowStatus(String followStatus) {
		this.followStatus = followStatus;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getCreateDateTime() {
		return createDateTime;
	}

	public void setCreateDateTime(Date createDateTime) {
		this.createDateTime = createDateTime;
	}

	public String getDataSource() {
		return dataSource;
	}

	public void setDataSource(String dataSource) {
		this.dataSource = dataSource;
	}

	public Integer getAmount() {
		return amount;
	}

	public void setAmount(Integer amount) {
		this.amount = amount;
	}

	public Integer getFsAmount() {
		return fsAmount;
	}

	public void setFsAmount(Integer fsAmount) {
		this.fsAmount = fsAmount;
	}

	public Long getPraiseNum() {
		return praiseNum;
	}

	public void setPraiseNum(Long praiseNum) {
		this.praiseNum = praiseNum;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Integer getStoreAmount() {
		return storeAmount;
	}

	public void setStoreAmount(Integer storeAmount) {
		this.storeAmount = storeAmount;
	}

	public String getCityName() {
		return cityName;
	}

	public void setCityName(String cityName) {
		this.cityName = cityName;
	}

	public List<MessageAttachment> getMessageAttachmentLists() {
		return messageAttachmentLists;
	}

	public void setMessageAttachmentLists(List<MessageAttachment> messageAttachmentLists) {
		this.messageAttachmentLists = messageAttachmentLists;
	}

	public List<MasterWork> getWorks() {
		return works;
	}

	public void setWorks(List<MasterWork> works) {
		this.works = works;
	}

	public List<MasterComment> getComments() {
		return comments;
	}

	public void setComments(List<MasterComment> comments) {
		this.comments = comments;
	}

	public List<MasterModel> getMsgList() {
		return msgList;
	}

	public void setMsgList(List<MasterModel> msgList) {
		this.msgList = msgList;
	}
}
