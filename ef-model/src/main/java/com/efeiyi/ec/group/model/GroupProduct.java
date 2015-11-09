package com.efeiyi.ec.group.model;

import com.efeiyi.ec.product.model.ProductModel;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 * Created by Administrator on 2015/10/20.
 */
@Entity
@Table(name = "group_product")
public class GroupProduct implements Serializable {
    private String id;
    private Integer memberAmount;//参团人数限制
    private BigDecimal groupPrice; // 团购价格
    private Date createDateTime; //创建时间
    private BigDecimal bonus;// 分享的红包
    private Integer groupPurchaseTime;// 成团时间
    private String status;// 状态标记
    private ProductModel productModel; //商品
    @Id
    @GenericGenerator(name = "id", strategy = "com.ming800.core.p.model.M8idGenerator")
    @GeneratedValue(generator = "id")
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }
    @Column(name = "member_amount")
    public Integer getMemberAmount() {
        return memberAmount;
    }

    public void setMemberAmount(Integer memberAmount) {
        this.memberAmount = memberAmount;
    }
    @Column(name = "group_price")
    public BigDecimal getGroupPrice() {
        return groupPrice;
    }

    public void setGroupPrice(BigDecimal groupPrice) {
        this.groupPrice = groupPrice;
    }
    @Column(name = "create_datetime")
    public Date getCreateDateTime() {
        return createDateTime;
    }

    public void setCreateDateTime(Date createDateTime) {
        this.createDateTime = createDateTime;
    }
    @Column(name = "bonus")
    public BigDecimal getBonus() {
        return bonus;
    }

    public void setBonus(BigDecimal bonus) {
        this.bonus = bonus;
    }
    @Column(name = "group_purchase_time")
    public Integer getGroupPurchaseTime() {
        return groupPurchaseTime;
    }

    public void setGroupPurchaseTime(Integer groupPurchaseTime) {
        this.groupPurchaseTime = groupPurchaseTime;
    }
    @Column(name = "status")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_id")
    public ProductModel getProductModel() {
        return productModel;
    }
    public void setProductModel(ProductModel productModel) {
        this.productModel = productModel;
    }
}
