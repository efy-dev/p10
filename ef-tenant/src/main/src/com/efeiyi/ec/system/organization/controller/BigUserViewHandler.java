//package com.efeiyi.ec.system.organization.controller;
//
//import com.ming800.core.base.model.MethodCache;
//import com.ming800.core.base.service.XdoManager;
//import com.ming800.core.does.model.Do;
//import com.ming800.core.does.model.Page;
//import com.ming800.core.does.service.DoHandler;
//import com.ming800.core.does.service.DoManager;
//import com.ming800.core.util.ApplicationContextUtil;
//import org.springframework.ui.ModelMap;
//
//import javax.servlet.http.HttpServletRequest;
//
///**
// * Created with IntelliJ IDEA.
// * User: Administrator
// * Date: 13-10-25
// * Time: 下午12:30
// * To change this template use File | Settings | File Templates.
// */
//public class BigUserViewHandler implements DoHandler {
//
//    private DoManager doManager = (DoManager) ApplicationContextUtil.getApplicationContext().getBean("doManagerImpl");
//    private XdoManager xdoManager = (XdoManager) ApplicationContextUtil.getApplicationContext().getBean("xdoManagerImpl");
//
//    @Override
//    public ModelMap handle(ModelMap modelMap, HttpServletRequest request) throws Exception {
//
//        Object object = modelMap.get("object");
//
//        Do tempDo = doManager.getDoByQueryModel("viewDefinedUser");
//
//        if (tempDo != null) {
//            Page tempPage = tempDo.getPageList().get(0);
//
//            MethodCache methodCache = new MethodCache();
//            methodCache.init(tempDo, tempPage);
//
//            modelMap.put("jsonData", xdoManager.viewPageJson(tempPage, object, methodCache));
//        }
//
//
//        return modelMap;  //To change body of implemented methods use File | Settings | File Templates.
//    }
//}
