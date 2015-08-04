package com.ming800.core.p.service.impl;
import com.ming800.core.p.dao.WordValueDao;
import com.ming800.core.p.service.WordValueManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

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
