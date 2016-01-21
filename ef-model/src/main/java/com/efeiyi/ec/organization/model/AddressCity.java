package com.efeiyi.ec.organization.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.io.Serializable;

/**
 * Created by Administrator on 2014/12/11.
 */
@Entity
@Table(name = "organization_address_city")
@JsonIgnoreProperties(value = {"hibernateLazyInitializer", "handler"})
public class AddressCity implements Serializable {
    private String id;
    private String name;
    private AddressProvince addressProvince;


    @Id
    @GenericGenerator(name = "id", strategy = "com.ming800.core.p.model.M8idGenerator")
    @GeneratedValue(generator = "id")
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @Column(name = "city_name")
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "province_id")
    @JsonIgnore
    public AddressProvince getAddressProvince() {
        return addressProvince;
    }

    public void setAddressProvince(AddressProvince addressProvince) {
        this.addressProvince = addressProvince;
    }

    @Override
    public String toString(){
        return  "AddressCity{id = "+id+"}";
    }
}
