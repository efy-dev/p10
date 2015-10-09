package com.efeiyi.association.service;

import com.ming800.core.p.model.Document;

import java.util.List;

public interface MyDocumentManager {

    /**
     * 获取 文档
     * @param groupName
     * @return
     */
    List getDocumentList(String groupName) throws Exception;

    /**
     * 保存字典
     * @param document
     */
    void saveDocument(Document document);

    /**
     * 假删
     * @param document
     */
    void removeDocument(Document document);

    /**
     * 真删
     * @param document
     */
    void  deleteDocument(Document document);
}
