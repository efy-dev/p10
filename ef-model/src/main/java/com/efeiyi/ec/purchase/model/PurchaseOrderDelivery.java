package com.efeiyi.ec.purchase.model;

import com.efeiyi.ec.organization.model.ConsumerAddress;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.util.Date;
import java.util.HashMap;

/**
 * Created by Administrator on 2015/5/28.
 */
@Entity
@Table(name = "purchase_order_delivery")
public class PurchaseOrderDelivery {

//                            <item label="顺丰" value="shunfeng"/>
//                        <item label="圆通" value="yuantong"/>
//                        <item label="申通" value="shentong"/>
//                        <item label="中通" value="zhongtong"/>
//                        <item label="韵达" value="yunda"/>
//                        <item label="宅急送" value="zhaijisong"/>
//                        <item label="EMS" value="ems"/>
//                        <item label="汇通快运" value="huitongkuaidi"/>
//                        <item label="天天快递" value="tiantian"/>
//                        <item label="UPS" value="ups"/>
//                        <item label="德邦物流" value="debangwuliu"/>
//                        <item label="国通快递" value="guotongkuaidi"/>
    public static HashMap<String,String> deliveryMap = new HashMap<>();

    static {
        deliveryMap.put("shunfeng","顺丰");
        deliveryMap.put("yuantong","圆通");
        deliveryMap.put("shentong","申通");
        deliveryMap.put("yunda","韵达");
        deliveryMap.put("zhaijisong","宅急送");
        deliveryMap.put("ems","EMS");
        deliveryMap.put("huitongkuaidi","汇通快运");
        deliveryMap.put("tiantian","天天快递");
        deliveryMap.put("ups","UPS");
        deliveryMap.put("debangwuliu","德邦物流");
        deliveryMap.put("guotongkuaidi","国通快递");
    }



    private String id;
    private PurchaseOrder purchaseOrder;
    private ConsumerAddress consumerAddress;
    private Date createDateTime;
    private String serial;
    private String status; // 1已发货 2未发货
    private String logisticsCompany;//物流公司
    private String bigPen; //物流bigpen

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
    @JoinColumn(name = "purchase_order_id")
    public PurchaseOrder getPurchaseOrder() {
        return purchaseOrder;
    }

    public void setPurchaseOrder(PurchaseOrder purchaseOrder) {
        this.purchaseOrder = purchaseOrder;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name="user_address_id")
    public ConsumerAddress getConsumerAddress() {
        return consumerAddress;
    }

    public void setConsumerAddress(ConsumerAddress consumerAddress) {
        this.consumerAddress = consumerAddress;
    }

    @Column(name = "create_datetime")
    public Date getCreateDateTime() {
        return createDateTime;
    }

    public void setCreateDateTime(Date createDateTime) {
        this.createDateTime = createDateTime;
    }

    @Column(name = "serial")
    public String getSerial() {
        return serial;
    }

    public void setSerial(String serial) {
        this.serial = serial;
    }

    @Column(name = "status")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Column(name= "logistics_company")
    public String getLogisticsCompany() {
        return logisticsCompany;
    }

    public void setLogisticsCompany(String logisticsCompany) {
        this.logisticsCompany = logisticsCompany;
    }

    @Column(name = "big_pen")
    public String getBigPen() {
        return bigPen;
    }

    public void setBigPen(String bigPen) {
        this.bigPen = bigPen;
    }


    @Override
    public String toString() {
        return "PurchaseOrderDelivery{id = " + id + "}";
    }
}
