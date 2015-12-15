package com.efeiyi.ec.system.zero.company.dao;

import java.util.List;
import java.util.Set;

/**
 * Created by Administrator on 2015/9/8.
 *
 */
public interface ModalDao {

    Set<Object> getListLikesName(String name, String type, String status) throws Exception;

    Set<Object> getListLikesProductName(String name, String type, String status) throws Exception;

    List getListProductModel()throws Exception;
}
