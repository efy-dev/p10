package com.ming800.core.p.service.impl;

import com.ming800.core.base.dao.XdoDao;
import com.ming800.core.p.dao.DocumentDao;
import com.ming800.core.p.dao.TagDao;
import com.ming800.core.p.model.*;
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

    @Autowired
    private XdoDao xdoDao;


    @Override
    public  List getDocumentList(String groupName) throws Exception{

        CommonDocument commonDocument =commonManager.getDocument(groupName);

        return  documentDao.getDocumentList(commonDocument.getGroup());
    }

    @Override
    public void saveDocument(Document document,String[] flag, String[] spId, String[] documentPicture)  {
        Document tempDoc = null;
        DocumentContent documentContent = null;
        if("".equals(document.getId())){
               tempDoc = new Document();
        }else {
            tempDoc = (Document)xdoDao.getObject(Document.class.getName(),document.getId());
        }
        tempDoc.setStatus("1");
        tempDoc.setTitle(document.getTitle());
        tempDoc.setGroup(document.getGroup());
        xdoDao.saveOrUpdateObject(tempDoc);
        if("".equals(document.getDocumentContent().getId())||document.getDocumentContent()==null){
               documentContent = new DocumentContent();
               documentContent.setContent(document.getDocumentContent().getContent());
        }else {
               documentContent = document.getDocumentContent();
        }
         documentContent.setDocument(tempDoc);
         xdoDao.saveOrUpdateObject(documentContent);
         tempDoc.setDocumentContent(documentContent);
         xdoDao.saveOrUpdateObject(tempDoc);
        if(spId!=null) {
            for (int i = 0; i < spId.length; i++) {
                if ("0".equals(spId[i])) {
                    DocumentPicture documentPicture1 = new DocumentPicture();
                    documentPicture1.setDocument(tempDoc);
                    documentPicture1.setPictureUrl(documentPicture[i]);
                    xdoDao.saveOrUpdateObject(documentPicture1);

                } else {
                    if ("-1".equals(flag[i])) {
                        xdoDao.deleteObject(DocumentPicture.class.getName(), spId[i]);

                    }
                }

            }
        }
    }

    @Override
    public void removeDocument(Document document) {
         documentDao.removeDocument(document);
    }

    @Override
    public void deleteDocument(Document document) {
        documentDao.deleteDocument(document);
    }

    @Override
    public void saveDocument(Document document) {
        documentDao.saveDocument(document);
    }
}
