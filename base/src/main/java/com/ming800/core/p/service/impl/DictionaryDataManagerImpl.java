package com.ming800.core.p.service.impl;

import com.ming800.core.p.dao.DictionaryDao;
import com.ming800.core.p.model.Dictionary;
import com.ming800.core.p.model.DictionaryData;
import com.ming800.core.p.service.DictionaryDataManager;
import com.ming800.core.util.ResourcesUtil;
import org.dom4j.Node;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by IntelliJ IDEA.
 * User: lxh
 * Date: 2010-1-15
 * Time: 13:41:03
 * To change this template use File | Settings | File Templates.
 */

@Service
public class DictionaryDataManagerImpl implements DictionaryDataManager {


    @Autowired
    private DictionaryDao dictionaryDao;

    private static final String DICTIONARIES_MODEL = "/setting/dictionaries.xml";
    private static Map<String, Dictionary> dictionaryMap = new HashMap<>();

    //按类型分类xml中的字典信息
    public static Map<String, Dictionary> load() {
        org.dom4j.Document document = ResourcesUtil.getDocument(DICTIONARIES_MODEL);                            //读取dictionaries.xml
        List<org.dom4j.Node> nodeList = document.selectNodes("/dictionaries/dictDefination");

        if (nodeList != null) {
            for (org.dom4j.Node node : nodeList) {
                String sid = node.selectSingleNode("@sid").getText();
                String name = node.selectSingleNode("@name").getText();
                String type = node.selectSingleNode("@type").getText();
                String detail = node.selectSingleNode("@detail").getText();

                String required = node.selectSingleNode("@required") == null ? "" : node.selectSingleNode("@required").getText();

                String[] definedValues = null;
                int i = 0;
                List<org.dom4j.Node> definedValueList = node.selectNodes("/dictData");
                for (org.dom4j.Node definedValue : definedValueList) {
                    if (definedValue != null) {
                        definedValues[i] = definedValue.selectSingleNode("@value").getText();
                    }
                    i++;
                }

                Dictionary dict = new Dictionary();
                dict.setName(name);
                dict.setSid(sid);
                dict.setRequired(required);
                dict.setDefinedNationValue(definedValues);

                dictionaryMap.put(sid, dict);

            }
        }

        return dictionaryMap;
    }

    public static Map<String, Dictionary> put(List<Node> nodeList) {
//        org.dom4j.Document document = ResourcesUtil.getDocument(DICTIONARIES_MODEL);                            //读取dictionaries.xml
//        List<org.dom4j.Node> nodeList = document.selectNodes("/dictionaries/dictDefination");

        if (nodeList != null) {
            for (org.dom4j.Node node : nodeList) {
                String sid = node.selectSingleNode("@sid").getText();
                String name = node.selectSingleNode("@name").getText();
                String type = node.selectSingleNode("@type").getText();
                String detail = node.selectSingleNode("@detail").getText();

                String required = node.selectSingleNode("@required") == null ? "" : node.selectSingleNode("@required").getText();

                String[] definedValues = null;
                int i = 0;
                List<org.dom4j.Node> definedValueList = node.selectNodes("/dictData");
                for (org.dom4j.Node definedValue : definedValueList) {
                    if (definedValue != null) {
                        definedValues[i] = definedValue.selectSingleNode("@value").getText();
                    }
                    i++;
                }

                Dictionary dict = new Dictionary();
                dict.setName(name);
                dict.setSid(sid);
                dict.setRequired(required);
                dict.setDefinedNationValue(definedValues);

                dictionaryMap.put(sid, dict);

            }
        }

        return dictionaryMap;
    }

    public Map<String, List<Dictionary>> getDictionaryListMap() {

        org.dom4j.Document document = ResourcesUtil.getDocument(DICTIONARIES_MODEL);                            //读取dictionaries.xml
        List<org.dom4j.Node> nodeList = document.selectNodes("/dictionaries/dictDefination");

        Map<String, List<Dictionary>> dictionaryListMap = new HashMap<>();
        if (nodeList != null) {
            List<Dictionary> dictionaryList = null;
            for (org.dom4j.Node node : nodeList) {
                String sid = node.selectSingleNode("@sid").getText();
                String name = node.selectSingleNode("@name").getText();
                String type = node.selectSingleNode("@type").getText();
                String detail = node.selectSingleNode("@detail").getText();

                Dictionary dict = new Dictionary();
                dict.setName(name);
                dict.setSid(sid);

                if (dictionaryListMap.get(type) == null) {
                    dictionaryList = new ArrayList<>();
                    dictionaryList.add(dict);
                } else {
                    dictionaryList = dictionaryListMap.get(type);
                    dictionaryList.add(dict);
                }

                dictionaryListMap.put(type, dictionaryList);

            }
        }

        return dictionaryListMap;
    }

    //按sid查找xml中的字典信息
    @Override
    public Dictionary getDictionaryBySid(String sid) {

        return dictionaryMap.get(sid);
    }

    @Override
    //@CacheEvict(value = "andCache",key="#dictData.definationName + #branchId + 'getDictionaryDataList'")
    public Dictionary deleteDictionaryData(Integer branchId, DictionaryData dictData) {
        dictData.setTheStatus(1);
        dictionaryDao.saveOrUpdateData(dictData);
        Dictionary dict = new Dictionary();
        dict.setSid(dictData.getDictionaryId());
        return dict;
    }

    public void saveOrUpdateData(DictionaryData dictionaryData) {
        dictionaryDao.saveOrUpdateData(dictionaryData);

    }

    public DictionaryData getDictionaryDataById(String id) {
        return dictionaryDao.getObject(id);
    }

    @Override
    public void updateDictionaryData(Integer branchId, Integer id, String dictionaryValue) {
        DictionaryData dictData = dictionaryDao.getDictionaryData(branchId, id);
        dictData.setData(dictionaryValue);
        dictionaryDao.saveOrUpdateDictionaryData(dictData);
    }

    @Override
    //@Cacheable(value = "andCache",key="#dictionaryId + #branchId + 'getDictionaryDataList'")
    public List<DictionaryData> getDictionaryDataList(String dictionaryId) {
        String hql = "FROM DictionaryData d WHERE d.dictionaryId = ? and d.theStatus != 0";
        Object[] params = new Object[]{dictionaryId};
        return dictionaryDao.getObjectList(hql, params);
    }

    @Override
    public void saveOrUpdateDictionaryData(DictionaryData dictData) {
        dictionaryDao.saveOrUpdateData(dictData);
    }

    @Override
    public DictionaryData getDictionaryData(Integer branchId, Integer id) {
        return dictionaryDao.getDictionaryData(branchId, id);
    }

}
