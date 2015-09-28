package com.efeiyi.ec.master.model;

import com.efeiyi.ec.organization.model.Consumer;
import com.fasterxml.jackson.annotation.JsonIgnore;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;

/**
 * Created by AC丶man on 2015/9/21.
 */
@Entity
@Table(name = "master_message_praise")
public class MasterMessagePraise {

	private String id;
	private Integer fsAmount;
	private MasterMessage message;
	private Consumer user;

	@Id
	@GenericGenerator(name = "id", strategy = "com.ming800.core.p.model.M8idGenerator")
	@GeneratedValue(generator = "id")
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	@Column(name = "praise_number")
	public Integer getFsAmount() {
		return fsAmount;
	}

	public void setFsAmount(Integer fsAmount) {
		this.fsAmount = fsAmount;
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
	public Consumer getUser() {
		return user;
	}

	public void setUser(Consumer user) {
		this.user = user;
	}
}
