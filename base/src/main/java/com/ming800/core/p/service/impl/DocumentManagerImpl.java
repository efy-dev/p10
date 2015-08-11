package com.ming800.core.p.service.impl;

import com.ming800.core.p.dao.DocumentDao;
import com.ming800.core.p.dao.TagDao;
import com.ming800.core.p.model.CommonDocument;
import com.ming800.core.p.model.CommonTag;
import com.ming800.core.p.model.Document;
import com.ming800.core.p.service.CommonManager;
import com.ming800.core.p.service.DocumentManager;
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
public class DocumentManagerImpl implements DocumentManager {


    @Autowired
    private DocumentDao documentDao;

    @Autowired
    private CommonManager commonManager;


    @Override
    public  List getDocumentList(String groupName) throws Exception{

        CommonDocument commonDocument =commonManager.getDocument(groupName);

        return  documentDao.getDocumentList(commonDocument.getGroup());
    }

    @Override
    public void saveDocument(Document document) {
        documentDao.saveDocument(document);
    }

    @Override
    public void removeDocument(Document document) {
         documentDao.removeDocument(document);
    }

    @Override
    public void deleteDocument(Document document) {
        documentDao.deleteDocument(document);
    }
}
