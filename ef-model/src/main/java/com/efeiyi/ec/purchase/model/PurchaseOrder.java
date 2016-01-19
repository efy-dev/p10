package com.efeiyi.ec.purchase.model;

import com.efeiyi.ec.organization.model.*;
import com.efeiyi.ec.tenant.model.BigTenant;
import com.efeiyi.ec.tenant.model.Tenant;
import com.efeiyi.ec.zero.promotion.model.PromotionPlan;
import com.fasterxml.jackson.annotation.JsonIgnore;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

/**
 * Created by Administrator on 2015/5/28.
 */
@Entity
@Table(name = "purchase_order")
@Inheritance(strategy = InheritanceType.JOINED)
public class PurchaseOrder {

    public static final String ORDER_STATUS_WPAY = "1";  //等待付款
    public static final String ORDER_STATUS_WAIT_GROUP = "3"; //等待成团
    public static final String ORDER_STATUS_WRECEIVE = "5"; //未发货
    public static final String ORDER_STATUS_WPOST = "51"; //已确认 发货中
    public static final String ORDER_STATUS_WRGIFT = "6"; //待收礼
    public static final String ORDER_STATUS_POSTED = "7";  //已发货
    public static final String ORDER_STATUS_UNCOMMENT = "9"; //未评价
    public static final String ORDER_STATUS_FINISHED = "13"; //已完成
    public static final String ORDER_STATUS_REFUND = "15"; //已退款
    public static final String ORDER_STATUS_CONSEL = "17"; //已取消
    public static final String ORDER_STATUS_SCANNING = "19"; //待扫运单

    //支付方式
    public static final String ZHIFUBAO = "1"; //支付宝
    public static final String YINHANGKA = "2"; //银行卡
    public static final String WEIXIN = "3";    //微信支付
    public static final String YOUHUIQUAN = "4";    //优惠券
    public static final String YUE = "5";       //余额

    private String id;
    private String serial;          //订单号
    private List<PurchaseOrderProduct> purchaseOrderProductList;
    private List<PurchaseOrderDelivery> purchaseOrderDeliveryList;  //发货记录 订单配送
    private List<PurchaseOrderPayment> purchaseOrderPaymentList;
    private Date createDatetime;       //下单时间
    private User user;
    private ConsumerAddress consumerAddress;  //收获地址
    private String status;//0假删 1正常 2企业礼品卡  9虚拟订单
    private BigDecimal total;  //订单总价
    private BigDecimal originalPrice; //订单原价
    private String orderStatus; //订单状态
    private Tenant tenant;
    private BigTenant bigTenant;
    private List<PurchaseOrder> subPurchaseOrder;
    private PurchaseOrder fatherPurchaseOrder;
    private String payWay; //订单的支付方式 1支付宝 2银行卡 3微信 4优惠券 5.余额
    private String message; //买家留言
    private Coupon coupon; //优惠券
    private String purchaseOrderAddress;//收货人地址
    private String receiverName;//收货人姓名
    private String receiverPhone;//收货人联系方式
    private String callback; //回调
    private String orderType; // 1.普通类型 2.秒杀类型 3.礼品卷类型 4.团购类型 5.企业礼品卡类型
    private String source;//来源推广渠道

