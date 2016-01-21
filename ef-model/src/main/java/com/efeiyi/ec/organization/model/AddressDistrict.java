package com.efeiyi.ec.organization.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.io.Serializable;

/**
 * User: Kyll
 * Time: 2008-7-3 15:27:28
 */
@Entity
@Table(name = "organization_address_district")
@JsonIgnoreProperties(value = {"hibernateLazyInitializer", "handler"})
public class AddressDistrict implements Serializable {
    private String id;
    private String name;
    private AddressCity addressCity;

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
    @JoinColumn(name = "city_id")
    @JsonIgnore
    public AddressCity getAddressCity() {
        return addressCity;
    }

    public void setAddressCity(AddressCity addressCity) {
        this.addressCity = addressCity;
    }

    @Override
    public String toString() {
        return "AddressDistrict{id = " + id + "}";
    }
}
