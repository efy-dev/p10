package com.ming800.core.develop.model;


import com.ming800.core.p.service.CommonManager;
import com.ming800.core.util.ApplicationContextUtil;

import javax.servlet.http.HttpServletRequest;
import java.util.*;
import java.util.concurrent.ConcurrentLinkedQueue;

/**
 * Created by Administrator on 2015/11/16.
 */
public class SolrReactor {
    public final Queue<HttpServletRequest> postQueue = new ConcurrentLinkedQueue<HttpServletRequest>();
//    public final Map<String, Collection> resultMap = new LinkedHashMap<String, Collection>();
    public final Map<HttpServletRequest, Map<String, Object>> responseMap = new LinkedHashMap<>(64);
    private static SolrReactor solrReactor;
    private CommonManager commonManager = (CommonManager) ApplicationContextUtil.getApplicationContext().getBean("commonManager") ;

    private SolrReactor() {
        super();
        init();
    }

    private void init() {
        int count = 0;
        try {
            count = commonManager.getSearchParam("efeiyi").getSolrClientCount();
        }catch (Exception e){
            count = 1;
            e.printStackTrace();
        }finally {
            for (int x = 0; x < count; x++) {
                new Thread(new SearchClient()).start();
            }
        }

    }

    public static SolrReactor getInstance() {
        if (solrReactor == null) {
            synchronized (SolrReactor.class) {
                if (solrReactor == null) {
                    solrReactor = new SolrReactor();
                    try {
                        //检索客户端首次启动时，可能在休眠之前poll检索request，故休眠若干毫秒，保证检索客户端都休眠后，再offer检索request
                        Thread.sleep(100);
                    }catch (Exception e){
                        e.printStackTrace();
                    }
                }
            }
        }

        return solrReactor;
    }

}
