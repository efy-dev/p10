package com.ming800.core.p.service;

import com.ming800.core.p.model.Document;
import com.ming800.core.p.model.Tag;

import java.util.List;

public interface DocumentManager {

    /**
     * 获取 文档
     * @param groupName
     * @return
     */
    List getDocumentList(String groupName) throws Exception;

    /**
     * 保存字典
     * @param tag
     */
    void saveDocument(Document document,String[] flag, String[] spId, String[] documentPicture);
    /**
     * 保存字典
     * @param tag
     */
    void saveDocument(Document document);

    /**
     * 假删
     * @param tag
     */
    void removeDocument(Document document);

    /**
     * 真删
     * @param tag
     */
    void  deleteDocument(Document document);
}
