package com.ming800.core.does.model;

import com.ming800.core.base.util.XDoUtil;
import com.ming800.core.does.service.DoManager;
import com.ming800.core.taglib.PageEntity;
import com.ming800.core.util.ApplicationContextUtil;

import javax.servlet.http.HttpServletRequest;
import java.util.LinkedHashMap;


/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-2-5
 * Time: 下午5:02
 * To change this template use File | Settings | File Templates.
 * XQuery负责存储所有有关查询的数据
 */
public class XQuery {

    private Boolean flag;
    private String headHql; //查询语句的头部 例如：select s from
    private String queryHql; //查询条件部分 例如 where之后 order by之前的
    private String sortHql; //查询语句的 排序部分 例如  order by s.createDatetime;
    private String hql;  //全部的查询语句
    private LinkedHashMap<String, Object> queryParamMap; //查询参数
    private PageEntity pageEntity;//分页信息

    private DoManager doManager = (DoManager) ApplicationContextUtil.getApplicationContext().getBean("doManagerImpl");


    //初始化查询对象
    public XQuery(String doQueryName, HttpServletRequest request) throws Exception {
        Do tempDo = null;
        tempDo = doManager.getDoByQueryModel(doQueryName.split("_")[0]);
        //判断是否是分页查询
        if (doQueryName.startsWith("plist")) {
            this.setPageEntity(XDoUtil.getPageEntity(request));
        }

        DoQuery tempDoQuery = tempDo.getDoQueryByName(doQueryName.split("_")[1]);
        XQuery xQuery = XDoUtil.generateQueryString(tempDo.getXentity().getModel(), tempDoQuery, request.getParameter("conditions"));

        //判断是否有排序参数
        if (request.getParameter("sort") != null) {
            this.setSortHql(XDoUtil.fetchOrderStr(tempDoQuery, request.getParameter("sort")));
        }

        //补全查询语句
        xQuery.setHql(xQuery.getHql() + getSortHql());
        //初始化
        this.setFlag(xQuery.getFlag());
        this.setQueryHql(xQuery.getQueryHql());
        this.setHeadHql(xQuery.getHeadHql());
        this.setHql(xQuery.getHql());
        this.setQueryParamMap(xQuery.getQueryParamMap());
    }

//
//    public XQuery(Do tempDo , DoQuery tempDoQuery , String tempConditions) throws Exception {
//        //判断是否是分页查询
//        if (tempDoQuery.getName().startsWith("plist")) {
//            this.setPageEntity(XDoUtil.getPageEntity(request));
//        }
//
//        DoQuery tempDoQuery = tempDo.getDoQueryByName(doQueryName.split("_")[1]);
//        XQuery xQuery = XDoUtil.generateQueryString(tempDo.getXentity().getModel(), tempDoQuery, request.getParameter("conditions"));
//
//        //判断是否有排序参数
//        if (request.getParameter("sort") != null) {
//            this.setSortHql(XDoUtil.fetchOrderStr(tempDoQuery, request.getParameter("sort")));
//        }
//
//        //补全查询语句
//        xQuery.setHql(xQuery.getHql() + getSortHql());
//        //初始化
//        this.setFlag(xQuery.getFlag());
//        this.setQueryHql(xQuery.getQueryHql());
//        this.setHeadHql(xQuery.getHeadHql());
//        this.setHql(xQuery.getHql());
//        this.setQueryParamMap(xQuery.getQueryParamMap());
//    }

    public XQuery() {
    }


    public Boolean getFlag() {
        return flag;
    }

    public void setFlag(Boolean flag) {
        this.flag = flag;
    }

    public String getHql() {
        return hql;
    }

    public void setHql(String hql) {
        this.hql = hql;
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


    public String getHeadHql() {
        return headHql;
    }

    public void setHeadHql(String headHql) {
        this.headHql = headHql;
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

    public void updateHql() {
        hql = headHql + queryHql + sortHql;
    }

    //更新查询参数
    public void updateQueryParam(String key,Object value){
        if (queryParamMap.get(key)!=null){
            queryParamMap.put(key,value);
        }else {
            throw new RuntimeException("参数不存在!");
        }
    }

    //添加查询参数
    public void addQueryParam(String key,Object value){
        if (queryParamMap.get(key)==null){
            queryParamMap.put(key,value);
        }else {
            throw new RuntimeException("参数已经存在!");
        }
    }

}
