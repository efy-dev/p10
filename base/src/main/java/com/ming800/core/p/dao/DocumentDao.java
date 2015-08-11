package com.ming800.core.p.dao;


import com.ming800.core.p.model.Document;
import com.ming800.core.p.model.Tag;

import java.util.List;


public interface DocumentDao  {

    /**
     * 获取 文档
     * @param groupName
     * @return
     */
    List getDocumentList(String groupName);

    /**
     * 保存字典
     * @param document
     */
    void saveDocument(Document document);

    /**
     * 删除字典 真删
     * @param document
     */
    void  deleteDocument(Document document);

    /**
     * 假删 删除字典
     * @param document
     */
    void  removeDocument(Document document);
}
