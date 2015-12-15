package com.efeiyi.ec.zero.virtual.model;

import javax.persistence.*;
import java.util.List;

/**
 * Created by Administrator on 2015/11/25.
 */
@Entity
@Table(name = "virtual_user_plan")
public class VirtualUserPlan extends VirtualPlan{

    private Integer count;
    private List<VirtualUser> virtualUserList;

    @Column(name = "count")
    public Integer getCount() {
        return count;
    }

    public void setCount(Integer count) {
        this.count = count;
    }

    @OneToMany(fetch = FetchType.LAZY,mappedBy = "virtualUserPlan")
    public List<VirtualUser> getVirtualUserList() {
        return virtualUserList;
    }

    public void setVirtualUserList(List<VirtualUser> virtualUserList) {
        this.virtualUserList = virtualUserList;
    }
}
