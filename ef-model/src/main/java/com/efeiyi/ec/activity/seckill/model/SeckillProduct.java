package com.efeiyi.ec.activity.seckill.model;

import com.efeiyi.ec.product.model.ProductModel;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import javax.persistence.criteria.Fetch;
import java.math.BigDecimal;
import java.util.Date;

/**
 * Created by Administrator on 2015/11/17 0017.
 */
@Entity
@Table(name = "seckill_product")
@Inheritance(strategy = InheritanceType.JOINED)
public class SeckillProduct {

//    public static final String SECKILL_WIL = "1"; //即将开始
//    public static final String SECKILL_ING = "2"; //秒杀进行中
//    public static final String SECKILL_END = "3"; //秒杀已经结束


    private String id;
    private ProductModel productModel; //关联的商品
    private BigDecimal price; //秒杀的价格
    private Integer amount;//秒杀商品的库存 总库存
    private Integer usefulAmount; //可用库存
    private Integer orderAmount; //订单占用库存
    private Integer unusefulAmount ; //不可用库存
    private Date endDatetime; //秒杀结束时间
    private Date startDatetime; //秒杀开始时间
    private Integer attentionAmount; //关注数
    private Integer limitAmount; //限购数量
    private String status; //秒杀状态

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
    @JoinColumn(name = "product_model_id")
    public ProductModel getProductModel() {
        return productModel;
    }

    public void setProductModel(ProductModel productModel) {
        this.productModel = productModel;
    }


    @Column(name = "price")
    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    @Column(name = "amount")
    public Integer getAmount() {
        return amount;
    }

    public void setAmount(Integer amount) {
        this.amount = amount;
    }

    @Column(name = "end_datetime")
    public Date getEndDatetime() {
        return endDatetime;
    }

    public void setEndDatetime(Date endDatetime) {
        this.endDatetime = endDatetime;
    }

    @Column(name = "attention_amount")
    public Integer getAttentionAmount() {
        return attentionAmount;
    }

    public void setAttentionAmount(Integer attentionAmount) {
        this.attentionAmount = attentionAmount;
    }

    @Column(name = "status")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Column(name = "start_datetime")
    public Date getStartDatetime() {
        return startDatetime;
    }

    public void setStartDatetime(Date startDatetime) {
        this.startDatetime = startDatetime;
    }

    @Column(name = "limit_amount")
    public Integer getLimitAmount() {
        return limitAmount;
    }

    public void setLimitAmount(Integer limitAmount) {
        this.limitAmount = limitAmount;
    }

    @Column(name = "unuseful_amount")
    public Integer getUnusefulAmount() {
        return unusefulAmount;
    }

    public void setUnusefulAmount(Integer unusefulAmount) {
        this.unusefulAmount = unusefulAmount;
    }

    @Column(name = "order_amount")
    public Integer getOrderAmount() {
        return orderAmount;
    }

    public void setOrderAmount(Integer orderAmount) {
        this.orderAmount = orderAmount;
    }

    @Column(name = "useful_amount")
    public Integer getUsefulAmount() {
        return usefulAmount;
    }

    public void setUsefulAmount(Integer usefulAmount) {
        this.usefulAmount = usefulAmount;
    }

    @Override
    public String toString(){
        return  "SeckillProduct{id = "+id+"}";
    }
}
