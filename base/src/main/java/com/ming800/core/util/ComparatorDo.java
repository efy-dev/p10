package com.ming800.core.util;

import com.ming800.core.does.model.Do;

import java.util.Comparator;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-6-14
 * Time: 上午11:14
 * To change this template use File | Settings | File Templates.
 */
public class ComparatorDo implements Comparator {
    @Override
    public int compare(Object o1, Object o2) {

        Do user0 = (Do) o1;
        Do user1 = (Do) o2;

        //首先比较年龄，如果年龄相同，则比较名字

        return user0.getXentity().getName().compareTo(user1.getXentity().getName());

    }
}
