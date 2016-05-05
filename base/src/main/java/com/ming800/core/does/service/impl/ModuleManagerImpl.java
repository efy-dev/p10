package com.ming800.core.does.service.impl;

import com.ming800.core.does.model.*;
import com.ming800.core.does.service.ModuleManager;
import org.apache.log4j.Logger;
import org.dom4j.Node;
import org.dom4j.io.SAXReader;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.core.io.support.ResourcePatternResolver;
import org.springframework.stereotype.Service;

import java.io.File;
import java.util.*;


/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-4-19
 * Time: 下午2:35
 * To change this template use File | Settings | File Templates.
 */
@Service
public class ModuleManagerImpl implements ModuleManager {

    private static Map<String, Module> modulesMap = new HashMap<>();
    private static Map<String, Xentity> entityMap = new HashMap<>();
    private static Map<String, Xentity> tempEntityMap = new HashMap<>();

    public static void readXmlFiles() {

        ResourcePatternResolver resolver = new PathMatchingResourcePatternResolver();
        Logger logger = Logger.getLogger(ModuleManagerImpl.class);
        try {
            Resource[] xmlFiles = resolver.getResources("/system/**/*.xml");
            if (xmlFiles != null) {
                for (Resource resource : xmlFiles) {
                    logger.info("开始解析文件：" + resource.getURL());
                    initXmlFiles(new SAXReader().read(resource.getInputStream()));
                }
            }


            Resource[] xmlFiles2 = null;
            try {
                xmlFiles2 = resolver.getResources("/system2/**/*.xml");
            } catch (java.io.IOException ioe) {
                //默认情况下 xdo2下无文件 所以此处抛出异常为正常现象
            }
            if (xmlFiles2 != null) {
                for (Resource resource : xmlFiles2) {
                    org.dom4j.Document document = new SAXReader().read(resource.getInputStream());
                    List<Node> nodeList = document.selectNodes("/module");
                    if (nodeList != null && nodeList.size() > 0) {
                        initXmlFiles2(nodeList);
                    }
                }
            }


            generateEntityMap();
            DoManagerImpl.generateDoMap(entityMap);

        } catch (Exception e) {
            e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
        }

    }

    private static void generateEntityMap() {

        if (tempEntityMap != null && tempEntityMap.size() > 0) {

            Iterator iterator = tempEntityMap.keySet().iterator();
            while (iterator.hasNext()) {

                Xentity xentity = tempEntityMap.get(iterator.next());
                Xentity tempXentity = entityMap.get(xentity.getReference());

                xentity.setModel(tempXentity.getModel());
                xentity.setFieldMap(tempXentity.getFieldMap());

                entityMap.put(xentity.getName(), xentity);
            }
        }
    }

    public static void initXmlFiles(org.dom4j.Document document) {
        List<Node> nodeList = document.selectNodes("/module");

        for (Node node : nodeList) {

            Module module = new Module();
            module.setName(node.selectSingleNode("@name").getText());
            module.setLabel(node.selectSingleNode("@label").getText());
            module.setPackagePath(node.selectSingleNode("@package").getText());

            /*生成entityMap*/
            List<Xentity> xentityList = createEntityMap(module, node);
            module.setXentityList(xentityList);

            List<ConfigProperty> configPropertyList = createConfigPropertyList(module, node);
            module.setConfigPropertyList(configPropertyList);

            modulesMap.put(module.getName(), module);

        }
    }

    private static List<ConfigProperty> createConfigPropertyList(Module module, Node node) {
        List<ConfigProperty> configPropertyList = new ArrayList<>();
        List<Node> configPropertyNodeList = node.selectNodes("properties/property");

        if (configPropertyNodeList != null && configPropertyNodeList.size() > 0) {
            for (Node configPropertyNode : configPropertyNodeList) {
                ConfigProperty configProperty = new ConfigProperty();

                configProperty.setName(configPropertyNode.selectSingleNode("@name").getText());
                configProperty.setLabel(configPropertyNode.selectSingleNode("@label").getText());
                configProperty.setType(configPropertyNode.selectSingleNode("@type").getText());
                configProperty.setDefaultValue(configPropertyNode.selectSingleNode("@defaultValue") == null ? "" : configPropertyNode.selectSingleNode("@defaultValue").getText());
                configProperty.setValues(configPropertyNode.selectSingleNode("@values") == null ? "" : configPropertyNode.selectSingleNode("@values").getText());
                configProperty.setMemo(configPropertyNode.selectSingleNode("@memo") == null ? "" : configPropertyNode.selectSingleNode("@memo").getText());

                configProperty.setModule(module);

                configPropertyList.add(configProperty);
            }
        }


        return configPropertyList;
    }

