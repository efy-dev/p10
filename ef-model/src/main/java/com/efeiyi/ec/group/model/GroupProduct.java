package com.efeiyi.ec.group.model;

import com.efeiyi.ec.product.model.Product;

import javax.persistence.*;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 * Created by Administrator on 2015/10/20.
 */
@Entity
@Table(name = "Group_Product")
public class GroupProduct implements Serializable {
    private String id;
    private Integer memberAmount;//参团人数限制
    private BigDecimal groupPrice; // 团购价格
    private Date createDateTime; //创建时间
    private BigDecimal bonus;// 分享的红包
    private Date groupPurchaseTime;// 成团时间
    private String status;// 状态标记
    private Product product; //商品
    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_id")
    public Product getProduct() {
        return product;
    }
}
