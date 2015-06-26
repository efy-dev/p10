package com.efeiyi.ec.organization.model;

import com.efeiyi.ec.tenant.model.Tenant;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.math.BigDecimal;

/**
 * Created by Administrator on 2015/5/28.
 */
@Entity
@Table(name = "organization_consumer")
public class Consumer extends BigUser{
    private BigDecimal deposit;
    private Integer score;

    @Column(name="deposit")
    public BigDecimal getDeposit() {
        return deposit;
    }

    public void setDeposit(BigDecimal deposit) {
        this.deposit = deposit;
    }

    @Column(name="score")
    public Integer getScore() {
        return score;
    }

    public void setScore(Integer score) {
        this.score = score;
    }
}
