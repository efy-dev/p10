package com.efeiyi.pal.label.model;

import com.efeiyi.pal.check.model.LabelCheckRecord;
import com.efeiyi.pal.organization.model.Tenant;
import com.efeiyi.pal.purchase.model.PurchaseOrderLabel;
import com.fasterxml.jackson.annotation.JsonIgnore;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;
import org.hibernate.annotations.Where;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

/**
 * Created by Administrator on 2015/7/16.
 */

@Entity
@Table(name = "label")
public class Label {

    private String id;
    private String serial;
    private String code;
    private LabelBatch labelBatch;
    private Tenant seller;
    private String status;
    private Date firstCheckDateTime;
    private Date lastCheckDateTime;
    private int checkCount;
    private List<LabelCheckRecord> labelCheckRecordList;
    private PurchaseOrderLabel purchaseOrderLabel;

    @Id
    @GenericGenerator(name = "id", strategy = "com.ming800.core.p.model.M8idGenerator")
//    @GenericGenerator(name = "id", strategy = "uuid")
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

    @Column(name = "code")
    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "label_batch_id")
    @NotFound(action= NotFoundAction.IGNORE)
    public LabelBatch getLabelBatch() {
        return labelBatch;
    }

    public void setLabelBatch(LabelBatch labelBatch) {
        this.labelBatch = labelBatch;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "tenant_id")
    @Where(clause = "status='1'")
    @NotFound(action= NotFoundAction.IGNORE)
    public Tenant getSeller() {
        return seller;
    }

    public void setSeller(Tenant seller) {
        this.seller = seller;
    }

    @Column(name="status")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Column(name = "first_check_datetime")
    public Date getFirstCheckDateTime() {
        return firstCheckDateTime;
    }

    public void setFirstCheckDateTime(Date firstCheckDateTime) {
        this.firstCheckDateTime = firstCheckDateTime;
    }

    @Column(name = "last_check_datetime")
    public Date getLastCheckDateTime() {
        return lastCheckDateTime;
    }

    public void setLastCheckDateTime(Date lastCheckDateTime) {
        this.lastCheckDateTime = lastCheckDateTime;
    }

    @Column(name = "checked_count")
    public int getCheckCount() {
        return checkCount;
    }

    public void setCheckCount(int checkCount) {
        this.checkCount = checkCount;
    }

    @JsonIgnore
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "label")
    public List<LabelCheckRecord> getLabelCheckRecordList() {
        return labelCheckRecordList;
    }

    public void setLabelCheckRecordList(List<LabelCheckRecord> labelCheckRecordList) {
        this.labelCheckRecordList = labelCheckRecordList;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "purchase_order_label_id")
    @NotFound(action= NotFoundAction.IGNORE)
    public PurchaseOrderLabel getPurchaseOrderLabel() {
        return purchaseOrderLabel;
    }

    public void setPurchaseOrderLabel(PurchaseOrderLabel purchaseOrderLabel) {
        this.purchaseOrderLabel = purchaseOrderLabel;
    }

}
