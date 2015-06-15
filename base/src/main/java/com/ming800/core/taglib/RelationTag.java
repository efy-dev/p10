package com.ming800.core.taglib;

import com.ming800.core.base.model.Relation;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.base.service.XdoManager;
import com.ming800.core.does.model.Xentity;
import com.ming800.core.does.service.ModuleManager;
import com.ming800.core.util.ApplicationContextUtil;
import com.ming800.core.base.util.ReflectUtil;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;
import java.io.IOException;
import java.util.List;
import java.util.Map;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-7-9
 * Time: 上午11:36
 * To change this template use File | Settings | File Templates.
 */
public class RelationTag extends TagSupport {

    private XdoManager xdoManager = (XdoManager) ApplicationContextUtil.getApplicationContext().getBean("xdoManagerImpl");
    private BaseManager baseManager = (BaseManager) ApplicationContextUtil.getApplicationContext().getBean("baseManagerImpl");
    private ModuleManager moduleManager = (ModuleManager) ApplicationContextUtil.getApplicationContext().getBean("moduleManagerImpl");

    private String type;
    private String entity1;
    private String objectId1;
    private String objectName1;
    private String conditions;
    private String htmlTag;


    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getEntity1() {
        return entity1;
    }

    public void setEntity1(String entity1) {
        this.entity1 = entity1;
    }

    public String getObjectId1() {
        return objectId1;
    }

    public void setObjectId1(String objectId1) {
        this.objectId1 = objectId1;
    }

    public String getObjectName1() {
        return objectName1;
    }

    public void setObjectName1(String objectName1) {
        this.objectName1 = objectName1;
    }

    public String getConditions() {
        return conditions;
    }

    public void setConditions(String conditions) {
        this.conditions = conditions;
    }

    @Override
    public int doStartTag() {
        try {
            this.getHtmlTag();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return SKIP_BODY;   //忽略对body的处理
    }

    @Override
    public int doEndTag() throws JspException {
        JspWriter out = pageContext.getOut();
        try {
            out.println(htmlTag); //页面中显示的内容
        } catch (IOException e) {
            throw new JspException(e);
        }
        return EVAL_PAGE; //继续处理页面内容
    }


    private void getHtmlTag() throws Exception {
        htmlTag = generateHtml();
    }

    private String generateHtml() throws Exception {
        String projectName = ApplicationContextUtil.getApplicationContext().getApplicationName();

        String strTag = "";
        if (type != null && type.equals("relation")) {
            strTag += "<a href=\"" + projectName + "/basic/xm.do?qm=plistSendProcess_default&entity1=" + entity1 + "&entityId1=" + objectId1 + "&entityName1=" + objectName1 + "\">\n" +
                    "新建流程\n" +
                    "</a>";
        } else {
            strTag += "<a href=\"###\" onclick=\"m8uDialog.openDialog('entityName1', 'objectId1', 'relation', saveOrUpdateRelation)\">\n" +
                    "新建关联\n" +
                    "</a>";
        }
        strTag += "<br/>";

        List<Relation> relationList = (List<Relation>) xdoManager.list("plistRelationByObjectId_default", conditions);
        Map<String, Xentity> xentityMap = moduleManager.fetchXentityMap();
        if (relationList != null && relationList.size() > 0) {
            for (Relation relation : relationList) {

                String objectId = "";
                Xentity xentity = null;
                Object object = null;
                if (conditions.contains("objectId:")) {
                    objectId = relation.getObjectId1();
                    xentity = xentityMap.get(relation.getEntity1());
                    object = baseManager.getObject(xentity.getModel(), relation.getObjectId1());
                } else {
                    objectId = relation.getObjectId();
                    xentity = xentityMap.get(relation.getEntity());
                    object = baseManager.getObject(xentity.getModel(), relation.getObjectId());
                }

                /*RelationObject relationObject = new RelationObject();
                relationObject.setXentity(xentity);
                relationObject.setObjectId(objectId);
                relationObject.setObjectName(ReflectUtil.invokeGetterMethod(object, "name").toString());*/

                String qm = "";
                for (String str : xentity.getDoMap().keySet()) {
                    if (str.startsWith("view")) {
                        qm = str;
                        break;
                    }
                }

                strTag += xentity.getLabel();
                strTag += "<a href=\"###\" onclick=\"art.dialog.open('" + projectName + "/basic/xm.do?qm=" + qm + "&id=" + objectId + "', {width:800, height:500})\">";
                strTag += ReflectUtil.invokeGetterMethod(object, "name").toString();
                strTag += "</a>";
                strTag += "<br/>";
            }
        }

        return strTag;
    }

}
