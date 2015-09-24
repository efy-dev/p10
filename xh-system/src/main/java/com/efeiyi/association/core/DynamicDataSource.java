package com.efeiyi.association.core;

import org.springframework.jdbc.datasource.lookup.AbstractRoutingDataSource;

/**
 * Created by Administrator on 2015/9/22.
 */
public class DynamicDataSource extends AbstractRoutingDataSource {
    @Override
    protected Object determineCurrentLookupKey() {
        return DatabaseContextHolder.getCustomerType();
    }
}
