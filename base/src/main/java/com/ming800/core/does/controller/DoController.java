package com.ming800.core.does.controller;

import com.ming800.core.base.service.BaseManager;
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
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

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

    @Autowired
    private BaseManager baseManager;

    /*jsp页面根据配置文件basic_do.xml生成  tabs*/
    @RequestMapping("/generateTabs.do")
    public ModelAndView generateTabs(HttpServletRequest request, ModelMap modelMap) throws Exception {

        String qm = request.getParameter("qm");
        modelMap.put("qm", qm);

        //取出扩展参数
        Map<String, Object> paramMap = new HashMap<>();
        Enumeration<String> enumeration = request.getParameterNames();
        while (enumeration.hasMoreElements()) {
            String paramName = enumeration.nextElement();
            if (!paramName.equals("qm") && !paramName.equals("conditions") && !paramName.equals("sort")&& !paramName.equals("pageEntity.index")&& !paramName.equals("pageEntity.size"))
                paramMap.put(paramName, request.getParameter(paramName));
        }
        modelMap.put("paramMap", paramMap);

        Do tempDo = doManager.getDoByQueryModel(qm.split("_")[0]);
        modelMap.put("tempDo", tempDo);
        modelMap.put("doQueryList", tempDo.getDoQueryList());

        DoQuery tempDoQuery = tempDo.getDoQueryByName(qm.split("_")[1]);
        modelMap.put("tabTitle", tempDoQuery.getLabel());

        return new ModelAndView("/jmenu/tabDiv");
    }

//
//    @RequestMapping("/saveOrUpdateChoose.do")
//    @ResponseBody
//    public Object saveOrUpdateChoose() {
//        BaseChoose baseChoose = new BaseChoose();
//        baseManager.saveOrUpdate(BaseChoose.class.getName(), baseChoose);
//        return baseChoose;
//    }

    @RequestMapping("/generatePages.do")
    public String generatePages(HttpServletRequest request) throws Exception {

        String qm = request.getParameter("qm");
//        modelMap.put("qm", qm);

        String chooseId = request.getParameter("chooseId");

        String redirectUrl = "/basic/xm.do?qm=" + qm + "&chooseId=" + chooseId + "&resultPage=/jmenu/chooseList";

        return "forward:/" + redirectUrl;
    }

//    @RequestMapping("/chooseItem.do")
//    @ResponseBody
//    public boolean chooseItem(HttpServletRequest request) {
//        try {
//            String param = request.getParameter("param");
//            if (param != null && !param.equals("")) {
//                String chooseId = param.split(":")[0];
//                String modelId = param.split(":")[1];
//                BaseChoose baseChoose = (BaseChoose) baseManager.getObject(BaseChoose.class.getName(), chooseId);
//                baseChoose.setModelId(modelId);
//                baseManager.saveOrUpdate(BaseChoose.class.getName(), baseChoose);
//            }
//            return true;
//        } catch (Exception e) {
//            return false;
//        }
//    }

//    @RequestMapping({"/viewChoose.do"})
//    @ResponseBody
//    public Object viewBaseChoose(HttpServletRequest request){
//        String chooseId = request.getParameter("chooseId");
//        BaseChoose baseChoose = (BaseChoose)baseManager.getObject(BaseChoose.class.getName(),chooseId);
//        return baseChoose;
//    }

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
