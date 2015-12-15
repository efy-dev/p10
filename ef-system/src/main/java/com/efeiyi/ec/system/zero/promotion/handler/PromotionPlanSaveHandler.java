package com.efeiyi.ec.system.zero.promotion.handler;

import com.efeiyi.ec.zero.promotion.model.PromotionPlan;
import com.ming800.core.base.dao.XdoDao;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.base.util.XDoUtil;
import com.ming800.core.does.model.Do;
import com.ming800.core.does.service.DoHandler;
import com.ming800.core.util.ApplicationContextUtil;
import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by Administrator on 2015/7/23.
 * 新建或修改返利链接 Handler
 */
public class PromotionPlanSaveHandler implements DoHandler {

    private BaseManager baseManager = (BaseManager) ApplicationContextUtil.getApplicationContext().getBean("baseManagerImpl");
    private XdoDao xdoDao = (XdoDao) ApplicationContextUtil.getApplicationContext().getBean("xdoDaoSupport");

    @Override
    public ModelMap handle(ModelMap modelMap, HttpServletRequest request) throws Exception {

        PromotionPlan promotionPlan = new PromotionPlan();

        String promotionPlanId = request.getParameter("id");
        String type = "new";
        if (promotionPlanId != null && !"".equals(promotionPlanId.trim())) {
            type = "edit";
            promotionPlan = (PromotionPlan) baseManager.getObject(PromotionPlan.class.getName(), promotionPlanId);
        }
        Do tempDo = (Do) modelMap.get("tempDo");
        promotionPlan = (PromotionPlan) XDoUtil.processSaveOrUpdateTempObject(tempDo, promotionPlan, promotionPlan.getClass(), request, type, xdoDao);

        if (type.equals("new")){
            promotionPlan.setStatus("1");
        }
        modelMap.put("object", promotionPlan);
        return modelMap;
    }

}
