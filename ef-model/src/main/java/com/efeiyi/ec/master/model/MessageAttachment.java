package com.efeiyi.ec.master.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;

/**
 * Created by AC丶man on 2015/9/7.
 */

@Entity
@Table(name="master_message_attachment")
@JsonIgnoreProperties(value = {"hibernateLazyInitializer", "handler"})
public class MessageAttachment {

	private String id;
	private String fileName;
	private String pictureUrl;
	private String videoPath;
	protected MasterMessage masterMessage;

	@Id
	@GenericGenerator(name = "id", strategy = "com.ming800.core.p.model.M8idGenerator")
	@GeneratedValue(generator = "id")
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	@Column(name = "file_name")
	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	@Column(name = "picture_url")
	public String getPictureUrl() {
		return pictureUrl;
	}

	public void setPictureUrl(String pictureUrl) {
		this.pictureUrl = pictureUrl;
	}

	@Column(name = "video_path")
	public String getVideoPath() {
		return videoPath;
	}

	public void setVideoPath(String videoPath) {
		this.videoPath = videoPath;
	}

	@JsonIgnore
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "master_message_id")
	public MasterMessage getMasterMessage() {
		return masterMessage;
	}

	public void setMasterMessage(MasterMessage masterMessage) {
		this.masterMessage = masterMessage;
	}

    @Override
    public String toString(){
        return  "MessageAttachment{id = "+id+"}";
    }
}
