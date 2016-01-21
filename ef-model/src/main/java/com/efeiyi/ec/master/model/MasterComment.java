package com.efeiyi.ec.master.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import org.hibernate.annotations.GenericGenerator;
import com.efeiyi.ec.organization.model.User;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * Created by AC丶man on 2015/9/18.
 */
@Entity
@Table(name = "master_comment")
@JsonIgnoreProperties(value = {"hibernateLazyInitializer", "handler"})
public class MasterComment implements Serializable {

	private String id ;
	private String status;
	private String content;
	private MasterComment fatherComment;
	private List<MasterComment> subComment;
	private List<MasterWorkPraise> praises;
	private MasterMessage masterMessage;
	private MasterWork masterWork;
	private Date createDateTime;
	private User user;
	private Integer amount;
	private User author;

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

	@Column(name = "content")
	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	@JsonIgnore
	@JoinColumn(name = "father_id")
	@ManyToOne(fetch = FetchType.LAZY)
	public MasterComment getFatherComment() {
		return fatherComment;
	}

	public void setFatherComment(MasterComment fatherComment) {
		this.fatherComment = fatherComment;
	}

	@JsonIgnore
	@OneToMany(fetch = FetchType.LAZY,mappedBy = "fatherComment", cascade = CascadeType.ALL)
	public List<MasterComment> getSubComment() {
		return subComment;
	}

	public void setSubComment(List<MasterComment> subComment) {
		this.subComment = subComment;
	}

	@JsonIgnore
	@OneToMany(fetch = FetchType.LAZY,mappedBy = "comment", cascade = CascadeType.ALL)
	public List<MasterWorkPraise> getPraises() {
		return praises;
	}

	public void setPraises(List<MasterWorkPraise> praises) {
		this.praises = praises;
	}

	@JsonIgnore
	@JoinColumn(name = "master_work_id")
	@ManyToOne(fetch = FetchType.LAZY)
	public MasterWork getMasterWork() {
		return masterWork;
	}

	public void setMasterWork(MasterWork masterWork) {
		this.masterWork = masterWork;
	}

	@JsonIgnore
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "master_message_id")
	public MasterMessage getMasterMessage() {
		return masterMessage;
	}

	public void setMasterMessage(MasterMessage masterMessage) {
		this.masterMessage = masterMessage;
	}

	@Column(name = "create_datetime")
	public Date getCreateDateTime() {
		return createDateTime;
	}

	public void setCreateDateTime(Date createDateTime) {
		this.createDateTime = createDateTime;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "user_id")
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	@Column(name = "comment_number")
	public Integer getAmount() {
		return amount;
	}

	public void setAmount(Integer amount) {
		this.amount = amount;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "author_id")
	public User getAuthor() {
		return author;
	}

	public void setAuthor(User author) {
		this.author = author;
	}

    @Override
    public String toString(){
        return  "MasterComment{id = "+id+"}";
    }
}
