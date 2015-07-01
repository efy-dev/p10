package com.ming800.core.does.model;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: ming
 * Date: 12-12-1
 * Time: 下午2:53
 * To change this template use File | Settings | File Templates.
 */
public class DoQuery {


    private String name;
    private String label;
    private String type;
    private String orderBy;
    private String groupBy;
    private String queryHql;
    private String queryExpress;
    private String queryExecute;
    private List<QueryCondition> conditionList;
    private List<Groupby> groupByList;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getLabel() {
        return label;
    }

    public void setLabel(String label) {
        this.label = label;
    }

    public String getOrderBy() {
        return orderBy;
    }

    public void setOrderBy(String orderBy) {
        this.orderBy = orderBy;
    }

    public String getGroupBy() {
        return groupBy;
    }

    public void setGroupBy(String groupBy) {
        this.groupBy = groupBy;
    }

    public String getQueryHql() {
        return queryHql;
    }

    public void setQueryHql(String queryHql) {
        this.queryHql = queryHql;
    }

    public String getQueryExpress() {
        return queryExpress;
    }

    public void setQueryExpress(String queryExpress) {
        this.queryExpress = queryExpress;
    }

    public String getQueryExecute() {
        return queryExecute;
    }

    public void setQueryExecute(String queryExecute) {
        this.queryExecute = queryExecute;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public List<QueryCondition> getConditionList() {
        return conditionList;
    }

    public void setConditionList(List<QueryCondition> conditionList) {
        this.conditionList = conditionList;
    }

    public List<Groupby> getGroupByList() {
        return groupByList;
    }

    public void setGroupByList(List<Groupby> groupByList) {
        this.groupByList = groupByList;
    }
}
