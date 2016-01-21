package com.efeiyi.ec.master.model;

import com.efeiyi.ec.organization.model.User;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

/**
 * Created by AC丶man on 2015/10/12.
 */
@Entity
@Table(name = "master_work_praise")
@JsonIgnoreProperties(value = {"hibernateLazyInitializer", "handler"})
public class MasterWorkPraise implements Serializable {

	private String id;
	private MasterWork work;
	private User user;
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

	@JoinColumn(name="work_id")
	@ManyToOne(fetch = FetchType.LAZY)
	public MasterWork getWork() {
		return work;
	}

	public void setWork(MasterWork work) {
		this.work = work;
	}

	@JoinColumn(name="user_id")
	@ManyToOne(fetch = FetchType.LAZY)
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
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

    @Override
    public String toString(){
        return  "MasterWorkPraise{id = "+id+"}";
    }
}
