// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   AdjunctTag.java

package com.ming800.core.taglib;

import com.ming800.core.p.PConst;

import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;
import java.io.IOException;
import java.util.Map;

public class Adjunct2Tag extends TagSupport {

    private static final long serialVersionUID = 1L;

    private String name;
    private String storeType;
    private String adjunctFileName;
    private String adjunctUrlName;
    private String adjunctUrl;

    public Adjunct2Tag() {
    }

    public int doEndTag() {
        JspWriter out = pageContext.getOut();
        StringBuffer tagBuf = new StringBuffer();


        Map<String, String> settingMap = AuthorizationUtil.getMyUser().getSettingMap();//getRole().
        String operation = settingMap.get("storeType");
        if (operation != null && !operation.equals("")) {
            storeType = operation;
        } else {
            storeType = PConst.ATTACHMENT_STORETYPE_ALI_CLOUD;
        }


        adjunctFileName = adjunctFileName == null ? "adjunctFile" : adjunctFileName;
        adjunctUrlName = adjunctUrlName == null ? "adjunctUrlName" : adjunctUrlName;
        adjunctUrl = adjunctUrl == null ? "adjunctUrl" : adjunctUrl;

        tagBuf.append("<input type=\"hidden\" name=\"storeType\" value=\"").append(storeType).append("\" />");

        tagBuf.append("  <span id=\"fileSpan\">")
                .append(" <input id=\"addFileButton\" type=\"button\" value=\"添加附件\"/>")
                .append(" <input id=\"addUrlButton\" type=\"button\" value=\"添加外链接\"/>")
                .append(" </span>");
        tagBuf.append(" <script type=\"text/javascript\">\n" +
                "        $(function(){" +
                "                $(\"#addFileButton\").click(function(){\n" +
                "                var file = '<span><br/><a href=\"###\" name=\\\"removeButton\\\" >删除</a> &nbsp;" +
                "<input type=\"file\" id=\"file\" name=\"" + adjunctFileName + "\"/></span>';\n" +
                "                $(\"#fileSpan\").append(file);\n" +
                "\n" +
                "                $(\"a[name='removeButton']\").click(function(){\n" +
                "                    $(this).parent().remove();\n" +
                "                })\n" +
                "            })\n" +
                "            $(\"#addUrlButton\").click(function(){\n" +
                "                var url = '<span><br/><a href=\"###\" name=\\\"removeButton\\\" >删除</a> &nbsp;" +
                "名称：<input type=\"text\" name=\"" + adjunctUrlName + "\" value=\"未命名\"/>" +
                "网址：<input type=\"text\" id=\"url\" name=\"" + adjunctUrl + "\" value=\"http://\" style=\"width:300px;\"/></span>';\n" +
                "                $(\"#fileSpan\").append(url);\n" +
                "\n" +
                "                $(\"a[name='removeButton']\").click(function(){\n" +
                "                    $(this).parent().remove();\n" +
                "                })\n" +
                "            })\n" +
                "        })\n" +
                "    </script>");
        try {
            out.println(tagBuf);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return 6;
    }


    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getStoreType() {
        return storeType;
    }

    public void setStoreType(String storeType) {
        this.storeType = storeType;
    }

    public String getAdjunctFileName() {
        return adjunctFileName;
    }

    public void setAdjunctFileName(String adjunctFileName) {
        this.adjunctFileName = adjunctFileName;
    }

    public String getAdjunctUrlName() {
        return adjunctUrlName;
    }

    public void setAdjunctUrlName(String adjunctUrlName) {
        this.adjunctUrlName = adjunctUrlName;
    }

    public String getAdjunctUrl() {
        return adjunctUrl;
    }

    public void setAdjunctUrl(String adjunctUrl) {
        this.adjunctUrl = adjunctUrl;
    }
}
