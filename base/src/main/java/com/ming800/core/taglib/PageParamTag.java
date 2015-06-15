package com.ming800.core.taglib;

import javax.servlet.jsp.tagext.TagSupport;

public class PageParamTag extends TagSupport {

    private static final long serialVersionUID = 1L;

    private String name;
    private String value;

    public int doEndTag() {
        PageTag pageTag = (PageTag) this.getParent();
        if (this.name != null && !this.name.equals("")) {
            StringBuffer paramBuf = new StringBuffer();
            paramBuf.append(pageTag.getParam()).append("&").append(this.name).append("=").append(this.value);
            pageTag.setParam(paramBuf.toString());
        }
        return TagSupport.EVAL_PAGE;
    }

    //

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

}
