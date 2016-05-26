package com.efeiyi.ec.wiki.model;

import com.efeiyi.ec.yale.question.model.Question;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;

/**
 * Created by Administrator on 2016/5/26 0026.
 */

@Entity
@JsonIgnoreProperties(value = {"hibernateLazyInitializer", "handler"})
@Table(name = "wiki_artistry_question")
public class ArtistryQuestion {

    private String id;
    private Artistry artistry;
    private Question question;
    private String status;


//    CREATE TABLE `wiki_artistry_question` (
//            `id`  char(16) NOT NULL ,
//    `artistry_id`  char(16) NOT NULL ,
//    `question_id`  char(16) NOT NULL ,
//    `status`  char(1) NOT NULL ,
//    PRIMARY KEY (`id`)
//    )
//    ;

    @Id
    @GenericGenerator(name = "id", strategy = "com.ming800.core.p.model.M8idGenerator")
    @GeneratedValue(generator = "id")
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @OneToOne
    @JoinColumn(name = "artistry_id")
    public Artistry getArtistry() {
        return artistry;
    }

    public void setArtistry(Artistry artistry) {
        this.artistry = artistry;
    }

    @OneToOne
    @JoinColumn(name = "question_id")
    public Question getQuestion() {
        return question;
    }

    public void setQuestion(Question question) {
        this.question = question;
    }

    @Column(name = "status")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
