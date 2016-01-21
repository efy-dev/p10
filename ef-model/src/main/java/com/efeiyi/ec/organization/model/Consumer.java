package com.efeiyi.ec.organization.model;

import com.efeiyi.ec.wiki.model.ProjectContent;

import javax.persistence.*;
import java.math.BigDecimal;
import java.util.List;

/**
 * Created by Administrator on 2015/5/28.
 */
@Entity
@Table(name = "organization_consumer")
public class Consumer extends BigUser {
    private BigDecimal deposit;
    private Integer score;
    private String unionid;
    private BigDecimal balance;
    //private List<ProjectContent> projectContents;

    @Column(name = "deposit")
    public BigDecimal getDeposit() {
        return deposit;
    }

    public void setDeposit(BigDecimal deposit) {
        this.deposit = deposit;
    }

    @Column(name = "score")
    public Integer getScore() {
        return score;
    }

    public void setScore(Integer score) {
        this.score = score;
    }

    @Column(name = "unionid")
    public String getUnionid() {
        return unionid;
    }

    public void setUnionid(String unionid) {
        this.unionid = unionid;
    }

    @Column(name = "balance")
    public BigDecimal getBalance() {
        return balance;
    }

    public void setBalance(BigDecimal balance) {
        this.balance = balance;
    }

   /* @ManyToMany(fetch = FetchType.LAZY,mappedBy = "consumer")
    public List<ProjectContent> getProjectContents() {
        return projectContents;
    }

    public void setProjectContents(List<ProjectContent> projectContents) {
        this.projectContents = projectContents;
    }*/
   @Override
   public String toString() {
       return "Consumer{id = " + id + "}";
   }
}
