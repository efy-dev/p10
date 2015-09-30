package com.efeiyi.association.core;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.lookup.AbstractRoutingDataSource;

import javax.annotation.Resource;

/**
 * Created by Administrator on 2015/9/22.
 */
public class DynamicDataSource extends AbstractRoutingDataSource {
    @Autowired
    private DatabaseContextHolder databaseContextHolder;

    @Override
    protected Object determineCurrentLookupKey() {
        return DatabaseContextHolder.getDataSource();
    }

    @Resource
    public void setDataSourceEntry(DatabaseContextHolder databaseContextHolder) {
        this.databaseContextHolder = databaseContextHolder;
    }
}
