package com.efeiyi.ec.activity.seckill.model;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.util.Date;

/**
 * Created by Administrator on 2015/12/4 0004.
 */

//CREATE TABLE `activity_seckill_record` (
//        `id`  char(16) NOT NULL ,
//        `user_id`  char(16) NULL ,
//        `seckill_product_id`  char(16) NULL ,
//        `create_datetime`  datetime NULL ,
//        PRIMARY KEY (`id`)
//        )
//        ;

@Entity
@Table(name = "activity_seckill_record")
public class SeckillRecord {

    private String id;
    private String userId;
    private String seckillProductId;
    private Date createDatetime;

    @Id
    @GenericGenerator(name = "id", strategy = "com.ming800.core.p.model.M8idGenerator")
    @GeneratedValue(generator = "id")
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @Column(name = "user_id")
    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }



    @Column(name = "seckill_product_id")
    public String getSeckillProductId() {
        return seckillProductId;
    }

    public void setSeckillProductId(String seckillProductId) {
        this.seckillProductId = seckillProductId;
    }



    @Column(name = "create_datetime")
    public Date getCreateDatetime() {
        return createDatetime;
    }

    public void setCreateDatetime(Date createDatetime) {
        this.createDatetime = createDatetime;
    }
}
