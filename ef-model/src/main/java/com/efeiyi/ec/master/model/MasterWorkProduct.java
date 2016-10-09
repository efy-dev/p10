package com.efeiyi.ec.master.model;

import com.efeiyi.ec.product.model.Product;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;

/**
 * Created by zhao on 2016/10/9.
 * 关联MasterWork&&Product
 */
@Entity
@Table(name = "masterwork_product")
@JsonIgnoreProperties(value = {"hibernateLazyInitializer", "handler"})
public class MasterWorkProduct {
    private String id;
    private MasterWork masterwork;
    private Product product;
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

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "masterwork_id")
    public MasterWork getMasterwork() {
        return masterwork;
    }

    public void setMasterwork(MasterWork masterwork) {
        this.masterwork = masterwork;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_id")
    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    @Column(name = "status")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "MasterWorkProduct{" +
                "id='" + id + '\'' +
                '}';
    }
}
