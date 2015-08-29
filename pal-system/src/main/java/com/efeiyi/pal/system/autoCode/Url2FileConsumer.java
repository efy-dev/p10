package com.efeiyi.pal.system.autoCode;


import org.apache.commons.io.FileUtils;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentLinkedQueue;

/**
 * Created by Administrator on 2015/8/24.
 */
public class Url2FileConsumer implements Runnable {

    private Map<String, String> codeUrlMap = new ConcurrentHashMap<>();
    private ConcurrentLinkedQueue<String> codeList = new ConcurrentLinkedQueue<>();
    private  boolean generatorEnd = false;
    private int count=0;
    private boolean start = false;
    private String labelBatchId;

    public Map<String, String> getCodeUrlMap() {
        return codeUrlMap;
    }

    public void setCodeUrlMap(Map<String, String> codeUrlMap) {
        this.codeUrlMap = codeUrlMap;
    }

    public boolean isGeneratorEnd() {
        return generatorEnd;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }

    public boolean isStart() {
        return start;
    }

    public void setStart(boolean start) {
        this.start = start;
    }

    public void setGeneratorEnd(boolean generatorEnd) {
        this.generatorEnd = generatorEnd;
    }

    public Url2FileConsumer(int count,String labelBatchId) {
        this.count = count;
        this.labelBatchId = labelBatchId;
    }

    public void run() {
        BufferedWriter bw = null;
        String path = this.getClass().getClassLoader().getResource("/").getPath();
        File clazzDir = new File(path);
        String webInfPath = clazzDir.getParent() + "/file/";
        File parent = new File(webInfPath);
        if(!parent.exists()){
            parent.mkdirs();
        }
        try {
            File file = new File(webInfPath + labelBatchId + ".txt.tmp");
//            if(!file.exists()) {
//                file.mkdirs();
//            }
            bw = new BufferedWriter(new FileWriter(file));
            long startTime = System.currentTimeMillis();
            while (true) {

                if (codeUrlMap.size() < count) {
                    System.out.println("当前codeUrlMap：" + codeUrlMap.size());
                    System.out.println("当前codeList：" + codeList.size());
                    synchronized (codeList){
                        codeList.notifyAll();
                    }
                    Thread.currentThread().sleep(3000);
                } else {
                    System.out.println("当前：" + codeUrlMap.size());
                    this.start = true;
                    synchronized (codeList) {
                        codeList.notifyAll();
                    }
                    for (Map.Entry<String, String> entry : codeUrlMap.entrySet()) {
                        bw.write(entry.getKey() + ":" + entry.getValue() + "\n");
                    }
                    System.out.println(Thread.currentThread().getId() + ":输出文本退出");
                    break;
                }
            }
            bw.flush();
            FileUtils.copyFile(file,new File(webInfPath + labelBatchId + ".txt"));
            System.out.println("输出用时：" + (System.currentTimeMillis() - startTime));
        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            if(bw != null){
                try {
                    bw.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    public ConcurrentLinkedQueue<String> getCodeList() {
        return codeList;
    }

    public void setCodeList(ConcurrentLinkedQueue<String> codeList) {
        this.codeList = codeList;
    }
}
