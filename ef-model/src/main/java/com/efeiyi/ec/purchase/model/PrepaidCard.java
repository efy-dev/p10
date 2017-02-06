package com.efeiyi.ec.purchase.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;


@Entity
@Table(name = "prepaid_card")
public class PrepaidCard {

    private String id;
    private String name;
    private String code;    //编码
    private String status;  //状态
    private BigDecimal totalValue; //总值
    private String type;   //类型
    private List<PrepaidCardRecord> prepaidCardRecordList; //使用记录
    private Date createDatetime; //创建时间

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
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Column(name = "code")
    public String getCode() {
        return code;
    }


    public void setCode(String code) {
        this.code = code;
    }

    @Column(name = "status")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }


    @Column(name = "total_value")
    public BigDecimal getTotalValue() {
        return totalValue;
    }

    public void setTotalValue(BigDecimal totalValue) {
        this.totalValue = totalValue;
    }


    @Column(name = "type")
    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    @Column(name = "create_datetime")
    public Date getCreateDatetime() {
        return createDatetime;
    }

    public void setCreateDatetime(Date createDatetime) {
        this.createDatetime = createDatetime;
    }


    @OneToMany(fetch = FetchType.LAZY, mappedBy = "prepaidCard")
    @JsonIgnore
    public List<PrepaidCardRecord> getPrepaidCardRecordList() {
        return prepaidCardRecordList;
    }

    public void setPrepaidCardRecordList(List<PrepaidCardRecord> prepaidCardRecordList) {
        this.prepaidCardRecordList = prepaidCardRecordList;
    }


    @Transient
    public BigDecimal getBalance() {
        BigDecimal used = BigDecimal.valueOf(0);
        BigDecimal result = getTotalValue();
        List<PrepaidCardRecord> recordList = getPrepaidCardRecordList();
        for (PrepaidCardRecord record : recordList) {
            if (record.getStatus().equals("1") && record.getType().equals(PrepaidCardRecord.TYPE_ADD)) {
                used = used.add(record.getValue());
            } else if (record.getStatus().equals("1") && record.getType().equals(PrepaidCardRecord.TYPE_SUB)) {
                used = used.subtract(record.getValue());
            }
        }

        result = result.subtract(used);

        if (result.compareTo(BigDecimal.valueOf(0)) == -1) {
            return BigDecimal.valueOf(0);
        } else {
            return result;
        }
    }

}
