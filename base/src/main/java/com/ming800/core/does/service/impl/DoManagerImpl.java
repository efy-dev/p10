package com.ming800.core.does.service.impl;

import com.ming800.core.base.dao.XdoDao;
import com.ming800.core.does.model.*;
import com.ming800.core.does.service.DoManager;
import com.ming800.core.does.model.Xentity;
//import com.ming800.organization.model.Role;
import org.dom4j.Node;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

/**
 * Created with IntelliJ IDEA.
 * User: ming
 * Date: 12-11-17
 * Time: 下午4:25
 * To change this template use File | Settings | File Templates.
 */
@Service
public class DoManagerImpl implements DoManager {

    private static Map<String, Do> queryModelMap = new HashMap<>();


    public static void generateDoMap(Map<String, Xentity> entityMap) throws Exception {

        Iterator iterator = queryModelMap.keySet().iterator();
        while (iterator.hasNext()) {
            String key = (String) iterator.next();
            Do tempDo = queryModelMap.get(key);
            if (tempDo.getXentity().getReference() != null && !tempDo.getXentity().getReference().equals("")) {
                tempDo.setXentity(entityMap.get(tempDo.getXentity().getName()));
            }

            if (tempDo.getPageList() != null) {
                for (Page page : tempDo.getPageList()) {
                    if (page.getCommandList() != null && page.getCommandList().size() > 0) {
                        createNewPermission(page.getCommandList());
                    }
                    if (page.getOperationList() != null && page.getOperationList().size() > 0) {
                        createNewPermission(page.getOperationList());
                    }
                }
            }

        }
    }

    private static void createNewPermission(List<Command> commandList) throws Exception {
        for (Command command : commandList) {
            String tempUrl = command.getUrl();
            String tempPermission = command.getPermission();
            if (tempUrl.contains("?qm=") && tempPermission.equals("")) {
                String tempDoName = tempUrl.substring(tempUrl.indexOf("?qm=") + 4, tempUrl.contains("&") ? tempUrl.indexOf("&") : tempUrl.length());

                if (tempDoName.contains("_")) {
                    tempDoName = tempDoName.split("_")[0];
                }

                try {
                    Xentity tempXentity = queryModelMap.get(tempDoName).getXentity();
                    if (tempXentity == null) {
                        throw new Exception(tempDoName + "不存在相应配置");
                    }
                    if (tempDoName.startsWith("form")) {
                        if (tempUrl.contains("&id")) {
                            tempPermission = tempXentity.getName() + ":em";
                        } else {
                            tempPermission = tempXentity.getName() + ":new";
                        }
                    } else if (tempDoName.startsWith("plistMy") || tempDoName.startsWith("listMy")) {
                        tempPermission = tempXentity.getName() + ":vm";
                    } else if (tempDoName.startsWith("plist") || tempDoName.startsWith("list") || tempDoName.startsWith("view")) {
                        tempPermission = tempXentity.getName() + ":va";
                    } else if (tempDoName.startsWith("delete") || tempDoName.startsWith("remove")) {
                        tempPermission = tempXentity.getName() + ":dm";
                    }
                    command.setPermission(tempPermission);
                } catch (Exception e) {
                    e.printStackTrace();
                }

            }

        }
    }

