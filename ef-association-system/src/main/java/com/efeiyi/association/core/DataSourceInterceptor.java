package com.efeiyi.association.core;

import org.aspectj.lang.JoinPoint;
import org.springframework.stereotype.Component;

/**
 * Created by Administrator on 2015/9/22.
 */
@Component
public class DataSourceInterceptor {

    public void setdataSource(JoinPoint jp) {
        DatabaseContextHolder.setCustomerType("dataSource");
    }

    public void setdataSource1(JoinPoint jp) {
        DatabaseContextHolder.setCustomerType("dataSource1");
    }
}