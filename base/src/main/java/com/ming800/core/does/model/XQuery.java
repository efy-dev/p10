package com.ming800.core.does.model;

import com.ming800.core.base.util.SystemValueUtil;
import com.ming800.core.base.util.XDoUtil;
import com.ming800.core.does.service.DoManager;
import com.ming800.core.taglib.PageEntity;
import com.ming800.core.util.ApplicationContextUtil;
import com.ming800.core.util.DateUtil;
import org.springframework.ui.Model;

import javax.servlet.http.HttpServletRequest;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Set;


/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-2-5
 * Time: 下午5:02
 * To change this template use File | Settings | File Templates.
 * XQuery负责存储所有有关查询的数据
 */
public class XQuery {


    private String hql;  //全部的查询语句
    private String headHql; //查询语句的头部 例如：select s from
    private String sortHql; //查询语句的 排序部分 例如  order by s.createDatetime;
    private String queryHql; //查询条件部分 例如 where之后 order by之前的
    private Boolean flag;
    private PageEntity pageEntity;//分页信息
    private LinkedHashMap<String, Object> queryParamMap; //查询参数
    private List<String> remoteConfig;

    public List<String> getRemoteConfig() {
        return remoteConfig;
    }

    public void setRemoteConfig(List<String> remoteConfig) {
        this.remoteConfig = remoteConfig;
    }

    private DoManager doManager = (DoManager) ApplicationContextUtil.getApplicationContext().getBean("doManagerImpl");


    //初始化查询对象
    public XQuery(String doQueryName, HttpServletRequest request) throws Exception {
        Do tempDo = doManager.getDoByQueryModel(doQueryName.split("_")[0]);
//        getRemoteConfig(tempDo);
        //判断是否是分页查询
        if (doQueryName.startsWith("plist")) {
            this.setPageEntity(XDoUtil.getPageEntity(request));
        }

        DoQuery tempDoQuery = tempDo.getDoQueryByName(doQueryName.split("_")[1]);
        generateQueryString(tempDo.getXentity().getModel(), tempDoQuery, request.getParameter("conditions"), this);

        //判断是否有排序参数
        if (request.getParameter("sort") != null) {
            this.setSortHql(fetchOrderStr(tempDoQuery, request.getParameter("sort")));
        } else if (tempDoQuery.getOrderBy() != null && tempDoQuery.getOrderBy() != "") {
            this.setSortHql(fetchOrderStr(tempDoQuery, tempDoQuery.getOrderBy()));
        }

        //补全查询语句
        if (sortHql != null) {
            this.setHql(this.getHql() + sortHql);
        }
    }


    private void getRemoteConfig(Do tempDo) {

        Xentity xentity = tempDo.getXentity();
        LinkedHashMap<String, Field> fieldMap = xentity.getFieldMap();
        Set<String> keySet = fieldMap.keySet();
        for (String key : keySet) {
            Field field = fieldMap.get(key);
            if (field != null && field.getInputType().equals("remoteObject")) {
                //远程对象调用
                if (remoteConfig == null) {
                    remoteConfig = new ArrayList<>();
                }
                remoteConfig.add(field.getName() + ":" + field.getSource());
            }
        }
    }

    public XQuery(String doQueryName, HttpServletRequest request, Integer psize) throws Exception {
        Do tempDo = doManager.getDoByQueryModel(doQueryName.split("_")[0]);
        getRemoteConfig(tempDo);
        //判断是否是分页查询
        if (doQueryName.startsWith("plist")) {
            this.setPageEntity(XDoUtil.getPageEntity(request, psize));
        }

        DoQuery tempDoQuery = tempDo.getDoQueryByName(doQueryName.split("_")[1]);
        generateQueryString(tempDo.getXentity().getModel(), tempDoQuery, request.getParameter("conditions"), this);

        //判断是否有排序参数
        if (request.getParameter("sort") != null) {
            this.setSortHql(fetchOrderStr(tempDoQuery, request.getParameter("sort")));
        } else if (tempDoQuery.getOrderBy() != null && tempDoQuery.getOrderBy() != "") {
            this.setSortHql(fetchOrderStr(tempDoQuery, tempDoQuery.getOrderBy()));
        }

        //补全查询语句
        if (sortHql != null) {
            this.setHql(this.getHql() + sortHql);
        }
    }

