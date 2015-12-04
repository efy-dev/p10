package com.ming800.core.p.controller;

import com.ming800.core.p.model.SearchParamBean;
import com.ming800.core.p.model.SolrReactor;
import com.ming800.core.p.service.CommonManager;
import com.ming800.core.taglib.PageEntity;
import com.ming800.core.util.JsonUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2015/11/5.
 */
@Controller
public class SearchController {

    @Autowired
    private CommonManager commonManager;


    @RequestMapping({"/search.do", "/AjaxSearch.do", "/filterSearch.do"})
    public ModelAndView solrSearch(ModelMap modelMap,SearchParamBean searchParamBean) throws Exception {

        if (searchParamBean.getQ() == null || "".equals(searchParamBean.getQ().trim())){
            searchParamBean.setQ("*");
        }
        //基本查询q
        String q = searchParamBean.getQ();
        StringBuilder queryString = new StringBuilder(commonManager.getSearchParam(searchParamBean.getGroup()).getDefaultQ()).append(q);

        //其他查询条件Json
        String queryFacetJson = searchParamBean.getQueryFacetJson();
        Map queryFacetMap = queryFacetJson != null && !"".equals(queryFacetJson) ? JsonUtil.parseJsonStringToMap(queryFacetJson.replaceAll("'", "\"")) : new HashMap();
        String queryFacet = searchParamBean.getQueryFacet();
        if(queryFacet != null && !"".equals(queryFacet)) {
            String[] newFacetQuery = queryFacet.split(":");
            queryFacetMap.put(newFacetQuery[0], newFacetQuery[1]);
        }
        //替换掉所有双引号
        searchParamBean.setQueryFacetJson(JsonUtil.getJsonString(queryFacetMap).replaceAll("\"","'"));

        //完整查询queryString
        if(queryFacet != null && !"".equals(queryFacet)) {
            queryString.append(" AND ").append(queryFacet);
            searchParamBean.setQueryFacet(queryFacet);
        }
        searchParamBean.setQuery(queryString.toString());

        //分页
        if(searchParamBean.getPageEntity() == null){
            PageEntity pageEntity = new PageEntity();
            pageEntity.setSize(commonManager.getSearchParam(searchParamBean.getGroup()).getRows());
            searchParamBean.setPageEntity(pageEntity);
        }

        //给客户端塞查询请求
        SolrReactor.getInstance().postQueue.offer(searchParamBean);
        synchronized (searchParamBean) {
            try {
                synchronized (SolrReactor.getInstance().postQueue) {
                    SolrReactor.getInstance().postQueue.notify();
                }
                searchParamBean.wait();
            } catch (Exception e) {
                Thread.currentThread().interrupt();
                e.printStackTrace();
            }

        }
        Map<String, Object> queryMap = SolrReactor.getInstance().responseMap.remove(searchParamBean);

        //检索结果
        List searchResultList = (List) queryMap.get("searchResultList");
        searchParamBean.setSearchResultList(searchResultList);

        //facet分组结果
        Map facetFieldsMap = (Map) queryMap.get("facetFieldsMap");
        String facetFieldJson = searchParamBean.getFacetFieldJson();
        if (facetFieldsMap == null && facetFieldJson != null && !facetFieldJson.equals("")) {
            //点击单个facet字段查询时需要把之前q查询检索到的facet字段集合存入页面modelMap
            //facetjson字符串的单引号转回双引号不然没法转成map
            facetFieldJson = facetFieldJson.replaceAll("'","\"");
            searchParamBean.setFacetFieldsMap(JsonUtil.parseJsonStringToMap(facetFieldJson));
        } else if(facetFieldsMap != null){
            searchParamBean.setFacetFieldsMap(facetFieldsMap);
            facetFieldJson = JsonUtil.getJsonString(facetFieldsMap);
        }else{
            throw new Exception("筛选分类的facetFieldsMap取不到值");
        }

        //facetjson的双引号转成单引号不然没法从页面提交
        searchParamBean.setFacetFieldJson(facetFieldJson.replaceAll("\"","'"));
        modelMap.put("searchParamBean",searchParamBean);

        return new ModelAndView(searchParamBean.getResultPage());
    }

}
