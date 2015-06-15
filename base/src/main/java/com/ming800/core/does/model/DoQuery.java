package com.ming800.core.does.model;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: ming
 * Date: 12-12-1
 * Time: 下午2:46
 * To change this template use File | Settings | File Templates.
 */
public interface DoQuery {

    String getName();

    void setName(String name);

    String getLabel();

    void setLabel(String label);

    String getType();

    void setType(String type);

    String getOrderBy();

    void setOrderBy(String orderBy);

    String getGroupBy();

    void setGroupBy(String groupBy);

     String getQueryHql();

     void setQueryHql(String queryHql);

     String getQueryExpress();

     void setQueryExpress(String queryExpress);

     String getQueryExecute();

     void setQueryExecute(String queryExecute);

     List<QueryCondition> getConditionList();

     void setConditionList(List<QueryCondition> conditionList);

     List<Groupby> getGroupByList();

     void setGroupByList(List<Groupby> groupByList);

}
