package com.ming800.core.p.service.impl;

import com.ming800.core.p.dao.FileDataDao;
import com.ming800.core.p.model.FileData;
import com.ming800.core.p.service.FileDataManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created with IntelliJ IDEA.
 * User: ming
 * Date: 12-11-6
 * Time: 下午3:25
 * To change this template use File | Settings | File Templates.
 */
@Service
public class FileDataManagerImpl implements FileDataManager {
    @Autowired
    FileDataDao fileDataDao;

    @Override
    public FileData getFileData(String fileDataId) {
        return fileDataDao.getObject(fileDataId);  //To change body of implemented methods use File | Settings | File Templates.
    }
}
