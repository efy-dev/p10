package com.efeiyi.ec.system.master.controller;

import com.efeiyi.ec.master.model.MasterNews;
import com.efeiyi.ec.master.model.MasterNewsTag;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.base.service.XdoManager;
import com.ming800.core.does.model.Do;
import com.ming800.core.does.service.DoHandler;
import com.ming800.core.does.service.DoManager;
import com.ming800.core.p.model.Tag;
import com.ming800.core.util.ApplicationContextUtil;
import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

/**
 * Created by Administrator on 2015/7/22.
 */
public class MasterNewsHandler implements DoHandler {

    private BaseManager baseManager = (BaseManager) ApplicationContextUtil.getApplicationContext().getBean("baseManagerImpl");
    private DoManager doManager = (DoManager) ApplicationContextUtil.getApplicationContext().getBean("doManagerImpl");
    private XdoManager xdoManager = (XdoManager) ApplicationContextUtil.getApplicationContext().getBean("xdoManagerImpl");



    @Override
    public ModelMap handle(ModelMap modelMap, HttpServletRequest request) throws Exception {

        Do tempDo = doManager.getDoByQueryModel(request.getParameter("qm"));
        Object object = xdoManager.saveOrUpdateObject(tempDo, request);
        modelMap.put("object", object);

        List<String> tagValueList = new ArrayList<>();

        Enumeration<String> paramEnumeration = request.getParameterNames();

        while (paramEnumeration.hasMoreElements()) {
            String paramKey = paramEnumeration.nextElement();
            if (paramKey.startsWith("tag")) {
                String value = request.getParameter(paramKey);
                tagValueList.add(value);
            }
        }

        if (tagValueList.size() > 0) {
            for (String tagId : tagValueList) {
                Tag wordValueTemp = new Tag();
                wordValueTemp.setId(tagId);
                MasterNewsTag masterNewsTag = new MasterNewsTag();
                masterNewsTag.setWordValue(wordValueTemp);
                masterNewsTag.setMasterNews((MasterNews) object);
                masterNewsTag.setStatus("1");
                baseManager.saveOrUpdate(MasterNewsTag.class.getName(), masterNewsTag);
            }

        }


        return modelMap;
    }
}
