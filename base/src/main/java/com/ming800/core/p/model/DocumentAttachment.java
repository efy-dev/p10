package com.ming800.core.p.model;

import com.ming800.core.p.model.Document;
import com.ming800.core.p.model.FileData;
import com.ming800.core.util.AttachmentUtil;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;


@Entity
@Table(name = "basic_attachment")
public class DocumentAttachment {
    private String id;
    private String storeType;  // database,  disk,  cloud
    private String fileName;
    private String fileType;
    private FileData data;      //附件
    private String path;        //地址
    private Document document;
    private String generate;   //页面的现实内容  图片类型直接显示   其他类型设置为下载链接




    @Id
    @GenericGenerator(name = "id", strategy = "com.ming800.core.p.model.M8idGenerator")
    @GeneratedValue(generator = "id")
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @Column(name = "store_type")
    public String getStoreType() {
        return storeType;
    }

    public void setStoreType(String storeType) {
        this.storeType = storeType;
    }

    @Column(name = "file_name")
    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    @Column(name = "file_type")
    public String getFileType() {
        return fileType;
    }

    public void setFileType(String fileType) {
        this.fileType = fileType;
    }

    @OneToOne(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    @JoinColumn(name = "data_id")
    public FileData getData() {
        return data;
    }

    public void setData(FileData data) {
        this.data = data;
    }

    @Column(name = "path")
    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "document_id")
    public Document getDocument() {
        return document;
    }

    public void setDocument(Document document) {
        this.document = document;
    }

    @Transient
    public String getGenerate() {
        String dataId = data == null ? null : data.getId();
        return AttachmentUtil.getGenerate(storeType, fileName, fileType, dataId, path);
    }

    public void setGenerate(String generate) {
        this.generate = generate;
    }
}
