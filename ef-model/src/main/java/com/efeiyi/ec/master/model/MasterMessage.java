package com.efeiyi.ec.master.model;

import com.efeiyi.ec.organization.model.User;
import com.efeiyi.ec.project.model.Project;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * Created by AC丶man on 2015/9/7.
 */
@Entity
@Table(name = "master_news")
@JsonIgnoreProperties(value = {"hibernateLazyInitializer", "handler"})
public class MasterMessage implements Serializable {
	private String id;
	private String content;
	private String type; //1.text 文本 2.rich 附件 3.link 超链接 4.video 视频 5.work 作品
	private Master master;
	private Project project;
	private Date createDateTime;
	private List<MessageAttachment> messageAttachmentLists;
	private String title;
	private String masterId;
	private User creator;
	private String brief; //简介
	private String masterName;
	private String status;
	private String dataSource; //来源
	private Long praiseNum;//点赞数量
	private String praiseStatus;
	private String followStatus;
	private String storeStatus;
	private Integer amount;//评论数量
	private Integer fsAmount;//关注人数
	private List<MasterNewsTag> masterNewsTagList;
	private List<MasterIntroductionAttachment> masterIntroductionAttachmentList;//附件
	private String remark;

	public MasterMessage() {
	}

	@Id
	@GenericGenerator(name = "id", strategy = "com.ming800.core.p.model.M8idGenerator")
	@GeneratedValue(generator = "id")
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	@Transient
	public String getMasterName() {
		return masterName;
	}

	public void setMasterName(String masterName) {
		this.masterName = masterName;
	}

	@Transient
	public String getFollowStatus() {
		return followStatus;
	}

	public void setFollowStatus(String followStatus) {
		this.followStatus = followStatus;
	}

	@Transient
	public String getPraiseStatus() {
		return praiseStatus;
	}

	public void setPraiseStatus(String praiseStatus) {
		this.praiseStatus = praiseStatus;
	}

	@Column(name = "praise_number")
	public Long getPraiseNum() {
		return praiseNum;
	}

	public void setPraiseNum(Long praiseNum) {
		this.praiseNum = praiseNum;
	}

	@Transient
	public String getMasterId() {
		return masterId;
	}

	public void setMasterId(String masterId) {
		this.masterId = masterId;
	}

	@Column(name="title")
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	@Column(name = "content")
	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	@Column(name = "type")
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name="user_id")
	public User getCreator() {
		return creator;
	}

	public void setCreator(User creator) {
		this.creator = creator;
	}

	@Column(name = "brief")
	public String getBrief() {
		return brief;
	}

	public void setBrief(String brief) {
		this.brief = brief;
	}

	@Column(name = "status")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	@Column(name = "data_source")
	public String getDataSource() {
		return dataSource;
	}

	public void setDataSource(String dataSource) {
		this.dataSource = dataSource;
	}

	@JsonIgnore
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "master_id")
	public Master getMaster() {
		return master;
	}

	public void setMaster(Master master) {
		this.master = master;
	}

	@JsonIgnore
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "project_id")
	public Project getProject() {
		return project;
	}

	public void setProject(Project project) {
		this.project = project;
	}

	@Column(name = "create_datetime")
	public Date getCreateDateTime() {
		return createDateTime;
	}

	public void setCreateDateTime(Date createDateTime) {
		this.createDateTime = createDateTime;
	}


	@JsonIgnore
	@OneToMany(fetch = FetchType.LAZY,mappedBy = "masterMessage")
	public List<MessageAttachment> getMessageAttachmentLists() {
		return messageAttachmentLists;
	}

	public void setMessageAttachmentLists(List<MessageAttachment> messageAttachmentLists) {
		this.messageAttachmentLists = messageAttachmentLists;
	}

	@Column(name = "amount")
	public Integer getAmount() {
		return amount;
	}

	public void setAmount(Integer amount) {
		this.amount = amount;
	}

	@Transient
	public String getStoreStatus() {
		return storeStatus;
	}

	public void setStoreStatus(String storeStatus) {
		this.storeStatus = storeStatus;
	}

	@Column(name = "fans_amount")
	public Integer getFsAmount() {
		return fsAmount;
	}

	public void setFsAmount(Integer fsAmount) {
		this.fsAmount = fsAmount;
	}

	@Column(name = "remark")
	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}
}
