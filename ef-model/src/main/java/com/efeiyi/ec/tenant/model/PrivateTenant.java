package com.efeiyi.ec.tenant.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import java.io.Serializable;
import java.util.Date;


/**
 * Created by IntelliJ IDEA.
 * User: ming
 * Date: 12-10-15
 * Time: 上午11:06
 * To change this template use File | Settings | File Templates.
 *
 *
 * 个体
 */
//
@Entity
@Table(name = "tenant_private")
@JsonIgnoreProperties(value = {"hibernateLazyInitializer", "handler"})
public class PrivateTenant extends BigTenant implements Serializable {

	private String operatorName;//经营者姓名//法定代表人姓名
	private Date indateBegin;//营业执照有效期开始时间;
	private Date indateEnd; // 营业执照有效期结束时间;
	private String businessScope;//经营范围
	private String businessLicense;//营业执照
	private String taxRegistrationAttachment;//税务登记附件


	@Column(name = "operator_name")
	public String getOperatorName() {
		return operatorName;
	}

	public void setOperatorName(String operatorName) {
		this.operatorName = operatorName;
	}

	@Column(name = "indate_begin")
	public Date getIndateBegin() {
		return indateBegin;
	}

	public void setIndateBegin(Date indateBegin) {
		this.indateBegin = indateBegin;
	}

	@Column(name = "indate_end")
	public Date getIndateEnd() {
		return indateEnd;
	}

	public void setIndateEnd(Date indateEnd) {
		this.indateEnd = indateEnd;
	}

	@Column(name = "business_scope")
	public String getBusinessScope() {
		return businessScope;
	}

	public void setBusinessScope(String businessScope) {
		this.businessScope = businessScope;
	}

	@Column(name = "business_license")
	public String getBusinessLicense() {
		return businessLicense;
	}

	public void setBusinessLicense(String businessLicense) {
		this.businessLicense = businessLicense;
	}

	@Column(name = "tax_registration_attachment")
	public String getTaxRegistrationAttachment() {
		return taxRegistrationAttachment;
	}

	public void setTaxRegistrationAttachment(String taxRegistrationAttachment) {
		this.taxRegistrationAttachment = taxRegistrationAttachment;
	}
}
