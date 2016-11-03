package com.ming800.core.p.model;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.util.Date;

/**
 * Created by Administrator on 2015/11/26 0026.
 */
@Entity
@Table(name = "wx_called_record")
public class WxCalledRecord {

    private String id;
    private String dataKey;     //数据的键
    private String data;        //需要存储的数据
    private String accessToken; //微信授权
    private String callback;    //接口回调
    private String requestSource; //请求来源
    private Date createDatetime; //请求时间
    private String consumerId;    //目标用户的id (非必须)


    public WxCalledRecord(String dataKey, String data, String callback) {
        this.dataKey = dataKey;
        this.data = data;
        this.callback = callback;
        this.createDatetime = new Date();
    }

    public WxCalledRecord() {
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

    @Column(name = "data_key")
    public String getDataKey() {
        return dataKey;
    }

    public void setDataKey(String dataKey) {
        this.dataKey = dataKey;
    }

    @Column(name = "data")
    public String getData() {
        return data;
    }

    public void setData(String data) {
        this.data = data;
    }

    @Column(name = "access_token")
    public String getAccessToken() {
        return accessToken;
    }

    public void setAccessToken(String accessToken) {
        this.accessToken = accessToken;
    }

    @Column(name = "callback")
    public String getCallback() {
        return callback;
    }

    public void setCallback(String callback) {
        this.callback = callback;
    }

    @Column(name = "request_source")
    public String getRequestSource() {
        return requestSource;
    }

    public void setRequestSource(String requestSource) {
        this.requestSource = requestSource;
    }

    @Column(name = "create_datetime")
    public Date getCreateDatetime() {
        return createDatetime;
    }

    public void setCreateDatetime(Date createDatetime) {
        this.createDatetime = createDatetime;
    }


    @Column(name = "consumer_id")
    public String getConsumerId() {
        return consumerId;
    }

    public void setConsumerId(String consumerId) {
        this.consumerId = consumerId;
    }
}
