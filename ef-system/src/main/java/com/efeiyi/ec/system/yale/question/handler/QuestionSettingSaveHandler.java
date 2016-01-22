package com.efeiyi.ec.system.yale.question.handler;

import com.efeiyi.ec.yale.question.model.QuestionSetting;
import com.ming800.core.base.dao.XdoDao;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.base.util.XDoUtil;
import com.ming800.core.does.model.Do;
import com.ming800.core.does.service.DoHandler;
import com.ming800.core.util.ApplicationContextUtil;
import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by Administrator on 2015/12/30.
 * 答题设置保存 Handler
 */
public class QuestionSettingSaveHandler implements DoHandler {

    private BaseManager baseManager = (BaseManager) ApplicationContextUtil.getApplicationContext().getBean("baseManagerImpl");
    private XdoDao xdoDao = (XdoDao) ApplicationContextUtil.getApplicationContext().getBean("xdoDaoSupport");

    @Override
    public ModelMap handle(ModelMap modelMap, HttpServletRequest request) throws Exception {
        QuestionSetting qs = new QuestionSetting();

        String qsId = request.getParameter("id");
        String type = "new";
        if (qsId != null && !"".equals(qsId.trim())) {
            type = "edit";
            qs = (QuestionSetting) baseManager.getObject(qs.getClass().getName(), qsId);
        }
        Do tempDo = (Do) modelMap.get("tempDo");
        qs = (QuestionSetting) XDoUtil.processSaveOrUpdateTempObject(tempDo, qs, qs.getClass(), request, type, xdoDao);

        String commonPrizeTrue = request.getParameter("commonPrizeTrue");
        if (commonPrizeTrue == null || commonPrizeTrue.trim().equals("")){
            commonPrizeTrue = "0";
        }
        qs.setCommonPrizeTrue(commonPrizeTrue);

        modelMap.put("object", qs);
        return modelMap;
    }
}
