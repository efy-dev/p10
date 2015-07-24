package com.efeiyi.pal.organization.model;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.io.Serializable;

/**
 * Created by Administrator on 2015/7/16.
 */

@Entity
@Table(name = "organization_address_province")
public class AddressProvince implements Serializable {

    private String id;
    private String name;
    private String status;

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

    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }

        AddressProvince addressProvince = (AddressProvince) o;

        if (id != null ? !id.equals(addressProvince.id) : addressProvince.id != null) {
            return false;
        }

        return true;
    }

    public int hashCode() {
        return (id != null ? id.hashCode() : 0);
    }

    @Column(name = "status")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

}
