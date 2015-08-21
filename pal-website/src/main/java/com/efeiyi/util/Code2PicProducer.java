package com.efeiyi.util;

import java.io.*;

/**
 * Created by Administrator on 2015/8/20.
 */
public class Code2PicProducer implements Runnable {

 String fileName = "D:/new/label.txt";
    public void run() {
        long start = System.currentTimeMillis();
        int count = 0;
        BufferedReader br = null;
        try {
            br = new BufferedReader(new FileReader(new File(fileName)));
            String code = "";
//            while(count < 1000){
//                code = br.readLine();
            while ((code = br.readLine()) != null) {

                count++;

                if (Code2PicConsumer.codeList.size() >= 100) {
                    synchronized (Code2PicConsumer.codeList) {
                        Code2PicConsumer.codeList.wait();
                    }
                }

                code = code.substring(35, 45);

                Code2PicConsumer.codeList.add(code);
                synchronized (Code2PicConsumer.codeList) {
                    Code2PicConsumer.codeList.notifyAll();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (br != null) {
                try {
                    br.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            Code2PicConsumer.theEnd = true;
            System.out.println("读取用时:" + (System.currentTimeMillis() - start) + "\n记录数：" + count);

        }
    }
}
