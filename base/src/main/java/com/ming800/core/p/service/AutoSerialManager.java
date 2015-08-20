package com.ming800.core.p.service;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 12-11-24
 * Time: 下午4:13
 * To change this template use File | Settings | File Templates.
 */
public interface AutoSerialManager {
   // String nextAutoSerial(String model);
    String nextSerial(String group)throws Exception;

}