    public static Map<String, Do> createDoMap(Xentity xentity, List<Node> nodeList) {
        Map<String, Do> tempQueryModelMap = new HashMap<>();


        for (Node node : nodeList) {

            Do tempDo = new Do();
            tempDo.setName(node.selectSingleNode("@name").getText());
            tempDo.setXentity(xentity);
//            tempDo.setModel(node.selectSingleNode("@model").getText());
            tempDo.setResult(node.selectSingleNode("@result") == null ? "" : node.selectSingleNode("@result").getText());
            tempDo.setExecute(node.selectSingleNode("@execute") == null ? "" : node.selectSingleNode("@execute").getText());
//            tempDo.setEntity(node.selectSingleNode("@entity") == null ? "" : node.selectSingleNode("@entity").getText());
            tempDo.setLabel(node.selectSingleNode("@label") == null ? "" : node.selectSingleNode("@label").getText());
            tempDo.setType(node.selectSingleNode("@type") == null ? "" : node.selectSingleNode("@type").getText());
            tempDo.setData(node.selectSingleNode("@data") == null ? "" : node.selectSingleNode("@data").getText());
            tempDo.setAccess(node.selectSingleNode("@access") == null ? "" : node.selectSingleNode("@access").getText());

            List<DoQuery> doQueryList = new ArrayList<>();
            List<Node> nodeDoQueryList = node.selectNodes("query");

            if (nodeDoQueryList != null && nodeDoQueryList.size() > 0) {
                for (Node doQueryNode : nodeDoQueryList) {
                    DoQuery doQuery = new DoQuery();
                    doQuery.setName(doQueryNode.selectSingleNode("@name").getText());
                    doQuery.setLabel(doQueryNode.selectSingleNode("@label").getText());
                    doQuery.setOrderBy(doQueryNode.selectSingleNode("@orderBy") == null ? "" : doQueryNode.selectSingleNode("@orderBy").getText());
                    doQuery.setGroupBy(doQueryNode.selectSingleNode("@groupby") == null ? "" : doQueryNode.selectSingleNode("@groupby").getText());
                    doQuery.setType(doQueryNode.selectSingleNode("@type") == null ? "" : doQueryNode.selectSingleNode("@type").getText());
                    doQuery.setQueryHql(doQueryNode.selectSingleNode("@queryHql") == null ? "" : doQueryNode.selectSingleNode("@queryHql").getText());
                    doQuery.setQueryExpress(doQueryNode.selectSingleNode("@express") == null ? "" : doQueryNode.selectSingleNode("@express").getText());
                    doQuery.setQueryExecute(doQueryNode.selectSingleNode("@execute") == null ? "" : doQueryNode.selectSingleNode("@execute").getText());

                    List<QueryCondition> queryConditionList = new ArrayList<>();
                    List<Node> nodeConditionList = doQueryNode.selectNodes("condition");
                    if (nodeConditionList != null && nodeConditionList.size() > 0) {
                        for (Node conditionNode : nodeConditionList) {
                            QueryCondition tempQueryCondition = new QueryCondition();

                            String name = conditionNode.selectSingleNode("@name").getText();

                            Field tempField = null;
                            if (xentity.getFieldMap() != null) {
                                tempField = xentity.getFieldMap().get(name);
                            }

                            String label = "";
                            Node labelNode = conditionNode.selectSingleNode("@label");
                            if (labelNode != null) {
                                label = labelNode.getText();
                            } else if (tempField != null) {
                                label = tempField.getLabel();
                            }

                            Node valueNode = conditionNode.selectSingleNode("@defaultValue");
                            String value = "";
                            if (valueNode != null) {
                                value = valueNode.getText();
                            } else if (tempField != null) {
                                value = tempField.getValue();
                            }

                            Node inputTypeNode = conditionNode.selectSingleNode("@inputType");
                            String inputType = "";
                            if (inputTypeNode != null) {
                                inputType = inputTypeNode.getText();
                            } else if (tempField != null) {
                                inputType = tempField.getInputType();
                            }

                            Node keyNode = conditionNode.selectSingleNode("@key");
                            String key = "";
                            if (keyNode != null) {
                                key = keyNode.getText();
                            } else if (tempField != null) {
                                key = tempField.getKey();
                            }

                            Node dataTypeNode = conditionNode.selectSingleNode("@dataType");
                            String dataType = "";
                            if (dataTypeNode != null) {
                                dataType = dataTypeNode.getText();
                            } else if (tempField != null) {
                                dataType = tempField.getDataType();
                            }


                            tempQueryCondition.setName(name);
                            tempQueryCondition.setLabel(label);
                            tempQueryCondition.setInputType(inputType);
                            tempQueryCondition.setKey(key);
                            tempQueryCondition.setValue(value);
                            tempQueryCondition.setDataType(dataType);

                            tempQueryCondition.setOperation(conditionNode.selectSingleNode("@operation") == null ? "" : conditionNode.selectSingleNode("@operation").getText());

                            tempQueryCondition.setRequired(conditionNode.selectSingleNode("@required") == null ? false : true);

                            queryConditionList.add(tempQueryCondition);
                        }

                        doQuery.setConditionList(queryConditionList);
                    }

                    List<Groupby> groupByList = new ArrayList<>();
                    List<Node> nodeGroupByList = doQueryNode.selectNodes("groupby");
                    if (nodeGroupByList != null && nodeGroupByList.size() > 0) {
                        for (Node groupByNode : nodeGroupByList) {
                            Groupby groupBy = new Groupby();
                            groupBy.setName(groupByNode.selectSingleNode("@name").getText());
                            groupBy.setKey(groupByNode.selectSingleNode("@key") == null ? "" : groupByNode.selectSingleNode("@key").getText());
                            groupBy.setGtype(groupByNode.selectSingleNode("@gtype") == null ? "" : groupByNode.selectSingleNode("@gtype").getText());
                            groupBy.setExtendName(groupByNode.selectSingleNode("@extendName") == null ? "" : groupByNode.selectSingleNode("@extendName").getText());
                            groupBy.setExpression(groupByNode.selectSingleNode("@expression") == null ? "" : groupByNode.selectSingleNode("@expression").getText());

                            groupByList.add(groupBy);
                        }
                    }
                    doQuery.setGroupByList(groupByList);

                    doQueryList.add(doQuery);
                }
            }

            tempDo.setDoQueryList(doQueryList);

            List<Node> nodeDoPageList = node.selectNodes("page");
            List<Page> pageList = new ArrayList<>();
            if (nodeDoPageList != null && nodeDoPageList.size() > 0) {
                pageList = initQueryModelViewMap(xentity, nodeDoPageList);
            }
            tempDo.setPageList(pageList);


            tempQueryModelMap.put(tempDo.getName(), tempDo);

        }

        queryModelMap.putAll(tempQueryModelMap);
        return tempQueryModelMap;
    }

