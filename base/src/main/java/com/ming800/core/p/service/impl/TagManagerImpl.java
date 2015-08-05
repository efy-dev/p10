package com.ming800.core.p.service.impl;
import com.ming800.core.p.dao.TagDao;
import com.ming800.core.p.service.TagManager;
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
public class TagManagerImpl implements TagManager {


    @Autowired
    private TagDao wordValueDao;



    @Override
    public  List listWordValueByGroup(String groupName){

        return  wordValueDao.listWordValueByGroup(groupName);
    }

}
