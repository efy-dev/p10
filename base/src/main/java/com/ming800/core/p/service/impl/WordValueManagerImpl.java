package com.ming800.core.p.service.impl;

import com.ming800.core.p.dao.DictionaryDao;
import com.ming800.core.p.dao.WordValueDao;
import com.ming800.core.p.model.Dictionary;
import com.ming800.core.p.model.DictionaryData;
import com.ming800.core.p.model.WordValue;
import com.ming800.core.p.service.DictionaryDataManager;
import com.ming800.core.p.service.WordValueManager;
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
public class WordValueManagerImpl implements WordValueManager {


    @Autowired
    private WordValueDao  wordValueDao;



    @Override
    public  List listWordValueByGroup(String group){

        return  wordValueDao.listWordValueByGroup(group);
    }

}
