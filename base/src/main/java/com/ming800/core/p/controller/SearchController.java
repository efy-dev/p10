package com.ming800.core.p.controller;

import com.ming800.core.develop.model.SolrReactor;
import com.ming800.core.p.service.CommonManager;
import com.ming800.core.taglib.PageEntity;
import com.ming800.core.util.JsonUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.net.URLEncoder;
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

    //    @RequestMapping("/search.do")
//    public ModelAndView search(HttpServletRequest request, ModelMap modelMap) throws Exception {
//
//        String query = request.getParameter("q");
//        query = URLEncoder.encode(query, "utf-8");
//
//        PageEntity pageEntity = new PageEntity();
//        String pageIndex = request.getParameter("pageEntity.index");
//        String pageSize = request.getParameter("pageEntity.size");
//        if (pageIndex != null) {
//            pageEntity.setIndex(Integer.parseInt(pageIndex));
//            pageEntity.setSize(Integer.parseInt(pageSize));
//        }
//
//        query = new StringBuilder(query)
//                .append("&start=")
//                .append((pageEntity.getIndex() - 1) * pageEntity.getSize())
//                .append("&rows=")
//                .append(pageEntity.getSize()).toString();
//        SearchClient.searchList.add(query);
//        modelMap.put("q", query);
//
//        synchronized (query) {
//            try {
//                synchronized (SearchClient.searchList) {
//                    SearchClient.searchList.notifyAll();
//                }
//                query.wait();
//            } catch (Exception e) {
//                Thread.currentThread().interrupt();
//                e.printStackTrace();
//            }
//
//        }
//        Map responseMap = (Map) SolrReactor.getInstance().resultMap.remove(query);
//        Map response = (Map) responseMap.get("response");
//        List docsList = (List) response.get("docs");
//        modelMap.put("searchList", docsList);
//
//        Integer num = (Integer) response.get("numFound");
//        pageEntity.setCount(num);
//        modelMap.put("pageEntity", pageEntity);
//
//        Map highLightingMap = (Map) responseMap.get("highlighting");
//
//        for (Object obj : docsList) {
//            Map docMap = (Map) obj;
//            String id = (String) docMap.get("id");
//            Map subHighLightingMap = (Map) highLightingMap.get(id);
//            for (Object subObj : subHighLightingMap.entrySet()) {
//                Map.Entry entry = (Map.Entry) subObj;
//                if (subHighLightingMap.get(entry.getKey()) instanceof List) {
//                    docMap.put(entry.getKey(), ((List) subHighLightingMap.get(entry.getKey())).get(0));
//                    continue;
//                }
//                docMap.put(entry.getKey(), subHighLightingMap.get(entry.getKey()));
//            }
//        }
//        return new ModelAndView("/search");
//    }

    @RequestMapping("/search.do")
    public ModelAndView solrSearch(HttpServletRequest request, ModelMap modelMap) throws Exception {

        //基本查询q
        String q = request.getParameter("q");
        modelMap.put("q", q);
        StringBuilder queryString = new StringBuilder(commonManager.getSearchParam(request.getParameter("group")).getDefaultQ()).append(q);

        //其他查询条件Json
        String queryFacetJson = request.getParameter("queryFacetJson");
        Map queryFacetMap = queryFacetJson != null && !"".equals(queryFacetJson) ? JsonUtil.parseJsonStringToMap(queryFacetJson.replaceAll("'", "\"")) : new HashMap();
        String queryFacet = request.getParameter("queryFacet");
        if(queryFacet != null && !"".equals(queryFacet)) {
            String[] newFacetQuery = queryFacet.split(":");
            queryFacetMap.put(newFacetQuery[0], newFacetQuery[1]);
        }
        //替换掉所有双引号
        modelMap.put("queryFacetJson", JsonUtil.getJsonString(queryFacetMap).replaceAll("\"","'"));

        //完整查询queryString
        if(queryFacet != null && !"".equals(queryFacet)) {
            queryString.append(" AND ").append(queryFacet);
            modelMap.put("queryFacet",queryFacet);
        }
        request.setAttribute("q",queryString);

        //分页
        PageEntity pageEntity = new PageEntity();
        request.setAttribute("pageEntity", pageEntity);
        modelMap.put("pageEntity", pageEntity);

        //给客户端塞查询请求
        SolrReactor.getInstance().postQueue.offer(request);
        synchronized (request) {
            try {
                synchronized (SolrReactor.getInstance().postQueue) {
                    SolrReactor.getInstance().postQueue.notify();
                }
                request.wait();
            } catch (Exception e) {
                Thread.currentThread().interrupt();
                e.printStackTrace();
            }

        }
        Map<String, Object> queryMap = SolrReactor.getInstance().responseMap.remove(request);

        //检索结果
        List searchResultList = (List) queryMap.get("searchResultList");
        modelMap.put("searchResultList", searchResultList);

        //facet分组结果
        Map facetFieldsMap = (Map) queryMap.get("facetFieldsMap");
        String facetFieldJson = request.getParameter("facetFieldJson");
        if (facetFieldsMap == null && facetFieldJson != null && !facetFieldJson.equals("")) {
            //点击单个facet字段查询时需要把之前q查询检索到的facet字段集合存入页面modelMap
            //facetjson字符串的单引号转回双引号不然没法转成map
            facetFieldJson = facetFieldJson.replaceAll("'","\"");
            modelMap.put("facetFieldsMap", JsonUtil.parseJsonStringToMap(facetFieldJson));
        } else if(facetFieldsMap != null){
            modelMap.put("facetFieldsMap", facetFieldsMap);
            facetFieldJson = JsonUtil.getJsonString(facetFieldsMap);
        }else{
            throw new Exception("筛选分类的facetFieldsMap取不到值");
        }

        //facetjson的双引号转成单引号不然没法从页面提交
        modelMap.put("facetFieldJson", facetFieldJson.replaceAll("\"","'"));
        modelMap.put("resultPage", request.getParameter("resultPage"));
        modelMap.put("sortParam", request.getParameter("sortParam"));
        modelMap.put("sortOrder", request.getParameter("sortOrder"));
        modelMap.put("sortField", request.getParameter("sortField"));
        modelMap.put("sortOrder",request.getParameter("sortOrder"));
        modelMap.put("fq",request.getParameter("fq"));
        return new ModelAndView(request.getParameter("resultPage"));
    }

}