    private AddressProvince province;
    private AddressDistrict district;
    private AddressCity city;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "address_province_id")
    @JsonIgnore
    public AddressProvince getProvince() {
        return province;
    }

    public void setProvince(AddressProvince province) {
        this.province = province;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "address_city_id")
    @JsonIgnore
    public AddressCity getCity() {
        return city;
    }

    public void setCity(AddressCity city) {
        this.city = city;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "address_district_id")
    @JsonIgnore
    public AddressDistrict getDistrict() {
        return district;
    }

    public void setDistrict(AddressDistrict district) {
        this.district = district;
    }


    @Column(name = "callback")
    public String getCallback() {
        return callback;
    }

    public void setCallback(String callback) {
        this.callback = callback;
    }

    @Column(name = "purchase_order_address")
    public String getPurchaseOrderAddress() {
        return purchaseOrderAddress;
    }

    public void setPurchaseOrderAddress(String purchaseOrderAddress) {
        this.purchaseOrderAddress = purchaseOrderAddress;
    }

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "coupon_id")
    @JsonIgnore
    public Coupon getCoupon() {
        return coupon;
    }

    public void setCoupon(Coupon coupon) {
        this.coupon = coupon;
    }

    @Column(name = "message")
    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "fatherPurchaseOrder")
    @JsonIgnore
    public List<PurchaseOrder> getSubPurchaseOrder() {
        return subPurchaseOrder;
    }

    public void setSubPurchaseOrder(List<PurchaseOrder> subPurchaseOrder) {
        this.subPurchaseOrder = subPurchaseOrder;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "father_purchase_order_id")
    @JsonIgnore
    public PurchaseOrder getFatherPurchaseOrder() {
        return fatherPurchaseOrder;
    }

    public void setFatherPurchaseOrder(PurchaseOrder fatherPurchaseOrder) {
        this.fatherPurchaseOrder = fatherPurchaseOrder;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "tenant_id")
    @JsonIgnore
    public Tenant getTenant() {
        return tenant;
    }

    public void setTenant(Tenant tenant) {
        this.tenant = tenant;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "tenant_id", updatable = false, insertable = false)
    @JsonIgnore
    public BigTenant getBigTenant() {
        return bigTenant;
    }

    public void setBigTenant(BigTenant bigTenant) {
        this.bigTenant = bigTenant;
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

    @Column(name = "serial")
    public String getSerial() {
        return serial;
    }

    public void setSerial(String serial) {
        this.serial = serial;
    }

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "purchaseOrder", cascade = CascadeType.ALL)
    @JsonIgnore
    public List<PurchaseOrderProduct> getPurchaseOrderProductList() {
        return purchaseOrderProductList;
    }

    public void setPurchaseOrderProductList(List<PurchaseOrderProduct> purchaseOrderProductList) {
        this.purchaseOrderProductList = purchaseOrderProductList;
    }

    @Column(name = "create_datetime")
    public Date getCreateDatetime() {
        return createDatetime;
    }

    public void setCreateDatetime(Date createDatetime) {
        this.createDatetime = createDatetime;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }


    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_address_id")
    @JsonIgnore
    public ConsumerAddress getConsumerAddress() {
        return consumerAddress;
    }

    public void setConsumerAddress(ConsumerAddress consumerAddress) {
        this.consumerAddress = consumerAddress;
    }


    @OneToMany(fetch = FetchType.LAZY, mappedBy = "purchaseOrder", cascade = CascadeType.ALL)
    @JsonIgnore
    public List<PurchaseOrderDelivery> getPurchaseOrderDeliveryList() {
        return purchaseOrderDeliveryList;
    }

    public void setPurchaseOrderDeliveryList(List<PurchaseOrderDelivery> purchaseOrderDeliveryList) {
        this.purchaseOrderDeliveryList = purchaseOrderDeliveryList;
    }

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "purchaseOrder", cascade = CascadeType.ALL)
    @JsonIgnore
    public List<PurchaseOrderPayment> getPurchaseOrderPaymentList() {
        return purchaseOrderPaymentList;
    }

    public void setPurchaseOrderPaymentList(List<PurchaseOrderPayment> purchaseOrderPaymentList) {
        this.purchaseOrderPaymentList = purchaseOrderPaymentList;
    }

    @Column(name = "status")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Column(name = "total")
    public BigDecimal getTotal() {
        return total;
    }

    public void setTotal(BigDecimal total) {
        this.total = total;
    }

    @Column(name = "order_status")
    public String getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
    }

    @Column(name = "original_price")
    public BigDecimal getOriginalPrice() {
        return originalPrice;
    }

    public void setOriginalPrice(BigDecimal originalPrice) {
        this.originalPrice = originalPrice;
    }

    @Column(name = "receiver_name")
    public String getReceiverName() {
        return receiverName;
    }

    public void setReceiverName(String receiverName) {
        this.receiverName = receiverName;
    }

    @Column(name = "receiver_phone")
    public String getReceiverPhone() {
        return receiverPhone;
    }

    public void setReceiverPhone(String receiverPhone) {
        this.receiverPhone = receiverPhone;
    }

    @Column(name = "payway")
    public String getPayWay() {
        return payWay;
    }

    public void setPayWay(String payWay) {
        this.payWay = payWay;
    }

    @Column(name = "order_type")
    public String getOrderType() {
        return orderType;
    }

    public void setOrderType(String orderType) {
        this.orderType = orderType;
    }

    @Transient
    public BigDecimal getRealPayMoney() {
        List<PurchaseOrderPayment> purchaseOrderPaymentList = getPurchaseOrderPaymentList();
        BigDecimal resultPrice = new BigDecimal(0);
        for (PurchaseOrderPayment purchaseOrderPaymentTemp : purchaseOrderPaymentList) {
            for (PurchaseOrderPaymentDetails purchaseOrderPaymentDetails : purchaseOrderPaymentTemp.getPurchaseOrderPaymentDetailsList()) {
                if (purchaseOrderPaymentDetails.getCoupon() == null && purchaseOrderPaymentDetails.getTransactionNumber() != null) {
                    resultPrice = resultPrice.add(purchaseOrderPaymentDetails.getMoney());
                }
            }
        }
        resultPrice = resultPrice.setScale(2, BigDecimal.ROUND_HALF_UP);
        return resultPrice;
    }

    @Transient
    public BigDecimal getOrderPayMoney() {
        BigDecimal couponPrice = new BigDecimal(0);
        BigDecimal spendBalance = new BigDecimal(0);
        if (this.getOrderStatus().equals("1") || this.getOrderStatus().equals("17")) {
            PurchaseOrderPayment purchaseOrderPaymentTemp = this.getPurchaseOrderPaymentList().get(0);
            for (PurchaseOrderPaymentDetails purchaseOrderPaymentDetailsTemp : purchaseOrderPaymentTemp.getPurchaseOrderPaymentDetailsList()) {
                if (purchaseOrderPaymentDetailsTemp.getPayWay().equals("4")) {
                    couponPrice = couponPrice.add(BigDecimal.valueOf(purchaseOrderPaymentDetailsTemp.getCoupon().getCouponBatch().getPrice()));

                }
                if (purchaseOrderPaymentDetailsTemp.getPayWay().equals("5")) {
                    spendBalance = purchaseOrderPaymentDetailsTemp.getMoney();

                }
            }
        } else {
            for (PurchaseOrderPayment purchaseOrderPaymentTemp : this.getPurchaseOrderPaymentList()) {
                if (purchaseOrderPaymentTemp.getStatus().equals("2")) {
                    for (PurchaseOrderPaymentDetails purchaseOrderPaymentDetailsTemp : purchaseOrderPaymentTemp.getPurchaseOrderPaymentDetailsList()) {
                        if (purchaseOrderPaymentDetailsTemp.getPayWay().equals("4")) {
                            couponPrice = couponPrice.add(BigDecimal.valueOf(purchaseOrderPaymentDetailsTemp.getCoupon().getCouponBatch().getPrice()));

                        }
                        if (purchaseOrderPaymentDetailsTemp.getPayWay().equals("5")) {
                            spendBalance = purchaseOrderPaymentDetailsTemp.getMoney();

                        }

                    }

                }

            }
        }
        couponPrice = couponPrice.setScale(2, BigDecimal.ROUND_HALF_UP);
        BigDecimal count = new BigDecimal(0);
        count.add(couponPrice);
        count.add(spendBalance);
        return count;

    }

    @Column(name = "source")
    public String getSource() {
        return source;
    }

    public void setSource(String source) {
        this.source = source;
    }
}
