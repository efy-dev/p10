package com.efeiyi.ec.system.zero.virtual.handler;

import com.efeiyi.ec.zero.virtual.model.VirtualPlan;
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
public class VirtualPlanSaveHandler implements DoHandler {

    private BaseManager baseManager = (BaseManager) ApplicationContextUtil.getApplicationContext().getBean("baseManagerImpl");
    private XdoDao xdoDao = (XdoDao) ApplicationContextUtil.getApplicationContext().getBean("xdoDaoSupport");
    private AutoSerialManager autoSerialManager = (AutoSerialManager) ApplicationContextUtil.getApplicationContext().getBean("autoSerialManager") ;

    @Override
    public ModelMap handle(ModelMap modelMap, HttpServletRequest request) throws Exception {

        VirtualPlan virtualPlan = new VirtualPlan();

        String virtualPlanId = request.getParameter("id");
        String type = "new";
        if (virtualPlanId != null && !"".equals(virtualPlanId.trim())) {
            type = "edit";
            virtualPlan = (VirtualPlan) baseManager.getObject(VirtualPlan.class.getName(), virtualPlanId);
        }
        Do tempDo = (Do) modelMap.get("tempDo");
        virtualPlan = (VirtualPlan) XDoUtil.processSaveOrUpdateTempObject(tempDo, virtualPlan, virtualPlan.getClass(), request, type, xdoDao);

        if ("new".equals(type)){
            virtualPlan.setStatus("1");
            virtualPlan.setSerial(autoSerialManager.nextSerial("virtualPlan"));
        }

        modelMap.put("object", virtualPlan);
        return modelMap;
    }

}
