package com.efeiyi.pal.purchase.model;

import com.efeiyi.pal.label.model.LabelBatch;
import com.efeiyi.pal.orgnization.model.Tenant;
import com.efeiyi.pal.orgnization.model.User;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

/**
 * Created by Administrator on 2015/7/16.
 */

@Entity
@Table(name = "purchase_order")
public class PurchaseOrder {

    private String id;
    private String serial;
    private List<LabelBatch> labelBatchList;
    private Tenant tenant;
    private User user;
    private Date createDatetime;

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
    public String getSerial() {
        return serial;
    }

    public void setSerial(String serial) {
        this.serial = serial;
    }

    @OneToMany(fetch = FetchType.LAZY)
    @JoinColumn(name = "label_batch_id")
    public List<LabelBatch> getLabelBatchList() {
        return labelBatchList;
    }

    public void setLabelBatchList(List<LabelBatch> labelBatchList) {
        this.labelBatchList = labelBatchList;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "tenant_id")
    public Tenant getTenant() {
        return tenant;
    }

    public void setTenant(Tenant tenant) {
        this.tenant = tenant;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    @Column(name = "create_datetime")
    public Date getCreateDatetime() {
        return createDatetime;
    }

    public void setCreateDatetime(Date createDatetime) {
        this.createDatetime = createDatetime;
    }

}
