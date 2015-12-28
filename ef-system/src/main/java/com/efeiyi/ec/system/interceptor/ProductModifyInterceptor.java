package com.efeiyi.ec.system.interceptor;

import com.ming800.core.p.model.CommonSearch;
import com.ming800.core.p.service.CommonManager;
import org.apache.http.HttpEntity;
import org.apache.http.auth.AuthScope;
import org.apache.http.auth.UsernamePasswordCredentials;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.DefaultHttpClient;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.InputStreamReader;

/**
 * Created by Administrator on 2015/12/24.
 */
public class ProductModifyInterceptor extends HandlerInterceptorAdapter {

    @Autowired
    @Qualifier("commonManager")
    private CommonManager commonManager;


    /**
    delta-import增量更新检索索引
     */
    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {


        CommonSearch commonSearch = null;
        try {
            commonSearch = commonManager.getSearchParam("efeiyi");
        }catch (Exception e){
            System.err.println("solr commonSearch exception!!!!!!!!!!");
        }
        DefaultHttpClient httpClient = new DefaultHttpClient();
        httpClient.getCredentialsProvider().setCredentials(
                new AuthScope(commonSearch.getSolrServerHost(), Integer.parseInt(commonSearch.getPort())),
                new UsernamePasswordCredentials(commonSearch.getUsername(), commonSearch.getPassword()));
        HttpEntity entity = httpClient.execute(new HttpPost(commonSearch.getSolrServerCoreUrl())).getEntity();
        BufferedReader reader = new BufferedReader(new InputStreamReader(
                entity.getContent(), "UTF-8"));
        StringBuilder result = new StringBuilder();
        String line = "";
        while ((line = reader.readLine()) != null) {
            result.append(line.trim());
        }
        System.out.println(result.toString());
        super.postHandle(request, response, handler, modelAndView);
    }
}
