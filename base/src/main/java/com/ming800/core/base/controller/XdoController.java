package com.ming800.core.base.controller;

import com.ming800.core.base.service.BaseManager;
import com.ming800.core.base.service.XdoManager;
import com.ming800.core.base.service.XdoSupportManager;
import com.ming800.core.base.util.ReflectUtil;
import com.ming800.core.base.util.SystemValueUtil;
import com.ming800.core.base.util.XDoUtil;
import com.ming800.core.does.model.*;
import com.ming800.core.does.service.DoManager;
import com.ming800.core.does.service.ModuleManager;
import com.ming800.core.taglib.PageEntity;
import com.ming800.core.does.model.PageInfo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartRequest;
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
        String menuId = request.getParameter("menuId");
        if (menuId == null || "".equals(menuId)) {
            menuId = "organmgmt";
        }
        Map map = request.getParameterMap();
        String qm = request.getParameter("qm");
        String resultPage = "";
        request.setAttribute("qm", qm);
        request.setAttribute("menuId", menuId);


        if (qm.startsWith("plist")) {       /*分页*/
            String conditions = request.getParameter("conditions");
            request.setAttribute("conditions", conditions);
            if (qm.split("_").length < 2) {
                throw new Exception("qm:" + qm + "的具体查询部分没有定义即'_'的后半部分没有定义");
            }
            //先找到配置文件里的entity
            Do tempDo = doManager.getDoByQueryModel(qm.split("_")[0]);
            //再从中找到query的信息
            DoQuery tempDoQuery = tempDo.getDoQueryByName(qm.split("_")[1]);
            modelMap.put("tempDo", tempDo);
            modelMap.put("doQueryList", tempDo.getDoQueryList());
            String export = request.getParameter("resultPage");
            if (export != null && !"".equals(export)) {
                resultPage = export;
            } else {
                resultPage = tempDo.getResult();
            }

            /*判断是否自定义了  xpage*/
  /*          List<Page> tempPageList = new ArrayList<>();


            String export = request.getParameter("resultPage");
            Page tempPage = null;
            if (tempPageList != null && tempPageList.size() > 0) {
                tempPage = tempPageList.get(0);
            } else if ((export != null && export.equals("xexcel")) || resultPage.startsWith("xpage")) {
                if (tempDo.getPageList() == null || tempDo.getPageList().size() == 0) {
                    throw new Exception("缺少页面配置,无法导出!");
                }
                tempPage = tempDo.getPageList().get(0);
            }
            modelMap.put("tempPage", tempPage);*/

/*            *//*如果自定义了xpage  而且不是导出， 进入通用页面*//*
            if (export == null && tempPageList != null && tempPageList.size() > 0) {
                resultPage = "xpage";
            }*/

            PageEntity pageEntity = new PageEntity();
            String pageIndex = request.getParameter("pageEntity.index");
            String pageSize = request.getParameter("pageEntity.size");
            if (pageIndex != null) {
                pageEntity.setIndex(Integer.parseInt(pageIndex));
                pageEntity.setSize(Integer.parseInt(pageSize));
            }

/*            *//*导出，  通用， 普通jsp页面*//*
            if (export != null && export.equals("xexcel")) {            //导出
                modelMap.put("objectList", xdoManager.list(tempDo, tempDoQuery, conditions));
//                resultPage = "export_excel_view_list";
                request.setAttribute("modelMap", modelMap);
                resultPage = "forward:/excelExportController/buildExcelDocument.do";*/
/*            } else if (resultPage.startsWith("xpage")) {
                if (conditions != null) {
                    String tempConditions = java.net.URLEncoder.encode(conditions, "utf-8");
                    modelMap.put("tempConditions", tempConditions);
                }

                modelMap.put("pageEntity", pageEntity);
/*                if (resultPage.equals("xpage")) {
                    resultPage = "/core/base/xlistPage";
                } else {
                    modelMap.put("index", request.getParameter("index"));
                    resultPage = "/core/base/relatedPage";
                }*/
/*            } else {*/

            modelMap.put("tabTitle", tempDoQuery.getLabel());
//                resultPage = "/pc/choiceness";
            PageInfo pageInfo = xdoManager.listPage(tempDo, tempDoQuery, conditions, pageEntity);
            modelMap.put("pageInfo", pageInfo);
            modelMap.put("pageEntity", pageInfo.getPageEntity());

//                返回列表
            xdoSupportManager.generateTempPageConditions(request.getRequestURI(), map, pageEntity.getIndex() + "", pageEntity.getSize() + "");
            // xdoSupportManager.generateTempPageConditions(request.getRequestURI(), map, 1 + "", 20 + "");


            if (tempDo.getExecute() != null && !tempDo.getExecute().equals("")) {
                modelMap = xdoSupportManager.execute(tempDo, modelMap, request);
            }


        } else if (qm.startsWith("list")) {           /*不分页*/
            String conditions = request.getParameter("conditions");

            Do tempDo = doManager.getDoByQueryModel(qm.split("_")[0]);
            DoQuery tempDoQuery = tempDo.getDoQueryByName(qm.split("_")[1]);

            modelMap.put("tempDo", tempDo);
            modelMap.put("tabTitle", tempDoQuery.getLabel());
            modelMap.put("doQueryList", tempDo.getDoQueryList());

            modelMap.put("objectList", xdoManager.list(tempDo, tempDoQuery, conditions));
            resultPage = tempDo.getResult();

            if (tempDo.getExecute() != null && !tempDo.getExecute().equals("")) {
                modelMap = xdoSupportManager.execute(tempDo, modelMap, request);
            }

            //String export = request.getParameter("resultPage");
           /* if (export != null && export.equals("xexcel")) {
                if (tempDo.getPageList() == null || tempDo.getPageList().size() == 0) {
                    throw new Exception("缺少页面配置,无法导出!");
                }
                String doResultId = request.getParameter("id");
                List<Page> tempPageList = (List<Page>) xdoManager.list("listPageByDoResult_default", "doResult.id:" + doResultId);
                if (tempPageList != null && tempPageList.size() > 0) {
                    modelMap.addAttribute("tempPage", tempPageList.get(0));
                } else {
                    modelMap.addAttribute("tempPage", tempDo.getPageList().get(0));
                }
//                resultPage = "export_excel_view_list";
                request.setAttribute("modelMap", modelMap);
                //resultPage = "forward:/excelExportController/buildExcelDocument.do";
            }*/


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
/*            if (resultPage.equals("xviewpage") || resultPage.equals("xformpage") || resultPage.equals("relatedviewpage") || resultPage.equals("relatedformpage")) {
                modelMap.put("jsonData", xdoManager.generateResultViewPage(tempDo, id, conditions));
                if (resultPage.equals("xviewpage")) {
                    resultPage = "/core/base/xviewPage";
                } else if (resultPage.equals("xformpage")) {
                    modelMap.put("tempPage", tempDo.getPageList().get(0));
                    resultPage = "/core/base/xformPage";
                } else if (resultPage.equals("relatedviewpage")) {
                    resultPage = "/core/base/relatedviewPage";
                } else if (resultPage.equals("relatedformpage")) {
                    resultPage = "/core/base/relatedformPage";
                }
            } else {*/
            modelMap.put("object", xdoManager.fetchObject(tempDo, id, conditions));
            resultPage = XDoUtil.convertPageUrl(resultPage, modelMap.get("object"));
            // }

            if (tempDo.getExecute() != null && !tempDo.getExecute().equals("")) {
                modelMap = xdoSupportManager.execute(tempDo, modelMap, request);
            }

        } else if (qm.startsWith("remove")) {  //假删
            String id = request.getParameter("id");
            Do tempDo = doManager.getDoByQueryModel(qm);
            modelMap.put("tempDo", tempDo);
            if (tempDo.getExecute() != null && !tempDo.getExecute().equals("")) {
                modelMap = xdoSupportManager.execute(tempDo, modelMap, request);
            }
            resultPage = xdoManager.removeObject(tempDo, id);
        } else if (qm.startsWith("delete")) {  //真删
            String id = request.getParameter("id");
            Do tempDo = doManager.getDoByQueryModel(qm);
            modelMap.put("tempDo", tempDo);
            if (tempDo.getExecute() != null && !tempDo.getExecute().equals("")) {
                modelMap = xdoSupportManager.execute(tempDo, modelMap, request);
            }
            resultPage = xdoManager.deleteObject(tempDo, id);
        } else if (qm.startsWith("saveOrUpdate")) {
            Do tempDo = doManager.getDoByQueryModel(qm);

            tempDo.getPageList();
            Object object = null;
            if (tempDo.getExecute() != null && !tempDo.getExecute().equals("")) {
                modelMap.put("tempDo", tempDo);
                modelMap = xdoSupportManager.execute(tempDo, modelMap, request);

                object = modelMap.get("object");
                baseManager.saveOrUpdate(object.getClass().getName(), object);
            } else {
                object = xdoManager.saveOrUpdateObject(tempDo, request);
                modelMap.put("object", object);
            }

            String tempResultPage = request.getParameter("resultPage");

            if (tempResultPage != null && !tempResultPage.equals("")) {
                resultPage = XDoUtil.convertPageUrl(tempResultPage, object);
            } else {
                resultPage = XDoUtil.convertPageUrl(tempDo.getResult(), object);
            }
            //在使用saveOrUpdate时，若do的result是jsp视图时，会导致页面无法显示
            /*if(resultPage.contains("?")){
                resultPage += "&mrb=success";
            }else{
                resultPage += "?mrb=success";
            }*/


        }

        return new ModelAndView(resultPage);
    }

    @RequestMapping({"/xmi.do"})
    public String xmi(HttpServletRequest request) {
        return "forward:/basic/xm.do?qm=" + request.getParameter("qm") + "&conditions=" + request.getParameter("conditions");
    }


    @RequestMapping("/xmm.do")   //多附件的情况
    public ModelAndView xmm(HttpServletRequest request, MultipartRequest multipartRequest, ModelMap modelMap) throws Exception {

//        String em = request.getParameter("em");
        String qm = request.getParameter("qm");
        Do tempDo = doManager.getDoByQueryModel(qm);

        modelMap = xdoSupportManager.executeMultipart(tempDo, modelMap, request, multipartRequest);
        Object object = modelMap.get("object");

/*配置文件*/

        if (tempDo.getPageList() != null && tempDo.getPageList().size() > 0) {
            Page tempPage = tempDo.getPageList().get(0);
            for (PageField pageField : tempPage.getFieldList()) {
                String propertyValue = pageField.getValue();
                Object paramObject = SystemValueUtil.getValue(propertyValue, "object");
                if (pageField.getDataType().equals("int")) {
                    paramObject = Integer.parseInt(paramObject.toString());
                } else if (pageField.getDataType().startsWith("boolean")) {
                    paramObject = Boolean.valueOf(paramObject.toString());
                }

                if (ReflectUtil.invokeGetterMethod(object, pageField.getName()) == null) {
                    ReflectUtil.invokeSetterMethod(object, pageField.getName(), paramObject);
                }
            }
        }

        baseManager.saveOrUpdate(modelMap.get("object").getClass().getName(), object);

        String tempResultPage = request.getParameter("resultPage");
        if (tempResultPage != null && !tempResultPage.equals("")) {
            tempResultPage = XDoUtil.convertPageUrl(tempResultPage, object);
        } else {
            tempResultPage = XDoUtil.convertPageUrl(tempDo.getResult(), object);
        }

        return new ModelAndView(tempResultPage);
    }


    /*返回json*/
    @RequestMapping("/xmj.do")
    @ResponseBody
    public Object xmj(HttpServletRequest request) throws Exception {

//        String em = request.getParameter("em");
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

            //return object;
            return true;
        } else if (qm.startsWith("statusType")) {
            String fieldName = request.getParameter("fieldName");

            return moduleManager.listStatusTypeItem(fieldName);
        }else if (qm.startsWith("plist")) {       /*分页*/
            ModelMap modelMap = new ModelMap();
            String conditions = request.getParameter("conditions");
            request.setAttribute("conditions", conditions);

            Do tempDo = doManager.getDoByQueryModel(qm.split("_")[0]);
            DoQuery tempDoQuery = tempDo.getDoQueryByName(qm.split("_")[1]);

            PageEntity pageEntity = new PageEntity();
            String pageIndex = request.getParameter("pageEntity.index");
            String pageSize = request.getParameter("pageEntity.size");
            if (pageIndex != null) {
                pageEntity.setIndex(Integer.parseInt(pageIndex));
                pageEntity.setSize(Integer.parseInt(pageSize));
            }

            PageInfo pageInfo = xdoManager.listPage(tempDo, tempDoQuery, conditions, pageEntity);
            modelMap.put("pageInfo", pageInfo);
            modelMap.put("pageEntity", pageInfo.getPageEntity());

            return xdoManager.listPage(tempDo, tempDoQuery, conditions, pageEntity);


        }
        else {
            return null;
        }
    }

/*

    */
/*配置文件   返回json*//*

    @RequestMapping("/xlist.do")
    @ResponseBody
    public String xlist(HttpServletRequest request) throws Exception {

//        String em = request.getParameter("em");
        String qm = request.getParameter("qm");
        String conditions = request.getParameter("conditions");

        String[] qms = qm.split("_");

        Do tempDo = doManager.getDoByQueryModel(qms[0]);
        DoQuery tempDoQuery = tempDo.getDoQueryByName(qms[1]);
        Page tempPage = tempDo.getPageList().get(0);

        String doResultId = request.getParameter("doResultId");
        if (doResultId != null && !doResultId.equals("")) {
            List<Page> tempPageList = (List<Page>) xdoManager.list("listPageByDoResult_default", "doResult.id:" + doResultId);
            tempPage = tempPageList.get(0);
        }

        return xdoManager.generateResultList(qms[0], tempDo, tempDoQuery, tempPage, conditions);
    }
*/


}


