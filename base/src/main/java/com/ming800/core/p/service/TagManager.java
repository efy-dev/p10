package com.ming800.core.p.service;

import java.util.List;

public interface TagManager {

    /**
     * 获取 字典列表
     * @param groupName
     * @return
     */
    List listWordValueByGroup(String groupName);
}
