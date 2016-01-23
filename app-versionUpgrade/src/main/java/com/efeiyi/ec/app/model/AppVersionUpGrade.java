package com.efeiyi.ec.app.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.io.Serializable;

/**
 * Created by Administrator on 2016/1/18.
 *
 */
@Entity
@Table(name = "ef_app_version_upgrade")
@JsonIgnoreProperties(value = {"hibernateLazyInitializer", "handler"})
public class AppVersionUpGrade implements Serializable {
    private String id;
    private AppDevice appDevice;
    private String version_id;
    private String sub_version_id;
    private String version_code;
    private String type;
    private String apk_url;
    private String upgrade_point;
    private String status;
    private String create_time;
    private String update_time;
    @Id
    @GenericGenerator(name = "id", strategy = "com.ming800.core.p.model.M8idGenerator")
    @GeneratedValue(generator = "id")
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }
    @JsonIgnore
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "app_id")
    public AppDevice getAppDevice() {
        return appDevice;
    }

    public void setAppDevice(AppDevice appDevice) {
        this.appDevice = appDevice;
    }
    @Column(name = "version_id")
    public String getVersion_id() {
        return version_id;
    }
    public void setVersion_id(String version_id) {
        this.version_id = version_id;
    }
    @Column(name = "version_mini")
    public String getSub_version_id() {
        return sub_version_id;
    }

    public void setSub_version_id(String sub_version_id) {
        this.sub_version_id = sub_version_id;
    }
    @Column(name = "version_code")
    public String getVersion_code() {
        return version_code;
    }

    public void setVersion_code(String version_code) {
        this.version_code = version_code;
    }
    @Column(name = "type")
    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }
    @Column(name = "apk_url")
    public String getApk_url() {
        return apk_url;
    }

    public void setApk_url(String apk_url) {
        this.apk_url = apk_url;
    }
    @Column(name = "upgrade_point")
    public String getUpgrade_point() {
        return upgrade_point;
    }

    public void setUpgrade_point(String upgrade_point) {
        this.upgrade_point = upgrade_point;
    }
    @Column(name = "status")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
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
}
