package com.efeiyi.ec.system.tenant.controller;

import com.efeiyi.ec.tenant.model.TenantNews;
import com.efeiyi.ec.tenant.model.TenantNewsTag;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.base.service.XdoManager;
import com.ming800.core.does.model.Do;
import com.ming800.core.does.service.DoHandler;
import com.ming800.core.does.service.DoManager;
import com.ming800.core.p.model.WordValue;
import com.ming800.core.p.service.AliOssUploadManager;
import com.ming800.core.util.ApplicationContextUtil;
import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

/**
 * Created by Administrator on 2015/7/22.
 */
public class TenantNewsHandler implements DoHandler {

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
                WordValue wordValueTemp = new WordValue();
                wordValueTemp.setId(tagId);
                TenantNewsTag tenantNewsTag = new TenantNewsTag();
                tenantNewsTag.setWordValue(wordValueTemp);
                tenantNewsTag.setTenantNews((TenantNews)object);
                tenantNewsTag.setStatus("1");
                baseManager.saveOrUpdate(TenantNewsTag.class.getName(),tenantNewsTag);
            }

        }


        return modelMap;
    }
}
