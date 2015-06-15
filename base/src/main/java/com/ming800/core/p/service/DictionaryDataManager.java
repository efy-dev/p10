package com.ming800.core.p.service;

import com.ming800.core.p.model.Dictionary;
import com.ming800.core.p.model.DictionaryData;

import java.util.List;
import java.util.Map;


public interface DictionaryDataManager {

    void saveOrUpdateDictionaryData(DictionaryData dictData);

    Dictionary getDictionaryBySid(String sid);

    DictionaryData getDictionaryDataById(String id);

    List<DictionaryData> getDictionaryDataList(String dictionaryId);

    Map<String, List<Dictionary>> getDictionaryListMap();


    //    public void saveOrUpdateDictionaryData(Integer id, String sid, Branch branch, String value);
    Dictionary deleteDictionaryData(Integer branchId, DictionaryData dictData);

    DictionaryData getDictionaryData(Integer branchId, Integer id);

    void updateDictionaryData(Integer branchId, Integer id, String dictionaryValue);

    void saveOrUpdateData(DictionaryData dictionaryData);
    //    public List<DictionaryData> getDictionaryDataListById(Integer branchId, String sid);
}
