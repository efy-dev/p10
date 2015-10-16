package com.efeiyi.ec.master.model;

import com.efeiyi.ec.organization.model.MyUser;
import com.fasterxml.jackson.annotation.JsonIgnore;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.util.Date;

/**
 * Created by AC丶man on 2015/9/21.
 */
@Entity
@Table(name = "master_message_praise")
public class MasterMessagePraise {

	private String id;
	private MasterMessage message;
	private MyUser user;
	private MasterComment comment;
	private String status;
	private Date createDateTime;

	@Id
	@GenericGenerator(name = "id", strategy = "com.ming800.core.p.model.M8idGenerator")
	@GeneratedValue(generator = "id")
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	@JsonIgnore
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "master_message_id")
	public MasterMessage getMessage() {
		return message;
	}

	public void setMessage(MasterMessage message) {
		this.message = message;
	}

	@JsonIgnore
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "user_id")
	public MyUser getUser() {
		return user;
	}

	public void setUser(MyUser user) {
		this.user = user;
	}

	@JsonIgnore
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "comment_id")
	public MasterComment getComment() {
		return comment;
	}

	public void setComment(MasterComment comment) {
		this.comment = comment;
	}

	@Column(name="status")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	@Column(name="create_datetime")
	public Date getCreateDateTime() {
		return createDateTime;
	}

	public void setCreateDateTime(Date createDateTime) {
		this.createDateTime = createDateTime;
	}
}
