package com.efeiyi.util;

import com.ming800.core.taglib.PageEntity;
import com.ming800.core.util.JsonUtil;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpMethod;
import org.apache.commons.httpclient.methods.GetMethod;

import java.io.IOException;
import java.net.URLEncoder;
import java.security.spec.ECField;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2015/11/5.
 */
public class SearchClient implements Runnable {

    public static List<String> searchList = new LinkedList<String>();
//    public static Map<String,List> resultMap = new LinkedHashMap<String,List>();
    public static Map resultMap = new LinkedHashMap<>();
    private static HttpClient httpclient = new HttpClient();

    public static PageEntity pageEntity = new PageEntity();
    private int start = 0;//起始数据
    private int rows = 9;//页数据量

    public void run() {
        while (true) {
            if (searchList.isEmpty()) {
                synchronized (searchList) {
                    if (searchList.isEmpty()) {
                        try {
                            searchList.wait();
                        } catch (InterruptedException e) {
                            Thread.currentThread().interrupt();
                            e.printStackTrace();
                        }
                    }
                }
            }

            String query = searchList.remove(0);
            try {
                postQuery2Solr(query);
//                List result = postQuery2Solr(query);
//                resultMap.put(query, result);
                synchronized (query){
                    query.notifyAll();
                }
            }catch (Exception e){
                synchronized (query){
                    query.notifyAll();
                }
                e.printStackTrace();
            }
        }
    }

//    private List postQuery2Solr(String query) throws Exception {
////                HttpClient httpclient = new HttpClient();
////        query = URLEncoder.encode(query,"utf-8");
//        HttpMethod method = new GetMethod(PalConst.getInstance().solrUrl + query);
//        httpclient.executeMethod(method);
//        String json = method.getResponseBodyAsString();
//        System.out.println(method.getResponseBodyAsString());
//        method.releaseConnection();
//        Map<?, ?> map = JsonUtil.parseJsonStringToMap(json);
//        List responseList = (List)((Map)map.get("response")).get("docs");
//        return responseList;
//    }

    private void postQuery2Solr(String query) throws Exception {
        start = getStart();
        rows = getRows();
        String url = PalConst.getInstance().solrUrl + query + "&start=" + start + "&rows=" + rows;
        HttpMethod method = new GetMethod(url);

        httpclient.executeMethod(method);
        String json = method.getResponseBodyAsString();
        System.out.println(method.getResponseBodyAsString());
        method.releaseConnection();
        Map<?, ?> map = JsonUtil.parseJsonStringToMap(json);
        List responseList = (List)((Map)map.get("response")).get("docs");
        pageEntity.setCount((Integer) ((Map) map.get("response")).get("numFound"));
        resultMap.put(query, responseList);
        resultMap.put("pageEntity", pageEntity);
    }

    public static void main (String[]args){

        SearchClient client = new SearchClient();
        try {
            client.postQuery2Solr("%E7%89%9B");
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    private int getStart(){
        return (pageEntity.getIndex()-1)*pageEntity.getSize();
    }

    private int getRows(){
        return pageEntity.getIndex()*pageEntity.getSize() - 1;
    }

}
