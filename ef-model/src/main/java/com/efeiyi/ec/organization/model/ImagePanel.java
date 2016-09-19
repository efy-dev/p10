package com.efeiyi.ec.organization.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.io.Serializable;

/**
 * Created by Administrator on 2016/9/6 0006.
 */
@Entity
@Table(name = "image_panel")
@Inheritance(strategy = InheritanceType.JOINED)
@JsonIgnoreProperties(value = {"hibernateLazyInitializer", "handler"})
public class ImagePanel implements Serializable {

    private String id;
    private Image image;
    private Panel panel;

    @Id
    @GenericGenerator(name = "id", strategy = "com.ming800.core.p.model.M8idGenerator")
    @GeneratedValue(generator = "id")
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "image_id")
    public Image getImage() {
        return image;
    }

    public void setImage(Image image) {
        this.image = image;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "panel_id")
    @JsonIgnore
    public Panel getPanel() {
        return panel;
    }

    public void setPanel(Panel panel) {
        this.panel = panel;
    }
    //    public String getPanelId() {
//        return panelId;
//    }
//
//    public void setPanelId(String panelId) {
//        this.panelId = panelId;
//    }
}
