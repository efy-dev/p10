package com.ming800.core.util;

import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.concurrent.FutureCallback;
import org.apache.http.impl.nio.client.CloseableHttpAsyncClient;
import org.apache.http.impl.nio.client.HttpAsyncClients;
import sun.net.www.http.HttpClient;

import javax.servlet.http.HttpServletRequest;
import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Scanner;
import java.util.concurrent.Future;

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

        return getHttpResponse(urlStr,requestStr,"UTF-8","UTF-8");
    }

    public static String getHttpResponse(String urlStr, String requestStr, String srcCharset, String destCharset) throws Exception {
        URL url = new URL(urlStr);
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        //PrintWriter writer =null;
        if (requestStr != null && !requestStr.equals("")) {
            connection.setDoOutput(true);
            OutputStream outputStream = connection.getOutputStream();
            outputStream.write(requestStr.getBytes(srcCharset));
            outputStream.flush();
            /*writer = new PrintWriter(connection.getOutputStream());
            writer.println(requestStr);
            writer.flush();*/
        }
//        Scanner scanner = new Scanner(connection.getInputStream());
        InputStream inputStream = connection.getInputStream();
        InputStreamReader inputStreamReader = new InputStreamReader(inputStream, destCharset);
        BufferedReader in = new BufferedReader(inputStreamReader);

        String jsonUserStr = in.readLine().toString();
//        StringBuilder responseStr = new StringBuilder();
//        while (scanner.hasNextLine()) {
//            responseStr.append(scanner.nextLine());
//        }

        return jsonUserStr;
    }

    public static String getHttpResponse(String urlStr, String requestStr, String defaultCharset) throws Exception {
        URL url = new URL(urlStr);
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        //PrintWriter writer =null;
        if (requestStr != null && !requestStr.equals("")) {
            connection.setDoOutput(true);
            OutputStream outputStream = connection.getOutputStream();
            outputStream.write(requestStr.getBytes());
            outputStream.flush();
            /*writer = new PrintWriter(connection.getOutputStream());
            writer.println(requestStr);
            writer.flush();*/
        }
//        Scanner scanner = new Scanner(connection.getInputStream());
        InputStream inputStream = connection.getInputStream();
        InputStreamReader inputStreamReader = new InputStreamReader(inputStream);
        BufferedReader in = new BufferedReader(inputStreamReader);

        String jsonUserStr = in.readLine().toString();
//        StringBuilder responseStr = new StringBuilder();
//        while (scanner.hasNextLine()) {
//            responseStr.append(scanner.nextLine());
//        }

        return jsonUserStr;
    }

    public static void getHttpResponseByAsynchronous(String urlStr){
        CloseableHttpAsyncClient httpclient = HttpAsyncClients.createDefault();
//        Httpclient httpclient = new HttpClient();
        try {
            httpclient.start();
            HttpPost request = new HttpPost(urlStr);
            Future<HttpResponse> future = httpclient.execute(request, null);
            HttpResponse response = future.get();
            System.out.println("Response: " + response.getStatusLine());
            System.out.println("Shutting down");
        }catch (Exception e){

        } finally {
            try {
                httpclient.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
}
