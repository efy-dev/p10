package com.ming800.core.taglib;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.JspTag;
import javax.servlet.jsp.tagext.TagSupport;
import java.io.IOException;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-3-30
 * Time: 下午3:49
 * To change this template use File | Settings | File Templates.
 */
public class Sum extends TagSupport {
    private String qm;
    private String conditions;
    private String sumField;
    private String label;

    public String getQm() {
        return qm;
    }

    public void setQm(String qm) {
        this.qm = qm;
    }

    public String getConditions() {
        return conditions;
    }

    public void setConditions(String conditions) {
        this.conditions = conditions;
    }

    public String getSumField() {
        return sumField;
    }

    public void setSumField(String sumField) {
        this.sumField = sumField;
    }

    public String getLabel() {
        return label;
    }

    public void setLabel(String label) {
        this.label = label;
    }

    @Override
    public int doStartTag() {
        return SKIP_BODY;   //忽略对body的处理
    }

    @Override
    public int doEndTag() throws JspException {
        JspWriter out = pageContext.getOut();
        try {
            out.println(this.getHtmlTag()); //页面中显示的内容
        } catch (IOException e) {
            throw new JspException(e);
        }
        return EVAL_PAGE; //继续处理页面内容
    }


    private String getHtmlTag() {
        if (label == null || label.equals("")) {
            label = "实收总额";
        }

        StringBuilder stringBuilder = new StringBuilder();
        stringBuilder.append("    <div style=\"text-align: right\">\n" +
                "        <a href=\"###\" onclick=\"getTotalMoney('" + qm + "', ' " + conditions + " ', ' " + sumField + " ', 'sum');\">"
                + label + "</a>\n" +
                "        <span id=\"sum\"></span>\n" +
                "    </div>");
        return stringBuilder.toString();
    }
}
