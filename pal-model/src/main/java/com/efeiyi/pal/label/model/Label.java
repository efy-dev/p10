package com.efeiyi.pal.label.model;

import com.efeiyi.pal.orgnization.model.Tenant;
import com.efeiyi.pal.product.model.Product;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.util.Date;

/**
 * Created by Administrator on 2015/7/16.
 */

@Entity
@Table(name = "label")
public class Label {

    private String id;
    private String serial;
    private LabelBatch labelBatch;
    private Product product;
    private Tenant seller;
    private String status;
    private Date usedDate;

    @Id
    @GenericGenerator(name = "id", strategy = "com.ming800.core.p.model.M8idGenerator")
    @GeneratedValue(generator = "id")
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @Column(name = "serial")
    public String getSerial() {
        return serial;
    }

    public void setSerial(String serial) {
        this.serial = serial;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "label_batch_id")
    public LabelBatch getLabelBatch() {
        return labelBatch;
    }

    public void setLabelBatch(LabelBatch labelBatch) {
        this.labelBatch = labelBatch;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_id")
    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "tenant_id")
    public Tenant getSeller() {
        return seller;
    }

    public void setSeller(Tenant seller) {
        this.seller = seller;
    }

    @Column(name="status")
    private String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Column(name = "used_date")
    public Date getUsedDate() {
        return usedDate;
    }

    public void setUsedDate(Date usedDate) {
        this.usedDate = usedDate;
    }

}