    public static Map<String, Do> createDoMap2(Xentity xentity, List<Node> nodeList) {
        Map<String, Do> tempQueryModelMap = new HashMap<>();

        for (Node node : nodeList) {

            String tempDoName = node.selectSingleNode("@name").getText();
            Do tempDo = queryModelMap.get(tempDoName);

            Boolean flag = false;
            Node inheritNode = node.selectSingleNode("@inherit");
            if (inheritNode != null && inheritNode.getText().equals("hide")) {
                queryModelMap.remove(tempDoName);
                xentity.getDoMap().remove(tempDoName);
                continue;
            }

            if (inheritNode != null && inheritNode.getText().equals("same")) {
                flag = true;
            }

            if (!flag) {
                if (tempDo == null) {
                    tempDo = new Do();
                }
                tempDo.setName(node.selectSingleNode("@name").getText());
                tempDo.setXentity(xentity);
                tempDo.setResult(node.selectSingleNode("@result").getText());
                tempDo.setExecute(node.selectSingleNode("@execute") == null ? "" : node.selectSingleNode("@execute").getText());
//                tempDo.setEntity(node.selectSingleNode("@entity") == null ? "" : node.selectSingleNode("@entity").getText());
                tempDo.setLabel(node.selectSingleNode("@label") == null ? "" : node.selectSingleNode("@label").getText());
                tempDo.setType(node.selectSingleNode("@type") == null ? "" : node.selectSingleNode("@type").getText());
                tempDo.setData(node.selectSingleNode("@data") == null ? "" : node.selectSingleNode("@data").getText());
            }

            List<DoQuery> doQueryList = createDoQueryList(tempDo, node);
            if (tempDo.getDoQueryList() != null && tempDo.getDoQueryList().size() > 0) {
                tempDo.getDoQueryList().clear();
            }
            tempDo.setDoQueryList(doQueryList);


            /*不能够重新定义*/
            List<Node> nodeDoPageList = node.selectNodes("page");
            if (nodeDoPageList != null && nodeDoPageList.size() > 0) {
                List<Page> pageList = initQueryModelViewMap(xentity, nodeDoPageList);
                tempDo.setPageList(pageList);
            }


            tempQueryModelMap.put(tempDo.getName(), tempDo);
        }

        queryModelMap.putAll(tempQueryModelMap);

        return tempQueryModelMap;
    }

    public static List<DoQuery> createDoQueryList(Do tempDo, Node node) {

        List<DoQuery> doQueryList = new ArrayList<>();
        List<Node> nodeDoQueryList = node.selectNodes("query");

        if (nodeDoQueryList != null && nodeDoQueryList.size() > 0) {
            for (Node doQueryNode : nodeDoQueryList) {
                String doQueryName = doQueryNode.selectSingleNode("@name").getText();

                DoQuery doQuery = null;

                Boolean flag = false;
                Node inheritNode = doQueryNode.selectSingleNode("@inherit");
                if (inheritNode != null && inheritNode.getText().equals("hide")) {
                    Iterator<DoQuery> iterator = tempDo.getDoQueryList().iterator();
                    while (iterator.hasNext()) {
                        doQuery = iterator.next();
                        if (doQuery.getName().equals(doQueryName)) {
                            iterator.remove();
                            break;
                        }
                    }
                    continue;
                } else if (inheritNode != null && inheritNode.getText().equals("same")) {
                    for (DoQuery tempDoQuery : tempDo.getDoQueryList()) {
                        if (tempDoQuery.getName().equals(doQueryName)) {
                            doQuery = tempDoQuery;
                            break;
                        }
                    }

                    flag = true;
                }


                if (!flag) {
                    if (doQuery == null) {
                        doQuery = new DoQuery();
                    }
                    doQuery.setName(doQueryName);
                    doQuery.setLabel(doQueryNode.selectSingleNode("@label").getText());
                    doQuery.setOrderBy(doQueryNode.selectSingleNode("@orderBy") == null ? "" : doQueryNode.selectSingleNode("@orderBy").getText());
                    doQuery.setGroupBy(doQueryNode.selectSingleNode("@groupby") == null ? "" : doQueryNode.selectSingleNode("@groupby").getText());
                    doQuery.setType(doQueryNode.selectSingleNode("@type") == null ? "" : doQueryNode.selectSingleNode("@type").getText());
                    doQuery.setQueryHql(doQueryNode.selectSingleNode("@queryHql") == null ? "" : doQueryNode.selectSingleNode("@queryHql").getText());
                    doQuery.setQueryExpress(doQueryNode.selectSingleNode("@express") == null ? "" : doQueryNode.selectSingleNode("@express").getText());
                    doQuery.setQueryExecute(doQueryNode.selectSingleNode("@execute") == null ? "" : doQueryNode.selectSingleNode("@execute").getText());
                }

                List<QueryCondition> queryConditionList = createQueryConditionList(tempDo.getXentity(), doQuery, doQueryNode);
                if (doQuery.getConditionList() != null && doQuery.getConditionList().size() > 0) {
                    doQuery.getConditionList().clear();
                }
                doQuery.setConditionList(queryConditionList);

                List<Groupby> groupByList = createGroupByList(doQuery, doQueryNode);
                if (doQuery.getGroupByList() != null && doQuery.getGroupByList().size() > 0) {
                    doQuery.getGroupByList().clear();
                }
                doQuery.setGroupByList(groupByList);

                doQueryList.add(doQuery);
            }
        }


        if (tempDo.getDoQueryList() != null && tempDo.getDoQueryList().size() > 0) {
            for (DoQuery doQuery1 : tempDo.getDoQueryList()) {
                String doQueryName1 = doQuery1.getName();
                Boolean flag = false;
                for (DoQuery doQuery2 : doQueryList) {
                    String doQueryName2 = doQuery2.getName();
                    if (doQueryName1.equals(doQueryName2)) {
                        flag = true;
                    }
                }

                if (!flag) {
                    doQueryList.add(doQuery1);
                }
            }
        }

        return doQueryList;
    }

