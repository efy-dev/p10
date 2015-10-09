package com.efeiyi.association.service.impl;

import com.efeiyi.association.dao.MyDocumentDao;
import com.efeiyi.association.service.MyDocumentManager;
import com.ming800.core.p.model.CommonDocument;
import com.ming800.core.p.model.Document;
import com.ming800.core.p.service.CommonManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: Administrator
 * Date: 2015-10-09
 */

@Service
public class MyDocumentManagerImpl implements MyDocumentManager {

    @Autowired
    @Qualifier("myDocumentDaoHibernate")
    private MyDocumentDao myDocumentDao;

    @Autowired
    private CommonManager commonManager;

    @Override
    public  List getDocumentList(String groupName) throws Exception{
        CommonDocument commonDocument =commonManager.getDocument(groupName);
        return  myDocumentDao.getDocumentList(commonDocument.getGroup());
    }

    @Override
    public void saveDocument(Document document) {
        myDocumentDao.saveDocument(document);
    }

    @Override
    public void removeDocument(Document document) {
        myDocumentDao.removeDocument(document);
    }

    @Override
    public void deleteDocument(Document document) {
        myDocumentDao.deleteDocument(document);
    }
}
