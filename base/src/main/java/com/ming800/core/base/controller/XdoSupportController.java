package com.ming800.core.base.controller;

import com.ming800.core.base.service.XdoManager;
import com.ming800.core.base.service.XdoSupportManager;
import com.ming800.core.does.model.*;
import com.ming800.core.does.service.DoManager;
import com.ming800.core.does.service.impl.DoManagerImpl;
import com.ming800.core.does.model.Xentity;
import com.ming800.core.does.model.Module;
import com.ming800.core.does.service.ModuleManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

/**
 * Created with IntelliJ IDEA.
 * User: ming
 * Date: 12-11-5
 * Time: 下午3:24
 * To change this template use File | Settings | File Templates.
 */
@Controller
@RequestMapping("/xdos")
public class XdoSupportController {

    @Autowired
    private ModuleManager moduleManager;

    @Autowired
    private DoManager doManager;

    @Autowired
    private XdoManager xdoManager;

    @Autowired
    private XdoSupportManager xdoSupportManager;


    /*页面右下角   查看配置文件*/
    @RequestMapping("/xmd.do")
    public ModelAndView xmd(HttpServletRequest request, ModelMap modelMap) throws Exception {

        Map<String, Do> tempDoMap = new HashMap<>();
        String queryModel = request.getParameter("queryModel");
        if (queryModel != null && !queryModel.equals("")) {
            modelMap.put("queryModel", queryModel);
            tempDoMap.put(queryModel, DoManagerImpl.getQueryModelMap().get(queryModel));
        } else {
            tempDoMap = DoManagerImpl.getQueryModelMap();
        }
        modelMap.put("tempDoMap", tempDoMap);
        String url = "/core/does/doList";

//        String em = request.getParameter("em");
        String qm = request.getParameter("qm");
        if (qm != null && !"".equals(qm)) {
            Do tempDo = tempDoMap.get(qm);
            modelMap.put("tempDo", doManager.getDoByQueryModel(qm));
            url = "/core/does/doView";

            String query = request.getParameter("query");
            if (query != null && !query.equals("")) {
                modelMap.put("tempDoQuery", tempDo.getDoQueryByName(query));
                url = "/core/does/queryView";
            }
        }

        return new ModelAndView(url);
    }


    /*模块设置 */
    @RequestMapping("/xme.do")
    public ModelAndView xme(HttpServletRequest request, ModelMap modelMap) throws Exception {

        String url;
        String type = request.getParameter("type");
        modelMap.put("type", type);

        String mname = request.getParameter("mname");
        String ename = request.getParameter("ename");
        String fname = request.getParameter("fname");
        if (mname != null && !mname.equals("")) {
            modelMap.put("module", moduleManager.fetchModule(mname));
            url = "/core/p/moduleView";
        } else if (ename != null && !ename.equals("")) {
            Xentity xentity = moduleManager.fetchXentity(ename);
            modelMap.put("xentity", xentity);
            if (fname != null && !fname.equals("")) {
                modelMap.put("field", xentity.getFieldMap().get(fname));
                url = "/core/p/fieldView";
            } else {
                url = "/core/p/xentityView";
            }

        } else {
            Map<String, Module> moduleMap = moduleManager.fetchModuleMap();

//            LinkedHashMap<String, Module> tempModuleMap = new LinkedHashMap<>();
/*
            LinkedList<Module> moduleLinkedList = new LinkedList<>();
            //Version version = versionManager.fetchVersion();
            for (String moduleName : version.getModuleList()) {
//                tempModuleMap.put(moduleName, moduleMap.get(moduleName));
                moduleLinkedList.add(moduleMap.get(moduleName));
            }
            modelMap.put("moduleList", moduleLinkedList);
            modelMap.put("entityList", version.getEntityList());
*/


            /*List<Map.Entry<String, Module>> mappingList = new ArrayList<Map.Entry<String, Module>>(moduleMap.entrySet());
            Collections.sort(mappingList, new Comparator<Map.Entry<String, Module>>() {
                public int compare(Map.Entry<String, Module> mapping1, Map.Entry<String, Module> mapping2) {
                    return mapping1.getValue().getPackagePath().compareTo(mapping2.getValue().getPackagePath());
                }
            });
            modelMap.put("moduleMap", mappingList);*/


            url = "/core/p/moduleList";
        }


        return new ModelAndView(url);
    }

/*

    */
/*通用页面*//*

    @RequestMapping("/xlistPage.do")
    @ResponseBody
    public String xlistPage(EasyuiDataGrid easyuiDataGrid, HttpServletRequest request) throws Exception {

        String qm = request.getParameter("qm");
        String conditions = request.getParameter("conditions");

        if (easyuiDataGrid.getSort() != null) {
            if (conditions.contains("asc") || conditions.contains("desc")) {
                conditions = conditions.substring(0, conditions.lastIndexOf(";"));
            }
            conditions += ";" + easyuiDataGrid.getOrder() + ":" + easyuiDataGrid.getSort();
        }

        String[] qms = qm.split("_");

        Do tempDo = doManager.getDoByQueryModel(qms[0]);
        DoQuery tempDoQuery = tempDo.getDoQueryByName(qms[1]);
        Page tempPage = tempDo.getPageList().get(0);
        String doResultId = request.getParameter("doResultId");
        if (doResultId != null && !doResultId.equals("")) {
            List<Page> tempPageList = (List<Page>) xdoManager.list("listPageByDoResult_default", "doResult.id:" + doResultId);
            if (tempPageList != null && tempPageList.size() > 0) {
                tempPage = tempPageList.get(0);
            }
        }

        PageEntity pageEntity = new PageEntity();
        pageEntity.setIndex(easyuiDataGrid.getPage());
        pageEntity.setSize(easyuiDataGrid.getRows());

//      返回列表
        if (tempDo.getResult().equals("xpage")) {
            xdoSupportManager.generateTempPageConditions(request.getRequestURI(), request.getParameterMap(), pageEntity.getIndex() + "", pageEntity.getSize() + "");
        }

        return xdoManager.generateResultListPage(qms[0], tempDo, tempDoQuery, tempPage, conditions, pageEntity);
    }
*/



}


