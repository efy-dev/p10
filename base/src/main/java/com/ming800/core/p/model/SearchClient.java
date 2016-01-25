package com.ming800.core.p.model;

import com.ming800.core.p.service.CommonManager;
import com.ming800.core.taglib.PageEntity;
import com.ming800.core.util.ApplicationContextUtil;
import org.apache.http.auth.AuthScope;
import org.apache.http.auth.UsernamePasswordCredentials;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.solr.client.solrj.SolrQuery;
import org.apache.solr.client.solrj.impl.HttpSolrClient;
import org.apache.solr.client.solrj.response.FacetField;
import org.apache.solr.client.solrj.response.QueryResponse;
import org.apache.solr.common.SolrDocumentList;

import java.util.*;

/**
 * Created by Administrator on 2015/11/5.
 */
public class SearchClient implements Runnable {

    public HttpSolrClient solrClient;
    private CommonManager commonManager = (CommonManager) ApplicationContextUtil.getApplicationContext().getBean("commonManager");

    public SearchClient(String group){
        CommonSearch commonSearch = null;
        try {
            commonSearch = commonManager.getSearchParam(group);
        }catch (Exception e){
            System.err.println("solr commonSearch exception!!!!!!!!!!");
        }
        solrClient = new HttpSolrClient(commonSearch.getSolrServerCoreUrl());
        DefaultHttpClient httpClient = (DefaultHttpClient) solrClient.getHttpClient();
          httpClient.getCredentialsProvider().setCredentials(
                      new AuthScope(commonSearch.getSolrServerHost(), Integer.parseInt(commonSearch.getPort())),
              new UsernamePasswordCredentials(commonSearch.getUsername(), commonSearch.getPassword()));
    }

    public void run() {
        while (true) {
            if (SolrReactor.getInstance().postQueue.isEmpty()) {
                synchronized (SolrReactor.getInstance().postQueue) {
                    if (SolrReactor.getInstance().postQueue.isEmpty()) {
                        try {
                            SolrReactor.getInstance().postQueue.wait();
                        } catch (InterruptedException e) {
                            Thread.currentThread().interrupt();
                            e.printStackTrace();
                        }
                    }
                }
            }

            SearchParamBean searchParamBean = SolrReactor.getInstance().postQueue.poll();
            try {
                Map resultMap = postQuery2Solr(searchParamBean);
                SolrReactor.getInstance().responseMap.put(searchParamBean, resultMap);

            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                try {
                    synchronized (searchParamBean) {
                        searchParamBean.notifyAll();
                    }
                }catch (NullPointerException e){
                    //一般是NullPointerException可以忽略
                }catch (Exception e){
                    e.printStackTrace();
                }
            }
        }
    }

    private Map<String, Object> postQuery2Solr(SearchParamBean searchParamBean) throws Exception {

        //完整查询q
        String queryString = searchParamBean.getQuery();
        SolrQuery solrQuery = new SolrQuery(queryString);

        //区间查询
        String fq = searchParamBean.getFq();
        if(fq != null && !"".equals(fq)) {
            solrQuery.setFilterQueries(searchParamBean.getFq());
        }

        CommonSearch commonSearch = commonManager.getSearchParam(searchParamBean.getGroup());
        if (commonSearch != null) {

            //分页
            PageEntity pageEntity = searchParamBean.getPageEntity();
            Integer pageIndex = pageEntity.getIndex();
            Integer pageSize = pageEntity.getSize();
            solrQuery.setStart(pageIndex == null ? 0 : ((pageEntity.getIndex() - 1) * pageEntity.getSize()))
                    .setRows(pageSize == null ? commonSearch.getRows() : pageSize);

            //高亮
            if (commonSearch.isHighLight() && !"*".equals(searchParamBean.getQ().trim())) {
                solrQuery.setHighlight(commonSearch.isHighLight());
                for (String highLightFields : commonSearch.getHighLightFields()) {
                    solrQuery.addHighlightField(highLightFields);
                }
                solrQuery.setHighlightSimplePre(commonSearch.getHighLightSimplePre())
                        .setHighlightSimplePost(commonSearch.getHighLightSimplePost());
            }

            //分配权重
            if (commonSearch.getDefType() != null) {
                solrQuery.set("defType", commonSearch.getDefType())
                        .set("qf", commonSearch.getQf());
            }

            //排序
            String sortField = searchParamBean.getSortField();
            String sortOrder = searchParamBean.getSortOrder();
            if (sortField != null && !sortField.equals("")) {
                solrQuery.setSort(sortField, sortOrder == null || sortOrder.equals("") ? SolrQuery.ORDER.desc : SolrQuery.ORDER.asc);
            }

            //分組
            String[] facetFieldsArray = null;
            String facetFields = searchParamBean.getFacetFields();
            if (facetFields != null && !facetFields.equals("")) {
                facetFieldsArray = facetFields.split(",");
                solrQuery.setFacet(true)
                        .setFacetMissing(false);
                for (String facetField : facetFieldsArray) {
                    solrQuery.addFacetField(facetField)
                    ;
                }
            }

            //检索
            QueryResponse response = solrClient.query(solrQuery);
            Map<String, Object> queryMap = new HashMap<String, Object>();

            //分組結果
            if (facetFields != null && !facetFields.equals("")) {
                Map<String, Map<String, Long>> facetFieldsMap = new HashMap<String, Map<String, Long>>();
                for (String facetField : facetFieldsArray) {
                    FacetField facetResult = response.getFacetField(facetField);
                    if (facetResult != null) {
                        List<FacetField.Count> facetFieldList = facetResult.getValues();
                        //facet分组的facetFieldList不能转换成json,故抽出所需数据name和条数count另存为facetFieldMap2
                        Map<String, Long> facetFieldMap2 = new HashMap<String, Long>(facetFieldList.size());
                        for (FacetField.Count count : facetFieldList) {
                            if (count.getCount() > 0) {
                                facetFieldMap2.put(count.getName(), count.getCount());
                            }
                        }
                        facetFieldsMap.put(facetField, facetFieldMap2);
                    }
                }
                queryMap.put("facetFieldsMap", facetFieldsMap);
            }

            //檢索結果
            SolrDocumentList searchResultList = response.getResults();
            Map<String, Map<String, List<String>>> highLightingMap = response.getHighlighting();
            pageEntity.setCount((int) searchResultList.getNumFound());
            if (searchResultList != null && highLightingMap != null) {
                for (Object obj : searchResultList) {
                    Map docMap = (Map) obj;
                    String id = (String) docMap.get("id");
                    Map subHighLightingMap = (Map) highLightingMap.get(id);
                    for (Object subObj : subHighLightingMap.entrySet()) {
                        Map.Entry entry = (Map.Entry) subObj;
                        if (subHighLightingMap.get(entry.getKey()) instanceof List) {
                            docMap.put(entry.getKey(), ((List) subHighLightingMap.get(entry.getKey())).get(0));
                            continue;
                        }
                        docMap.put(entry.getKey(), subHighLightingMap.get(entry.getKey()));
                    }
                }
            }

            queryMap.put("searchResultList", searchResultList);
            return queryMap;
        }
        throw new Exception("没有找到检索配置group：" + searchParamBean.getGroup());
    }

}
