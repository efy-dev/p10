package com.efeiyi.ec.exception;

/**
 * Created by Administrator on 2016/11/2 0002.
 */
public class NonUniqueConsumerException extends Exception {

    public NonUniqueConsumerException(String mark) {
        super("数据异常 : 与 " + mark + " 相关的用户不唯一!");
    }

}
