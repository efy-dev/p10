package com.efeiyi.ec.gift.model;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
/**
 * Created by Administrator on 2016/4/14 0014.
 */
@Entity
@Table(name = "gift_product_gift_industry_solution")
public class ProductGiftIndustrySolution {

    private String id;
    private IndustrySolution industrySolution;  //行业解决方案
    private ProductGift productGift;    //解决方案对应的一个礼品
    private String status;  //状态

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
    @JoinColumn(name = "industry_solution_id")
    public IndustrySolution getIndustrySolution() {
        return industrySolution;
    }

    public void setIndustrySolution(IndustrySolution industrySolution) {
        this.industrySolution = industrySolution;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_gift_id")
    public ProductGift getProductGift() {
        return productGift;
    }

    public void setProductGift(ProductGift productGift) {
        this.productGift = productGift;
    }

    @Column(name = "status")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
