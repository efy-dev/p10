package com.ming800.core.p.service.impl;

import com.ming800.core.base.util.ReflectUtil;
import com.ming800.core.base.util.SystemValueUtil;
import com.ming800.core.p.service.AliOssUploadManager;
import com.ming800.core.base.dao.XdoDao;
import com.ming800.core.p.PConst;
import com.ming800.core.p.service.AttachmentManager;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-3-19
 * Time: 上午9:33
 * To change this template use File | Settings | File Templates.
 */
@Service
public class AttachmentManagerImpl implements AttachmentManager {
    @Autowired
    private XdoDao baseDao;
    @Autowired
    private AliOssUploadManager aliOssUploadManager;

    @Override
    public List getAttachmentList(List<MultipartFile> fileList, String storeType, String bucketName, String folderName, Object object, String attachment) throws Exception {
        return null;
    }


    @Override
    public List getAttachmentList(String[] urlNameArray, String[] urlArray, Object object, String attachment) throws Exception {
        List attachmentObjectList = new ArrayList();
        if (urlNameArray.length > 0) {
            for (int i = 0; i < urlNameArray.length; i++) {
                Object attachmentObject = ReflectUtil.getNewInstance(attachment);
                ReflectUtil.invokeSetterMethod(attachmentObject, "fileName", urlNameArray[i]);
                ReflectUtil.invokeSetterMethod(attachmentObject, "fileType", "url");
                ReflectUtil.invokeSetterMethod(attachmentObject, "storeType", PConst.ATTACHMENT_STORETYPE_URL);
                ReflectUtil.invokeSetterMethod(attachmentObject, "path", urlArray[i]);
                ReflectUtil.invokeSetterMethod(attachmentObject, SystemValueUtil.generateSimpleName(object), object);
                attachmentObjectList.add(attachmentObject);
            }
        }
        return attachmentObjectList;
    }


    @Override
    public void deleteAttachments(String name, String[] attachementIds) throws Exception {
         /*删除以前的附件*/
        if (attachementIds != null && attachementIds.length > 0) {
            String queryStr = "from " + name + " o where o.id in (:attachementIds)";
            LinkedHashMap<String, Object> queryParamMap = new LinkedHashMap<>();
            queryParamMap.put("attachementIds", attachementIds);


            StringBuilder queryStrBuilder = new StringBuilder("delete from " + name + " where id in (:ids)");
            LinkedHashMap<String, Object> paramMap = new LinkedHashMap<>();
            paramMap.put("ids", attachementIds);
            baseDao.execteBulk(queryStrBuilder.toString(), paramMap);

        }
    }


}
