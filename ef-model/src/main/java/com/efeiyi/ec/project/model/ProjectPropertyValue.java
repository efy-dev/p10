package com.efeiyi.ec.project.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;

/**
 * Created by Administrator on 2015/6/24.
 * 项目属性
 */
@Entity
@Table(name="project_property_value")
@JsonIgnoreProperties(value = {"hibernateLazyInitializer", "handler"})
public class ProjectPropertyValue {
    private String id;
    private String value;
    private ProjectProperty projectProperty;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name="project_property_id")
    public ProjectProperty getProjectProperty() {
        return projectProperty;
    }

    public void setProjectProperty(ProjectProperty projectProperty) {
        this.projectProperty = projectProperty;
    }

    @Column(name="value")
    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
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

    @Override
    public String toString() {
        return "ProjectPropertyValue{id = " + id + "}";
    }
}
