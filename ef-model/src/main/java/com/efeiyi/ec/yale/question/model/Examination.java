package com.efeiyi.ec.yale.question.model;

import com.efeiyi.ec.organization.model.Consumer;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Where;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

/**
 * Created by Administrator on 2015/12/22.
 * 试题 model类
 */
@Entity
@Table(name = "yale_weixin_examination")
public class Examination {
    private String id;
    private String serial;
    private Consumer consumer;
    private List<ExaminationQuestion> examinationQuestionList;
    private List<ParticipationRecord> participationRecordList;
    private ExaminationEdition examinationEdition;
    private String status;//分享状态  0未分享  1已分享  2已答对  3已领奖
    private Date finishDatetime;

    public static final String examStarted = "0";
    public static final String examShared = "1";
    public static final String examFinished = "2";
    public static final String examRewarded = "3";


    @Id
    @GenericGenerator(name = "id", strategy = "com.ming800.core.p.model.M8idGenerator")
    @GeneratedValue(generator = "id")
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @Column(name = "serial")
    public String getSerial() {
        return serial;
    }

    public void setSerial(String serial) {
        this.serial = serial;
    }

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "examination")
    @OrderBy(value = "questionOrder asc")
    public List<ExaminationQuestion> getExaminationQuestionList() {
        return examinationQuestionList;
    }

    public void setExaminationQuestionList(List<ExaminationQuestion> examinationQuestionList) {
        this.examinationQuestionList = examinationQuestionList;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "yale_weixin_examination_edition_id")
    public ExaminationEdition getExaminationEdition() {
        return examinationEdition;
    }

    public void setExaminationEdition(ExaminationEdition examinationEdition) {
        this.examinationEdition = examinationEdition;
    }

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "examination")
    @OrderBy(value = "createDatetime asc,recordType asc")
    public List<ParticipationRecord> getParticipationRecordList() {
        return participationRecordList;
    }

    public void setParticipationRecordList(List<ParticipationRecord> participationRecordList) {
        this.participationRecordList = participationRecordList;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "organization_consumer_id")
    @Where(clause = "status != 0")
    public Consumer getConsumer() {
        return consumer;
    }

    public void setConsumer(Consumer consumer) {
        this.consumer = consumer;
    }

    @Column(name = "status")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Column(name = "finish_datetime")
    public Date getFinishDatetime() {
        return finishDatetime;
    }

    public void setFinishDatetime(Date finishDatetime) {
        this.finishDatetime = finishDatetime;
    }
}
