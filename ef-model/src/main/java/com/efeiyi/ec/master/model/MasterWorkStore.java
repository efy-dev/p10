package com.efeiyi.ec.master.model;

import com.efeiyi.ec.organization.model.User;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

/**
 * Created by AC丶man on 2015/10/12.
 */

@Entity
@Table(name="master_work_store")
public class MasterWorkStore implements Serializable {

	private String id;
	private MasterWork work;
	private User user;
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
        return  "MasterWorkStore{id = "+id+"}";
    }

}
