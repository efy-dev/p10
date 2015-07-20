package com.ming800.core.develop.controller;

import com.ming800.core.develop.model.CheckFieldBean;
import com.ming800.core.does.model.*;
//import com.ming800.core.does.service.TypeXmlManager;
import com.ming800.core.does.service.ModuleManager;
import com.ming800.core.base.util.ReflectUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.lang.reflect.Field;
import java.util.*;

/**
 * Created by IntelliJ IDEA.
 * User: lxh
 * Date: 2010-1-14
 * Time: 21:37:28
 * To change this template use File | Settings | File Templates.
 */
@Controller
@RequestMapping("/module")
public class ModuleCheckController {

    @Autowired
    private ModuleManager moduleManager;

/*    @Autowired
    private TypeXmlManager typeXmlManager;*/

    @RequestMapping("/checkField")
    public ModelAndView checkField(ModelMap modelMap) throws Exception {


        //Map<String, TypeXml> typeXmlMap = typeXmlManager.fetchTypeXmlMap();


        List<CheckFieldBean> checkFieldBeanList = new ArrayList<>();

        Map<String, Module> moduleMap = moduleManager.fetchModuleMap();

        Set<Map.Entry<String, Module>> moduleSet = moduleMap.entrySet();

        for (Iterator<Map.Entry<String, Module>> it = moduleSet.iterator(); it.hasNext(); ) {
            Map.Entry<String, Module> entry = it.next();
            Module module = entry.getValue();

            for (Xentity xentity : module.getXentityList()) {

                Object tempObject = Class.forName(xentity.getModel()).newInstance();

                int flag = 0;
                String xentityType = xentity.getName();
/*                if (!checkXmlProperty(xentity.getType(), typeXmlMap.get("xentity.type").getTypeXmlList())) {
                    flag = 1;
                    xentityType += "<br/>type=" + xentity.getType() + "异常";
                }*/


                Map<String, Do> tempDoMap = xentity.getDoMap();
                Set<Map.Entry<String, Do>> tempDoSet = tempDoMap.entrySet();
                for (Iterator<Map.Entry<String, Do>> tempDoIt = tempDoSet.iterator(); tempDoIt.hasNext(); ) {
                    Map.Entry<String, Do> tempDoEntry = tempDoIt.next();
                    Do tempDo = tempDoEntry.getValue();

                    String tempDoException = tempDo.getName();

                    int doFlag = 0;
                    String tempDoResult = tempDo.getResult();
                    if (!checkXmlResult(tempDo.getName(), tempDoResult)) {
                        doFlag = 2;
                        tempDoException += "<br/>result=" + tempDoResult + "异常";
                    }

/*                    if (!checkXmlProperty(tempDo.getType(), typeXmlMap.get("do.type").getTypeXmlList())) {
                        doFlag = 3;
                        tempDoException += "<br/>type=" + tempDo.getType() + "异常";
                    }*/

                    if (tempDo.getDoQueryList() != null) {
                        for (DoQuery tempDoQuery : tempDo.getDoQueryList()) {
                            String checkFieldNames = "";
                            if (tempDoQuery.getConditionList() != null) {
                                for (QueryCondition queryCondition : tempDoQuery.getConditionList()) {

                                    String tempFieldName = queryCondition.getName();
                                    if (!tempFieldName.startsWith("t.")) {
                                        if (tempFieldName.indexOf(".") > 0) {
                                            tempFieldName = tempFieldName.split("\\.")[0];
                                        }

                                        /*还原 查询字段中含有2的字段。*/
                                        if (tempFieldName.endsWith("2")) {
                                            tempFieldName = tempFieldName.substring(0, tempFieldName.length() - 1);
                                        }

                                        Field field = ReflectUtil.getDeclaredField(tempObject, tempFieldName);
                                        if (field == null) {
                                        /*字段为空， 则添加到checkFieldNames中*/
                                            checkFieldNames += queryCondition.getLabel() + "(" + queryCondition.getName() + ")" + "<br/>";
                                        } else {

/*                                            if (!checkXmlProperty(queryCondition.getInputType(), typeXmlMap.get("inputType").getTypeXmlList())) {
                                                checkFieldNames += queryCondition.getLabel() + "(inputType:" + queryCondition.getInputType() + ")" + "<br/>";
                                            } else if (!checkXmlProperty(queryCondition.getDataType(), typeXmlMap.get("dataType").getTypeXmlList())) {
                                                checkFieldNames += queryCondition.getLabel() + "(dataType:" + queryCondition.getDataType() + ")" + "<br/>";
                                            }*/

                                        }
                                    }

                                }
                            }

                            if (!checkFieldNames.equals("")) {
                                doFlag = 4;
                                CheckFieldBean checkFieldBean = new CheckFieldBean();
                                checkFieldBean.setModuleName(module.getName());
                                checkFieldBean.setXentityName(xentityType);
                                checkFieldBean.setTempDoName(tempDoException);
                                checkFieldBean.setTempDoQueryName(tempDoQuery.getName());
                                checkFieldBean.setQueryConditionName(checkFieldNames);

                                checkFieldBeanList.add(checkFieldBean);
                            }
                        }
                    }

                    if (doFlag == 2 || doFlag == 3) {
                        CheckFieldBean checkFieldBean = new CheckFieldBean();
                        checkFieldBean.setModuleName(module.getName());
                        checkFieldBean.setXentityName(xentityType);
                        checkFieldBean.setTempDoName(tempDoException);

                        checkFieldBeanList.add(checkFieldBean);
                    }
                }
                if (flag == 1) {
                    CheckFieldBean checkFieldBean = new CheckFieldBean();
                    checkFieldBean.setModuleName(module.getName());
                    checkFieldBean.setXentityName(xentityType);

                    checkFieldBeanList.add(checkFieldBean);
                }
            }
        }

        modelMap.put("checkFieldBeanList", checkFieldBeanList);

        return new ModelAndView("/core/p/checkField");
    }


