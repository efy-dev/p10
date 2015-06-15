package com.ming800.core.util;

import com.ming800.core.p.PConst;

/**
 * Created by Administrator on 14-6-12.
 */
public class AttachmentUtil {

    public static String getGenerate(String storeType, String fileName, String fileType, String fileDataId, String path) {
        StringBuilder stringBuilder = new StringBuilder();
        if (storeType.equals(PConst.ATTACHMENT_STORETYPE_URL)) {
            stringBuilder.append("<a href=### onclick=art.dialog.open(\'")
                    .append(path)
                    .append("\')>")
                    .append(fileName)
                    .append("</a>");
        } else if (storeType.equals(PConst.ATTACHMENT_STORETYPE_DATABASE)) {
            if (fileType.startsWith("image")) {
                StringBuilder href = new StringBuilder(ApplicationContextUtil.getApplicationContext().getApplicationName()).append("/fileData/downLoadByPath.do?fileName=").append(fileName).append("&path=").append(path);
                stringBuilder.append("<a href=\"+href+\" title=\'点击图片，进行下载\'><img src=\'").append(ApplicationContextUtil.getApplicationContext().getApplicationName()).append("/fileData/downLoad.do?id=").append(fileDataId).append("\'/></a>");
            } else {
                stringBuilder.append("<a href='").append(ApplicationContextUtil.getApplicationContext().getApplicationName()).append("/fileData/downLoad.do?id=").append(fileDataId).append("'>").append(fileName).append("</a>");
            }
        } else if (storeType.equals(PConst.ATTACHMENT_STORETYPE_ALI_CLOUD)) {
            if (fileType.startsWith("image")) {
                StringBuilder href = new StringBuilder(ApplicationContextUtil.getApplicationContext().getApplicationName()).append("/fileData/downLoadByPath.do?fileName=").append(fileName).append("&path=").append(path);
                stringBuilder.append("<a href=" + href + " title=\'点击图片，进行下载\'><image style='width:200px;' src=\'")
                        .append("http://i.ming800.com/").append(path)
                        .append("\'/></a>");
            } else {
                stringBuilder.append("<a href='").append("http://i.ming800.com/").append(path).append("'>").append(fileName).append("</a>");
            }

        } else {
            if (fileType.startsWith("image")) {
                StringBuilder href = new StringBuilder(ApplicationContextUtil.getApplicationContext().getApplicationName()).append("/fileData/downLoadByPath.do?fileName=").append(fileName).append("&path=").append(path);
                stringBuilder.append("<a href=" + href + " title=\'点击图片，进行下载\'><img style='width:200px;'  src=\'").append(ApplicationContextUtil.getApplicationContext().getApplicationName()).append("/fileData/downLoadByPath.do?fileName=").append(fileName).append("&path=").append(path).append("\'/></a>");
            } else {
                stringBuilder.append("<a href='").append(ApplicationContextUtil.getApplicationContext().getApplicationName()).append("/fileData/downLoadByPath.do?fileName=").append(fileName).append("&path=").append(path).append("'>").append(fileName).append("</a>");
            }
        }
        return stringBuilder.toString();
    }
}
