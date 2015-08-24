package com.efeiyi.pal.system.autoCode;


import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * Created by Administrator on 2015/8/24.
 */
public class Url2FileConsumer implements Runnable {

    public static Map<String, String> codeUrlMap = new ConcurrentHashMap<>();
    private  boolean generatorIsEnd = false;
    public static boolean outputIsEnd = false;
    private int count=0;

    public boolean isGeneratorIsEnd() {
        return generatorIsEnd;
    }

    public void setGeneratorIsEnd(boolean generatorIsEnd) {
        this.generatorIsEnd = generatorIsEnd;
    }

    public Url2FileConsumer(int count) {
        this.count = count;
    }

    public void run() {
        try {
            BufferedWriter bw = new BufferedWriter(new FileWriter(new File("d:/abc.txt")));
            long start = System.currentTimeMillis();
            while (true) {

                if (codeUrlMap.size() < count) {
                    System.out.println("当前codeUrlMap：" + codeUrlMap.size());
                    System.out.println("当前codeList：" + Code2UrlConsumer.codeList.size());
                    synchronized (Code2UrlConsumer.codeList){
                        Code2UrlConsumer.codeList.notifyAll();
                    }
                    Thread.currentThread().sleep(3000);
                } else {
                    System.out.println("当前：" + codeUrlMap.size());
                    Url2FileConsumer.outputIsEnd = true;
                    synchronized (Code2UrlConsumer.codeList) {
                        Code2UrlConsumer.codeList.notifyAll();
                    }
                    for (Map.Entry<String, String> entry : codeUrlMap.entrySet()) {
                        bw.write(entry.getKey() + ":" + entry.getValue() + "\n");
                    }
                    System.out.println(Thread.currentThread().getId() + ":输出文本退出");
                    break;
                }
            }
            bw.flush();
            System.out.println("输出用时：" + (System.currentTimeMillis() - start));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
