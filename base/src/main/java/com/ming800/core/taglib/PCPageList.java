package com.ming800.core.taglib;

import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;
import java.io.IOException;

/**
 * 分页列表（1,2,3...）
 */
public class PCPageList extends TagSupport {

    private static final long serialVersionUID = 1L;
    private static final int DISPLAY_PAGES = 9;//分页栏展示的总页数,
    private static final int CENTER_PAGES = 5;//分页栏中心位置展示的总页数(1...45678[中心5页]...40)

    private String namespace;
    private String action;
    private String url;
    private PageEntity bean;

    private String param;
    private String href;

    private int pageStepStart;
    private int pageStepEnd;
    private int pageCount;//总页数


    public int doStartTag() {
//        StringBuffer paramBuf = new StringBuffer();
//        paramBuf.append(PageEntity.PARAM_NAME_PAGERECORDS)
//                .append("=")
//                .append(this.bean.getSize());//单次查询记录数(步长pageSize)
        this.param = "";
        return TagSupport.EVAL_BODY_INCLUDE;//子标签将查询参数拼接上(qm,conditions)
    }


    public int doEndTag() {
        this.param = this.param.substring(1,this.param.length());
        StringBuffer paramBuf = new StringBuffer();
        paramBuf.append(PageEntity.PARAM_NAME_PAGERECORDS)
                .append("=")
                .append(this.bean.getSize());//单次查询记录数(步长pageSize)

        StringBuilder pageHref = new StringBuilder();
        pageHref.append(this.url).append("?")
                .append(this.param).append("&").append(paramBuf.toString()).append("&").append(PageEntity.PARAM_NAME_PAGEINDEX).append("=");
        pageCount = this.bean.getpCount();//总页数
        String tagStr = pageCount == 0 ? "" : getPagesUrl(this.bean.getIndex(), pageCount, pageHref);
        JspWriter out = this.pageContext.getOut();
        try {
            out.print(tagStr);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return TagSupport.EVAL_PAGE;
    }

    /**
     * 获取分页html代码
     *
     * @param index     当前访问的页码
     * @param pageCount 总页数
     * @param pageHref  每一页的查询请求
     * @return
     */
    private String getPagesUrl(int index, int pageCount, StringBuilder pageHref) {
        StringBuilder content = new StringBuilder();
        content.append("<ul class=\"am-pagination am-pagination-centered pages-new\">");
        //content.append(getPrePage(index, pageHref));
        if (pageCount <= DISPLAY_PAGES) {//总页数小于指定页数，则展示所有分页
            content.append(getDisplayPages(index, 1, pageCount, pageHref));
        } else {

            int distance = (CENTER_PAGES + 1) / 2 + 1;
            if (index - 1 <= distance) {//当前页距离首页近时，这之间不用省略号  呈现样式1234567...10 假设pageCount为10
                content.append(getDisplayPages(index, 1, DISPLAY_PAGES - 2, pageHref));
                content.append("<li><a href=\"#\">").append("...</a></li>");
                content.append("<li><a href=\"").append(pageHref).append(pageCount).append("\">").append(pageCount).append("</a></li>");
            } else if (pageCount - index <= distance) {//当前页尾页近时，这之间不用省略号 呈现样式1...456789 10
                content.append("<li><a href=\"").append(pageHref).append(1).append("\">").append(1).append("</a></li>");
                content.append("<li><a href=\"#\">").append("...</a></li>");
                content.append(getDisplayPages(index, pageCount - (DISPLAY_PAGES - 2) + 1, pageCount, pageHref));
            } else {//呈现样式1...45678...10
                content.append("<li><a href=\"").append(pageHref).append(1).append("\">").append(1).append("</a></li>");
                content.append("<li><a href=\"#\">").append("...</a></li>");
                int beginIndex = index - CENTER_PAGES / 2;
                int endIndex = index + CENTER_PAGES / 2;
                content.append(getDisplayPages(index, beginIndex, endIndex, pageHref));
                content.append("<li><a href=\"#\">").append("...</a></li>");
                content.append("<li><a href=\"").append(pageHref).append(pageCount).append("\">").append(pageCount).append("</a></li>");
            }
        }
        content.append(getNextPage(index, pageCount, pageHref));
        content.append("</ul>");
        return content.toString();
    }

    /**
     * 获取指定页码范围内的html内容
     *
     * @param beginIndex
     * @param endIndex
     * @return
     */
    private StringBuilder getDisplayPages(int index, int beginIndex, int endIndex, StringBuilder pageHref) {
        StringBuilder content = new StringBuilder();
        for (int i = beginIndex; i <= endIndex; ++i) {
            if (i == index) {//当前页 不能重复访问
                content.append("<li class=\"").append("am-active").append("\"><a href=\"#\">").append(i).append("</a></li>");
            } else {
                content.append("<li><a href=\"").append(pageHref).append(i).append("\">").append(i).append("</a></li>");
            }
        }
        return content;
    }

    /**
     * 上一页的url
     *
     * @param index    当前页
     * @param pageHref
     * @return
     */
    private String getPrePage(int index, StringBuilder pageHref) {
        int preIndex = index - 1;
        if (preIndex <= 0) {
            return "<li class=\"am-disabled bigRound\"><a href=\"#\">&laquo;</a></li>";
        } else {
            return new StringBuilder("<li class=\"bigRound\"><a href=\"").append(pageHref).append(preIndex).append("\">&laquo;</a></li>").toString();
        }
    }

    /**
     * 下一页的url
     *
     * @param index     当前页
     * @param pageCount
     * @param pageHref  总页数
     * @return
     */
    private String getNextPage(int index, int pageCount, StringBuilder pageHref) {
        int nextIndex = index + 1;
        if (nextIndex > pageCount) {
            return "<li class=\"am-disabled bigRound\"><a href=\"#\">最后一页</a></li>";
        } else {
            return new StringBuilder("<li class=\"bigRound\"><a href=\"").append(pageHref).append(pageCount).append("\">最后一页</a></li>").toString();
        }
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
