package com.efeiyi.ec.website.organization.model;

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
@JsonIgnoreProperties(value = {"hibernateLazyInitializer", "handler", "city"})
public class District implements Serializable {
    private Integer id;
    private String name;
    private City city;

    @Id
    @GenericGenerator(name = "id", strategy = "increment")
    @GeneratedValue(generator = "id")
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
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
    public City getCity() {
        return city;
    }

    public void setCity(City city) {
        this.city = city;
    }
}
