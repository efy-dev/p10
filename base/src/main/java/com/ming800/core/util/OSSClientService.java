package com.ming800.core.util;


import com.aliyun.openservices.oss.OSSClient;
import com.aliyun.openservices.oss.model.ObjectMetadata;
import com.aliyun.openservices.oss.model.PutObjectResult;
import org.springframework.stereotype.Service;

import java.io.InputStream;

/**
 * Created by Administrator on 2014/12/3.
 */
@Service
public class OSSClientService {
    public static final String KEY = "tK0kDIr0WoZsnYse";
    public static final String SECRET = "MUHlzfU6T5MvVSEoWAnFsScw7rcbnG";
    public static final String ENDPOINT = "http://oss-cn-beijing.aliyuncs.com";
    //public static final String BUCKETNAME="ypl-sample-photo";

    /**
     * 上传文件到阿里云存储
     *
     * @param key
     * @param content
     * @param size
     * @return
     */
    public static boolean putObject(String bucketName, String key, InputStream content, long size) {

        try {
            OSSClient client = new OSSClient(ENDPOINT, KEY, SECRET);
            ObjectMetadata meta = new ObjectMetadata();
            meta.setContentLength(size);
            PutObjectResult result = client.putObject(bucketName, key, content, meta);//PutObjectResult可用于校验上传的文件是否与本地一致
            content.close();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }

    }
}
