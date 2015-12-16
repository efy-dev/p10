package com.efeiyi.ec.purchase.model;

import com.efeiyi.ec.zero.company.model.CompanyOrderBatch;
import com.fasterxml.jackson.annotation.JsonIgnore;

import javax.persistence.*;

/**
 * Created by Administrator on 2015/11/19 0019.
 */
@Entity
@Table(name = "purchase_order_gift")
public class PurchaseOrderGift extends PurchaseOrder {

    private String giftMessage;
    private String showGiftNameStatus; //0不显示 1显示
    private String showGiftPriceStatus; // 0 不显示 1 显示
    private String giftPictureUrl ; //礼物图片
    private String giftGaverName;  //送礼人姓名
    private CompanyOrderBatch companyOrderBatch;//企业礼品卡批次

    @Column(name = "gift_gaver_name")
    public String getGiftGaverName() {
        return giftGaverName;
    }

    public void setGiftGaverName(String giftGaverName) {
        this.giftGaverName = giftGaverName;
    }

    @Column(name = "gift_message")
    public String getGiftMessage() {
        return giftMessage;
    }

    public void setGiftMessage(String giftMessage) {
        this.giftMessage = giftMessage;
    }

    @Column(name = "show_gift_name_status")
    public String getShowGiftNameStatus() {
        return showGiftNameStatus;
    }

    public void setShowGiftNameStatus(String showGiftNameStatus) {
        this.showGiftNameStatus = showGiftNameStatus;
    }

    @Column(name = "show_gift_price_status")
    public String getShowGiftPriceStatus() {
        return showGiftPriceStatus;
    }

    public void setShowGiftPriceStatus(String showGiftPriceStatus) {
        this.showGiftPriceStatus = showGiftPriceStatus;
    }

    @Column(name = "gift_picture_url")
    public String getGiftPictureUrl() {
        return giftPictureUrl;
    }

    public void setGiftPictureUrl(String giftPictureUrl) {
        this.giftPictureUrl = giftPictureUrl;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "zero_company_order_batch_id")
    @JsonIgnore
    public CompanyOrderBatch getCompanyOrderBatch() {
        return companyOrderBatch;
    }

    public void setCompanyOrderBatch(CompanyOrderBatch companyOrderBatch) {
        this.companyOrderBatch = companyOrderBatch;
    }
}
