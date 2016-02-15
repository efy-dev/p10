package com.efeiyi.ec.website.base.tag;

import com.efeiyi.ec.organization.model.Permission;
import com.efeiyi.ec.website.base.util.AuthorizationUtil;
import com.ming800.core.does.model.Do;
import com.ming800.core.does.service.DoManager;
import com.ming800.core.util.ApplicationContextUtil;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.BodyTagSupport;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 12-12-1
 * Time: 下午2:10
 * To change this template use File | Settings | File Templates.
 */

public class Access extends BodyTagSupport {
    private DoManager doManager = (DoManager) ApplicationContextUtil.getApplicationContext().getBean("doManagerImpl");


    private String name;         //qm  请求的Do名称，以此获取Do，判断当前用户是否有它的权限
    private String entity;       //例student
    private String operations;   //例vm,new,em,dm,
    private String userId;  //当前记录负责人的用户ID
    private String styleType;    //权限标签的类型   normal,view,edit,add,delete,back


    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEntity() {
        return entity;
    }

    public void setEntity(String entity) {
        this.entity = entity;
    }

    public String getOperations() {
        return operations;
    }

    public void setOperations(String operations) {
        this.operations = operations;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getStyleType() {
        return styleType;
    }

    public void setStyleType(String styleType) {
        this.styleType = styleType;
    }


    @Override
    public int doStartTag() throws JspException {
        if (validPermission())
            return EVAL_BODY_INCLUDE;
        else
            return SKIP_BODY;
    }

    private boolean validPermission() {
        //获取当前用户的权限列表
        List<Permission> permissionList = AuthorizationUtil.getMyUser().getRole().getPermissionsList();
        //获取当前的Do操作 对应实体entity和权限
        Do tempDo = null;
        String entity = "";
        String access = "";
        if (name == null) {
            return false;
        } else {
            try {
                tempDo = doManager.getDoByQueryModel(name);//此处Do不可能为空
                entity = tempDo.getXentity().getName();
                access = tempDo.getAccess();
            } catch (Exception e) {
                e.printStackTrace();
                return false;
            }
            boolean match = false;
            boolean result = true;
            if (permissionList != null && permissionList.size() > 0) {
                for (Permission permission : permissionList) {
                    if (permission.getEntityName().equals(entity) && permission.getBasic().contains(access) || permission.getEntityName().equals(entity) && permission.getAll()) {// TODO 此处验证只从basic中取？
                        match = true;
                        break;
                    }
                }
            }
            if (!match) result = false;
            return result;
        }

    }

    /*   @Override
    public int doAfterBody() {
        if (processPermission()) {
            StringBuilder bodyString = new StringBuilder(bodyContent.getString());
            if (bodyString.indexOf("href") != -1) {
                bodyString.insert(bodyString.indexOf("href") - 1, getStyleClass() + " ");
            }
            try {
                bodyContent.getEnclosingWriter().write(bodyString.toString());
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return SKIP_BODY;
    }

     @Override
    public int doEndTag() {
        return TagSupport.EVAL_PAGE;
    }

    private String getStyleClass() {
        String styleClass = "";
        if (styleType != null) {
            switch (styleType) {
                case "normal":
                    break;
                case "view":
                    styleClass = " class=\"easyui-linkbutton\"";
                    break;
                case "add":
                    styleClass = " class=\"easyui-linkbutton\"  data-options=\"iconCls:'icon-add'\"";
                    break;
                case "edit":
                    styleClass = " class=\"easyui-linkbutton\"  data-options=\"iconCls:'icon-edit'\"";
                    break;
                case "delete":
                    styleClass = " class=\"easyui-linkbutton\"  data-options=\"iconCls:'icon-remove'\"";
                    break;
                case "back":
                    styleClass = " class=\"easyui-linkbutton\"  data-options=\"iconCls:'icon-back'\"";
                    break;
                default:
            }
        }
        return styleClass;
    }


    private Boolean processPermission() {

        String roleType = AuthorizationUtil.getMyUser().getRoleType();
        if (!roleType.equals("system") && operations != null && operations.equals("system")) {
            return false;
        }

        return true;
    }*/
}
