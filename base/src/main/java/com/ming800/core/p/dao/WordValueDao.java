package com.ming800.core.p.dao;

import com.ming800.core.base.dao.BaseDao;
import com.ming800.core.p.model.WordValue;

import java.util.List;


public interface WordValueDao extends BaseDao<WordValue> {

    /**
     * 获取 字典列表
     * @param group
     * @return
     */
    List listWordValueByGroup(String group);
}
