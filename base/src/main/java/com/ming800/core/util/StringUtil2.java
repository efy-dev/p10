package com.ming800.core.util;

/**
 * Created by Administrator on 2015/7/10.
 */


/**
 * 字符串工具类
 *
 * @author kayson_yang
 *
 */
public class StringUtil2 {
    /**
     * 判断字符串是否为null或者空
     *
     * @param str
     * @return
     */
    public static boolean isEmpty(String str) {
        return str == null || "".equals(str);
    }

    /**
     * 字符串替换

     *
     * @param text
     *            原始字符串

     * @param repl
     *            想被替换的内容

     * @param with
     *            替换后的内容
     * @return
     */
    public static String replace(String text, String repl, String with) {
        if (text == null || repl == null || with == null || repl.length() == 0) {
            return text;
        }

        StringBuffer buf = new StringBuffer(text.length());
        int searchFrom = 0;
        while (true) {
            int foundAt = text.indexOf(repl, searchFrom);
            if (foundAt == -1) {
                break;
            }

            buf.append(text.substring(searchFrom, foundAt)).append(with);
            searchFrom = foundAt + repl.length();
        }
        buf.append(text.substring(searchFrom));

        return buf.toString();
    }

    /**
     * 将为null的对象转换为空字符串
     * */
    public static String getNoNullStr(Object str){
        return str==null?"":str.toString();
    }
}


