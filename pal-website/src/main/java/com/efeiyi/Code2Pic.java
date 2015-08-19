package com.efeiyi;

import com.ming800.core.util.JsonUtil;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpMethod;
import org.apache.commons.httpclient.methods.GetMethod;

import java.util.Map;

/**
 * Created by Administrator on 2015/8/19.
 */
public class Code2Pic {

    public static void main(String []  arg){



    }


    public String getIpAddress(String ip) throws Exception{

        HttpClient httpclient = new HttpClient();
        HttpMethod method = new GetMethod(PalConst.getInstance().baiduApiUrl);
        httpclient.executeMethod(method);
        String json = method.getResponseBodyAsString();
        System.out.println(method.getResponseBodyAsString());
        method.releaseConnection();
        Map<?, ?> ipAddressMap = JsonUtil.parseJsonStringToMap(json);
        String [] addresses = ((String)ipAddressMap.get("address")).split("\\|");
        return (String)ipAddressMap.get("address");
    }
}
