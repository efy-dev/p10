package com.ming800.core.does.model;

import com.ming800.core.base.util.XDoUtil;
import com.ming800.core.does.service.DoManager;
import com.ming800.core.taglib.PageEntity;
import com.ming800.core.util.ApplicationContextUtil;
import org.springframework.ui.Model;

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

    private String hql;  //全部的查询语句
    private String headHql; //查询语句的头部 例如：select s from
    private String sortHql; //查询语句的 排序部分 例如  order by s.createDatetime;
    private String queryHql; //查询条件部分 例如 where之后 order by之前的
    private Boolean flag;
    private PageEntity pageEntity;//分页信息
    private LinkedHashMap<String, Object> queryParamMap; //查询参数

    private DoManager doManager = (DoManager) ApplicationContextUtil.getApplicationContext().getBean("doManagerImpl");


    //初始化查询对象
    public XQuery(String doQueryName, HttpServletRequest request) throws Exception {
        Do tempDo = doManager.getDoByQueryModel(doQueryName.split("_")[0]);
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
        if (sortHql != null) {
            xQuery.setHql(xQuery.getHql() + sortHql);
        }
        //初始化
        this.setHql(xQuery.getHql());
        this.setFlag(xQuery.getFlag());
        this.setHeadHql(xQuery.getHeadHql());
        this.setQueryHql(xQuery.getQueryHql());
        this.setQueryParamMap(xQuery.getQueryParamMap());
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
    public void updateQueryParam(String key, Object value) {
        if (queryParamMap.get(key) != null) {
            queryParamMap.put(key, value);
        } else {
            throw new RuntimeException("参数不存在!");
        }
    }

    //添加查询参数
    public void addQueryParam(String key, Object value) {
        if (queryParamMap.get(key) == null) {
            queryParamMap.put(key, value);
        } else {
            throw new RuntimeException("参数已经存在!");
        }
    }

    //分页专用，将当前的查询条件返回给客户端
    public void addRequestParamToModel(Model model, HttpServletRequest request) {
        model.addAttribute("pageEntity", pageEntity);
        model.addAttribute("conditions", request.getParameter("conditions"));
        model.addAttribute("sort", request.getParameter("sort"));
        //@TODO 将来可能会有更多的查询参数，这里的几个参数是固定的，其他的参数可以在controller中添加就好了
    }

}
