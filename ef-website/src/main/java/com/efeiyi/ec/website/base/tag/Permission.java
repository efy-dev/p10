package com.efeiyi.ec.website.base.tag;

import com.efeiyi.ec.website.base.util.AuthorizationUtil;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.BodyTagSupport;
import javax.servlet.jsp.tagext.TagSupport;
import java.io.IOException;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 12-12-1
 * Time: 下午2:10
 * To change this template use File | Settings | File Templates.
 */

public class Permission extends BodyTagSupport {
    private String styleType;    //权限标签的类型   normal,view,edit,add,delete,back
    private String userId;  //当前记录负责人的用户ID
    private String permission;  //所需权限  多个权限之间用逗号隔开

    public String getStyleType() {
        return styleType;
    }

    public void setStyleType(String styleType) {
        this.styleType = styleType;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getPermission() {
        return permission;
    }

    public void setPermission(String permission) {
        this.permission = permission;
    }

    @Override
    public int doStartTag() throws JspException {
        if (processSuper() || (processPermission() && processUser())) {
            return EVAL_BODY_BUFFERED;
        } else {
            return TagSupport.SKIP_BODY;
        }
    }

    @Override
    public int doAfterBody() {
        StringBuilder bodyString = new StringBuilder(bodyContent.getString());
        if (bodyString.indexOf("href") != -1) {
            bodyString.insert(bodyString.indexOf("href") - 1, getStyleClass() + " ");
        }
        try {
            bodyContent.getEnclosingWriter().write(bodyString.toString());
        } catch (IOException e) {
            e.printStackTrace();
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

    private Boolean processSuper() {
        return true;//AuthorizationUtil.getMyUser().getRole().getBasicType().equals("admin");
    }


    private Boolean processPermission() {
       /* Set<String> permissionSet = AuthorizationUtil.getMyUser().getPermissionSet();
        for (String s : permission.split(",")) {
            if (permissionSet.contains(s)) {
                return true;
            }
        }
        return false;*/
        return true;
    }

    private Boolean processUser() {
        if (userId == null || userId.equals(AuthorizationUtil.getMyUser().getId())) {
            return true;
        } else {
            return false;
        }
    }
}
