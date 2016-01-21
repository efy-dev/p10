package com.efeiyi.ec.master.model;

import com.efeiyi.ec.organization.model.User;
import com.fasterxml.jackson.annotation.JsonIgnore;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

/**
 * Created by AC丶man on 2015/9/18.
 */
@Entity
@Table(name = "master_message_store")
public class MasterMessageStore implements Serializable {

	private String id ;
	private String status;
	private MasterMessage masterMessage;
	private User user;
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

	@Column(name = "status")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	@JsonIgnore
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "message_id")
	public MasterMessage getMasterMessage() {
		return masterMessage;
	}

	public void setMasterMessage(MasterMessage masterMessage) {
		this.masterMessage = masterMessage;
	}

	@JsonIgnore
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "user_id")
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	@Column(name="create_datetime")
	public Date getCreateDateTime() {
		return createDateTime;
	}

	public void setCreateDateTime(Date createDateTime) {
		this.createDateTime = createDateTime;
	}

    @Override
    public String toString(){
        return  "MasterMessageStore{id = "+id+"}";
    }
}
