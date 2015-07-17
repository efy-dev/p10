//package com.efeiyi.ec.system.organization.controller;
//
//
//import com.efeiyi.ec.organization.model.BigUser;
//import com.ming800.core.base.model.MethodCache;
//import com.ming800.core.base.service.XdoManager;
//import com.ming800.core.does.model.Do;
//import com.ming800.core.does.model.Page;
//import com.ming800.core.does.service.DoHandler;
//import com.ming800.core.does.service.DoManager;
//import com.ming800.core.util.ApplicationContextUtil;
//import com.ming800.core.util.MD5Encode;
//import org.springframework.ui.ModelMap;
//
//import javax.servlet.http.HttpServletRequest;
//import java.util.List;
//
///**
// * Created by IntelliJ IDEA.
// * User: ming
// * Date: 12-10-30
// * Time: 上午10:30
// * To change this template use File | Settings | File Templates.
// */
//
//public class BigUserFormHandler implements DoHandler {
//
//    private XdoManager xdoManager = (XdoManager) ApplicationContextUtil.getApplicationContext().getBean("xdoManagerImpl");
//    private DoManager doManager = (DoManager) ApplicationContextUtil.getApplicationContext().getBean("doManagerImpl");
//
//    @Override
//    public ModelMap handle(ModelMap modelMap, HttpServletRequest request) throws Exception {
//
//        String id = request.getParameter("id");
//        if (!userLimit() && id == null) {
//            throw new Exception("用户数量超出最大限制！");
//        }
//        Object object = modelMap.get("object");
//
//        Do tempDo = doManager.getDoByQueryModel("formDefinedUser");
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
//        return modelMap;  //To change body of implemented methods use File | Settings | File Templates.
//    }
//
//    private Boolean userLimit() throws Exception {
//        Boolean flag = true;
//
//        String license = "";
//
//
//        if (license != null && license.contains(";validate")) {
//            String tempLicense = license.substring(0, license.indexOf(";validate:"));
//            MD5Encode md5Encode = new MD5Encode();
//            String mdeStr = md5Encode.MD5Encode(tempLicense + ";ming800");
//
//            String tempValidate = license.substring(license.indexOf(";validate:") + 10, license.length());
//
//            if (tempValidate != null && !tempValidate.equals("") && !tempValidate.equals(mdeStr)) {
//                throw new Exception("许可被修改!");
//            }
//        }
//
//
//        if (license != null && !license.equals("")) {
//            String[] licenses = license.split(";");
//            Integer userCount = null;
//            for (String str : licenses) {
//                String[] strArray = str.split(":");
//                if (strArray[0].equals("userLimit")) {
//                    userCount = Integer.parseInt(strArray[1]);
//                    break;
//                }
//            }
//
//            List<BigUser> bigUserList = (List<BigUser>) xdoManager.list("plistBigUser_default", null);
//            if (userCount != null && userCount <= bigUserList.size()) {
//                flag = false;
//            }
//        }
//
//        return flag;
//    }
//}
