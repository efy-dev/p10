package com.efeiyi.ec.yale.question.model;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.math.BigDecimal;

/**
 * Created by Administrator on 2015/12/29.
 * 答题设置 model
 */
@Entity
@Table(name = "yale_weixin_question_setting")
public class QuestionSetting {

    private String id;
    private Integer rank11;//阶段一开始  第1名到100名奖励10元，阶段一开始=1
    private Integer rank12;//阶段一结束                     阶段一结束=100
    private BigDecimal prize10;//阶段一奖励                 阶段一奖励=10
    private Integer rank21;//阶段二开始
    private Integer rank22;//阶段二结束
    private BigDecimal prize20;//阶段二奖励
    private Integer rank31;//阶段三开始
    private Integer rank32;//阶段三结束
    private BigDecimal prize30;//阶段三奖励
    private BigDecimal commonPrize;//普通奖励
    private String commonPrizeTrue;//是否启用普通奖  0不启用  1启用
    private String couponUrl;//优惠券地址
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

    @Column(name = "rank_11")
    public Integer getRank11() {
        return rank11;
    }

    public void setRank11(Integer rank11) {
        this.rank11 = rank11;
    }

    @Column(name = "rank_12")
    public Integer getRank12() {
        return rank12;
    }

    public void setRank12(Integer rank12) {
        this.rank12 = rank12;
    }

    @Column(name = "prize_10")
    public BigDecimal getPrize10() {
        return prize10;
    }

    public void setPrize10(BigDecimal prize10) {
        this.prize10 = prize10;
    }

    @Column(name = "rank_21")
    public Integer getRank21() {
        return rank21;
    }

    public void setRank21(Integer rank21) {
        this.rank21 = rank21;
    }

    @Column(name = "rank_22")
    public Integer getRank22() {
        return rank22;
    }

    public void setRank22(Integer rank22) {
        this.rank22 = rank22;
    }

    @Column(name = "prize_20")
    public BigDecimal getPrize20() {
        return prize20;
    }

    public void setPrize20(BigDecimal prize20) {
        this.prize20 = prize20;
    }

    @Column(name = "rank_31")
    public Integer getRank31() {
        return rank31;
    }

    public void setRank31(Integer rank31) {
        this.rank31 = rank31;
    }

    @Column(name = "rank_32")
    public Integer getRank32() {
        return rank32;
    }

    public void setRank32(Integer rank32) {
        this.rank32 = rank32;
    }

    @Column(name = "prize_30")
    public BigDecimal getPrize30() {
        return prize30;
    }

    public void setPrize30(BigDecimal prize30) {
        this.prize30 = prize30;
    }

    @Column(name = "common_prize")
    public BigDecimal getCommonPrize() {
        return commonPrize;
    }

    public void setCommonPrize(BigDecimal commonPrize) {
        this.commonPrize = commonPrize;
    }

    @Column(name = "common_prize_true")
    public String getCommonPrizeTrue() {
        return commonPrizeTrue;
    }

    public void setCommonPrizeTrue(String commonPrizeTrue) {
        this.commonPrizeTrue = commonPrizeTrue;
    }

    @Column(name = "coupon_url")
    public String getCouponUrl() {
        return couponUrl;
    }

    public void setCouponUrl(String couponUrl) {
        this.couponUrl = couponUrl;
    }

    @Column(name = "status")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