    //只能用于List操作
    public XQuery(String doQueryName, String conditions, String sort, HttpServletRequest request) throws Exception {
        Do tempDo = doManager.getDoByQueryModel(doQueryName.split("_")[0]);
        getRemoteConfig(tempDo);
        //判断是否是分页查询
        if (request != null) {
            this.setPageEntity(XDoUtil.getPageEntity(request));
        }

        DoQuery tempDoQuery = tempDo.getDoQueryByName(doQueryName.split("_")[1]);
        generateQueryString(tempDo.getXentity().getModel(), tempDoQuery, conditions, this);

        //判断是否有排序参数
        if (sort != null && !"".equals(sort)) {
            this.setSortHql(fetchOrderStr(tempDoQuery, sort));
        } else if (tempDoQuery.getOrderBy() != null && tempDoQuery.getOrderBy() != "") {
            this.setSortHql(fetchOrderStr(tempDoQuery, tempDoQuery.getOrderBy()));
        }

        //补全查询语句
        if (sortHql != null) {
            this.setHql(this.getHql() + sortHql);
        }
    }


    public XQuery(Do tempDo, DoQuery tempDoQuery, PageEntity pageEntity, String tempConditions) throws Exception {
//        getRemoteConfig(tempDo);
        //判断是否是分页查询
        if (pageEntity != null) {
            this.setPageEntity(pageEntity);
        }
        generateQueryString(tempDo.getXentity().getModel(), tempDoQuery, tempConditions, this);
        //判断是否有排序参数
        this.setSortHql(fetchOrderStr(tempDoQuery, tempDoQuery.getOrderBy()));

        //补全查询语句
        if (sortHql != null) {
            this.setHql(this.getHql() + sortHql);
        }
    }


    public XQuery() {
    }


    public LinkedHashMap<String, Object> getQueryParamMap() {
        return queryParamMap;
    }

    public void setQueryParamMap(LinkedHashMap<String, Object> queryParamMap) {
        this.queryParamMap = queryParamMap;
    }

    public PageEntity getPageEntity() {
        return pageEntity;
    }

    public void setPageEntity(PageEntity pageEntity) {
        this.pageEntity = pageEntity;
    }

    public Boolean getFlag() {
        return flag;
    }

    public void setFlag(Boolean flag) {
        this.flag = flag;
    }

    public String getQueryHql() {
        return queryHql;
    }

    public void setQueryHql(String queryHql) {
        this.queryHql = queryHql;
    }

    public String getSortHql() {
        return sortHql;
    }

    public void setSortHql(String sortHql) {
        this.sortHql = sortHql;
    }

    public String getHeadHql() {
        return headHql;
    }

    public void setHeadHql(String headHql) {
        this.headHql = headHql;
    }

    public String getHql() {
        return hql;
    }

    public void setHql(String hql) {
        this.hql = hql;
    }

    public void updateHql() {
        hql = headHql + queryHql + sortHql;
    }

    //更新查询参数
    public void put(String key, Object value) {
//        if (queryParamMap.get(key) != null) {
        queryParamMap.put(key, value);
//        } else {
//            throw new RuntimeException("参数不存在!");
//        }
    }


    //添加查询参数
//    public void addQueryParam(String key, Object value) {
//        if (queryParamMap.get(key) == null) {
//            queryParamMap.put(key, value);
//        } else {
//            throw new RuntimeException("参数已经存在!");
//        }
//    }

    //分页专用，将当前的查询条件返回给客户端
    public void addRequestParamToModel(Model model, HttpServletRequest request) {
        model.addAttribute("pageEntity", pageEntity);
        model.addAttribute("conditions", request.getParameter("conditions"));
        model.addAttribute("sort", request.getParameter("sort"));
        //@TODO 将来可能会有更多的查询参数，这里的几个参数是固定的，其他的参数可以在controller中添加就好了
    }


    private void generateQueryString(String queryModel, DoQuery doQuery, String tempConditions, XQuery xQuery) {
        StringBuilder sb = new StringBuilder(100);
        /*拼写 配置文件中的conditon*/
        fetchXQueryByConditions(doQuery.getConditionList(), doQuery, tempConditions, xQuery);
        sb.append(xQuery.getHql());
        StringBuilder queryStringBuilder = new StringBuilder(150);
        /*查询对象 select from */
        String queryHead = fetchQueryHead(queryModel, doQuery);
        queryStringBuilder.append(queryHead);
        /*转换  第一个and  为 where*/
        String queryCondition = sb.toString().replaceFirst("and", "where");
        queryStringBuilder.append(queryCondition);
        xQuery.setHeadHql(queryHead);
        xQuery.setQueryHql(queryCondition);
        xQuery.setHql(queryStringBuilder.toString());
    }


