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
 */
public class XQuery {

    private Boolean flag;
    private String hql;  //查询语句
    private String sort; //排序条件
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
            this.setSort(request.getParameter("sort"));
        }

        //补全查询语句
        xQuery.setHql(xQuery.getHql() + XDoUtil.fetchOrderStr(tempDoQuery, this.sort));
        //初始化
        this.setFlag(xQuery.getFlag());
        this.setHql(xQuery.getHql());
        this.setQueryParamMap(xQuery.getQueryParamMap());
    }

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

    public String getSort() {
        return sort;
    }

    public void setSort(String sort) {
        this.sort = sort;
    }
}
