package com.ming800.core.p.dao;

import com.ming800.core.base.dao.BaseDao;
import com.ming800.core.p.model.Tag;

import java.util.List;


public interface TagDao {

    /**
     * 获取 字典列表
     * @param groupName
     * @return
     */
    List getTagList(String groupName);

    /**
     * 保存字典
     * @param tag
     */
    void saveTag(Tag tag);

    /**
     * 删除字典 真删
     * @param tag
     */
    void  deleteTag(Tag tag);

    /**
     * 假删 删除字典
     * @param tag
     */
     void  removeTag(Tag tag);
}
