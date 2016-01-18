package com.ming800.core.util;

import javax.servlet.http.HttpServletRequest;
import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Scanner;

/**
 * Created by Administrator on 2015/1/28.
 */
public class HttpUtil {

    /**
     * 通过UserAgent信息来判断当前访问的设备是否是手机
     *
     * @param userAgent
     * @return
     */
    public static boolean isPhone(String userAgent) {

        if (userAgent.contains("Mozilla/") && userAgent.contains("iPhone")) {
            return true;
        } else return userAgent.contains("Android") && userAgent.contains("Linux");
    }

    public static boolean isPhone(HttpServletRequest request) {
        String serverName = request.getServerName();
        String cityName = "\\.".split(serverName)[0];
        String userAgent = request.getHeader("User-Agent");
        if (userAgent.contains("Mozilla/") && userAgent.contains("iPhone")) {
            return true;
        } else if (userAgent.contains("Android") && userAgent.contains("Linux")) {
            return true;
        } else if (cityName.equals("m")) {
            return true;
        } else {
            return false;
        }
    }


    public static boolean isWeixin(HttpServletRequest request) {
        String serverName = request.getServerName();
        String userAgent = request.getHeader("User-Agent");
        if (userAgent.contains("MicroMessenger")) {
            return true;
        } else {
            return false;
        }
    }


    public static String getHttpResponse(String urlStr, String requestStr) throws Exception {
        URL url = new URL(urlStr);
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        //PrintWriter writer =null;
        if (requestStr != null && !requestStr.equals("")) {
            connection.setDoOutput(true);
            OutputStream outputStream = connection.getOutputStream();
            outputStream.write(requestStr.getBytes("UTF-8"));
            outputStream.flush();
            /*writer = new PrintWriter(connection.getOutputStream());
            writer.println(requestStr);
            writer.flush();*/
        }
//        Scanner scanner = new Scanner(connection.getInputStream());
        InputStream inputStream = connection.getInputStream();
        InputStreamReader inputStreamReader = new InputStreamReader(inputStream, "UTF-8");
        BufferedReader in = new BufferedReader(inputStreamReader);

        String jsonUserStr = in.readLine().toString();
//        StringBuilder responseStr = new StringBuilder();
//        while (scanner.hasNextLine()) {
//            responseStr.append(scanner.nextLine());
//        }

        return jsonUserStr;
    }

}
