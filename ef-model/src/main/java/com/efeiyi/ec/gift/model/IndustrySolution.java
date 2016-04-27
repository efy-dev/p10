package com.efeiyi.ec.gift.model;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.util.List;

/**
 * Created by Administrator on 2016/4/14 0014.
 */
@Entity
@Table(name = "gift_industry_solution")
public class IndustrySolution {

    private String id;
    private String solutionName; //解决方案的名称
    private String introduction; //解决方案的介绍
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

    @Column(name = "solution_name")
    public String getSolutionName() {
        return solutionName;
    }

    public void setSolutionName(String sloutionName) {
        this.solutionName = sloutionName;
    }

    @Column(name = "introduction")
    public String getIntroduction() {
        return introduction;
    }

    public void setIntroduction(String introduction) {
        this.introduction = introduction;
    }

    @Column(name = "status")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
