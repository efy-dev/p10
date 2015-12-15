package com.efeiyi.ec.zero.virtual.model;

import com.efeiyi.ec.organization.model.User;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;

/**
 * Created by Administrator on 2015/11/25.
 */
@Entity
@Table(name = "virtual_user")
public class VirtualUser {

    private VirtualUserPlan virtualUserPlan;
    private String id;
    private User user;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "virtual_user_plan_id")
    public VirtualUserPlan getVirtualUserPlan() {
        return virtualUserPlan;
    }

    public void setVirtualUserPlan(VirtualUserPlan virtualUserPlan) {
        this.virtualUserPlan = virtualUserPlan;
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

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
}
