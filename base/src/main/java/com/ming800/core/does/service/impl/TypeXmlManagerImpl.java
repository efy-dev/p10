package com.ming800.core.does.service.impl;

import com.ming800.core.does.model.*;
import com.ming800.core.does.service.TypeXmlManager;
import com.ming800.core.util.ResourcesUtil;
import org.dom4j.Document;
import org.dom4j.Node;
import org.springframework.stereotype.Service;

import java.util.*;

/**
 * Created with IntelliJ IDEA.
 * User: ming
 * Date: 12-11-17
 * Time: 下午4:25
 * To change this template use File | Settings | File Templates.
 */

public class TypeXmlManagerImpl implements TypeXmlManager {
    private static final String TYPE_XML = "/setting/types.xml";
    private static Map<String, TypeXml> typeXmlMap = new HashMap<>();

    public static void readXmlFiles() {

        Document infoDocument = ResourcesUtil.getDocument(TYPE_XML);
        if (infoDocument != null) {

            List<Node> typeNodeList = infoDocument.selectNodes("types/type");
            for (Node typeNode : typeNodeList) {
                TypeXml typeXml = new TypeXml();

                String name = typeNode.selectSingleNode("@name").getText();
                String label = typeNode.selectSingleNode("@label").getText();

                List<TypeXml> typeItemXmlList = new ArrayList<>();
                List<Node> typeItemNodeList = typeNode.selectNodes("item");
                for (Node typeItemNode : typeItemNodeList) {
                    TypeXml typeItemXml = new TypeXml();
                    String typeItemName = typeItemNode.selectSingleNode("@name").getText();
                    String typeItemLabel = typeItemNode.selectSingleNode("@label").getText();
                    typeItemXml.setName(typeItemName);
                    typeItemXml.setLabel(typeItemLabel);

                    typeItemXmlList.add(typeItemXml);
                }

                typeXml.setName(name);
                typeXml.setLabel(label);
                typeXml.setTypeXmlList(typeItemXmlList);

                typeXmlMap.put(name, typeXml);
            }
        }
    }


    @Override
    public Map<String, TypeXml> fetchTypeXmlMap() {
        return typeXmlMap;  //To change body of implemented methods use File | Settings | File Templates.
    }
}