    public static List<QueryCondition> createQueryConditionList(Xentity xentity, DoQuery doQuery, Node doQueryNode) {
        List<QueryCondition> queryConditionList = new ArrayList<>();
        List<Node> nodeConditionList = doQueryNode.selectNodes("condition");
        if (nodeConditionList != null && nodeConditionList.size() > 0) {
            for (Node queryConditionNode : nodeConditionList) {
                QueryCondition queryCondition = null;
                String queryConditionName = queryConditionNode.selectSingleNode("@name").getText();

                Boolean flag = false;
                Node inheritNode = queryConditionNode.selectSingleNode("@inherit");
                if (inheritNode != null && inheritNode.getText().equals("hide")) {
                    Iterator<QueryCondition> iterator = doQuery.getConditionList().iterator();
                    while (iterator.hasNext()) {
                        QueryCondition tempDoQuery = iterator.next();
                        if (tempDoQuery.getName().equals(queryConditionName)) {
                            iterator.remove();
                            break;
                        }
                    }
                    continue;
                } else if (inheritNode != null && inheritNode.getText().equals("same")) {
                    for (QueryCondition tempQueryCondition : doQuery.getConditionList()) {
                        if (tempQueryCondition.getName().equals(queryConditionName)) {
                            queryCondition = tempQueryCondition;
                            break;
                        }
                    }

                    flag = true;
                }


                if (!flag) {

                    if (queryCondition == null) {
                        queryCondition = new QueryCondition();
                    }

                    Field tempField = null;
                    if (xentity.getFieldMap() != null) {
                        tempField = xentity.getFieldMap().get(queryConditionName);
                    }
                    String label = "";
                    Node labelNode = queryConditionNode.selectSingleNode("@label");
                    if (labelNode != null) {
                        label = labelNode.getText();
                    } else if (tempField != null) {
                        label = tempField.getLabel();
                    }

                    Node valueNode = queryConditionNode.selectSingleNode("@defaultValue");
                    String value = "";
                    if (valueNode != null) {
                        value = valueNode.getText();
                    } else if (tempField != null) {
                        value = tempField.getValue();
                    }

                    Node inputTypeNode = queryConditionNode.selectSingleNode("@inputType");
                    String inputType = "";
                    if (inputTypeNode != null) {
                        inputType = inputTypeNode.getText();
                    } else if (tempField != null) {
                        inputType = tempField.getInputType();
                    }

                    Node keyNode = queryConditionNode.selectSingleNode("@key");
                    String key = "";
                    if (keyNode != null) {
                        key = keyNode.getText();
                    } else if (tempField != null) {
                        key = tempField.getKey();
                    }

                    Node dataTypeNode = queryConditionNode.selectSingleNode("@dataType");
                    String dataType = "";
                    if (dataTypeNode != null) {
                        dataType = dataTypeNode.getText();
                    } else if (tempField != null) {
                        dataType = tempField.getDataType();
                    }


                    queryCondition.setName(queryConditionName);
                    queryCondition.setLabel(label);
                    queryCondition.setInputType(inputType);
                    queryCondition.setKey(key);
                    queryCondition.setValue(value);
                    queryCondition.setDataType(dataType);

//                    queryCondition.setName(queryConditionName);
//                    queryCondition.setLabel(queryConditionNode.selectSingleNode("@label").getText());
//                    queryCondition.setValue(queryConditionNode.selectSingleNode("@defaultValue") == null ? "":queryConditionNode.selectSingleNode("@defaultValue").getText());
//                    queryCondition.setInputType(queryConditionNode.selectSingleNode("@inputType") == null ? "":queryConditionNode.selectSingleNode("@inputType").getText());
//                    queryCondition.setKey(queryConditionNode.selectSingleNode("@key") == null ? "":queryConditionNode.selectSingleNode("@key").getText());
//                    queryCondition.setDataType(queryConditionNode.selectSingleNode("@dataType") == null ? "":queryConditionNode.selectSingleNode("@dataType").getText());

                    queryCondition.setOperation(queryConditionNode.selectSingleNode("@operation") == null ? "" : queryConditionNode.selectSingleNode("@operation").getText());

                    queryCondition.setRequired(queryConditionNode.selectSingleNode("@required") == null ? false : true);

                }

                queryConditionList.add(queryCondition);
            }
        }

        if (doQuery.getConditionList() != null && doQuery.getConditionList().size() > 0) {
            for (QueryCondition queryCondition1 : doQuery.getConditionList()) {
                String queryConditionName1 = queryCondition1.getName();
                Boolean flag = false;
                for (QueryCondition queryCondition2 : queryConditionList) {
                    String queryConditionName2 = queryCondition2.getName();
                    if (queryConditionName1.equals(queryConditionName2)) {
                        flag = true;
                    }
                }

                if (!flag) {
                    queryConditionList.add(queryCondition1);
                }
            }
        }

        return queryConditionList;
    }

