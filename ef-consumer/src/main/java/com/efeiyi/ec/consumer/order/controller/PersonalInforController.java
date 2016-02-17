package com.efeiyi.ec.consumer.order.controller;

import com.efeiyi.ec.balance.model.BalanceRecord;
import com.efeiyi.ec.consumer.organization.util.AuthorizationUtil;
import com.efeiyi.ec.organization.model.BigUser;
import com.efeiyi.ec.organization.model.Consumer;
import com.efeiyi.ec.organization.model.MyUser;

import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.does.model.XSaveOrUpdate;
import com.ming800.core.p.service.AliOssUploadManager;
import com.ming800.core.util.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2015/8/19.
 */
@Controller
@RequestMapping("/myEfeiyi")
public class PersonalInforController {
    @Autowired
    private BaseManager baseManager;
    @Autowired
    private AliOssUploadManager aliOssUploadManager;

    @RequestMapping({"updatePersonalInfo.do"})
    public String updatePersonalInfo(HttpServletRequest request) throws Exception {
        XSaveOrUpdate xSaveOrUpdate = new XSaveOrUpdate("saveOrUpdateInfo", request);
        baseManager.saveOrUpdate(xSaveOrUpdate);
        return "redirect:/myEfeiyi/personalInfo.do";
    }

    /*
       我的收藏
    */
    @RequestMapping({"listProductFavorite.do"})
    public String listProductFavorite(HttpServletRequest request, Model model) throws Exception {
        MyUser currentUser = AuthorizationUtil.getMyUser();
        List<Object> list = null;
        if (currentUser.getId() != null) {
            XQuery xQuery = new XQuery("plistProductFavorite_default", request);
            list = baseManager.listObject(xQuery);
        }
        model.addAttribute("productFavoriteList", list);
        return "/purchaseOrder/productCollectionList";

    }

    @RequestMapping({"personalInfo.do"})
    public String getPersonalInfo(ModelMap modelMap) {
        String id = AuthorizationUtil.getMyUser().getId();
        BigUser user = (BigUser) baseManager.getObject(BigUser.class.getName(), id);
        modelMap.addAttribute("user", user);
        return "/purchaseOrder/personalInfoView";
    }

    @RequestMapping({"personalInfoOfMobile.do"})
    public String getPersonalInfoOfMobile(ModelMap modelMap) {
        String id = AuthorizationUtil.getMyUser().getId();
        BigUser user = (BigUser) baseManager.getObject(BigUser.class.getName(), id);
        modelMap.addAttribute("user", user);
        return "/purchaseOrder/updateUser";
    }

    /**
     * 密码修改
     *
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping({"updatePassword.do"})
    @ResponseBody
    public String updatePassword(HttpServletRequest request) throws Exception {
        String contion = request.getParameter("pwd");
        String password = StringUtil.encodePassword(contion, "SHA");
        XSaveOrUpdate xSaveOrUpdate = new XSaveOrUpdate("saveOrUpdatePassword", request);
        xSaveOrUpdate.getParamMap().put("password", password);
        baseManager.saveOrUpdate(xSaveOrUpdate);
        HttpSession session = request.getSession();
        if (session != null) {
            session.invalidate();
        }
        MyUser bigUser = AuthorizationUtil.getMyUser();
        System.out.println(bigUser.isAccountExpired());
        return password;

    }

    @RequestMapping({"getPassword.do"})
    public String getPassword(HttpServletRequest request, ModelMap modelMap) {
        String id = AuthorizationUtil.getMyUser().getId();
        BigUser user = (BigUser) baseManager.getObject(BigUser.class.getName(), id);
        modelMap.addAttribute("user", user);
        return "/purchaseOrder/securityAccount";
    }

    /**
     * 检查原有密码
     *
     * @param request
     * @return
     */
    @RequestMapping({"checkPassword.do"})
    @ResponseBody
    public boolean checkPassword(HttpServletRequest request) {
        String mm = request.getParameter("password");
        String password = StringUtil.encodePassword(mm, "SHA");
        String id = AuthorizationUtil.getMyUser().getId();
        BigUser user = (BigUser) baseManager.getObject(BigUser.class.getName(), id);
        if (password.equals(user.getPassword())) {
            return true;
        } else {
            return false;
        }
    }


    @RequestMapping("/uploadIcon.do")
    @ResponseBody
    public String uploadProductImg(HttpServletRequest request) throws Exception {
        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
        Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
        String identify = sdf.format(new Date());
        String url = "";
        for (Map.Entry<String, MultipartFile> entry : fileMap.entrySet()) {
            //上传文件
            MultipartFile mf = entry.getValue();
            String fileName = mf.getOriginalFilename();//获取原文件名
            String hz = fileName.substring(fileName.indexOf("."), fileName.length());

            url = "user/" + fileName.substring(0, fileName.indexOf(hz)) + identify + hz;
            try {
                aliOssUploadManager.uploadFile(mf, "ec-efeiyi", url);
                XSaveOrUpdate xSaveOrUpdate = new XSaveOrUpdate("saveOrUpdateInfo", request);
                xSaveOrUpdate.getParamMap().put("pictureUrl", url);
                baseManager.saveOrUpdate(xSaveOrUpdate);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return url;
    }

    /**
     * 用于模板取到用户头像
     *
     * @return
     */
    @RequestMapping("/getUserAvatar.do")
    @ResponseBody
    public String getUserAvatar() {
        String id = AuthorizationUtil.getMyUser().getId();
        BigUser user = (BigUser) baseManager.getObject(BigUser.class.getName(), id);
        String avatar = user.getPictureUrl();
        if (avatar == null || "".equals(avatar)) {
            avatar = "false";
        }
        return avatar;
    }

    /**
     * 用于个人中心菜单获取账户余额
     *
     * @return
     */
    @RequestMapping("/getBalance.do")
    @ResponseBody
    public String getBalance() {
        String consumerId = AuthorizationUtil.getMyUser().getId();
        Consumer consumer = (Consumer) baseManager.getObject(Consumer.class.getName(), consumerId);
        if (consumer.getBalance() != null) {
            String balance = consumer.getBalance().toString();
            return balance;
        } else {
            return "0.00";
        }
    }


    /**
     * 获取余额明细
     *
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/getBalanceDetailsList.do")
    public String getBalanceDetailList(HttpServletRequest request, Model model) throws Exception {
        String consumerId = AuthorizationUtil.getMyUser().getId();
        Consumer consumer = (Consumer) baseManager.getObject(Consumer.class.getName(), consumerId);
        if (consumer.getBalance() == null) {
            model.addAttribute("balance", "0.00");
        } else {
            model.addAttribute("balance", consumer.getBalance());
        }
        XQuery xQuery = new XQuery("listBalanceRecord_default", request);
        xQuery.put("consumer_id", consumerId);
        List balanceDetailList = baseManager.listObject(xQuery);
        model.addAttribute("balanceDetailList", balanceDetailList);
        return "/purchaseOrder/balanceDetailList";

    }

}
