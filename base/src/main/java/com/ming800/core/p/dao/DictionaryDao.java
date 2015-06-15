package com.ming800.core.p.dao;

import com.ming800.core.base.dao.BaseDao;
import com.ming800.core.p.model.DictionaryData;

import java.util.List;


public interface DictionaryDao extends BaseDao<DictionaryData> {

    public List getDictDefinationList(String sid);

    public void saveOrUpdateData(DictionaryData dictionaryData);


    public void updateDictionaryData(DictionaryData dictionaryData);

    /*
     *根据sid和校区查找字典数据
     */
//    public PageInfo getDictionaryDataList(Integer branchId, String sid, PageEntity pageEntity);
    /*
     *添加或删除数据字典
     */
    public void saveOrUpdateDictionaryData(DictionaryData dictData);

    /*
    *根据id查找相应的数据字典
    */
    public DictionaryData getDictionaryData(Integer branchId, Integer id);

    public List<DictionaryData> getDictionaryDataListById(Integer branchId, String sid);
}
