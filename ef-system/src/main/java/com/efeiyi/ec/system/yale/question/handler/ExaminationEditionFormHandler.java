package com.efeiyi.ec.system.yale.question.handler;

import com.efeiyi.ec.yale.question.model.ExaminationEdition;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.service.DoHandler;
import com.ming800.core.util.ApplicationContextUtil;
import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpServletRequest;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by Administrator on 2015/12/23.
 * 试卷期次 新建更新 Handler
 */

public class ExaminationEditionFormHandler implements DoHandler {

    private BaseManager baseManager = (BaseManager) ApplicationContextUtil.getApplicationContext().getBean("baseManagerImpl");

    @Override
    public ModelMap handle(ModelMap modelMap, HttpServletRequest request) throws Exception {
        ExaminationEdition examEdition = new ExaminationEdition();

        String id = request.getParameter("id");
        String type = "new";
        if (id != null && !id.trim().equals("")) {
            type = "edit";
            examEdition = (ExaminationEdition) baseManager.getObject(ExaminationEdition.class.getName(), id);
        }
        examEdition = getBaseProperty(examEdition, request);

        if ("new".equals(type)){
            examEdition.setStatus("1");
            examEdition.setCreateDatetime(new Date());
        }

        modelMap.put("object", examEdition);
        return modelMap;
    }

    private ExaminationEdition getBaseProperty(ExaminationEdition examEdition, HttpServletRequest request) throws ParseException {
        String name = request.getParameter("name");
        String strDate = request.getParameter("expireDate");
        String questionCount = request.getParameter("questionCount");

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date expireDate = sdf.parse(strDate);

        examEdition.setName(name);
        examEdition.setExpireDate(expireDate);
        examEdition.setQuestionCount(Integer.parseInt(questionCount));

        return examEdition;
    }
}
