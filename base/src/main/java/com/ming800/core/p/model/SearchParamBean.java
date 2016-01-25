package com.ming800.core.p.model;

import com.google.common.base.Objects;
import com.ming800.core.taglib.PageEntity;

import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2015/11/17.
 */
public class SearchParamBean {
    private String id;
    private String q;
    private String query;
    private String facetFields;
    private String queryFacetJson;
    private String queryFacet;
    private List searchResultList;
    private Map facetFieldsMap;
    private String  facetFieldJson;
    private String resultPage;
    private String sortOrder;
    private String sortField;
    private String fq;
    private String group;
    private Integer pageIndex;
    private Integer pageSize;
    private PageEntity pageEntity;
    private String priceUD;

    public String getPriceUD() {
        return priceUD;
    }

    public void setPriceUD(String priceUD) {
        this.priceUD = priceUD;
    }

    public String getQ() {
        return q;
    }

    public void setQ(String q) {
        this.q = q;
    }

    public String getFacetFields() {
        return facetFields;
    }

    public void setFacetFields(String facetFields) {
        this.facetFields = facetFields;
    }

    public String getQuery() {
        return query;
    }

    public void setQuery(String query) {
        this.query = query;
    }

    public String getQueryFacetJson() {
        return queryFacetJson;
    }

    public void setQueryFacetJson(String queryFacetJson) {
        this.queryFacetJson = queryFacetJson;
    }

    public String getQueryFacet() {
        return queryFacet;
    }

    public void setQueryFacet(String queryFacet) {
        this.queryFacet = queryFacet;
    }

    public List getSearchResultList() {
        return searchResultList;
    }

    public void setSearchResultList(List searchResultList) {
        this.searchResultList = searchResultList;
    }

    public Map getFacetFieldsMap() {
        return facetFieldsMap;
    }

    public void setFacetFieldsMap(Map facetFieldsMap) {
        this.facetFieldsMap = facetFieldsMap;
    }

    public String getFacetFieldJson() {
        return facetFieldJson;
    }

    public void setFacetFieldJson(String facetFieldJson) {
        this.facetFieldJson = facetFieldJson;
    }

    public String getResultPage() {
        return resultPage;
    }

    public void setResultPage(String resultPage) {
        this.resultPage = resultPage;
    }

    public String getSortOrder() {
        return sortOrder;
    }

    public void setSortOrder(String sortOrder) {
        this.sortOrder = sortOrder;
    }

    public String getSortField() {
        return sortField;
    }

    public void setSortField(String sortField) {
        this.sortField = sortField;
    }

    public String getGroup() {
        return group;
    }

    public void setGroup(String group) {
        this.group = group;
    }

    public Integer getPageIndex() {
        return pageIndex;
    }

    public void setPageIndex(Integer pageIndex) {
        this.pageIndex = pageIndex;
    }

    public Integer getPageSize() {
        return pageSize;
    }

    public void setPageSize(Integer pageSize) {
        this.pageSize = pageSize;
    }

    public PageEntity getPageEntity() {
        return pageEntity;
    }

    public void setPageEntity(PageEntity pageEntity) {
        this.pageEntity = pageEntity;
    }

    public String getFq() {
        return fq;
    }

    public void setFq(String fq) {
        this.fq = fq;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        SearchParamBean that = (SearchParamBean) o;
        return Objects.equal(id, that.id);
    }

    @Override
    public int hashCode() {
        return Objects.hashCode(id);
    }
}
