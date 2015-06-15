package com.ming800.core.p.model;


import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.util.Date;

/**
 * Created with IntelliJ IDEA.
 * User: ming
 * Date: 12-11-6
 * Time: 上午9:52
 * To change this template use File | Settings | File Templates.
 */
@Entity
@Table(name = "core_p_system_log")
public class SystemLog {
    private String id;
    private String content;
    private Integer theType;
    private String ip;
    //    @FieldValue(value = "CURRENT_DATETIME")
    private Date theDateTime;
    //    @FieldValue(value = "MY_USER")
    //private User user;
    //    @FieldValue(value = "MY_BRANCH")
    /*private Branch branch;*/
    //    @FieldValue(value = "MY_TEACH_AREA")


    @Id
    @GenericGenerator(name = "id", strategy = "com.ming800.core.p.model.M8idGenerator")
    @GeneratedValue(generator = "id")
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @Column(name = "content")
    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    @Column(name = "thetype")
    public Integer getTheType() {
        return theType;
    }

    public void setTheType(Integer theType) {
        this.theType = theType;
    }

    @Column(name = "ip")
    public String getIp() {
        return ip;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }

    @Column(name = "thedatetime")
    public Date getTheDateTime() {
        return theDateTime;
    }

    public void setTheDateTime(Date theDateTime) {
        this.theDateTime = theDateTime;
    }

/*    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

}*/
/*    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "branch_id")
    public Branch getBranch() {
        return branch;
    }

    public void setBranch(Branch branch) {
        this.branch = branch;
    }*/

}