    public static void initXmlFiles2(List<Node> nodeList) {
//        List<Node> nodeList = document.selectNodes("/module");

        for (Node node : nodeList) {
            String moduleName = node.selectSingleNode("@name").getText();
            Module module = modulesMap.get(moduleName);

            Boolean flag = false;
            Node inheritNode = node.selectSingleNode("@inherit");

            if (inheritNode != null && inheritNode.getText().equals("hide")) {
                modulesMap.remove(moduleName);
                continue;
            }

            if (inheritNode != null && inheritNode.getText().equals("same")) {
                flag = true;
            }

            if (!flag) {
                if (module == null) {
                    module = new Module();

                    List<ConfigProperty> configPropertyList = createConfigPropertyList(module, node);
                    module.setConfigPropertyList(configPropertyList);
                }
                module.setName(node.selectSingleNode("@name").getText());
                module.setLabel(node.selectSingleNode("@label").getText());
                module.setPackagePath(node.selectSingleNode("@package").getText());
            }

            /*生成entityMap*/
            List<Xentity> xentityList = createEntityMap2(module, node);
            if (module.getXentityList() != null && module.getXentityList().size() > 0) {
                module.getXentityList().clear();
            }
            module.setXentityList(xentityList);

            modulesMap.put(module.getName(), module);

        }
    }

    /*生成entityMap*/
    private static List<Xentity> createEntityMap(Module module, Node node) {
        List<Xentity> xentityList = new ArrayList<>();
        List<Node> entityNodeList = node.selectNodes("entities/entity");
        for (Node entityNode : entityNodeList) {
            Xentity xentity = new Xentity();
            xentity.setName(entityNode.selectSingleNode("@name").getText());
            xentity.setLabel(entityNode.selectSingleNode("@label").getText());

            xentity.setType(entityNode.selectSingleNode("@type") == null ? "" : entityNode.selectSingleNode("@type").getText());

            String xentityBasic = entityNode.selectSingleNode("@basic") == null ? "" : entityNode.selectSingleNode("@basic").getText();
            xentity.setBasic(xentityBasic);

            String xentityOthers = entityNode.selectSingleNode("@others") == null ? "" : entityNode.selectSingleNode("@others").getText();
            xentity.setOthers(xentityOthers);

            xentity.setModule(module);

            Integer flag = 1;
            Node reference = entityNode.selectSingleNode("@reference");
            if (reference != null) {
                /*Xentity tempXentity = entityMap.get(reference.getText());
                if (tempXentity != null) {
                    xentity.setModel(tempXentity.getModel());
                    xentity.setFieldMap(tempXentity.getFieldMap());
                } else {*/
                xentity.setReference(reference.getText());
                flag = 2;
//                }

            } else {
                xentity.setModel(entityNode.selectSingleNode("@model").getText());

                /*生成fieldMap*/
                List<Node> fieldNodeList = entityNode.selectNodes("fields/field");
                LinkedHashMap<String, Field> fieldMap = new LinkedHashMap<>();
                fieldMap = createFieldMap(fieldNodeList, fieldMap);
                xentity.setFieldMap(fieldMap);

                /*生成moFieldMap*/
                /*List<Node> moFieldNodeList = entityNode.selectNodes("moFields/field");
                Map<String, Field> moFieldMap = new HashMap<>();
                moFieldMap = createFieldMap(moFieldNodeList, moFieldMap);
                xentity.setMoFieldMap(moFieldMap);*/

            }

            /*生成DoMap*/
            Map<String, Do> doMap = createDoMap(xentity, entityNode);
            xentity.setDoMap(doMap);

            if (flag == 1) {
                entityMap.put(xentity.getName(), xentity);
            } else {
                tempEntityMap.put(xentity.getName(), xentity);
            }

            xentityList.add(xentity);
        }

        return xentityList;
    }

