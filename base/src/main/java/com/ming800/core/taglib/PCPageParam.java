package com.ming800.core.taglib;

/**
 * Created by Administrator on 2014/11/24.
 */

import javax.servlet.jsp.tagext.TagSupport;

public class PCPageParam extends TagSupport {

    private static final long serialVersionUID = 1L;

    private String name;
    private String value;

    public int doEndTag() {
        PCPageList pageTag = (PCPageList) this.getParent();
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

