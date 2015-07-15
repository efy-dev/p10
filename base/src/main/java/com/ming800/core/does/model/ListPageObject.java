package com.ming800.core.does.model;

/**
 * Created with IntelliJ IDEA.
 * User: ming
 * Date: 12-11-14
 * Time: 上午9:47
 * To change this template use File | Settings | File Templates.
 */
public class ListPageObject {

    private Do tempDo;
    private DoQuery tempDoQuery;

    private String result;
    private String tabTitle;
    private PageInfo pageInfo;


    public Do getTempDo() {
        return tempDo;
    }

    public void setTempDo(Do tempDo) {
        this.tempDo = tempDo;
    }

    public DoQuery getTempDoQuery() {
        return tempDoQuery;
    }

    public void setTempDoQuery(DoQuery tempDoQuery) {
        this.tempDoQuery = tempDoQuery;
    }

    public String getResult() {
        return result;
    }

    public void setResult(String result) {
        this.result = result;
    }

    public String getTabTitle() {
        return tabTitle;
    }

    public void setTabTitle(String tabTitle) {
        this.tabTitle = tabTitle;
    }

    public PageInfo getPageInfo() {
        return pageInfo;
    }

    public void setPageInfo(PageInfo pageInfo) {
        this.pageInfo = pageInfo;
    }
}
