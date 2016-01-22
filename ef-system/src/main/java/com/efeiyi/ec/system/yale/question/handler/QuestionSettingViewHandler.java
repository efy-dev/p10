package com.efeiyi.ec.system.yale.question.handler;

import com.efeiyi.ec.yale.question.model.QuestionSetting;
import com.ming800.core.does.service.DoHandler;
import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by Administrator on 2015/12/29.
 * 答题设置 显示 Handler
 */
public class QuestionSettingViewHandler implements DoHandler {
    @Override
    public ModelMap handle(ModelMap modelMap, HttpServletRequest httpServletRequest) throws Exception {
        QuestionSetting questionSetting = new QuestionSetting();
        List list = (List) modelMap.get("objectList");
        if (list != null && list.size() > 0){
            questionSetting = (QuestionSetting) list.get(0);
        }
        modelMap.put("questionSetting", questionSetting);
        return modelMap;
    }
}
