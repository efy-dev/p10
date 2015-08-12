package com.ming800.core.p.service.impl;
import com.ming800.core.p.dao.TagDao;
import com.ming800.core.p.model.CommonTag;
import com.ming800.core.p.model.ObjectRecommended;
import com.ming800.core.p.model.Tag;
import com.ming800.core.p.service.CommonManager;
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
    private TagDao tagDao;

    @Autowired
    private CommonManager commonManager;


    @Override
    public  List getTagList(String groupName) throws Exception{

        CommonTag commonTag =commonManager.getTag(groupName);

        return  tagDao.getTagList(commonTag.getGroup());
    }

    @Override
    public void saveTag(Tag tag) {
        tagDao.saveTag(tag);
        //  xdoDao.saveOrUpdateObject(objectRecommended);
    }

    @Override
    public void deleteTag(Tag tag) {
        tagDao.deleteTag(tag);
        //  xdoDao.saveOrUpdateObject(objectRecommended);
    }

    @Override
    public void removeTag(Tag tag) {
        tagDao.removeTag(tag);
        //  xdoDao.saveOrUpdateObject(objectRecommended);
    }

}
