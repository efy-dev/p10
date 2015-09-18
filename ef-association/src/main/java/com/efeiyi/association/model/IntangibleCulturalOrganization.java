package com.efeiyi.association.model;

import com.efeiyi.ec.organization.model.AddressDistrict;
import org.hibernate.annotations.GenericGenerator;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.util.Date;

/**
 * Created by Administrator on 2015/9/11.
 */
@Entity
@Table(name = "organization_intangible_cultural")
public class IntangibleCulturalOrganization {

    private String id;
    private String name;
    private AddressDistrict addressDistrict;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    private Date theDatetime;
    private String inCharge;
    private String status;
    private String group;

    @Column(name = "group_name")
    public String getGroup() {
        return group;
    }

    public void setGroup(String group) {
        this.group = group;
    }

    @Id
    @GenericGenerator(name = "id", strategy = "com.ming800.core.p.model.M8idGenerator")
    @GeneratedValue(generator = "id")
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @Column(name = "name")
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "district_id")
    public AddressDistrict getAddressDistrict() {
        return addressDistrict;
    }

    public void setAddressDistrict(AddressDistrict addressDistrict) {
        this.addressDistrict = addressDistrict;
    }

    @Column(name = "the_datetime")
    public Date getTheDatetime() {
        return theDatetime;
    }

    public void setTheDatetime(Date theDatetime) {
        this.theDatetime = theDatetime;
    }

    @Column(name = "in_charge_person")
    public String getInCharge() {
        return inCharge;
    }

    public void setInCharge(String inCharge) {
        this.inCharge = inCharge;
    }

    @Column(name = "status")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
