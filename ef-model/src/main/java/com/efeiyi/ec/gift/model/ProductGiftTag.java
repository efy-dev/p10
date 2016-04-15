package com.efeiyi.ec.gift.model;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;

/**
 * Created by Administrator on 2016/4/14 0014.
 */
@Entity
@Table(name = "product_gift_tag")
public class ProductGiftTag {

    private String id;
    private ProductGift productGift; //标签对应的礼品
    private ProductGiftTagValue productGiftTagValue; //标签对应的标签值
    private String statue; //标签的状态 0删除 1正常


    @Id
    @GenericGenerator(name = "id", strategy = "com.ming800.core.p.model.M8idGenerator")
    @GeneratedValue(generator = "id")
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_gift_id")
    public ProductGift getProductGift() {
        return productGift;
    }

    public void setProductGift(ProductGift productGift) {
        this.productGift = productGift;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_gift_tag_value")
    public ProductGiftTagValue getProductGiftTagValue() {
        return productGiftTagValue;
    }

    public void setProductGiftTagValue(ProductGiftTagValue productGiftTagValue) {
        this.productGiftTagValue = productGiftTagValue;
    }

    @Column(name = "status")
    public String getStatue() {
        return statue;
    }

    public void setStatue(String statue) {
        this.statue = statue;
    }
}