    /*拼写  配置文件中的 condition*/
    public void fetchXQueryByConditions(List<QueryCondition> queryConditionList, DoQuery doQuery, String tempConditions, XQuery xQuery) {

        /*andor 在这里获取，以防后面用到*/
        String queryExpress = "";
        String tempQueryExpress = doQuery.getQueryExpress();
        if (tempQueryExpress != null && !tempQueryExpress.equals("")) {
            queryExpress = doQuery.getQueryExpress();
        }

        StringBuilder queryStr = new StringBuilder(150);
        LinkedHashMap<String, Object> queryParamMap = new LinkedHashMap<>();

        String bigBranch = "";  //大数据

        int t = 0;
        for (QueryCondition queryCondition : queryConditionList) {
            String propertyName = queryCondition.getName();
            String tempOperator = queryCondition.getOperation();
            String operator = "";
            if ((queryCondition.getKey().equals("teachArea") || queryCondition.getKey().equals("singleTeachArea")) && bigBranch != null && bigBranch.equals("true")) {
                tempOperator = "likes";
                operator = "like";
            } else {
                operator = convertOperator(tempOperator);
            }

            Object value = null;

            if (propertyName.equalsIgnoreCase("createDatetime") || propertyName.equalsIgnoreCase("createDateTime")) {
                if (t == 1) {//暂时先考虑只有两个时间的分段查询  第二次查询createDatetime
                    //获得指定的参数的值
                    value = convertPropertyValue(queryCondition, tempConditions, operator, true, true);
                } else {
                    value = convertPropertyValue(queryCondition, tempConditions, operator, true, false);
                    t++;
                    propertyName += "2";
                }
            } else {
                value = convertPropertyValue(queryCondition, tempConditions, operator, false, false);
            }


            StringBuilder tempQueryStr = new StringBuilder(20);
            if (tempQueryExpress == null || tempQueryExpress.equals("")) {
                tempQueryStr.append(" and ");
            }
            if (value != null && !value.equals("") && !value.toString().trim().equals("") && !value.toString().trim().equals("headquarters")) {

                if (tempOperator.equals("likes")) {
                    value = value.toString() + "%";
                } else if (tempOperator.equals("like")) {
                    value = "%" + value.toString() + "%";
                }

                if (value.equals("null")) {
                    value = null;
                }
                String tempPropertyName = propertyName;
                if (propertyName.contains(".")) {
                    tempPropertyName = propertyName.replace(".", "_");
                }

                if (!propertyName.startsWith("t.")) {
                    tempQueryStr.append("s.");
                }

                tempQueryStr.append(getPropertyName(propertyName));
                if (operator.equals("in")) {
                    tempQueryStr.append(" in (:")
                            .append(tempPropertyName)
                            .append(")");
                } else {
                    tempQueryStr.append(" ")
                            .append(operator)
                            .append(" :")
                            .append(tempPropertyName)
                            .append("");

                }
                queryParamMap.put(tempPropertyName, value);


            } else {
                tempQueryStr.append("1=1");
            }

            if (tempQueryExpress != null && !tempQueryExpress.equals("")) {
                queryExpress = queryExpress.replaceFirst(propertyName, tempQueryStr.toString());
            } else {
                queryStr.append(tempQueryStr.toString());
            }
        }

        StringBuilder sb = new StringBuilder();
        if (tempQueryExpress != null && !tempQueryExpress.equals("")) {
            sb.append(queryExpress);
        } else {
            sb.append(queryStr.toString());
        }

        xQuery.setHql(sb.toString());
        xQuery.setQueryParamMap(queryParamMap);
    }


    /*拼写  orderby 语句*/
    private String fetchOrderStr(DoQuery doQuery, String tempConditions) {

        /*页面 传递排序 参数*/
        XQuery orderXQuery = fetchQueryOrder(tempConditions);

        /*拼写  order by*/
        String orders = doQuery.getOrderBy();
        StringBuilder orderConditions = new StringBuilder();
        if (orderXQuery != null && orderXQuery.getFlag()) {
            orderConditions.append(" order by ").append(orderXQuery.getHql());
        } else if (orders != null && !orders.equals("")) {
            orderConditions.append(" order by ");
            for (String str : orders.split(";")) {
                String[] strTemp = str.split(":");
                orderConditions.append(" s.").append(strTemp[0]).append(" ").append(strTemp[1]).append(",");
            }
            orderConditions.deleteCharAt(orderConditions.length() - 1);
        }

        return orderConditions.toString();
    }


    /*页面  点击排序   效果*/
    //支持排序可控制
    private XQuery fetchQueryOrder(String conditions) {
        Boolean flag = false;
        StringBuilder sb = new StringBuilder();

        if (conditions != null && !conditions.equals("")) {
            for (String condition : conditions.split(";")) {
                String[] conditionArray = condition.split(":");
                if (conditionArray[0].equals("asc") || conditionArray[0].equals("desc")) {
                    flag = true;
                    sb.append("s.").append(conditionArray[1]).append(" ").append(conditionArray[0]).append(",");
                }
            }
            if (sb.length() > 1) {
                sb.deleteCharAt(sb.length() - 1);
            }
        }

        XQuery xQuery = new XQuery();
        xQuery.setHql(sb.toString());
        xQuery.setFlag(flag);

        return xQuery;

    }


