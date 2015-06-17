package com.ming800.core.util;


import com.fasterxml.jackson.core.JsonFactory;
import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.io.IOException;
import java.io.StringWriter;
import java.util.HashMap;
import java.util.Map;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 12-11-10
 * Time: 上午10:44
 * To change this template use File | Settings | File Templates.
 */
public class JsonUtil {
    /**
     * 把一个对象解析为json格式的字符串
     *
     * @param o
     * @return
     */
    public static String getJsonString(Object o) {
        ObjectMapper om = new ObjectMapper();
        StringWriter sw = new StringWriter();
        try {
            JsonGenerator jg = new JsonFactory().createJsonGenerator(sw);
            om.writeValue(jg, o);
            jg.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return sw.toString();
    }

    /**
     * 把一个json格式的字符串解析为Map
     *
     * @param jsonString
     * @return
     */
    public static Map<?, ?> parseJsonStringToMap(String jsonString) {

        Map<?, ?> map = new HashMap<>();
        ObjectMapper mapper = new ObjectMapper();
        try {
            map = mapper.readValue(jsonString, Map.class);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return map;
    }
}
