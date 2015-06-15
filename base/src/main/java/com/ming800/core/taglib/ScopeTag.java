// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   ScopeTag.java

package com.ming800.core.taglib;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

public class ScopeTag extends TagSupport {

    private boolean evalOtherAuth;

    public ScopeTag() {
        evalOtherAuth = true;
    }

    public int doStartTag()
            throws JspException {
        return 1;
    }

    public int doEndTag()
            throws JspException {
        evalOtherAuth = true;
        return 6;
    }

    public boolean isEvalOtherAuth() {
        return evalOtherAuth;
    }

    public void setEvalOtherAuth(boolean evalOtherAuth) {
        this.evalOtherAuth = evalOtherAuth;
    }
}
