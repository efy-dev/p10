package com.efeiyi.ec.art.master.model;

import java.io.Serializable;
import java.util.List;

/**
 * Created by AC丶man on 2015/11/4.
 */
public class MasterListModel implements Serializable {
	private List<MasterModel> msgModelList;
	private List<MasterModel> mrModelList;

	public List<MasterModel> getMsgModelList() {
		return msgModelList;
	}

	public void setMsgModelList(List<MasterModel> msgModelList) {
		this.msgModelList = msgModelList;
	}

	public List<MasterModel> getMrModelList() {
		return mrModelList;
	}

	public void setMrModelList(List<MasterModel> mrModelList) {
		this.mrModelList = mrModelList;
	}
}
