package com.ming800.core.p.service.impl;

import com.ming800.core.p.service.GlobalManager;
import com.ming800.core.util.ResourcesUtil;
import org.dom4j.Document;
import org.dom4j.io.SAXReader;
import org.springframework.stereotype.Service;

import java.io.File;


/**
 * Created with IntelliJ IDEA.
 * User: ming
 * Date: 13-1-25
 * Time: 下午3:43
 * To change this template use File | Settings | File Templates.
 */
@Service
public class GlobalManagerImpl implements GlobalManager {
    private static final String GLOBAL_XML = "/setting/global.xml";
    private static Document document;

    @Override
    public Document load() {

        File tempFile = new File(GlobalManagerImpl.class.getClassLoader().getResource("/").getPath());
        String tempFileName = tempFile.getParentFile().getParentFile().getParentFile().getParentFile().getParentFile().getPath();
        File dir = new File(tempFileName + "/home/setting3/global.xml");
        if (document == null && dir.exists()) {
            try {
                document = new SAXReader().read(dir);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        if (document == null) {
            document = ResourcesUtil.getDocument(GLOBAL_XML);
        }
        return document;
    }


}
