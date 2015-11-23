package com.ming800.core.p.model;


import com.ming800.core.p.service.CommonManager;
import com.ming800.core.util.ApplicationContextUtil;

import java.util.*;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentLinkedQueue;

/**
 * Created by Administrator on 2015/11/16.
 */
public class SolrReactor {
    public final Queue<SearchParamBean> postQueue = new ConcurrentLinkedQueue<SearchParamBean>();
    public final Map<SearchParamBean, Map<String, Object>> responseMap = new ConcurrentHashMap<>(64);
    private static SolrReactor solrReactor;
    private CommonManager commonManager = (CommonManager) ApplicationContextUtil.getApplicationContext().getBean("commonManager") ;

    private SolrReactor() {
        super();
        init();
    }

    private void init() {
        try {
            int count = Integer.parseInt(commonManager.getSearchParam("efeiyi").getSolrClientCount());
            for (int x = 0; x < count; x++) {
                new Thread(new SearchClient(commonManager.getSearchParam("efeiyi").getSolrServerCoreUrl())).start();
            }
        }catch (Exception e){
            System.err.println("solrReactor����ʧ����!!!!!!");
            e.printStackTrace();
        }

    }

    public static SolrReactor getInstance() {
        if (solrReactor == null) {
            synchronized (SolrReactor.class) {
                if (solrReactor == null) {
                    solrReactor = new SolrReactor();
                }
            }
            try {
                //�����ͻ����״�����ʱ������������֮ǰpoll����request�����������ɺ��룬��֤�����ͻ��˶����ߺ���offer����request
                Thread.sleep(1000);
            }catch (Exception e){
                e.printStackTrace();
            }
        }

        return solrReactor;
    }

}
