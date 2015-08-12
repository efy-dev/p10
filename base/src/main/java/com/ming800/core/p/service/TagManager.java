package com.ming800.core.p.service;

import com.ming800.core.p.model.Tag;

import java.util.List;

public interface TagManager {

    /**
     * 获取 字典列表
     * @param groupName
     * @return
     */
    List getTagList(String groupName) throws Exception;

    /**
     * 保存字典
     * @param tag
     */
    void saveTag(Tag tag);

    /**
     * 假删
     * @param tag
     */
    void removeTag(Tag tag);

    /**
     * 真删
     * @param tag
     */
    void  deleteTag(Tag tag);
}