    private Boolean checkXmlResult(String name, String result) {
        boolean flag = true;

        if (name.startsWith("xreport") || name.startsWith("xchart")
                || name.startsWith("remove") || name.startsWith("batch") || name.startsWith("delete")
                || result.equals("xpage") || result.equals("xpagerelated")
                || result.equals("xviewpage") || result.equals("xformpage")
                || result.contains("redirect:") || result.equals("json")) {

        } else {
            Resource res1 = new ClassPathResource("../springmvc" + result + ".jsp");

            if (!res1.exists()) {
                flag = false;
            }
        }

        return flag;
    }

    private Boolean checkXmlProperty(String xmlProperty, List<TypeXml> typeXmlList) {
        Boolean flag = true;

        if (xmlProperty != null && !xmlProperty.equals("") && typeXmlList != null && typeXmlList.size() > 0) {
            flag = false;
            for (TypeXml typeXml : typeXmlList) {
                if (typeXml.getName().equals(xmlProperty)) {
                    flag = true;
                    break;
                }
            }
        }

        return flag;
    }


    @RequestMapping("/checkBranch")
    public ModelAndView checkBranch(ModelMap modelMap) throws Exception {

        List<CheckFieldBean> checkFieldBeanList = new ArrayList<>();

        Map<String, Module> moduleMap = moduleManager.fetchModuleMap();

        Set<Map.Entry<String, Module>> moduleSet = moduleMap.entrySet();

        for (Iterator<Map.Entry<String, Module>> it = moduleSet.iterator(); it.hasNext(); ) {
            Map.Entry<String, Module> entry = it.next();
            Module module = entry.getValue();

            for (Xentity xentity : module.getXentityList()) {

                Object tempObject = Class.forName(xentity.getModel()).newInstance();

                Map<String, Do> tempDoMap = xentity.getDoMap();
                Set<Map.Entry<String, Do>> tempDoSet = tempDoMap.entrySet();
                for (Iterator<Map.Entry<String, Do>> tempDoIt = tempDoSet.iterator(); tempDoIt.hasNext(); ) {
                    Map.Entry<String, Do> tempDoEntry = tempDoIt.next();
                    Do tempDo = tempDoEntry.getValue();

                    if (tempDo.getDoQueryList() != null) {
                        for (DoQuery tempDoQuery : tempDo.getDoQueryList()) {
                            Boolean flag = false;
//                            String checkFieldNames = "";
                            if (tempDoQuery.getConditionList() != null) {
                                for (QueryCondition queryCondition : tempDoQuery.getConditionList()) {

                                    String tempFieldName = queryCondition.getName();

                                    if (tempFieldName.contains("branch.id") || tempFieldName.contains("teachArea.id")
                                            || tempFieldName.contains("department.id")
                                            || tempFieldName.contains("user.id") || tempFieldName.contains("creator.id")
                                            || tempFieldName.contains("owner.id") || tempFieldName.contains("excutor.id")
                                            || tempFieldName.contains("executeUser.id") || tempFieldName.contains("author.id")) {
                                        flag = true;
                                    }

                                }
                            }

                            if (!flag) {
                                CheckFieldBean checkFieldBean = new CheckFieldBean();
                                checkFieldBean.setModuleName(module.getName());
                                checkFieldBean.setXentityName(xentity.getName());
                                checkFieldBean.setTempDoName(tempDo.getName());
                                checkFieldBean.setTempDoQueryName(tempDoQuery.getName());

                                checkFieldBeanList.add(checkFieldBean);
                            }
                        }
                    }
                }
            }
        }

        modelMap.put("checkFieldBeanList", checkFieldBeanList);

        return new ModelAndView("/core/p/checkField");
    }


}
