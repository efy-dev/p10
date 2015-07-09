package com.ming800.core.base.controller;

import com.ming800.core.base.service.BaseManager;
import com.ming800.core.base.service.XdoManager;
import com.ming800.core.base.service.XdoSupportManager;
import com.ming800.core.does.model.*;
import com.ming800.core.does.service.DoManager;
import com.ming800.core.does.service.ModuleManager;
import com.ming800.core.taglib.PageEntity;
import com.ming800.core.util.PageInfo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

/**
 * Created with IntelliJ IDEA.
 * User: ming
 * Date: 12-11-5
 * Time: 下午3:24
 * To change this template use File | Settings | File Templates.
 */
@Controller
@RequestMapping("/basic")
public class XdoController {

    @Autowired
    private ModuleManager moduleManager;

    @Autowired
    private DoManager doManager;
    @Autowired
    private XdoManager xdoManager;
    @Autowired
    private BaseManager baseManager;

    @Autowired
    private XdoSupportManager xdoSupportManager;

    @RequestMapping("/xm.do")
    public ModelAndView xm(HttpServletRequest request, ModelMap modelMap) throws Exception {

        
        Map map = request.getParameterMap();
        String qm = request.getParameter("qm");
        String resultPage = "";

        if (qm.startsWith("plist")) {       /*分页*/
            String conditions = request.getParameter("conditions");
            if (qm.split("_").length < 2) {
                throw new Exception("qm:" + qm + "的具体查询部分没有定义即'_'的后半部分没有定义");
            }
            //先找到配置文件里的entity
            Do tempDo = doManager.getDoByQueryModel(qm.split("_")[0]);
            //再从中找到query的信息
            DoQuery tempDoQuery = tempDo.getDoQueryByName(qm.split("_")[1]);
            modelMap.put("tempDo", tempDo);
            modelMap.put("doQueryList", tempDo.getDoQueryList());
            resultPage = tempDo.getResult();

            PageEntity pageEntity = new PageEntity();
            String pageIndex = request.getParameter("pageEntity.index");
            String pageSize = request.getParameter("pageEntity.size");
            if (pageIndex != null) {
                pageEntity.setIndex(Integer.parseInt(pageIndex));
                pageEntity.setSize(Integer.parseInt(pageSize));
            }

                modelMap.put("tabTitle", tempDoQuery.getLabel());
                PageInfo pageInfo = xdoManager.listPage(tempDo, tempDoQuery, conditions, pageEntity);
                modelMap.put("pageInfo", pageInfo);
                modelMap.put("pageEntity", pageInfo.getPageEntity());

//                返回列表
                xdoSupportManager.generateTempPageConditions(request.getRequestURI(), map, pageEntity.getIndex() + "", pageEntity.getSize() + "");

        } else if (qm.startsWith("list")) {           /*不分页*/
            String conditions = request.getParameter("conditions");

            Do tempDo = doManager.getDoByQueryModel(qm.split("_")[0]);
            DoQuery tempDoQuery = tempDo.getDoQueryByName(qm.split("_")[1]);

            modelMap.put("tempDo", tempDo);
            modelMap.put("tabTitle", tempDoQuery.getLabel());
            modelMap.put("doQueryList", tempDo.getDoQueryList());

            modelMap.put("objectList", xdoManager.list(tempDo, tempDoQuery, conditions));
            resultPage = tempDo.getResult();

        } else if (qm.startsWith("view") || qm.startsWith("form")) {
            String id = request.getParameter("id");
            if (qm.startsWith("view") && (id == null || id.equals(""))) {
                throw new Exception("id不能为空");
            }
            String conditions = request.getParameter("conditions");

            String mrb = request.getParameter("mrb");
            if (mrb != null && !mrb.equals("")) {
                modelMap.put("mrb", mrb);
            }
            Do tempDo = doManager.getDoByQueryModel(qm);
            modelMap.put("tempDo", tempDo);

            resultPage = tempDo.getResult();
            modelMap.put("tempPageList", tempDo.getPageList());
            modelMap.put("object", xdoManager.fetchObject(tempDo, id, conditions));
            resultPage = xdoManager.convertPageUrl(resultPage, modelMap.get("object"));
        } else if (qm.startsWith("remove")) {  //假删
            String id = request.getParameter("id");
            Do tempDo = doManager.getDoByQueryModel(qm);
            modelMap.put("tempDo", tempDo);
            resultPage = xdoManager.removeObject(tempDo, id);
        } else if (qm.startsWith("delete")) {  //真删
            String id = request.getParameter("id");
            Do tempDo = doManager.getDoByQueryModel(qm);
            modelMap.put("tempDo", tempDo);
            resultPage = xdoManager.deleteObject(tempDo, id);
        } else if (qm.startsWith("saveOrUpdate")) {
            Do tempDo = doManager.getDoByQueryModel(qm);

            tempDo.getPageList();
            Object object = null;
            object = xdoManager.saveOrUpdateObject(tempDo, request);
            modelMap.put("object", object);
            String tempResultPage = request.getParameter("resultPage");
            if (tempResultPage != null && !tempResultPage.equals("")) {
                resultPage = xdoManager.convertPageUrl(tempResultPage, object);
            } else {
                resultPage = xdoManager.convertPageUrl(tempDo.getResult(), object);
            }
        }

        return new ModelAndView(resultPage);
    }

