package com.efeiyi.ec.system.master.service;

/**
 * Created by IntelliJ IDEA.
 * User: ming
 * Date: 12-8-6
 * Time: 上午11:02
 * To change this template use File | Settings | File Templates.
 */
public interface MasterWorkManager {

    /**
     *
     * @param sourceId
     * @param sourceSort
     * @param targetId
     * @param targetSort
     */
    void changePictureSort(String sourceId,String sourceSort,String targetId,String targetSort);
}
