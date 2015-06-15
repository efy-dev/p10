/*
package com.ming800.core.util;

import net.sourceforge.pinyin4j.PinyinHelper;
import net.sourceforge.pinyin4j.format.HanyuPinyinCaseType;
import net.sourceforge.pinyin4j.format.HanyuPinyinOutputFormat;
import net.sourceforge.pinyin4j.format.HanyuPinyinToneType;
import net.sourceforge.pinyin4j.format.exception.BadHanyuPinyinOutputFormatCombination;

*/
/**
 * Created with IntelliJ IDEA.
 * User: ming
 * Date: 13-1-10
 * Time: 下午3:30
 * To change this template use File | Settings | File Templates.
 *//*

public class PinYinUtil {

    */
/**
     * 进行拼音处理
     *
     * @param str 要处理的字符串
     * @return
     *//*

    public static String parsePinYin(String str) throws BadHanyuPinyinOutputFormatCombination {
        HanyuPinyinOutputFormat defaultFormat = new HanyuPinyinOutputFormat();  //设置转化输出格式
        defaultFormat.setCaseType(HanyuPinyinCaseType.LOWERCASE);     //小写
        defaultFormat.setToneType(HanyuPinyinToneType.WITHOUT_TONE);   //无声调音标如： liu     有音标 liu2, 2为声调
        StringBuilder pinyin = new StringBuilder();
        for (int i = 0; i < str.length(); i++) {
            if (i > 3) {
                break;
            }
            //如果是中文汉字
            if (str.charAt(i) > 128) {
                String[] pinyinArr = PinyinHelper.toHanyuPinyinStringArray(str.charAt(i), defaultFormat);  //把名字的单个字转化为拼音，因为汉字可能有多个读音，所以为数组
                //对于没有拼音的字符直接跳过  例如例如符号 ： （），；等
                if (pinyinArr == null || pinyinArr.length <= 0) {
                    continue;
                }
                //对姓氏进行相关处理
                if (i == 0) {
                    String xingShi = String.valueOf(str.charAt(0));
                    switch (xingShi) {
                        case "重":
                            pinyinArr[0] = "chong";
                            break;
                        case "区":
                            pinyinArr[0] = "ou";
                            break;
                        case "仇":
                            pinyinArr[0] = "qiu";
                            break;
                        case "秘":
                            pinyinArr[0] = "bi";
                            break;
                        case "解":
                            pinyinArr[0] = "xie";
                            break;
                        case "折":
                            pinyinArr[0] = "she";
                            break;
                        case "单":
                            pinyinArr[0] = "shan";
                            break;
                        case "朴":
                            pinyinArr[0] = "piao";
                            break;
                        case "查":
                            pinyinArr[0] = "zha";
                            break;
                        case "曾":
                            pinyinArr[0] = "zeng";
                            break;
                    }
                }
                pinyin.append(pinyinArr[0]);  //忽略多音字，只取数组的第一个拼音的首字符。
            } else {
                pinyin.append(str.charAt(i));
            }
        }
        return pinyin.toString();
    }


}
*/
