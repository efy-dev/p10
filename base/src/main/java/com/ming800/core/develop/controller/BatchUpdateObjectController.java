package com.ming800.core.develop.controller;

import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.Xentity;
import com.ming800.core.does.service.ModuleManager;
import com.ming800.core.util.DateUtil;
import com.ming800.core.base.util.ReflectUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: ming
 * Date: 12-11-5
 * Time: 下午3:24
 * To change this template use File | Settings | File Templates.
 */
@Controller
@RequestMapping("/batchUpdateObject")
public class BatchUpdateObjectController {

    @Autowired
    private BaseManager baseManager;
    @Autowired
    private ModuleManager moduleManager;


    @RequestMapping("/formBatchUpdate.do")
    public ModelAndView formBatchUpdate(HttpServletRequest request, ModelMap modelMap) throws Exception {

        String objectIds = request.getParameter("objectIds");
        modelMap.put("objectIds", objectIds);

        String entityName = request.getParameter("entityName");
        modelMap.put("entityName", entityName);

        Xentity xentity = moduleManager.fetchXentity(entityName);
        modelMap.put("fieldMap", xentity.getFieldMap());

        String type = request.getParameter("type");
        if (type != null && !type.equals("")) {
            modelMap.put("type", type);
        }


        return new ModelAndView("/core/develop/batchUpdate/batchUpdateForm");
    }


    @RequestMapping("/batchUpdateObject.do")
    public ModelAndView batchUpdateObject(HttpServletRequest request) throws Exception {

        String objectIds = request.getParameter("objectIds");
        String nameValue = request.getParameter("nameSelect");
        String inputType = request.getParameter("inputType");
        String dataType = request.getParameter("dataType");
        String updateValue = request.getParameter("updateValue");

        String entityName = request.getParameter("entityName");
        Xentity xentity = moduleManager.fetchXentity(entityName);

        Object tempObjectValue = null;
        if (dataType != null && dataType.equals("int")) {
            tempObjectValue = Integer.parseInt(updateValue);
        } else if (inputType != null && dataType.equals("date")) {
            tempObjectValue = DateUtil.parseDate(updateValue);
        } else if (inputType != null && dataType.equals("datetime")) {
            String time = DateUtil.formatDateTime(new Date()).split(" ")[1];
            tempObjectValue = DateUtil.parseDateTime(updateValue + " " + time);
        } else if (inputType != null && dataType.equals("boolean")) {
            tempObjectValue = Boolean.parseBoolean(updateValue);
        } else if (inputType != null && (inputType.equals("dialog_pop") || inputType.equals("dialog_do") || inputType.equals("select_dictionary") || inputType.equals("radio_dictionary"))) {
            /*处理  多对一 。。。*/
            if (inputType.equals("dialog_pop") || inputType.equals("dialog_do")) {
                updateValue = request.getParameter("updateValue.id");
            }

            if (updateValue != null && !updateValue.equals("")) {
                nameValue = nameValue.split("\\.")[0];
                Object object = Class.forName(xentity.getModel()).newInstance();
                Field field = ReflectUtil.getDeclaredField(object, nameValue);
                tempObjectValue = baseManager.getObject(field.getType().getName(), updateValue);
            } else {
                tempObjectValue = null;
            }
        } else {
            tempObjectValue = updateValue;
        }

        List<Object> objectList = new ArrayList<>();

        String[] objectIdArray = objectIds.split(",");
        for (String objectId : objectIdArray) {
            Object object = baseManager.getObject(xentity.getModel(), objectId);

            ReflectUtil.invokeSetterMethod(object, nameValue, tempObjectValue);

            objectList.add(object);
        }

        baseManager.batchSaveOrUpdate("update", xentity.getModel(), objectList);

        return new ModelAndView("url");
    }


}


