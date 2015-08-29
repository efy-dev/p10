package com.efeiyi.ec.organization.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

/**
 * Created by Administrator on 2015/6/26.
 */
@Entity
@Table(name="organization_professional")
public class Professional extends BigUser{
    private String temp;



    @Column(name="temp")
    public String getTemp() {
        return temp;
    }

    public void setTemp(String temp) {
        this.temp = temp;
    }
}
