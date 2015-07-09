package com.ming800.core.base.controller;

import com.ming800.core.base.dao.XdoDao;
import com.ming800.core.base.util.ReflectUtil;
import com.ming800.core.base.util.SystemValueUtil;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.base.service.XdoManager;
import com.ming800.core.base.util.XDoUtil;
import com.ming800.core.does.model.Do;
import com.ming800.core.does.service.MultipartHandler;
import com.ming800.core.p.service.AttachmentManager;
import com.ming800.core.util.*;
import org.springframework.ui.ModelMap;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;

import javax.servlet.http.HttpServletRequest;
import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: ming
 * Date: 12-10-30
 * Time: 上午10:30
 * To change this template use File | Settings | File Templates.
 */

public class AttachmentHandler implements MultipartHandler {

    private BaseManager baseManager = (BaseManager) ApplicationContextUtil.getApplicationContext().getBean("baseManagerImpl");
    private XdoManager xdoManager = (XdoManager) ApplicationContextUtil.getApplicationContext().getBean("xdoManagerImpl");
    private AttachmentManager attachmentManager = (AttachmentManager) ApplicationContextUtil.getApplicationContext().getBean("attachmentManagerImpl");
    private XdoDao xdoDao = (XdoDao) ApplicationContextUtil.getApplicationContext().getBean("xdoDaoSupport");

    /**
     * newsAttachment  / messageAttachment  无法确定
     * setNews       /   setMessage         无法确定
     * setNewAttachmentList                 无法确定
     * 需要传值    com.ming800.info.model.NewsAttachment   和  nws（属性）
     */

    @Override
    public ModelMap handleMultipart(Do tempDo, ModelMap modelMap, HttpServletRequest request, MultipartRequest multipartRequest) throws Exception {

        String type;

        Object object;
        String id = request.getParameter("id");
        if (id != null && !id.equals("")) {
            type = "edit";
            object = baseManager.getObject(tempDo.getXentity().getModel(), id);

            /*删除以前的附件*/
            attachmentManager.deleteAttachments(tempDo.getExecute(), request.getParameterValues("attachementIds"));

        } else {
            type = "new";
            object = ReflectUtil.getNewInstance(tempDo.getXentity().getModel());
        }

        object = XDoUtil.processSaveOrUpdateObject(tempDo, object, object.getClass(), request, type,xdoDao);

        String storeType = request.getParameter("storeType");

        List<Object> attachmentObjectList = new ArrayList<>();
        List<MultipartFile> multipartFileList = multipartRequest.getFiles("adjunctFile");
        if (multipartFileList != null && multipartFileList.size() > 0) {
            attachmentObjectList.addAll(attachmentManager.getAttachmentList(multipartFileList, storeType, "m80", "a", object, tempDo.getExecute()));
        }

        String[] urlNameArray = request.getParameterValues("adjunctUrlName");
        String[] urlArray = request.getParameterValues("adjunctUrl");
        if (urlNameArray != null && urlNameArray.length > 0) {
            attachmentObjectList.addAll(attachmentManager.getAttachmentList(urlNameArray, urlArray, object, tempDo.getExecute()));
        }


        String simpleName = SystemValueUtil.generateSimpleName(ReflectUtil.getNewInstance(tempDo.getExecute()));

        Field field = ReflectUtil.getDeclaredField(object, simpleName + "List");
        field.setAccessible(true);
        field.set(object, attachmentObjectList);

        modelMap.put("object", object);

        return modelMap;  //To change body of implemented methods use File | Settings | File Templates.
    }
}
