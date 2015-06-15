package com.ming800.core.p.service.impl;

import com.aliyun.openservices.oss.OSSClient;
import com.aliyun.openservices.oss.model.CannedAccessControlList;
import com.aliyun.openservices.oss.model.OSSObject;
import com.aliyun.openservices.oss.model.ObjectMetadata;
import com.aliyun.openservices.oss.model.PutObjectResult;
import com.ming800.core.p.service.AliOssUploadManager;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-11-19
 * Time: 下午3:04
 * To change this template use File | Settings | File Templates.
 */
@Service
public class AliOssUploadManagerImpl implements AliOssUploadManager {

    private static String accessKeyId = "Mlfmxetirzbsso0O";
    private static String accessKeySecret = "BxIPUCoDF7IqeSjrvhH9cJLqHNi6cL";

//    private String bucketName = "lms";

    @Override
    public Boolean uploadFile(MultipartFile multipartFile, String bucketName, String uploadName) throws IOException {
        OSSClient client = new OSSClient(accessKeyId, accessKeySecret);

        // 获取Bucket的存在信息
        boolean exists = client.doesBucketExist(bucketName);
        if (!exists) {
            // 新建一个Bucket
            client.createBucket(bucketName);
            //CannedAccessControlList是枚举类型，包含三个值： Private 、 PublicRead 、 PublicReadWrite
            client.setBucketAcl(bucketName, CannedAccessControlList.PublicReadWrite);
        }

        // 获取指定文件的输入流
//        File file = new File(filePath);
        InputStream content = multipartFile.getInputStream();

        // 创建上传Object的Metadata
        ObjectMetadata meta = new ObjectMetadata();

        // 必须设置ContentLength
        meta.setContentLength(multipartFile.getSize());

        // 上传Object.
        PutObjectResult result = client.putObject(bucketName, uploadName, content, meta);

        // 打印ETag
        System.out.println(result.getETag());

        return true;
        //To change body of implemented methods use File | Settings | File Templates.
    }


    /**
     * 删除附件
     */
    @Override
    public void deleteFile(String bucketName, String uploadName) throws IOException {
        OSSClient client = new OSSClient(accessKeyId, accessKeySecret);
        client.deleteObject(bucketName, uploadName);

        //To change body of implemented methods use File | Settings | File Templates.
    }


    @Override
    public Long calculateFileSize(String bucketName, List<String[]> keysList) {

        Long fileSize = 0L;

        OSSClient client = new OSSClient(accessKeyId, accessKeySecret);
        for (String[] keys : keysList) {
            String key = keys[0];
            OSSObject ossObject = client.getObject(bucketName, key);
            fileSize = fileSize + ossObject.getObjectMetadata().getContentLength();
        }

        return fileSize;  //To change body of implemented methods use File | Settings | File Templates.
    }
}