    public static List<Groupby> createGroupByList(DoQuery doQuery, Node doQueryNode) {
        List<Groupby> groupByList = new ArrayList<>();
        List<Node> nodeGroupByList = doQueryNode.selectNodes("groupby");
        if (nodeGroupByList != null && nodeGroupByList.size() > 0) {
            for (Node groupByNode : nodeGroupByList) {
                Groupby groupBy = new Groupby();
                groupBy.setName(groupByNode.selectSingleNode("@name").getText());
                groupBy.setKey(groupByNode.selectSingleNode("@key") == null ? "" : groupByNode.selectSingleNode("@key").getText());
                groupBy.setGtype(groupByNode.selectSingleNode("@gtype") == null ? "" : groupByNode.selectSingleNode("@gtype").getText());
                groupBy.setExtendName(groupByNode.selectSingleNode("@extendName") == null ? "" : groupByNode.selectSingleNode("@extendName").getText());
                groupBy.setExpression(groupByNode.selectSingleNode("@expression") == null ? "" : groupByNode.selectSingleNode("@expression").getText());

                groupByList.add(groupBy);
            }
        }

        if (doQuery.getGroupByList() != null && doQuery.getGroupByList().size() > 0) {
            for (Groupby groupby1 : doQuery.getGroupByList()) {
                String groupby1Name = groupby1.getName();
                Boolean flag = false;
                for (Groupby groupby2 : groupByList) {
                    String groupby2Name = groupby2.getName();
                    if (groupby1Name.equals(groupby2Name)) {
                        flag = true;
                    }
                }

                if (!flag) {
                    groupByList.add(groupby1);
                }
            }
        }

        return groupByList;
    }

