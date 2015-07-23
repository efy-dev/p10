package com.ming800.core.p.service;

import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-11-19
 * Time: 下午3:03
 * To change this template use File | Settings | File Templates.
 */
public interface AliOssUploadManager {

    Boolean uploadFile(MultipartFile multipartFile, String bucket, String uploadName) throws IOException;

    void deleteFile(String bucket, String uploadName) throws IOException;

    Long calculateFileSize(String bucketName, List<String[]> keysList);

    List listObjectByPath(String bucket,String path);

}
