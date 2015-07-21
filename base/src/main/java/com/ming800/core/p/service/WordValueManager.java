package com.ming800.core.p.service;

import com.ming800.core.p.model.Dictionary;
import com.ming800.core.p.model.DictionaryData;
import com.ming800.core.p.model.WordValue;

import java.util.List;
import java.util.Map;


public interface WordValueManager {

    /**
     * 获取 字典列表
     * @param wordValue
     * @return
     */
    List listWordValueByGroup(String group);
}
