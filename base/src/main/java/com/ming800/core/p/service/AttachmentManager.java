package com.ming800.core.p.service;


import org.springframework.web.multipart.MultipartFile;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-3-19
 * Time: 上午9:41
 * To change this template use File | Settings | File Templates.
 */
public interface AttachmentManager {

    /**
     * 外链接类型的附件
     *
     * @param urlNameArray 附件名称
     * @param urlArray     附件的外部链接地址
     * @param object       例：message
     * @param attachment   例：MessageAttachement.class.getName()
     * @return
     * @throws Exception
     */
    List getAttachmentList(String[] urlNameArray, String[] urlArray, Object object, String attachment) throws Exception;

    /**
     * 上传的附件
     *
     * @param fileList   文件集合
     * @param storeType  存储类型 （storeType来自附件标签adjunct中的hidden input）
     * @param object     例：message
     * @param attachment 例：MessageAttachement.class.getName()
     * @return
     * @throws Exception
     */
    List getAttachmentList(List<MultipartFile> fileList, String storeType, String bucketName, String folderName, Object object, String attachment) throws Exception;

    //public List getAttachmentList(List<MultipartFile> fileList, String storeType, String bucketName, String folderName, Object object, String attachment, Branch branch) throws Exception;

    /**
     * 删除附件
     *
     * @param name           类的完成路径  例如 MessageAttachment.class.getName()
     * @param attachementIds 要删除的附件 id 数组
     * @throws Exception
     */
    void deleteAttachments(String name, String[] attachementIds) throws Exception;
}
