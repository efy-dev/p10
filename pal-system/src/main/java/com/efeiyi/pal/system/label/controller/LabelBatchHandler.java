package com.efeiyi.pal.system.label.controller;

import com.efeiyi.pal.label.model.LabelBatch;
import com.ming800.core.base.dao.XdoDao;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.base.util.XDoUtil;
import com.ming800.core.does.model.Do;
import com.ming800.core.does.service.DoHandler;
import com.ming800.core.p.service.AutoSerialManager;
import com.ming800.core.util.ApplicationContextUtil;
import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by Administrator on 2015/7/23.
 * 新建或修改标签批次 Handler
 */
public class LabelBatchHandler implements DoHandler {

    private BaseManager baseManager = (BaseManager) ApplicationContextUtil.getApplicationContext().getBean("baseManagerImpl");
    private XdoDao xdoDao = (XdoDao) ApplicationContextUtil.getApplicationContext().getBean("xdoDaoSupport");
    private AutoSerialManager autoSerialManager = (AutoSerialManager) ApplicationContextUtil.getApplicationContext().getBean("autoSerialManager") ;

    @Override
    public ModelMap handle(ModelMap modelMap, HttpServletRequest request) throws Exception {

        LabelBatch labelBatch = new LabelBatch();

        String labelBatchId = request.getParameter("id");
        String type = "new";
        if (labelBatchId != null && !"".equals(labelBatchId)) {
            type = "edit";
            labelBatch = (LabelBatch) baseManager.getObject(LabelBatch.class.getName(), labelBatchId);
        }
        Do tempDo = (Do) modelMap.get("tempDo");
        labelBatch = (LabelBatch) XDoUtil.processSaveOrUpdateTempObject(tempDo, labelBatch, labelBatch.getClass(), request, type, xdoDao);

        if ("new".equals(type)){
            labelBatch.setStatus("1");
            labelBatch.setSerial(autoSerialManager.nextSerial("serial"));
        }

        modelMap.put("object", labelBatch);
        return modelMap;
    }

}
