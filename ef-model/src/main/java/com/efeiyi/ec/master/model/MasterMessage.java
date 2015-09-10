package com.efeiyi.ec.master.model;

import com.efeiyi.ec.organization.model.BigUser;
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
@Table(name = "master_message")
@JsonIgnoreProperties(value = {"hibernateLazyInitializer", "handler"})
public class MasterMessage implements Serializable {
	private String id;
	private String content;
	private String type; //1.text 文本 2.rich 附件 3.link 超链接 4.video 视频 5.work 作品
	private Master master;
	private Project project;
	private String author;
	private Date createDateTime;
	private List<MessageAttachmentList> messageAttachmentLists;

	@Id
	@GenericGenerator(name = "id", strategy = "com.ming800.core.p.model.M8idGenerator")
	@GeneratedValue(generator = "id")
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
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

	@Column(name = "author")
	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
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
	public List<MessageAttachmentList> getMessageAttachmentLists() {
		return messageAttachmentLists;
	}

	public void setMessageAttachmentLists(List<MessageAttachmentList> messageAttachmentLists) {
		this.messageAttachmentLists = messageAttachmentLists;
	}
}
