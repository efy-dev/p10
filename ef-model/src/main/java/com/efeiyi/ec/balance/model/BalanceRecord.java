package com.efeiyi.ec.balance.model;

import com.efeiyi.ec.organization.model.Consumer;
import com.fasterxml.jackson.annotation.JsonIgnore;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.math.BigDecimal;
import java.util.Date;

/**
 * Created by Administrator on 2016/1/8.
 */
@Entity
@Table(name = "balance_record")
public class BalanceRecord {

    private String id;
    private BigDecimal currentBalance;
    private BigDecimal changeBalance;
    private BigDecimal resultBalance;
    private String type;
    private String status;
    private String key;
    private Date createDateTime;
    private Consumer consumer;

    @Id
    @GenericGenerator(name = "id", strategy = "com.ming800.core.p.model.M8idGenerator")
    @GeneratedValue(generator = "id")
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @Column(name = "current_balance")
    public BigDecimal getCurrentBalance() {
        return currentBalance;
    }

    public void setCurrentBalance(BigDecimal currentBalance) {
        this.currentBalance = currentBalance;
    }

    @Column(name = "change_balance")
    public BigDecimal getChangeBalance() {
        return changeBalance;
    }

    public void setChangeBalance(BigDecimal changeBalance) {
        this.changeBalance = changeBalance;
    }

    @Column(name = "result_balance")
    public BigDecimal getResultBalance() {
        return resultBalance;
    }

    public void setResultBalance(BigDecimal resultBalance) {
        this.resultBalance = resultBalance;
    }

    @Column(name = "type")
    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    @Column(name = "status")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Column(name = "key")
    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }

    @Column(name = "create_date_time")
    public Date getCreateDateTime() {
        return createDateTime;
    }

    public void setCreateDateTime(Date createDateTime) {
        this.createDateTime = createDateTime;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "consumer_id")
    @JsonIgnore
    public Consumer getConsumer() {
        return consumer;
    }

    public void setConsumer(Consumer consumer) {
        this.consumer = consumer;
    }
}