    public static List<Page> initQueryModelViewMap(Xentity xentity, List<Node> nodeXmlDataModelViewList) {
        List<Page> pageList = new ArrayList<>();

        for (Node node : nodeXmlDataModelViewList) {

            Page tempPage = new Page();
            tempPage.setName(node.selectSingleNode("@name") == null ? "" : node.selectSingleNode("@name").getText());
            tempPage.setLabel(node.selectSingleNode("@label") == null ? "" : node.selectSingleNode("@label").getText());
            tempPage.setType(node.selectSingleNode("@type") == null ? "" : node.selectSingleNode("@type").getText());
            tempPage.setUrl(node.selectSingleNode("@url") == null ? "" : node.selectSingleNode("@url").getText());
            tempPage.setTotal(node.selectSingleNode("@total") == null ? "" : node.selectSingleNode("@total").getText());
            tempPage.setSortName(node.selectSingleNode("@sortName") == null ? "" : node.selectSingleNode("@sortName").getText());

            List<Node> nodeCommandsList = node.selectNodes("commands");
            if (nodeCommandsList != null && nodeCommandsList.size() > 0) {
                for (Node commandsNode : nodeCommandsList) {
                    List<Command> commandList = new ArrayList<>();

                    List<Node> nodeCommandList = commandsNode.selectNodes("command");
                    if (nodeCommandList != null && nodeCommandList.size() > 0) {
                        for (Node commandNode : nodeCommandList) {
                            Command command = new Command();

                            String commandName = commandNode.selectSingleNode("@name").getText();
                            command.setName(commandName);
                            command.setLabel(commandNode.selectSingleNode("@label").getText());

                            Node urlNode = commandNode.selectSingleNode("@url");
                            String url = "";
                            if (urlNode == null) {
                                url = "/basic/xm.do";
                                if (commandName.startsWith("new")) {
                                    url += "?qm=" + "form" + commandName.substring(3, commandName.length());
                                } else if (commandName.startsWith("edit")) {
                                    url += "?qm=" + "form" + commandName.substring(4, commandName.length()) + "&id=${id}";
                                } else if (commandName.startsWith("remove")) {
                                    url += "?qm=" + "remove" + commandName.substring(6, commandName.length()) + "&id=${id}";
                                } else if (commandName.startsWith("delete")) {
                                    url += "?qm=" + "delete" + commandName.substring(6, commandName.length()) + "&id=${id}";
                                } else if (commandName.startsWith("plist")) {
                                    url += "?qm=" + "plist" + commandName.substring(5, commandName.length());
                                }
                            } else {
                                url = urlNode.getText();
                            }
                            command.setUrl(url);
//                            command.setUrl(commandNode.selectSingleNode("@url") == null ? "" : commandNode.selectSingleNode("@url").getText());

                            Node typeNode = commandNode.selectSingleNode("@type");
                            String type = "";
                            if (typeNode == null) {
                                if (commandName.startsWith("new")) {
                                    type = "add";
                                }
                            } else {
                                type = typeNode.getText();
                            }
                            command.setType(type);
//                            command.setType(commandNode.selectSingleNode("@type") == null ? "" : commandNode.selectSingleNode("@type").getText());

                            Node permissionNode = commandNode.selectSingleNode("@access");
                            String permission = "";
                            if (permissionNode != null) {
                                permission = permissionNode.getText();
                            }
                            /*if (permissionNode == null || permissionNode.getText().equals("")) {

                                if (url.indexOf("form") > 0) {
                                    if (url.indexOf("&id") > 0) {
                                        permission = xentity.getName() + ":ea";
                                    } else {
                                        permission = xentity.getName() + ":new";
                                    }
                                } else if (url.indexOf("plistMy") > 0 || url.indexOf("listMy") > 0) {
                                    permission = xentity.getName() + ":vm";
                                }  else if (url.indexOf("plist") > 0 || url.indexOf("list") > 0) {
                                    permission = xentity.getName() + ":va";
                                }  else if (url.indexOf("delete") > 0 || url.indexOf("remove") > 0) {
                                    permission = xentity.getName() + ":da";
                                }


                                *//*if (commandName.startsWith("new")) {
                                    permission = commandName.substring(3, commandName.length()) + ":new";
                                } else if (commandName.startsWith("edit")) {
                                    permission = commandName.substring(4, commandName.length()) + ":ea";
                                } else if (commandName.startsWith("remove")) {
                                    permission = commandName.substring(6, commandName.length()) + ":da";
                                } else if (commandName.startsWith("delete")) {
                                    permission = commandName.substring(6, commandName.length()) + ":da";
                                } else if (url.contains("qm=form")) {
                                    if (url.contains("id=")) {
                                        permission = xentity.getName() + ":ea";
                                    } else {
                                        permission = xentity.getName() + ":new";
                                    }
                                }*//*
                            } else {
                                permission = permissionNode.getText();
                            }*/
                            command.setPermission(permission);
//                            command.setPermission(commandNode.selectSingleNode("@access") == null ? "" : commandNode.selectSingleNode("@access").getText());

                            command.setOwner(commandNode.selectSingleNode("@owner") == null ? "" : commandNode.selectSingleNode("@owner").getText());

                            commandList.add(command);
                        }
                    }
                    String commandType = commandsNode.selectSingleNode("@type").getText();
                    if (commandType.equals("command")) {
                        tempPage.setCommandList(commandList);
                    } else if (commandType.equals("operation")) {
                        tempPage.setOperationList(commandList);
                    } else {
                        tempPage.setBatchOperationList(commandList);
                    }
                }
            }

            List<Node> nodePageFieldsList = node.selectNodes("fields");
            if (nodePageFieldsList != null && nodePageFieldsList.size() > 0) {
                List<PageField> pageFieldList = new ArrayList<>();
                for (Node pagesNode : nodePageFieldsList) {

                    List<Node> nodePageFieldList = pagesNode.selectNodes("field");
                    if (nodePageFieldList != null && nodePageFieldList.size() > 0) {
                        for (Node pageFieldNode : nodePageFieldList) {
                            PageField pageField = new PageField();

                            String name = pageFieldNode.selectSingleNode("@name").getText();
                            Field tempField = null;
                            if (xentity.getFieldMap() != null) {
                                tempField = xentity.getFieldMap().get(name);
                            }

                            pageField.setName(name);

                            Node labelNode = pageFieldNode.selectSingleNode("@label");
                            String label = "";
                            if (labelNode != null) {
                                label = labelNode.getText();
                            } else if (tempField != null) {
                                label = tempField.getLabel();
                            }
                            pageField.setLabel(label);

                            Node dataTypeNode = pageFieldNode.selectSingleNode("@dataType");
                            String dataType = "";
                            if (dataTypeNode != null) {
                                dataType = dataTypeNode.getText();
                            } else if (tempField != null) {
                                dataType = tempField.getDataType();
                            }
                            pageField.setDataType(dataType);

                            Node keyNode = pageFieldNode.selectSingleNode("@key");
                            String key = "";
                            if (keyNode != null) {
                                key = keyNode.getText();
                            } else if (tempField != null) {
                                key = tempField.getKey();
                            }
                            pageField.setKey(key);

                            Node inputTypeNode = pageFieldNode.selectSingleNode("@inputType");
                            String inputType = "";
                            if (inputTypeNode != null) {
                                inputType = inputTypeNode.getText();
                            } else if (tempField != null) {
                                inputType = tempField.getInputType();
                            }
                            pageField.setInputType(inputType);

                            Node valueNode = pageFieldNode.selectSingleNode("@defaultValue");
                            String value = "";
                            if (valueNode != null) {
                                value = valueNode.getText();
                            } else if (tempField != null) {
                                value = tempField.getValue();
                            }
                            pageField.setValue(value);

                            pageField.setUrl(pageFieldNode.selectSingleNode("@url") == null ? "" : pageFieldNode.selectSingleNode("@url").getText());
                            pageField.setGroup(pageFieldNode.selectSingleNode("@group") == null ? "" : pageFieldNode.selectSingleNode("@group").getText());
                            pageField.setPosition(pageFieldNode.selectSingleNode("@position") == null ? "" : pageFieldNode.selectSingleNode("@position").getText());
                            pageField.setValidateType(pageFieldNode.selectSingleNode("@validateType") == null ? "" : pageFieldNode.selectSingleNode("@validateType").getText());
                            pageField.setWidths(pageFieldNode.selectSingleNode("@width") == null ? "20" : pageFieldNode.selectSingleNode("@width").getText());
                            pageField.setAligns(pageFieldNode.selectSingleNode("@align") == null ? "" : pageFieldNode.selectSingleNode("@align").getText());

                            pageField.setRequired(pageFieldNode.selectSingleNode("@isRequired") == null ? false : true);

                            pageFieldList.add(pageField);
                        }
                    }
                }
                tempPage.setFieldList(pageFieldList);
            }
            pageList.add(tempPage);
        }
        return pageList;
    }

