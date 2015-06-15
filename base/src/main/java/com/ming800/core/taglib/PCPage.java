package com.ming800.core.taglib;

import com.ming800.core.util.ApplicationContextUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;
import java.io.IOException;

public class PCPage extends TagSupport {

    private static final long serialVersionUID = 1L;

    private String namespace;
    private String action;
    private String url;
    private PageEntity bean;

    private String param;
    private String href;

    private int pageStepStart;
    private int pageStepEnd;
    private int pageCount;

    private int nextPage;
    private int previousPage;
    private int nnextPage;
    private int ppreviousPage;

    public int doStartTag() {
        this.pageCount = this.bean.getpCount();
        /*this.pageStepStart = this.bean.getPageStepStart();
		this.pageStepEnd = this.bean.getPageStepEnd();*/

        if (this.namespace != null) {
            HttpServletRequest request = (HttpServletRequest) this.pageContext.getRequest();
            this.href = request.getContextPath() + (this.namespace.startsWith("/") ? this.namespace : "/" + this.namespace) + (this.action.startsWith("/") ? this.action : "/" + this.action);
            this.href = this.href.split("\\.").length > 1 ? this.href : this.href.replace(".", "") + ".action";
        } else {
            this.href = this.url;
        }
        this.href = ApplicationContextUtil.getApplicationContext().getApplicationName() + this.href;

        StringBuffer paramBuf = new StringBuffer();
        paramBuf.append("&")
                .append(PageEntity.PARAM_NAME_PAGERECORDS)
                .append("=")
                .append(this.bean.getSize());
//				.append("&")
//				.append(PageEntity.PARAM_NAME_PAGESTEP)
//				.append("=");
//				.append(this.bean.getPageStep());
        this.param = paramBuf.toString();

        if (this.pageCount != 0) {
            this.nextPage = this.bean.getNext();
            this.previousPage = this.bean.getPrevious();
//			this.nnextPage = this.bean.getNnextPage();
//			this.ppreviousPage = this.bean.getPpreviousPage();
        } else {
            this.nextPage = 1;
            this.previousPage = 1;
            this.nnextPage = 1;
            this.ppreviousPage = 1;
        }

        return TagSupport.EVAL_BODY_INCLUDE;
    }


    public int doEndTag() {

        StringBuilder nextHref = new StringBuilder();
        nextHref.append(this.href).append("?")
                .append(PageEntity.PARAM_NAME_PAGEINDEX).append("=").append(this.bean.getNext())
                .append(this.param);
        StringBuilder preHref = new StringBuilder();
        preHref.append(this.href).append("?")
                .append(PageEntity.PARAM_NAME_PAGEINDEX).append("=").append(this.bean.getPrevious())
                .append(this.param);

        StringBuffer tagBuffer = new StringBuffer();
        tagBuffer.append("<ul class=\"pager\" style=\"text-align:left;\">");
        if (this.pageCount <= 1) {
            tagBuffer.append("  <li class=\"disabled\"><a href=\"#\">&larr; 上一页</a></li>");
            tagBuffer.append("  <li class=\"disabled\"><a href=\"#\">下一页 &rarr;</a></li>");
        } else {
            if (this.bean.getIndex() > 1) {
                tagBuffer.append("  <li><a href=\"" + preHref + "\">&larr; 上一页</a></li>");
            } else {
                tagBuffer.append("  <li class=\"disabled\"><a href=\"#\">&larr; 上一页</a></li>");
            }

            if (this.bean.getNext() > this.bean.getIndex()) {
                tagBuffer.append("  <li><a href=\"" + nextHref + "\">下一页 &rarr;</a></li>");
            } else {
                tagBuffer.append("  <li class=\"disabled\"><a href=\"#\">下一页 &rarr;</a></li>");
            }
        }

        tagBuffer.append("</ul>");

        JspWriter out = this.pageContext.getOut();
        try {
            out.print(tagBuffer);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return TagSupport.EVAL_PAGE;
    }


    String getPageList() {
        String pageList = "10,20,30,50";
        boolean pageFlag = false;
        for (String page : pageList.split(",")) {
            if (page.equals(this.bean.getSize() + "")) {
                pageFlag = true;
            }
        }
        if (!pageFlag) {
            pageList = this.bean.getSize() + "," + pageList;
        }
        return pageList;
    }

    public String getNamespace() {
        return namespace;
    }

    public void setNamespace(String namespace) {
        this.namespace = namespace;
    }

    public String getAction() {
        return action;
    }

    public void setAction(String action) {
        this.action = action;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public PageEntity getBean() {
        return bean;
    }

    public void setBean(PageEntity bean) {
        this.bean = bean;
    }

    public void setParam(String param) {
        this.param = param;
    }

    public String getParam() {
        return param;
    }

}