    /*返回json*/
    @RequestMapping("/xmj.do")
    @ResponseBody
    public Object xmj(HttpServletRequest request) throws Exception {

        String qm = request.getParameter("qm");
        if (qm.startsWith("list")) {
            String conditions = request.getParameter("conditions");
            Do tempDo = doManager.getDoByQueryModel(qm.split("_")[0]);
            DoQuery tempDoQuery = tempDo.getDoQueryByName(qm.split("_")[1]);

            return xdoManager.list(tempDo, tempDoQuery, conditions);
        } else if (qm.startsWith("view")) {
            String id = request.getParameter("id");  //应该是id
            Do tempDo = doManager.getDoByQueryModel(qm);
            return xdoManager.fetchObject(tempDo, id, null);
        } else if (qm.startsWith("remove")) {
            String id = request.getParameter("id");
            Do tempDo = doManager.getDoByQueryModel(qm);
            ModelMap modelMap = new ModelMap();
            modelMap.put("tempDo", tempDo);
            if (tempDo.getExecute() != null && !tempDo.getExecute().equals("")) {
                modelMap = xdoSupportManager.execute(tempDo, modelMap, request);
                String message = (String) modelMap.get("message");
                if (message != null) {
                    return message;
                }
            }
            xdoManager.removeObject(tempDo, id);
            return true;
        } else if (qm.startsWith("delete")) {
            String id = request.getParameter("id");
            Do tempDo = doManager.getDoByQueryModel(qm);
            ModelMap modelMap = new ModelMap();
            modelMap.put("tempDo", tempDo);
            if (tempDo.getExecute() != null && !tempDo.getExecute().equals("")) {
                modelMap = xdoSupportManager.execute(tempDo, modelMap, request);
                String message = (String) modelMap.get("message");
                if (message != null) {
                    return message;
                }
            }
            xdoManager.deleteObject(tempDo, id);
            return true;
        } else if (qm.startsWith("batch")) {
            String ids = request.getParameter("checkedObjectIds");
            Do tempDo = doManager.getDoByQueryModel(qm);
            ModelMap modelMap = new ModelMap();
            modelMap.put("tempDo", tempDo);
            if (tempDo.getExecute() != null && !tempDo.getExecute().equals("")) {
                modelMap = xdoSupportManager.execute(tempDo, modelMap, request);
                String message = (String) modelMap.get("message");
                if (message != null) {
                    return message;
                }
            }
            xdoManager.batchUpdate(tempDo, ids);
            return true;
        } else if (qm.startsWith("saveOrUpdate")) {
            ModelMap modelMap = new ModelMap();
            Do tempDo = doManager.getDoByQueryModel(qm);
            Object object = null;
            if (tempDo.getExecute() != null && !tempDo.getExecute().equals("")) {
                modelMap.put("tempDo", tempDo);
                modelMap = xdoSupportManager.execute(tempDo, modelMap, request);

                object = modelMap.get("object");
                baseManager.saveOrUpdate(object.getClass().getName(), object);
            } else {
                xdoManager.saveOrUpdateObject(tempDo, request);
            }
            return true;
        } else if (qm.startsWith("statusType")) {
            String fieldName = request.getParameter("fieldName");

            return moduleManager.listStatusTypeItem(fieldName);
        }  else {
            return null;
        }
    }
}