    @Override
    public Do getDoByQueryModel(String queryModel) throws Exception {
        Do tempDo = null;
        tempDo = queryModelMap.get(queryModel);
//        String currentRoleType ="";
        //权限校验
        //当前用户角色类型
        //Role role=AuthorizationUtil.getMyUser().getRole();

//        currentRoleType=AuthorizationUtil.getMyUser().getRole().getBasicType();

        //拥有当前动作权限的用户角色
//        String access = tempDo.getAccess();
//        if (tempDo != null && access.contains("$")) {
//
//            //do标签未配置access属性，或者access为空，或者access属性不含当前用户的角色类型
//            if (!access.contains(currentRoleType)) {
//                throw new Exception("当前用户权限不足");
//            }
//        }
        /*
        @TODO 暂时先注释掉权限判断的代码
         */
        if (tempDo == null) {

            //do标签未配置access属性，或者access为空，或者access属性不含当前用户的角色类型
            throw new Exception("tempDo is null");
        }
        return tempDo;  //To change body of implemented methods use File | Settings | File Templates.
    }


    /**
     * 41 都查数据库
     * 31 x,plist,list,view,form查询     save remove delete batch   不查询
     * 21  x,plist,list 查询   save form view remove delete batch开头的不查询
     * 11  x开头的查询    plist list save form view remove delete batch 开头的不查询
     * 0   都不查
     */
    private Boolean queryOrNot(Integer mode, String queryModel) {
        Boolean flag = false;

        if (mode == null || mode == 0) {

        } else {
            char qm = queryModel.charAt(0);
            if (mode == 11) {
                if (qm == 'x') {
                    flag = true;
                }
            } else if (mode == 21) {
                if (qm == 'p' || qm == 'l' || qm == 'x') {
                    flag = true;
                }
            } else if (mode == 31) {
                if (qm == 'p' || qm == 'v' || qm == 'f' || qm == 'l' || qm == 'x') {
                    flag = true;
                }
            } else if (mode == 41) {
                flag = true;
            }
        }


        return flag;
    }

    public static Map<String, Do> getQueryModelMap() {
        return queryModelMap;
    }

    public static void setQueryModelMap(Map<String, Do> queryModelMap) {
        DoManagerImpl.queryModelMap = queryModelMap;
    }





