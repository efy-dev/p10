package com.ming800.core.does.service;

import com.ming800.core.does.model.Do;

/**
 * Created with IntelliJ IDEA.
 * User: ming
 * Date: 12-11-17
 * Time: 下午4:25
 * To change this template use File | Settings | File Templates.
 */
public interface DoManager {


    Do getDoByQueryModel(String queryModel) throws Exception;

}