    /*生成entityMap*/
    private static List<Xentity> createEntityMap2(Module module, Node node) {
        List<Xentity> xentityList = new ArrayList<>();
        List<Node> entityNodeList = node.selectNodes("entities/entity");
        for (Node entityNode : entityNodeList) {

            String xentityName = entityNode.selectSingleNode("@name").getText();
            Xentity xentity = entityMap.get(xentityName);

            Boolean flag = false;
            Node inheritNode = node.selectSingleNode("@inherit");

            if (inheritNode != null && inheritNode.getText().equals("hide")) {
                entityMap.remove(xentityName);
                continue;
            } else if (inheritNode != null && inheritNode.getText().equals("same")) {
                flag = true;
            }

            Integer mapFlag = 1;
            if (!flag) {
                if (xentity == null) {
                    xentity = new Xentity();

                    Node reference = entityNode.selectSingleNode("@reference");
                    if (reference != null) {
                        /*Xentity tempXentity = entityMap.get(reference.getText());
                        if (tempXentity != null) {
                            xentity.setModel(tempXentity.getModel());
                            xentity.setFieldMap(tempXentity.getFieldMap());
                        } else {*/

                        xentity.setReference(reference.getText());
                        mapFlag = 2;
//                        }

                    } else {
                        xentity.setModel(entityNode.selectSingleNode("@model").getText());

                        /*生成fieldMap*/
                        List<Node> fieldNodeList = entityNode.selectNodes("fields/field");
                        LinkedHashMap<String, Field> fieldMap = new LinkedHashMap<>();
                        fieldMap = createFieldMap(fieldNodeList, fieldMap);
                        xentity.setFieldMap(fieldMap);

                        /*生成moFieldMap*/
                        /*List<Node> moFieldNodeList = entityNode.selectNodes("moFields/field");
                        Map<String, Field> moFieldMap = new HashMap<>();
                        moFieldMap = createFieldMap(moFieldNodeList, moFieldMap);
                        xentity.setMoFieldMap(moFieldMap);*/
                    }
                    /*生成fieldMap*/
                    /*Map<String, Field> fieldMap = createFieldMap(entityNode);
                    xentity.setFieldMap(fieldMap);*/
                }
                xentity.setName(entityNode.selectSingleNode("@name").getText());
                xentity.setLabel(entityNode.selectSingleNode("@label").getText());
                xentity.setType(entityNode.selectSingleNode("@type") == null ? "" : entityNode.selectSingleNode("@type").getText());

                if (xentity.getModel() == null || xentity.getModel().equals("")) {
                    xentity.setModel(entityNode.selectSingleNode("@model") == null ? null : entityNode.selectSingleNode("@model").getText());
                }

                String xentityBasic = entityNode.selectSingleNode("@basic") == null ? "" : entityNode.selectSingleNode("@basic").getText();
                xentity.setBasic(xentityBasic);

                String xentityOthers = entityNode.selectSingleNode("@others") == null ? "" : entityNode.selectSingleNode("@others").getText();
                xentity.setOthers(xentityOthers);

            }

            xentity.setModule(module);

            /*生成DoMap*/
            Map<String, Do> doMap = createDoMap2(xentity, entityNode);
            xentity.setDoMap(doMap);

            if (mapFlag == 1) {
                entityMap.put(xentity.getName(), xentity);
            } else {
                tempEntityMap.put(xentity.getName(), xentity);
            }

            xentityList.add(xentity);
        }

        if (module.getXentityList() != null && module.getXentityList().size() > 0) {
            for (Xentity xentity : module.getXentityList()) {
                String xentityName1 = xentity.getName();
                Boolean flag = false;
                for (Xentity xentity2 : xentityList) {
                    String xentityName2 = xentity2.getName();
                    if (xentityName1.equals(xentityName2)) {
                        flag = true;
                    }
                }

                if (!flag) {
                    xentityList.add(xentity);
                }
            }
        }

        return xentityList;
    }

