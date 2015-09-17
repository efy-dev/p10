package com.efeiyi.pal.label.model;

import com.efeiyi.pal.organization.model.Tenant;
import com.efeiyi.pal.product.model.Product;
import com.efeiyi.pal.purchase.model.PurchaseOrder;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.util.Date;

/**
 * Created by Administrator on 2015/7/16.
 */

@Entity
@Table(name = "label_batch")
public class LabelBatch {

    private String id;
    private String setting;
    private String serial;
    private Integer amount;
    private Date createDate;
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

    @Column(name = "serial")
    public String getSerial() {
        return serial;
    }

    public void setSerial(String serial) {
        this.serial = serial;
    }

    @Column(name = "setting")
    public String getSetting() {
        return setting;
    }

    public void setSetting(String setting) {
        this.setting = setting;
    }

    @Column(name = "amount")
    public Integer getAmount() {
        return amount;
    }

    public void setAmount(Integer amount) {
        this.amount = amount;
    }

    @Column(name = "create_date")
    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    @Column(name = "status")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

}