    /*
    public static void readXmlFiles(){

        queryModelMap = new HashMap<>();
        ResourcePatternResolver resolver = new PathMatchingResourcePatternResolver();
        try {
            Resource[] xmlFiles = resolver.getResources("/xdo/*.xml");
            if( xmlFiles != null ){
                for(Resource resource : xmlFiles ){
                    initQueryModelMap(new SAXReader().read(resource.getInputStream()));
                }
            }

            // /xdo2/*.xml中的配置 将覆盖掉/xdo/*.xml中相同的配置
            Resource[] xmlFiles2 = null;
            try{
                xmlFiles2 = resolver.getResources("/xdo2/*.xml");
            }catch (java.io.IOException ioe){
                //默认情况下 xdo2下无文件 所以此处抛出异常为正常现象
            }
            if( xmlFiles2 != null ){
                for(Resource resource : xmlFiles2 ){
                    initQueryModelMap(new SAXReader().read(resource.getInputStream()));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
        }

    }

    public static void initQueryModelMap(org.dom4j.Document document){
        List<Node> nodeXmlDataModelList = document.selectNodes("/xes/does/do");
        for (Node node:nodeXmlDataModelList) {

            Do tempDo = new DoXml();
            tempDo.setName(node.selectSingleNode("@name").getText());
//            tempDo.setModel(node.selectSingleNode("@model").getText());
            tempDo.setResult(node.selectSingleNode("@result").getText());
            tempDo.setExecute(node.selectSingleNode("@execute") == null ? "":node.selectSingleNode("@execute").getText());
            tempDo.setEntity(node.selectSingleNode("@entity") == null ? "":node.selectSingleNode("@entity").getText());
            tempDo.setLabel(node.selectSingleNode("@label") == null ? "":node.selectSingleNode("@label").getText());
            tempDo.setData(node.selectSingleNode("@data") == null ? "":node.selectSingleNode("@data").getText());

            List<DoQuery> doQueryList = new ArrayList<>();
            List<Node> nodeDoQueryList = node.selectNodes("query");

            if (nodeDoQueryList != null && nodeDoQueryList.size() > 0) {
                for (Node doQueryNode:nodeDoQueryList) {
                    DoQuery doQuery = new DoQueryXml();
                    doQuery.setName(doQueryNode.selectSingleNode("@name").getText());
                    doQuery.setLabel(doQueryNode.selectSingleNode("@label").getText());
                    doQuery.setOrderBy(doQueryNode.selectSingleNode("@orderBy") == null ? "":doQueryNode.selectSingleNode("@orderBy").getText());
                    doQuery.setGroupBy(doQueryNode.selectSingleNode("@groupby") == null ? "":doQueryNode.selectSingleNode("@groupby").getText());
                    doQuery.setType(doQueryNode.selectSingleNode("@type") == null ? "":doQueryNode.selectSingleNode("@type").getText());

                    List<QueryCondition> queryConditionList = new ArrayList<>();
                    List<Node> nodeConditionList = doQueryNode.selectNodes("condition");
                    if (nodeConditionList != null && nodeConditionList.size() > 0) {
                        for (Node conditionNode:nodeConditionList) {
                            QueryCondition tempQueryCondition = new QueryConditionXml();
                            tempQueryCondition.setName(conditionNode.selectSingleNode("@name").getText());
                            tempQueryCondition.setLabel(conditionNode.selectSingleNode("@label").getText());

                            tempQueryCondition.setValue(conditionNode.selectSingleNode("@defaultValue") == null ? "":conditionNode.selectSingleNode("@defaultValue").getText());

                            tempQueryCondition.setInputType(conditionNode.selectSingleNode("@inputType") == null ? "":conditionNode.selectSingleNode("@inputType").getText());
                            tempQueryCondition.setKey(conditionNode.selectSingleNode("@key") == null ? "":conditionNode.selectSingleNode("@key").getText());

                            tempQueryCondition.setDataType(conditionNode.selectSingleNode("@dataType") == null ? "":conditionNode.selectSingleNode("@dataType").getText());
                            tempQueryCondition.setOperation(conditionNode.selectSingleNode("@operation") == null ? "":conditionNode.selectSingleNode("@operation").getText());

                            tempQueryCondition.setRequired(conditionNode.selectSingleNode("@required") == null ? false : true);

//                            tempQueryCondition.setType(conditionNode.selectSingleNode("@type") == null ? null:conditionNode.selectSingleNode("@type").getText());

                            queryConditionList.add(tempQueryCondition);
                        }

                        doQuery.setConditionList(queryConditionList);
                    }

                    List<Groupby> groupByList = new ArrayList<>();
                    List<Node> nodeGroupByList = doQueryNode.selectNodes("groupby");
                    if (nodeGroupByList != null && nodeGroupByList.size() > 0) {
                        for (Node groupByNode:nodeGroupByList) {
                            Groupby groupBy = new GroupbyXml();
                            groupBy.setName(groupByNode.selectSingleNode("@name").getText());
                            groupBy.setKey(groupByNode.selectSingleNode("@key") == null ? "":groupByNode.selectSingleNode("@key").getText());
                            groupBy.setGtype(groupByNode.selectSingleNode("@gtype") == null ? "":groupByNode.selectSingleNode("@gtype").getText());
                            groupBy.setExtendName(groupByNode.selectSingleNode("@extendName") == null ? "":groupByNode.selectSingleNode("@extendName").getText());
                            groupBy.setExpression(groupByNode.selectSingleNode("@expression") == null ? "":groupByNode.selectSingleNode("@expression").getText());

                            groupByList.add(groupBy);
                        }
                    }
                    doQuery.setGroupByList(groupByList);

                    doQueryList.add(doQuery);
                }
            }

            tempDo.setDoQueryList(doQueryList);

            List<Node> nodeDoPageList = node.selectNodes("page");
            List<Page> pageList = new ArrayList<>();
            if (nodeDoPageList != null && nodeDoPageList.size() > 0) {
                pageList = initQueryModelViewMap(nodeDoPageList);
            }
            tempDo.setPageList(pageList);


            queryModelMap.put(tempDo.getName(), tempDo);

        }
    }*/


}
