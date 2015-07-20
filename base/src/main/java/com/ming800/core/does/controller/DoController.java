package com.ming800.core.does.controller;

import com.ming800.core.does.model.*;
import com.ming800.core.does.service.DoManager;
import com.ming800.core.base.util.SystemValueUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

/**
 * Created with IntelliJ IDEA.
 * User: ming
 * Date: 12-11-5
 * Time: 下午3:24
 * To change this template use File | Settings | File Templates.
 */
@Controller
@RequestMapping("/do")
public class DoController {

    @Autowired
    private DoManager doManager;

    /*jsp页面根据配置文件basic_do.xml生成  tabs*/
    @RequestMapping("/generateTabs.do")
    public ModelAndView generateTabs(HttpServletRequest request, ModelMap modelMap) throws Exception {

        String qm = request.getParameter("qm");
        modelMap.put("qm", qm);

        Do tempDo = doManager.getDoByQueryModel(qm.split("_")[0]);
        modelMap.put("tempDo", tempDo);
        modelMap.put("doQueryList", tempDo.getDoQueryList());

        DoQuery tempDoQuery = tempDo.getDoQueryByName(qm.split("_")[1]);
        modelMap.put("tabTitle", tempDoQuery.getLabel());

        return new ModelAndView("/jmenu/tabDiv");
    }

    /*jsp页面根据配置文件basic_do.xml生成  tabs*/
    @RequestMapping("/listCondition.do")
    @ResponseBody
    public String listCondition(HttpServletRequest request) throws Exception {

        String qm = request.getParameter("qm");
        Do tempDo = doManager.getDoByQueryModel(qm.split("_")[0]);
        DoQuery tempDoQuery = tempDo.getDoQueryByName(qm.split("_")[1]);

        StringBuilder stringBuilder = new StringBuilder();

        stringBuilder.append("[");
        for (QueryCondition queryCondition : tempDoQuery.getConditionList()) {
            String defaultValue = SystemValueUtil.getValue(queryCondition.getValue(), "name").toString();

            stringBuilder.append("{");

            stringBuilder.append("\"name\":\"").append(queryCondition.getName()).append("\",");
            stringBuilder.append("\"label\":\"").append(queryCondition.getLabel()).append("\",");
            stringBuilder.append("\"value\":\"").append(defaultValue).append("\",");
            stringBuilder.append("\"inputType\":\"").append(queryCondition.getInputType()).append("\",");
            stringBuilder.append("\"key\":\"").append(queryCondition.getKey()).append("\",");
            stringBuilder.append("\"required\":\"").append(queryCondition.getRequired()).append("\",");
            stringBuilder.append("\"dataType\":\"").append(queryCondition.getDataType()).append("\"");

            stringBuilder.append("},");

        }

        if (stringBuilder.length() > 0) {
            stringBuilder.deleteCharAt(stringBuilder.length() - 1);
        }

        stringBuilder.append("]");
        return stringBuilder.toString();
    }

}