    private static LinkedHashMap<String, Field> createFieldMap(List<Node> fieldNodeList, LinkedHashMap<String, Field> fieldMap) {

//        Map<String, Field> fieldMap = new HashMap<>();

//        List<Node> fieldNodeList = entityNode.selectNodes("fields/field");

        if (fieldNodeList != null && fieldNodeList.size() > 0) {
            for (Node fieldNode : fieldNodeList) {

                String name = fieldNode.selectSingleNode("@name").getText();
                String label = fieldNode.selectSingleNode("@label") == null ? "" : fieldNode.selectSingleNode("@label").getText();
                String inputType = fieldNode.selectSingleNode("@inputType") == null ? "" : fieldNode.selectSingleNode("@inputType").getText();

                String value = fieldNode.selectSingleNode("@value") == null ? "" : fieldNode.selectSingleNode("@value").getText();
                String key = fieldNode.selectSingleNode("@key") == null ? "" : fieldNode.selectSingleNode("@key").getText();

                String name2 = fieldNode.selectSingleNode("@name2") == null ? "" : fieldNode.selectSingleNode("@name2").getText();
                String dataType = fieldNode.selectSingleNode("@dataType") == null ? "" : fieldNode.selectSingleNode("@dataType").getText();

                String gtype = fieldNode.selectSingleNode("@gtype") == null ? "" : fieldNode.selectSingleNode("@gtype").getText();
                String gvalue = "";
                if (fieldNode.selectSingleNode("@gtype") != null) {
                    gvalue = fieldNode.selectSingleNode("@gvalue") == null ? key : fieldNode.selectSingleNode("@gvalue").getText();
                }

                String orderby = fieldNode.selectSingleNode("@orderby") == null ? "" : fieldNode.selectSingleNode("@orderby").getText();
                String viewType = fieldNode.selectSingleNode("@viewType") == null ? "" : fieldNode.selectSingleNode("@viewType").getText();
                String formType = fieldNode.selectSingleNode("@formType") == null ? "" : fieldNode.selectSingleNode("@formType").getText();

                String reference = fieldNode.selectSingleNode("@reference") == null ? "" : fieldNode.selectSingleNode("@reference").getText();
                String source = fieldNode.selectSingleNode("@source") == null ? "" : fieldNode.selectSingleNode("@source").getText();


                /*dictionaryField*/
                List<Node> dictionaryNodeList = fieldNode.selectNodes("dictDefination");
                if (dictionaryNodeList.size() > 0) {


                }

                /*statusTypeField*/
                List<Node> statusTypeNodeList = fieldNode.selectNodes("statusType");
                if (statusTypeNodeList.size() > 0) {

                    StatusTypeField statusTypeField = createStatusTypeField(statusTypeNodeList);

                    statusTypeField.setName(name);
                    statusTypeField.setLabel(label);
                    statusTypeField.setInputType(inputType);
                    statusTypeField.setKey(key);

                    statusTypeField.setName2(name2);
                    statusTypeField.setValue(value);
                    statusTypeField.setDataType(dataType);

                    statusTypeField.setGtype(gtype);
                    statusTypeField.setGvalue(gvalue);

                    statusTypeField.setOrderby(orderby);
                    statusTypeField.setViewType(viewType);
                    statusTypeField.setFormType(formType);

                    statusTypeField.setFieldType("statusType");

                    statusTypeField.setReference(reference);

                    fieldMap.put(statusTypeField.getName(), statusTypeField);


                }

                /*field*/
                if (dictionaryNodeList.size() == 0 && statusTypeNodeList.size() == 0) {
                    Field field = new Field();
                    field.setName(name);
                    field.setLabel(label);
                    field.setInputType(inputType);
                    field.setKey(key);

                    field.setName2(name2);
                    field.setValue(value);
                    field.setDataType(dataType);

                    field.setGtype(gtype);
                    field.setGvalue(gvalue);

                    field.setOrderby(orderby);
                    field.setViewType(viewType);
                    field.setFormType(formType);

                    field.setFieldType("auto");

                    field.setReference(reference);
                    field.setSource(source);

                    fieldMap.put(field.getName(), field);
                }

            }
        }

        return fieldMap;
    }


    private static StatusTypeField createStatusTypeField(List<Node> statusTypeNodeList) {
        StatusTypeField statusTypeField = new StatusTypeField();

        List<StatusType> statusTypeList = new ArrayList<>();
        for (Node statusTypeNode : statusTypeNodeList) {
            StatusType statusType = new StatusType();

            String fieldName = statusTypeNode.selectSingleNode("@fieldName").getText();
            String fieldRequired = statusTypeNode.selectSingleNode("@required") == null ? "" : statusTypeNode.selectSingleNode("@required").getText();
            String fieldLabel = statusTypeNode.selectSingleNode("@label") == null ? "" : statusTypeNode.selectSingleNode("@label").getText();
            String fieldData = statusTypeNode.selectSingleNode("@data") == null ? "" : statusTypeNode.selectSingleNode("@data").getText();

            List<Node> nodes = statusTypeNode.selectNodes("item");
            List<StatusTypeItem> statusTypeItemList = null;
            if (nodes != null) {
                statusTypeItemList = new ArrayList<>();
                for (Node tempNode : nodes) {
                    StatusTypeItem statusTypeItem = new StatusTypeItem();
                    statusTypeItem.setLabel(tempNode.selectSingleNode("@label").getText());
                    statusTypeItem.setValue(tempNode.selectSingleNode("@value").getText());
                    if (!statusTypeItem.getValue().equals("0")) {
                        statusTypeItemList.add(statusTypeItem);
                    }
                }
            }
            statusType.setData(fieldData);
            statusType.setFieldName(fieldName);
            statusType.setRequired(fieldRequired);
            statusType.setLabel(fieldLabel);
            statusType.setStatusTypeItemList(statusTypeItemList);


            statusTypeList.add(statusType);
        }

        statusTypeField.setStatusTypeList(statusTypeList);

        return statusTypeField;
    }

