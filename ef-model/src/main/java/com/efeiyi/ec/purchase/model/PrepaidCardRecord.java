package com.efeiyi.ec.purchase.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.math.BigDecimal;


@Entity
@Table(name = "prepaid_card_record")
@JsonIgnoreProperties(value = {"hibernateLazyInitializer", "handler"})
public class PrepaidCardRecord {

    public final static String TYPE_ADD = "0"; //类型为加
    public final static String TYPE_SUB = "1"; //类型为减

    public final static String STATUS_DELETED = "0";
    public final static String STATUS_USED = "1";
    public final static String STATUS_INIT = "2";

    private String id;
    private BigDecimal value;
    private String targetId;
    private PrepaidCard prepaidCard;
    private String status; //0:删除 1：使用 2：初始化
    private String type;

    public PrepaidCardRecord() {
    }

    public PrepaidCardRecord(BigDecimal value, String targetId, PrepaidCard prepaidCard, String type) {
        this.value = value;
        this.targetId = targetId;
        this.prepaidCard = prepaidCard;
        this.status = STATUS_INIT;
        this.type = type;
    }

    @Id
    @GenericGenerator(name = "id", strategy = "com.ming800.core.p.model.M8idGenerator")
    @GeneratedValue(generator = "id")
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @Column(name = "value")
    public BigDecimal getValue() {
        return value;
    }

    public void setValue(BigDecimal value) {
        this.value = value;
    }

    @Column(name = "target_id")
    public String getTargetId() {
        return targetId;
    }

    public void setTargetId(String targetId) {
        this.targetId = targetId;
    }

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "prepaid_card_id")
    public PrepaidCard getPrepaidCard() {
        return prepaidCard;
    }

    public void setPrepaidCard(PrepaidCard prepaidCard) {
        this.prepaidCard = prepaidCard;
    }


    @Column(name = "status")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }


    @Column(name = "type")
    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }
}
