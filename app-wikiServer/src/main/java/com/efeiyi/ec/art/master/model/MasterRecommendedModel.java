package com.efeiyi.ec.art.master.model;

import java.io.Serializable;

/**
 * Created by AC丶man on 2015/11/4.
 */
public class MasterRecommendedModel implements Serializable {
	private String id;
	private String masterId;
	private String favicon;
	private String followStatus;
	private String masterName;

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

	public String getFavicon() {
		return favicon;
	}

	public void setFavicon(String favicon) {
		this.favicon = favicon;
	}

	public String getFollowStatus() {
		return followStatus;
	}

	public void setFollowStatus(String followStatus) {
		this.followStatus = followStatus;
	}

	public String getMasterName() {
		return masterName;
	}

	public void setMasterName(String masterName) {
		this.masterName = masterName;
	}
}
