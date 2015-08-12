package com.efeiyi.service;

import com.ming800.core.base.service.BaseManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by Administrator on 2015/8/10.
 */
@Service
public class TestManagerImpl implements TestManager{

    @Autowired
    private BaseManager baseManager;

    @Override
    public Object saveOrUpdateTest(String className , Object object) throws Exception{
        baseManager.saveOrUpdate(className,object);
        return object;
    }

}
