package com.efeiyi.ec.art.version.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.io.Serializable;

/**
 * Created by Administrator on 2016/1/18.
 */
@Entity
@Table(name = "ef_app_info")
@JsonIgnoreProperties(value = {"hibernateLazyInitializer", "handler"})
public class AppDevice  implements Serializable{
    private String id;
    private String name;
    private String is_encryption;
    private String key;
    private String create_time;
    private String update_time;
    private String status;
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
    @Column(name = "is_encryption")
    public String getIs_encryption() {
        return is_encryption;
    }

    public void setIs_encryption(String is_encryption) {
        this.is_encryption = is_encryption;
    }
    @Column(name = "key")
    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }

    @Column(name = "create_time")
    public String getCreate_time() {
        return create_time;
    }

    public void setCreate_time(String create_time) {
        this.create_time = create_time;
    }
    @Column(name = "update_time")
    public String getUpdate_time() {
        return update_time;
    }

    public void setUpdate_time(String update_time) {
        this.update_time = update_time;
    }
    @Column(name = "status")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
