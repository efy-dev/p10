package com.ming800.core.p.dao;

import com.ming800.core.base.dao.BaseDao;
import com.ming800.core.p.model.AutoSerial;

import java.util.LinkedHashMap;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 12-11-24
 * Time: 下午3:51
 * To change this template use File | Settings | File Templates.
 */
public interface AutoSerialDao extends BaseDao<AutoSerial> {
    AutoSerial getAutoSerial(String queryStr, LinkedHashMap<String, Object> queryParamMap);
}
