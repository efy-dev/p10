//package com.efeiyi.ec.site.model;
//
//import com.efeiyi.ec.master.model.MasterProject;
//import com.efeiyi.ec.master.model.MasterRecommended;
//import com.efeiyi.ec.master.model.MasterWork;
//import com.efeiyi.ec.organization.model.AddressProvince;
//import com.fasterxml.jackson.annotation.JsonIgnore;
//import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
//import org.hibernate.annotations.GenericGenerator;
//import org.hibernate.annotations.Where;
//
//import javax.persistence.*;
//import java.io.Serializable;
//import java.util.Date;
//import java.util.List;
//
//
///**
// * Created by IntelliJ IDEA.
// * User: ming
// * Date: 12-10-15
// * Time: 上午11:06
// * To change this template use File | Settings | File Templates.
// */
//
//@Entity
//@Table(name = "site")
//@JsonIgnoreProperties(value = {"hibernateLazyInitializer", "handler"})
//public class Site implements Serializable {
//
//    private String id;
//    private String name;//馆藏名称
//    private MasterWork masterWork;//作品
//
//    @Id
//    @GenericGenerator(name = "id", strategy = "com.ming800.core.p.model.M8idGenerator")
//    @GeneratedValue(generator = "id")
//    public String getId() {
//        return id;
//    }
//
//    public void setId(String id) {
//        this.id = id;
//    }
//
//    @Column(name = "name")
//    public String getName() {
//        return name;
//    }
//
//    public void setName(String name) {
//        this.name = name;
//    }
//
//
//    @OneToMany(fetch = FetchType.LAZY)
//    @JoinColumn(name = "masterWork_id")
//    public MasterWork getMasterWork() {
//        return masterWork;
//    }
//
//    public void setMasterWork(MasterWork masterWork) {
//        this.masterWork = masterWork;
//    }
//}
