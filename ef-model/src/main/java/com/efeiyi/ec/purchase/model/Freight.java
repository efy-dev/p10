package com.efeiyi.ec.purchase.model;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;

/**
 * Created by Administrator on 2016/2/18.
 */
@Entity
@Table(name = "purchase_order_freight")
public class Freight {
    private String id;
    private String startProvince;//出发省
    private String startCity;//出发市
    private String reachProvince;//目的地省
    private String standardYkgMoney;//标准快递首重费用
    private String standardAkgMoney;//标准快递续重费用
    private String ykg360Money;//360套餐首重费用
    private String akg360Money;//360套餐续重费用

    @Id
    @GenericGenerator(name = "id", strategy = "com.ming800.core.p.model.M8idGenerator")
    @GeneratedValue(generator = "id")
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @Column(name = "start_province")
    public String getStartProvince() {
        return startProvince;
    }

    public void setStartProvince(String startProvince) {
        this.startProvince = startProvince;
    }

    @Column(name = "start_city")
    public String getStartCity() {
        return startCity;
    }

    public void setStartCity(String startCity) {
        this.startCity = startCity;
    }

    @Column(name = "reach_province")
    public String getReachProvince() {
        return reachProvince;
    }

    public void setReachProvince(String reachProvince) {
        this.reachProvince = reachProvince;
    }

    @Column(name = "standard_ykg_money")
    public String getStandardYkgMoney() {
        return standardYkgMoney;
    }

    public void setStandardYkgMoney(String standardYkgMoney) {
        this.standardYkgMoney = standardYkgMoney;
    }

    @Column(name = "standard_akg_money")
    public String getStandardAkgMoney() {
        return standardAkgMoney;
    }

    public void setStandardAkgMoney(String standardAkgMoney) {
        this.standardAkgMoney = standardAkgMoney;
    }

    @Column(name = "ykg_360money")
    public String getYkg360Money() {
        return ykg360Money;
    }

    public void setYkg360Money(String ykg360Money) {
        this.ykg360Money = ykg360Money;
    }

    @Column(name = "akg_360money")
    public String getAkg360Money() {
        return akg360Money;
    }

    public void setAkg360Money(String akg360Money) {
        this.akg360Money = akg360Money;
    }
}