    private static Map<String, Do> createDoMap(Xentity xentity, Node entityNode) {

        List<Node> doNodeList = entityNode.selectNodes("does/do");

        return DoManagerImpl.createDoMap(xentity, doNodeList);
    }

    private static Map<String, Do> createDoMap2(Xentity xentity, Node entityNode) {

        List<Node> doNodeList = entityNode.selectNodes("does/do");

        return DoManagerImpl.createDoMap2(xentity, doNodeList);
    }

    @Override
    public Map<String, Module> fetchModuleMap() {

        return modulesMap;  //To change body of implemented methods use File | Settings | File Templates.
    }

    @Override
    public Map<String, Xentity> fetchXentityMap() {
        return entityMap;  //To change body of implemented methods use File | Settings | File Templates.
    }

    @Override
    public Module fetchModule(String moduleName) {
        return modulesMap.get(moduleName);  //To change body of implemented methods use File | Settings | File Templates.
    }

    @Override
    public Xentity fetchXentity(String xentityName) {
        return entityMap.get(xentityName);  //To change body of implemented methods use File | Settings | File Templates.
    }

    @Override
    public String convertStatusTypeLabel(String key, String propertyValue) {

        String[] keys = key.split("\\.");
        // System.out.println("=============================keys is ========================="+Arrays.deepToString(keys));

        Xentity xentity = entityMap.get(keys[0]);

        if (xentity != null) {
            StatusTypeField statusTypeField = (StatusTypeField) xentity.getFieldMap().get(keys[1]);
            if (statusTypeField != null) {
                if (keys.length == 2) {
                    StatusType statusType = statusTypeField.getStatusTypeList().get(0);
                    for (StatusTypeItem statusTypeItem : statusType.getStatusTypeItemList()) {
                        if (statusTypeItem.getValue().equals(propertyValue)) {
                            return statusTypeItem.getLabel();
                        }
                    }
                } else {
                    for (StatusType statusType : statusTypeField.getStatusTypeList()) {
                        if (statusType.getFieldName().equals(keys[2])) {
                            for (StatusTypeItem statusTypeItem : statusType.getStatusTypeItemList()) {
                                if (statusTypeItem.getValue().equals(propertyValue)) {
                                    return statusTypeItem.getLabel();
                                }
                            }
                        }
                    }
                }
            }
        }

        return "";
    }

    @Override
    public StatusType fetchStatusType(String key) {

        String[] keys = key.split("\\.");
        Xentity xentity = entityMap.get(keys[0]);

        if (xentity != null) {
            StatusTypeField statusTypeField = (StatusTypeField) xentity.getFieldMap().get(keys[1]);
            if (statusTypeField != null) {
                if (keys.length == 2) {
                    return statusTypeField.getStatusTypeList().get(0);
                } else {
                    for (StatusType statusType : statusTypeField.getStatusTypeList()) {
                        if (statusType.getFieldName().equals(keys[2])) {
                            return statusType;
                        }
                    }
                }
            }
        }

        return null;  //To change body of implemented methods use File | Settings | File Templates.
    }

    @Override
    public List<StatusTypeItem> listStatusTypeItem(String key) {

        String[] keys = key.split("\\.");
        Xentity xentity = entityMap.get(keys[0]);

        if (xentity != null) {
            StatusTypeField statusTypeField = (StatusTypeField) xentity.getFieldMap().get(keys[1]);
            if (statusTypeField != null) {
                if (keys.length == 2) {
                    StatusType statusType = statusTypeField.getStatusTypeList().get(0);
                    return statusType.getStatusTypeItemList();
                } else {
                    for (StatusType statusType : statusTypeField.getStatusTypeList()) {
                        if (statusType.getFieldName().equals(keys[2])) {
                            return statusType.getStatusTypeItemList();
                        }
                    }
                }
            }
        }

        return null;  //To change body of implemented methods use File | Settings | File Templates.
    }

    public List<StatusType> listStatusType(String key) {
        String[] keys = key.split("\\.");
        Xentity xentity = entityMap.get(keys[0]);
        StatusTypeField statusTypeField = (StatusTypeField) xentity.getFieldMap().get(keys[1]);
        return statusTypeField.getStatusTypeList();
    }



}