    /*查询 对象 select from*/
    private String fetchQueryHead(String queryModel, DoQuery doQuery) {

        String tempQueryHql = doQuery.getQueryHql();

        StringBuilder sb = new StringBuilder();
        if (tempQueryHql != null && !tempQueryHql.equals("")) {
            sb.append("select distinct s from ");
        } else {
            sb.append("select s from ");
        }
        sb.append(queryModel);
        sb.append(" s ");
        if (tempQueryHql != null && !tempQueryHql.equals("")) {
            sb.append(doQuery.getQueryHql()).append(" ");
        }
        return sb.toString();
    }


    /**
     * 处理配置文件中   操作符号的问题   大于，小雨。。。
     */
    private String convertOperator(String tempOperator) {
        String operator = tempOperator;

        if (tempOperator.equals("eq")) {
            operator = "=";
        } else if (tempOperator.equals("ne")) {
            operator = "!=";
        } else if (tempOperator.equals("ge")) {
            operator = ">=";
        } else if (tempOperator.equals("le")) {
            operator = "<=";
        } else if (tempOperator.equals("gt")) {
            operator = ">";
        } else if (tempOperator.equals("lt")) {
            operator = "<";
        } else if (tempOperator.equals("likes")) {
            operator = "like";
        }

        return operator;
    }


    /**
     * 处理配置文件中   同一个属性对应  开始时间，结束时间的问题
     */
    private String getPropertyName(String tempPropertyName) {
        String propertyName = tempPropertyName;

        if (propertyName.endsWith("2")) {
            propertyName = propertyName.substring(0, propertyName.length() - 1);
        }

        return propertyName;
    }


    /**
     * 取值
     */
    private Object convertPropertyValue(QueryCondition condition, String tempConditions, String tempOperator, boolean flag1, boolean flag2) {

        Object value = "";
        String propertyValue = condition.getValue();

        if (tempConditions != null && !tempConditions.equals("")) {
            int times = 0;
            for (String str : tempConditions.split(";")) {
                String[] tempStr = str.split(":");
                if (flag1 && flag2) {//判断是找createDatetime 并且是找第二个createDatetime
                    if (condition.getName().equals(tempStr[0].trim()) && (times == 0)) {//判断是第一个createDatetime
                        times++;
                        continue;
                    }
                }
                if (condition.getName().equals(tempStr[0].trim())) {
                    if (tempStr.length < 2) {
                        return null;
                    } else {
                        propertyValue = tempStr[1].trim();
                        if (propertyValue.split(",")[0].trim().equals("")) {//弹窗临时处理
                            return null;
                        }
                        break;
                    }
                }
            }
        }

        String tempValue = SystemValueUtil.getValue(propertyValue, "id").toString();

        if (tempValue.equals("")) {
            return null;
        }
        if (tempOperator.equals("in") || tempOperator.equals("not in")) {
            List<Object> list = new ArrayList<>();
            if (tempValue.contains("_")) {
                if (tempValue.equals("_")) {
                    return null;
                }
                tempValue = tempValue.split("_")[0].trim();
            }
            if (!tempValue.equals("")) {
                for (String tempStr : tempValue.split(",")) {
                    if (condition.getDataType() != null && condition.getDataType().equals("int")) {
                        list.add(Integer.parseInt(tempStr));
                    } else {
                        list.add(tempStr);
                    }
                }
                value = list;
            }

        } else if (condition.getInputType().equals("dialog_do") || condition.getInputType().equals("dialog_pop")) {
            if (tempValue.equals("_")) {
                value = null;
            } else {
                value = tempValue.split("_")[0].trim();
            }

        } else if (condition.getDataType() != null && condition.getDataType().equals("float")) {
            value = Float.parseFloat(tempValue);
        } else if (condition.getDataType() != null && condition.getDataType().equals("int")) {
            value = Integer.parseInt(tempValue);
        } else if (condition.getDataType() != null && condition.getDataType().equals("date")) {
            tempValue = SystemValueUtil.getValue(propertyValue, "name").toString();
            value = DateUtil.parseDate(tempValue);
        } else if (condition.getDataType() != null && condition.getDataType().equals("datetime")) {
            tempValue = SystemValueUtil.getValue(propertyValue, "name").toString();
            if (condition.getOperation().equals("ge")) {
                value = DateUtil.parseDateTime(tempValue + " 00:00:00");
            } else {
                value = DateUtil.parseDateTime(tempValue + " 23:59:59");
            }
        } else if (condition.getDataType() != null && condition.getDataType().equals("boolean")) {
            value = Boolean.valueOf(tempValue);
        } else if (condition.getDataType() != null && condition.getDataType().equals("bigDecimal")) {
            value = new BigDecimal(tempValue);
        } else {
            value = tempValue;
        }

        return value;
    }


}
