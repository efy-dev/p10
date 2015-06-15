package com.ming800.core.base.model;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-12-11
 * Time: 下午3:21
 * To change this template use File | Settings | File Templates.
 */
public class SpObserver {

    @SuppressWarnings("unchecked")
    private static ThreadLocal<String> local = new ThreadLocal();

    @SuppressWarnings("unchecked")
    public static void putSp(String sp) {
//        System.out.println("set方法");
        local.set(sp);
    }

    public static String getSp() {
//        System.out.println("get方法");
        return local.get();
    }
}
