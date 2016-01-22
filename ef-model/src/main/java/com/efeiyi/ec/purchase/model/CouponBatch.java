package com.efeiyi.ec.purchase.model;

import com.efeiyi.ec.product.model.Product;
import com.efeiyi.ec.project.model.Project;
import com.efeiyi.ec.tenant.model.Tenant;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

/**
 * Created by Administrator on 2015/8/10.
 */
@Entity
@Table(name = "purchase_coupon_batch")
@JsonIgnoreProperties(value = {"hibernateLazyInitializer", "handler"})
public class CouponBatch implements Serializable {
    private String id;
    private String name; //优惠券名称
    private Integer amount;//生成优惠券数量
    private Date startDate;//生效日期
    private Date endDate;//失效日期
    private List<Coupon> couponList;
    private Float price;//优惠价格
    private String status;//批次装填
    private Integer isCreatedCoupon;//是否创建了优惠券
    private Float priceLimit;//使用限制价格 比如满100用
    private String pictureUrl;//优惠券图片

    private String type; //优惠券类型  1 满减卷 2 现金卷  需要配置固定类型
    private String range; //优惠券使用范围 1 全场通用  2 品类使用 3 店铺使用 4 单品使用 需要在配置文件中配置一下固定类型
    private Project project; //品类  没有可以为空
    private Tenant tenant;  //店铺    没有可以为空
    private Product product; //单品   没有可以为空
    private String uniqueKey; //兑换码  需要系统生成  只有再发放方式为兑换码的时候才生成
    private String deliverType; //发放方式 1 发优惠券 2 发兑换码  3通码
    private String startReceiveTime;//领取时间起
    private String endReceiveTime;//领取时间止
    private String defaultFlag; //默认优惠券的标示  注册自动发放优惠券就发放有该标示的批次

    @Column(name = "default_flag")
    public String getDefaultFlag() {
        return defaultFlag;
    }

    public void setDefaultFlag(String defaultFlag) {
        this.defaultFlag = defaultFlag;
    }

    private String viewStatus;

    @Column(name = "start_receive_time")
    public String getStartReceiveTime() {
        return startReceiveTime;
    }

    public void setStartReceiveTime(String startReceiveTime) {
        this.startReceiveTime = startReceiveTime;
    }

    @Column(name = "end_receive_time")
    public String getEndReceiveTime() {
        return endReceiveTime;
    }

    public void setEndReceiveTime(String endReceiveTime) {
        this.endReceiveTime = endReceiveTime;
    }

    @Column(name = "cdkey")
    public String getUniqueKey() {
        return uniqueKey;
    }

    public void setUniqueKey(String uniqueKey) {
        this.uniqueKey = uniqueKey;
    }

    @Transient
    public String getViewStatus() {
        return viewStatus;
    }

    public void setViewStatus(String viewStatus) {
        this.viewStatus = viewStatus;
    }

    @Transient
    public String getStartDateString() {
        return startDateString;
    }

    public void setStartDateString(String startDateString) {
        this.startDateString = startDateString;
    }

    @Transient
    public String getEndDateString() {
        return endDateString;
    }

    public void setEndDateString(String endDateString) {
        this.endDateString = endDateString;
    }

    private String startDateString;
    private String endDateString;

    @Column(name = "picture_url")
    public String getPictureUrl() {
        return pictureUrl;
    }

    public void setPictureUrl(String pictureUrl) {
        this.pictureUrl = pictureUrl;
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

    @Column(name = "name")
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Column(name = "amount")
    public Integer getAmount() {
        return amount;
    }

    public void setAmount(Integer amount) {
        this.amount = amount;
    }

    @Column(name = "price")
    public Float getPrice() {
        return price;
    }

    public void setPrice(Float price) {
        this.price = price;
    }

    @Column(name = "start_date")
    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    @Column(name = "end_date")
    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    @JsonIgnore
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "couponBatch")
    public List<Coupon> getCouponList() {
        return couponList;
    }

    @Transient
    public List<Coupon> fetchCouponList() {
        List<Coupon> couponList = getCouponList();
        Iterator<Coupon> iterator = couponList.iterator();
        while (iterator.hasNext()) {
            Coupon coupon = iterator.next();
            if (coupon.getWhetherBind().equals("2")) { //已绑定
                iterator.remove();
            }
        }
        return couponList;
    }

    public void setCouponList(List<Coupon> couponList) {
        this.couponList = couponList;
    }

    @Column(name = "status")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Column(name = "is_created_coupon")
    public Integer getIsCreatedCoupon() {
        return isCreatedCoupon;
    }

    public void setIsCreatedCoupon(Integer isCreatedCoupon) {
        this.isCreatedCoupon = isCreatedCoupon;
    }

    @Column(name = "price_limit")
    public Float getPriceLimit() {
        return priceLimit;
    }

    public void setPriceLimit(Float priceLimit) {
        this.priceLimit = priceLimit;
    }

    @Column(name = "type")
    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    @Column(name = "use_range")
    public String getRange() {
        return range;
    }

    public void setRange(String range) {
        this.range = range;
    }

    @JsonIgnore
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "project_id")
    public Project getProject() {
        return project;
    }

    public void setProject(Project project) {
        this.project = project;
    }

    @JsonIgnore
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "tenant_id")
    public Tenant getTenant() {
        return tenant;
    }

    public void setTenant(Tenant tenant) {
        this.tenant = tenant;
    }

    @JsonIgnore
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_id")
    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    @Column(name = "deliver_type")
    public String getDeliverType() {
        return deliverType;
    }

    public void setDeliverType(String deliverType) {
        this.deliverType = deliverType;
    }

    @Override
    public String toString() {
        return "CouponBatch{id = " + id + "}";
    }
}
