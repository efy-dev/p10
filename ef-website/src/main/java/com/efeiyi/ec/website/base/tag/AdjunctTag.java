// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   AdjunctTag.java

package com.efeiyi.ec.website.base.tag;

import com.efeiyi.ec.website.organization.util.AuthorizationUtil;
import com.ming800.core.p.PConst;

import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;
import java.io.IOException;
import java.util.Map;

public class AdjunctTag extends TagSupport {

    private static final long serialVersionUID = 1L;
    private boolean single;
    private String name;
    private String width;
    private String height;
    private String style;

    public AdjunctTag() {
    }

    public int doEndTag() {
        String storeType = "ali";
        Map<String, String> settingMap = AuthorizationUtil.getMyUser().getSettingMap();//getRole().
        String operation = settingMap.get("storeType");
        if (operation != null && !operation.equals("")) {
            storeType = operation;
        } else {
            storeType = PConst.ATTACHMENT_STORETYPE_ALI_CLOUD;
        }

        JspWriter out = pageContext.getOut();
        StringBuffer tagBuf = new StringBuffer();
        StringBuffer styleBuf = new StringBuffer();
        tagBuf.append("<input type=\"hidden\" name=\"storeType\" value=\"").append(storeType).append("\" />");
        tagBuf.append("<input type=\"file\" name=\"").append(name).append("\"");
        if (width != null && !width.equals("") || height != null && !height.equals("") || style != null && !style.equals("")) {
            tagBuf.append(" style=\"");
            styleBuf.append(" style='");
        }
        if (width != null && !width.equals("")) {
            tagBuf.append("width:").append(width);
            styleBuf.append("width:").append(width);
            if (width.indexOf("%") != -1) {
                tagBuf.append("px");
                styleBuf.append("px");
            }
            tagBuf.append(";");
            styleBuf.append(";");
        }
        if (height != null && !height.equals("")) {
            tagBuf.append("height:").append(height);
            styleBuf.append("height:").append(height);
            if (height.indexOf("%") != -1) {
                tagBuf.append("px");
                styleBuf.append("px");
            }
            tagBuf.append(";");
            styleBuf.append(";");
        }
        if (width != null && !width.equals("") || height != null && !height.equals("") || style != null && !style.equals("")) {
            tagBuf.append("\"");
            styleBuf.append("'");
        }
        tagBuf.append("/>");
        if (!single)
            tagBuf.append("<input type=\"button\" value=\"添加\" onclick=\"addAdjunct(this.parentNode);\"/>");
        tagBuf.append("<script type=\"text/javascript\">").append("function addAdjunct(parentTag){var tagStr=\"<div><input type='file' name='").append(name).append("' ").append(styleBuf).append("/><input type='button' value='删除' onclick='delAdjunct(this.parentNode);'/></div>\";parentTag.insertAdjacentHTML(\"beforeEnd\", tagStr);}").append("function delAdjunct(obj){obj.parentNode.removeChild(obj);}").append("</script>");
        try {
            out.println(tagBuf);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return 6;
    }

    public boolean isSingle() {
        return single;
    }

    public void setSingle(boolean single) {
        this.single = single;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getWidth() {
        return width;
    }

    public void setWidth(String width) {
        this.width = width;
    }

    public String getHeight() {
        return height;
    }

    public void setHeight(String height) {
        this.height = height;
    }

    public String getStyle() {
        return style;
    }

    public void setStyle(String style) {
        this.style = style;
    }
}
