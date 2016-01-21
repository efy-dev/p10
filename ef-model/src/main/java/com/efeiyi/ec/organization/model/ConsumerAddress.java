package com.efeiyi.ec.organization.model;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.io.Serializable;

/**
 * Created by Administrator on 2015/5/29.
 */
@Entity
@Table(name = "organization_consumer_address")
public class ConsumerAddress implements Serializable {
    private String id;
    private AddressProvince province;
    private AddressDistrict district;
    private AddressCity city;
    private String details;
    private String post;
    private String phone;
    private String email;
    private MyUser consumer;
    private String status;   //1 正常的 2 默认的
    private  String consignee; //收货人姓名
    @Id
    @GenericGenerator(name = "id", strategy = "com.ming800.core.p.model.M8idGenerator")
    @GeneratedValue(generator = "id")
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name="address_province_id")
    public AddressProvince getProvince() {
        return province;
    }

    public void setProvince(AddressProvince province) {
        this.province = province;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name="address_city_id")
    public AddressCity getCity() {
        return city;
    }

    public void setCity(AddressCity city) {
        this.city = city;
    }

    @Column(name = "details")
    public String getDetails() {
        return details;
    }

    public void setDetails(String details) {
        this.details = details;
    }

    @Column(name = "post")
    public String getPost() {
        return post;
    }

    public void setPost(String post) {
        this.post = post;
    }

    @Column(name = "phone")
    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    @Column(name = "email")
    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "address_district_id")
    public AddressDistrict getDistrict() {
        return district;
    }

    public void setDistrict(AddressDistrict district) {
        this.district = district;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "consumer_id")
    public MyUser getConsumer() {
        return consumer;
    }

    public void setConsumer(MyUser consumer) {
        this.consumer = consumer;
    }

    @Column(name="status")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Column(name = "consignee")
    public String getConsignee() {
        return consignee;
    }

    public void setConsignee(String consignee) {
        this.consignee = consignee;
    }

    @Override
    public String toString() {
        return "ConsumerAddress{id = " + id + "}";
    }
}
