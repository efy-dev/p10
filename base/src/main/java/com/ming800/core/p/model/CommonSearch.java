package com.ming800.core.p.model;

import java.io.Serializable;

/**
 * Created by Administrator on 2015/11/16.
 */
public class CommonSearch implements Serializable {
    private Integer rows;//每页显示数
    private String defaultQ;//基本查询字段名,类似:"all_name:"
    private boolean highLight;//是否高亮
    private String [] highLightFields;//高亮字段,多字段使用","分隔
    private String highLightSimplePre;//高亮前缀
    private String highLightSimplePost;//高亮后缀
    private String defType;//权重类型
    private String qf;//权重分配算式
    private String solrClientCount;//启动的SolrClient数
    private String solrServerCoreUrl;//Solr服务端地址

    public Integer getRows() {
        return rows;
    }

    public void setRows(Integer rows) {
        this.rows = rows;
    }

    public String getDefaultQ() {
        return defaultQ;
    }

    public void setDefaultQ(String defaultQ) {
        this.defaultQ = defaultQ;
    }

    public String [] getHighLightFields() {
        return highLightFields;
    }

    public void setHighLightFields(String [] highLightFields) {
        this.highLightFields = highLightFields;
    }

    public String getHighLightSimplePre() {
        return highLightSimplePre;
    }

    public void setHighLightSimplePre(String highLightSimplePre) {
        this.highLightSimplePre = highLightSimplePre;
    }

    public String getHighLightSimplePost() {
        return highLightSimplePost;
    }

    public void setHighLightSimplePost(String highLightSimplePost) {
        this.highLightSimplePost = highLightSimplePost;
    }

    public void setDefType(String defType) {
        this.defType = defType;
    }

    public String getSolrClientCount() {
        return solrClientCount;
    }

    public void setSolrClientCount(String solrClientCount) {
        this.solrClientCount = solrClientCount;
    }

    public boolean isHighLight() {
        return highLight;
    }

    public void setHighLight(boolean highLight) {
        this.highLight = highLight;
    }

    public String getDefType() {
        return defType;
    }

    public String getQf() {
        return qf;
    }

    public void setQf(String qf) {
        this.qf = qf;
    }

    public String getSolrServerCoreUrl() {
        return solrServerCoreUrl;
    }

    public void setSolrServerCoreUrl(String solrServerCoreUrl) {
        this.solrServerCoreUrl = solrServerCoreUrl;
    }
}
