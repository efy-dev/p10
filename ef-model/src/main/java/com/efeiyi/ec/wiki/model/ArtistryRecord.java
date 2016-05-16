package com.efeiyi.ec.wiki.model;

import com.efeiyi.ec.organization.model.User;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Where;

import javax.persistence.*;
import java.util.Date;

/**
 * Created by Administrator on 2016/5/10.
 */
@Entity
@Table(name = "artistry_record")
@JsonIgnoreProperties(value = {"hibernateLazyInitializer", "handler"})
public class ArtistryRecord {

    private String id;
    private Artistry artistry;    //项目名称
    private ArtistryDescription artistryDescription;  //项目级别
    private Date createDatetime;
    private User user;
    private String checkResult;
    @Id
    @GenericGenerator(name = "id", strategy = "com.ming800.core.p.model.M8idGenerator")
    @GeneratedValue(generator = "id")
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }
    @JoinColumn(name = "artistry_id")
    @OneToOne(fetch = FetchType.LAZY)
    public Artistry getArtistry() {
        return artistry;
    }

    public void setArtistry(Artistry artistry) {
        this.artistry = artistry;
    }
    @JoinColumn(name = "artistry_description_id")
    @OneToOne(fetch = FetchType.LAZY)
    public ArtistryDescription getArtistryDescription() {
        return artistryDescription;
    }

    public void setArtistryDescription(ArtistryDescription artistryDescription) {
        this.artistryDescription = artistryDescription;
    }
    @Column(name = "create_datetime")
    public Date getCreateDatetime() {
        return createDatetime;
    }

    public void setCreateDatetime(Date createDatetime) {
        this.createDatetime = createDatetime;
    }
    @JoinColumn(name = "user_id")
    @OneToOne(fetch = FetchType.LAZY)
    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
    @Column(name = "check_result")
    public String getCheckResult() {
        return checkResult;
    }

    public void setCheckResult(String checkResult) {
        this.checkResult = checkResult;
    }


}
