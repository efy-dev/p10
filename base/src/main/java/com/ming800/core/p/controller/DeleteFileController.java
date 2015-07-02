package com.ming800.core.p.controller;

import com.ming800.core.base.service.BaseManager;
import com.ming800.core.p.PConst;
import com.ming800.core.p.model.FileData;
import com.ming800.core.p.service.AliOssUploadManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.LinkedHashMap;
import java.util.List;


/**
 * Created with IntelliJ IDEA.
 * User: ming
 * Date: 12-11-5
 * Time: 下午3:24
 * To change this template use File | Settings | File Templates.
 */
@Controller
@RequestMapping("/deleteFile")
public class DeleteFileController {

    @Autowired
    private BaseManager baseManager;
    @Autowired
    private AliOssUploadManager aliOssUploadManager;

    @RequestMapping("/deleteFile.do")
    @ResponseBody
    public Object deleteFile(HttpServletRequest request) throws Exception {

        String attachmentId = request.getParameter("attachmentId");

        String queryStr = "select store_type, data_id, path from core_p_attachment where id =:attachmentId";
        LinkedHashMap<String, Object> queryParamMap = new LinkedHashMap<>();
        queryParamMap.put("attachmentId", attachmentId);
        List<Object[]> attachmentArrayList = (List<Object[]>) baseManager.executeSql("list", queryStr, queryParamMap);

        if (attachmentArrayList != null && attachmentArrayList.size() > 0) {

            for (Object[] attachmentArray : attachmentArrayList) {
                String storeType = attachmentArray[0].toString();

                if (storeType.equals(PConst.ATTACHMENT_STORETYPE_DATABASE)) {
                    String fileDataId = attachmentArray[1].toString();
                    baseManager.delete(FileData.class.getName(), fileDataId);
                } else if (storeType.equals(PConst.ATTACHMENT_STORETYPE_DISK)) {
                    // 获取路径
                    File file = new File(attachmentArray[2].toString());
                    if (file.exists()) {
                        file.delete();
                    }
                  /*  String fileDataId = attachmentArray[1].toString();
                    FileData fileData = (FileData)baseManager.getObject(FileData.class.getName(), fileDataId);
                    // 获取路径
                    File file = new File(fileData.getPath());
                    if (file.exists()) {
                        file.delete();
                    }
                    baseManager.delete(FileData.class.getName(), fileDataId);*/
                } else if (storeType.equals(PConst.ATTACHMENT_STORETYPE_ALI_CLOUD)) {
                    String path = attachmentArray[2].toString();
                    aliOssUploadManager.deleteFile("m80", path);
                }
            }

            StringBuilder queryStrBuilder = new StringBuilder("delete s from core_p_attachment as s where s.id =:attachmentId");
            LinkedHashMap<String, Object> paramMap = new LinkedHashMap<>();
            paramMap.put("attachmentId", attachmentId);
            baseManager.executeSql("delete", queryStrBuilder.toString(), paramMap);
        }

        return true;
    }


}


