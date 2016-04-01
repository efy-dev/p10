package com.efeiyi.ec.system.util;

/**
 * Created by Administrator on 2015/10/30.
 */


import jxl.Workbook;
import jxl.format.Alignment;
import jxl.format.Border;
import jxl.format.BorderLineStyle;
import jxl.format.VerticalAlignment;
import jxl.write.*;
import net.sourceforge.pinyin4j.PinyinHelper;
import net.sourceforge.pinyin4j.format.HanyuPinyinOutputFormat;
import net.sourceforge.pinyin4j.format.HanyuPinyinToneType;
import net.sourceforge.pinyin4j.format.exception.BadHanyuPinyinOutputFormatCombination;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.lang.reflect.Field;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/***
 * @author lsf
 */
public class PinYi {
    private  HanyuPinyinOutputFormat format = null;
    private   String[] pinyin;

    public PinYi(){
        format = new HanyuPinyinOutputFormat();
        format.setToneType(HanyuPinyinToneType.WITHOUT_TONE);

        pinyin = null;
    }

    //转换单个字符

    public String getCharacterPinYin(char c)

    {

        try

        {

            pinyin = PinyinHelper.toHanyuPinyinStringArray(c, format);

        }

        catch(BadHanyuPinyinOutputFormatCombination e)

        {

            e.printStackTrace();

        }



        // 如果c不是汉字，toHanyuPinyinStringArray会返回null

        if(pinyin == null) return null;



        // 只取一个发音，如果是多音字，仅取第一个发音

        return pinyin[0];

    }



    //转换一个字符串

    public String getStringPinYin(String str)

    {

        StringBuilder sb = new StringBuilder();

        String tempPinyin = null;

        for(int i = 0; i < str.length(); ++i)

        {

            tempPinyin =getCharacterPinYin(str.charAt(i));

            if(tempPinyin == null)

            {

                // 如果str.charAt(i)非汉字，则保持原样

                sb.append(str.charAt(i));

            }

            else

            {

                sb.append(tempPinyin);

            }

        }

        return sb.toString();

    }

}