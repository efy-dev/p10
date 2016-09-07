package com.efeiyi.ec.tenant.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import javax.persistence.Column;
import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;
import javax.persistence.Table;
import java.io.Serializable;
import java.util.List;


/**
 * Created by IntelliJ IDEA.
 * User: ming
 * Date: 12-10-15
 * Time: 上午11:06
 * To change this template use File | Settings | File Templates.
 * <p>
 * <p>
 * 企业商家
 */

@Entity
@Table(name = "tenant_enterprise")
@JsonIgnoreProperties(value = {"hibernateLazyInitializer", "handler"})
public class EnterpriseTenant extends BigTenant implements Serializable {

    private String legalName;//经营者姓名//法定代表人姓名
    private String registeredAssets;//注册资本
    private String businessScope;//经营范围
    private String organizationAttachment;//组织机构附件
    private String bankAttachment;//银行开户附件
    private String businessLicense;//营业执照
    private String taxRegistrationAttachment;//税务登记附件



    @Column(name = "legal_name")
    public String getLegalName() {
        return legalName;
    }

    public void setLegalName(String legalName) {
        this.legalName = legalName;
    }

    @Column(name = "registered_assets")
    public String getRegisteredAssets() {
        return registeredAssets;
    }

    public void setRegisteredAssets(String registeredAssets) {
        this.registeredAssets = registeredAssets;
    }

    @Column(name = "business_scope")
    public String getBusinessScope() {
        return businessScope;
    }

    public void setBusinessScope(String businessScope) {
        this.businessScope = businessScope;
    }

    @Column(name = "organization_attachment")
    public String getOrganizationAttachment() {
        return organizationAttachment;
    }

    public void setOrganizationAttachment(String organizationAttachment) {
        this.organizationAttachment = organizationAttachment;
    }

    @Column(name = "bank_attachment")
    public String getBankAttachment() {
        return bankAttachment;
    }

    public void setBankAttachment(String bankAttachment) {
        this.bankAttachment = bankAttachment;
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
