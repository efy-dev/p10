package com.ming800.core.util;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.io.SAXReader;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;

import java.io.IOException;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-1-22
 * Time: 下午12:24
 * To change this template use File | Settings | File Templates.
 */
public class ResourcesUtil {

    /**
     * dom4j读取xml文件
     *
     * @param classPath
     * @return dom4j.Document
     */
    public static Document getDocument(String classPath) {
        Document infoDocument = null;

        String classPath2 = classPath;
        if (classPath.contains("setting")) {
            classPath2 = classPath.replace("setting", "setting2");
        }
        Resource jMenuResource = new ClassPathResource(classPath2);
        if (!jMenuResource.exists()) {
            jMenuResource = new ClassPathResource(classPath);
        }
        try {
            if (jMenuResource.exists()) {
                infoDocument = new SAXReader().read(jMenuResource.getInputStream());
            }
        } catch (DocumentException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return infoDocument;
    }

}
