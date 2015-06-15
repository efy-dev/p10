package com.ming800.core.p.model;


import org.codehaus.jackson.annotate.JsonIgnoreProperties;
import org.codehaus.jackson.annotate.JsonProperty;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.io.Serializable;

/**
 * Created by IntelliJ IDEA.
 * User: lxh
 * Date: 2010-4-8
 * Time: 20:46:52
 * To change this template use File | Settings | File Templates.
 */
@Entity
@Table(name = "core_p_dictionary_data")
@JsonIgnoreProperties(value = {"hibernateLazyInitializer", "handler", "branch"})
public class DictionaryData implements Serializable {
    @JsonProperty(value = "id")
    private String id;
    private Integer theStatus = 0;  //0 删除    1正常
    private String dictionaryId;   //sid
    @JsonProperty(value = "text")
    private String data;
    //private Branch branch;

    @Id
    @GenericGenerator(name = "id", strategy = "com.ming800.core.p.model.M8idGenerator")
    @GeneratedValue(generator = "id")
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @Column(name = "thestatus")
    public Integer getTheStatus() {
        return theStatus;
    }

    public void setTheStatus(Integer theStatus) {
        this.theStatus = theStatus;
    }

    @Column(name = "dictionary_id")
    public String getDictionaryId() {
        return dictionaryId;
    }

    public void setDictionaryId(String dictionaryId) {
        this.dictionaryId = dictionaryId;
    }

    @Column(name = "data")
    public String getData() {
        return data;
    }

    public void setData(String data) {
        this.data = data;
    }

/*    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "branch_id")
    public Branch getBranch() {
        return branch;
    }

    public void setBranch(Branch branch) {
        this.branch = branch;
    }
*/
}