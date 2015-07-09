package com.ming800.core.p.service.impl;


import com.ming800.core.does.service.DoManager;
import com.ming800.core.p.model.Jmenu;
import com.ming800.core.p.model.JmenuTree;
import com.ming800.core.p.model.Jnode;
import com.ming800.core.p.service.GlobalManager;
import com.ming800.core.p.service.JmenuManager;
import com.ming800.core.util.ApplicationContextUtil;
import com.ming800.core.util.ResourcesUtil;

import org.dom4j.Document;
import org.dom4j.Node;
import org.dom4j.io.SAXReader;
import org.springframework.beans.factory.annotation.Autowired;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by IntelliJ IDEA.
 * User: ming
 * Date: 12-8-6
 * Time: 上午11:04
 * To change this template use File | Settings | File Templates.
 */
public class JmenuManagerImpl implements JmenuManager {

    private static final String MENU_COMMONMENU = "/setting/jmenu_commonMenu.xml";
    private static HashMap<String, JmenuTree> menuHashMap;
    private static int jmenuId = 1;
    private DoManager doManager;

    @Autowired
    private GlobalManager globalManager;


    private static void initMenu() {
        menuHashMap = new HashMap<>();
        File tempFile = new File(JmenuManagerImpl.class.getClassLoader().getResource("/").getPath());
       /* String tempFileName = tempFile.getParentFile().getParentFile().getParentFile().getParentFile().getParentFile().getPath();*/

        File dir_commonMenu = new File(tempFile + "/setting/jmenu_commonMenu.xml");

        Document infoDocument_commonMenu = null;
        if (dir_commonMenu.exists()) {
            try {
                infoDocument_commonMenu = new SAXReader().read(dir_commonMenu);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        if (infoDocument_commonMenu == null) {
            infoDocument_commonMenu = ResourcesUtil.getDocument(MENU_COMMONMENU);
        }

        JmenuTree jmenuTree_commonMenu = initJmenuMap(infoDocument_commonMenu);

        menuHashMap.put(jmenuTree_commonMenu.getName(), jmenuTree_commonMenu);
    }

    private HashMap<String, Jmenu> fetchJmenuMap() {
        String version = "commonMenu";
        /*if (version == null || version.equals("")) {
            Document globalDocument = globalManager.load();
            List<Node> nodeList = globalDocument.selectNodes("/global");
            version = nodeList.get(0).selectSingleNode("@version").getText();
        }
*/

        return menuHashMap.get(version).getJmenuHashMap();
    }

    /**
     * 将菜单对应的xml文件转为Jmenu对象 并存入jmenuMap
     */
    private static JmenuTree initJmenuMap(Document infoDocument) {
        JmenuTree jmenuTree = new JmenuTree();
        if (infoDocument != null) {

            List<Node> menuNodeList = infoDocument.selectNodes("jmenuTree");
            String name = menuNodeList.get(0).selectSingleNode("@name").getText();

            HashMap<String, Jmenu> jmenuMap = new HashMap<>();
            List<Node> jmenuNodeList = infoDocument.selectNodes("jmenuTree/jmenu");
            for (Node jMenuXmlNode : jmenuNodeList) {
                Jmenu jmenu = new Jmenu();
                jmenu.setChildren(new ArrayList<Jnode>());
                String id = jMenuXmlNode.selectSingleNode("@id").getText();
                jmenu.setId(id);
                List<Node> firstLayerList = jMenuXmlNode.selectNodes("jnode");
                for (Node firstLayerXmlNode : firstLayerList) {
                    Jnode firstLayerJnode = JmenuManagerImpl.parseXmlNodeToJavaBean(firstLayerXmlNode);
                    firstLayerJnode.setChildren(new ArrayList<Jnode>());
                    List<Node> secondLayerList = firstLayerXmlNode.selectNodes("jnode");
                    for (Node secondLayerXmlNode : secondLayerList) {
                        Jnode secondLayerJnode = JmenuManagerImpl.parseXmlNodeToJavaBean(secondLayerXmlNode);
                        firstLayerJnode.getChildren().add(secondLayerJnode);
                    }
                    jmenu.getChildren().add(firstLayerJnode);
                }
                jmenuMap.put(jmenu.getId(), jmenu);
            }

            jmenuTree.setName(name);
            jmenuTree.setJmenuHashMap(jmenuMap);
        }

        return jmenuTree;
    }

    /**
     * 将xml中的Node节点转为Jnode对象
     *
     * @param xmlNode
     * @return
     */
    private static Jnode parseXmlNodeToJavaBean(Node xmlNode) {
        String url = xmlNode.selectSingleNode("@url").getText();
        String text_zh_CN = xmlNode.selectSingleNode("@text_zh_CN").getText();
        String state = "open";
        if (xmlNode.selectSingleNode("@state") != null) {
            state = xmlNode.selectSingleNode("@state").getText();
        }
        String access = xmlNode.selectSingleNode("@access").getText();

        Jnode jnode = new Jnode();
        jnode.setId(jmenuId++ + "");
        jnode.setText_zh_CN(text_zh_CN);
        jnode.setUrl(url);
        jnode.setState(state);
        jnode.setAccess(access);
        return jnode;
    }

    /**
     * 取得Jmenu对应的Json格式，String类型的字符串
     *~
     * @param jmenuName
     * @param type      菜单类型
     * @return
     */
    public String getJmenuJson(String jmenuName, Integer type) {
        Jmenu jmenu = fetchJmenuMap().get(jmenuName);
        StringBuilder jMenuJson = new StringBuilder(500);
        if (jmenu.getChildren() != null && jmenu.getChildren().size() > 0) {
            jMenuJson.append("[");
            for (Jnode jnode : jmenu.getChildren()) {
                jMenuJson.append(this.getJnodeJson(jnode, type));
            }
            jMenuJson.deleteCharAt(jMenuJson.length() - 1);
            jMenuJson.append("]");
        }
        return jMenuJson.toString();
    }

    /**
     * 获得Jnode对应的Json格式，StringBuilder类型的字符串
     *
     * @param jnode
     * @param type  菜单类型
     * @return
     */
    private StringBuilder getJnodeJson(Jnode jnode, Integer type) {
        StringBuilder jNodeJson = new StringBuilder(50);
        String roleType="ALL";

        Boolean access;

   /*     if(type != null && type == PConst.JMENU_TYPE_HEAD){      //头菜单
            access = doHeadRoleFilter(jnode,role);
        }else{
            access = doRoleFilter(jnode,role);
        }*/

//        if (!doRoleFilter(jnode, roleType)) return jNodeJson;

//        access = doLisenceFilter(jnode,role);
//
//        if (!access) return jNodeJson;

/*        Map<String, String> settingMap = AuthorizationUtil.getMyUser().getSettingMap();
        access = doSettingFilter(jnode, settingMap);

        if (!access) return jNodeJson;*/

        String text = jnode.getText_zh_CN();
//        String locale = AuthorizationUtil.getBigUser().getLocale().toString();
        String locale = "zh_CN";
        if (locale.startsWith("en")) {
            text = jnode.getText_en_US();
        }
        jNodeJson.append('{');
        jNodeJson.append("\"id\":\"" + jnode.getId()).append("\",")
                .append("\"text\":\"" + text).append("\",")
                .append("\"state\":\"" + jnode.getState()).append("\",")
                //easyUI默认属性无URL 需要添加在拓展属性 attributes中（注意拓展属性之间用逗号隔开，最后一个属性后面不加逗号）
                .append("\"attributes\":{")
                .append("\"url\":\"" + jnode.getUrl()).append("\"")
                .append("},");
        StringBuilder childrenBuilder = new StringBuilder(100);
        if (jnode.getChildren() != null && jnode.getChildren().size() > 0) {
            jNodeJson.append("\"children\":[");
            for (Jnode childJnode : jnode.getChildren()) {
                childrenBuilder.append(this.getJnodeJson(childJnode, type));
            }
            if (childrenBuilder.toString().endsWith(",")) {
                childrenBuilder.deleteCharAt(childrenBuilder.length() - 1);
            }
            jNodeJson.append(childrenBuilder);
            jNodeJson.append("]").append(",");
        }
        jNodeJson.deleteCharAt(jNodeJson.length() - 1);
        jNodeJson.append("}").append(",");
        if (jnode.getUrl().equals("") && (childrenBuilder.length() == 0)) {
            jNodeJson = new StringBuilder("");
        }
        return jNodeJson;
    }

    /**
     * 根据用户角色判断(左侧菜单),每个菜单项必须配置access属性
     *
     * @param jnode
     * @return
     */
    private boolean doRoleFilter(Jnode jnode, String role) {

        /*当不满足条件的时候隐藏*/
        String access = jnode.getAccess();
        if (access != null && !access.contains(role)) {
            return false;
        } else return true;
    }

    /**
     * 根据用户角色判断 (头菜单)
     *
     * @param jnode
     * @return
     *//*
    private boolean doHeadRoleFilter(Jnode jnode, Role role) {

        if(jnode.getAccess().equals("")){
            return true;
        }
        if(role.getSuperPermission().intValue() == OrganizationConst.ROLE_SUPER_PERMISSION_TRUE){
            return true;
        }else{
            HashMap<String, Permission> permissionHashMap = role.getPermissionMap();
            String[] accessArray = jnode.getAccess().split(";");
            for(int i=0;i<accessArray.length;i++){
                String[] accessPartArray = accessArray[i].split(":");
                if(accessPartArray.length == 1){
                    if(permissionHashMap.containsKey(accessPartArray[0])){
                        return true;
                    }
                }else{
                    Permission permission = permissionHashMap.get(accessPartArray[0]);
                    if (permission != null) {
                        for(String p:accessPartArray[1].split(",")){
                            if(permission.getBasic() != null){
                                for(String b:permission.getBasic().split(",")){
                                    if(b.equals(p)){
                                        return true;
                                    }
                                }
                            }
                            if(permission.getOthers() != null){
                                for(String o:permission.getOthers().split(",")){
                                    if(o.equals(p)){
                                        return true;
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        return false;
    }*/

    /**
     * 根据机构类型判断
     *
     * @param jnode
     * @return
     *//*
    private boolean doBranchFilter(Jnode jnode) {
        User myUser = AuthorizationUtil.getBigUser();
        String branch  = jnode.getBranch();
        if(!branch.equals("")&&branch.indexOf(myUser.getBranch().getThetype().toString())==-1) {
            return false;
        }
        return true;
    }


    /**
     * 根据系统管理参数配置（setting）判断
     * @param jnode      jnode.setting 键与值用冒号隔开，多个键用分号隔开    例：key1:value1;key2:value2
     * @return
     */
    private boolean doSettingFilter(Jnode jnode, Map<String, String> settingMap) {

        String jnodeSetting = jnode.getSetting();
        if (jnodeSetting.equals("")) {
            return true;
        }

        for (String settting : jnodeSetting.split(";")) {
            if (settting.split(":").length < 2) {
                System.out.print(jnode.getText_zh_CN() + "setting设置异常/n");
            }
            String name = settting.split(":")[0];
            String value = settting.split(":")[1];

            if (value.startsWith("*")) {  //星号开头的值 配置了反而不显示
                if (settingMap.containsKey(name) && settingMap.get(name).equals(value.substring(1, value.length()))) {
                    return false;
                } else {
                    return true;
                }
            } else {
                if (settingMap.containsKey(name) && settingMap.get(name).equals(value)) {
                    return true;
                } else {
                    return false;
                }
            }

        }
        return false;
    }

//    private boolean doLisenceFilter(Jnode jnode,Role role){
//        String jnodeSetting = jnode.getSetting();
//        if(jnodeSetting.equals("") || role.getLisenceSet().contains(jnodeSetting)){
//            return true;
//        }else{
//            return false;
//        }
//    }

}
