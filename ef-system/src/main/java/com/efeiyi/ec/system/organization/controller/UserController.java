//package com.efeiyi.ec.system.organization.controller;
//
//import com.efeiyi.ec.system.organization.OrganizationConst;
//import com.efeiyi.ec.system.organization.service.UserManager;
//import com.efeiyi.ec.system.organization.util.AuthorizationUtil;
//import com.efeiyi.ec.organization.model.BigUser;
//import com.ming800.core.base.controller.BaseController;
//import com.ming800.core.util.StringUtil;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.ModelMap;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.ResponseBody;
//import org.springframework.web.servlet.ModelAndView;
//
//import javax.servlet.http.HttpServletRequest;
//import java.util.LinkedHashMap;
//import java.util.List;
//
///**
// * Created by IntelliJ IDEA.
// * User: ming
// * Date: 12-10-15
// * Time: 下午4:56
// * To change this template use File | Settings | File Templates.
// */
//
//@Controller
//@RequestMapping("/user")
//public class UserController extends BaseController {
//
//    @Autowired
//    private UserManager userManager;
//
//
//    /**
//     * 建立用户
//     *
//     * @return
//     * @throws Exception
//     */
//    @RequestMapping(value = "/formUser.do")
//    public ModelAndView formUser(BigUser bigUser) throws Exception {
//        ModelMap modelMap = new ModelMap();
//        if (bigUser != null && bigUser.getId() != null) {//修改
//            bigUser = (BigUser) baseManager.getObject(BigUser.class.getName(), bigUser.getId());
//            modelMap.put("bigUser", bigUser);
//        }
//        return new ModelAndView("organization/user/bigUserForm", modelMap);
//    }
//
//    /**
//     * 建立教师类型的用户
//     *
//     * @param bigUser
//     * @return
//     * @throws Exception
//     */
//    @RequestMapping(value = "/saveOrUpdateUser.do")
//    public ModelAndView saveOrUpdateUser(HttpServletRequest request, BigUser bigUser, ModelMap modelMap) throws Exception {
//        if (bigUser.getId() == null) {
//
//            /*bigUser.setRoleType(OrganizationConst.ROLE_THE_TYPE_AGENT);*/
//        }
//
//        if ("true".equals(request.getParameter("isUser"))) {       //是否作为登录用户
//            bigUser.setTheStatus(OrganizationConst.USER_THE_STATUS_USERANDSTAFF);
//            if (bigUser.getPassword() != null && !bigUser.getPassword().equals("")) {
//                bigUser.setPassword(StringUtil.encodePassword(bigUser.getPassword(), "SHA"));
//                bigUser.setAccountExpired(false);
//                bigUser.setAccountLocked(false);
//                bigUser.setCredentialsExpired(false);
//            }
//        } else {
//            bigUser.setTheStatus(OrganizationConst.USER_THE_STATUS_STAFF);
//        }
//
//        String isEnabled = request.getParameter("isEnabled"); //是否启用登录账号
//        if (isEnabled != null) {
//            if (isEnabled.equals("false")) {
//                bigUser.setEnabled(false);
//            } else {
//                bigUser.setEnabled(true);
//            }
//        }
//
////        bigUser.setPinyin(PinYinUtil.parsePinYin(request.getParameter("name")));
//        bigUser.setWorkStatus(1);
//
////        TeachArea teachArea = teachAreaManager.getTeachArea(bigUser.getDepartment().getId());
////        bigUser.setTeachArea(super.getTeachAreaByDept(teachArea));
//        bigUser = (BigUser) manulSaveOrUpdate(bigUser);
//        baseManager.saveOrUpdate(BigUser.class.getName(), bigUser);
//
//
//        /*String queryStrSel = "select t from TeacherCourse t where t.user.id=:userId ";
//        LinkedHashMap<String, Object> paramMapSel = new LinkedHashMap<>();
//        paramMapSel.put("userId", bigUser.getId());
//        List<TeacherCourse> teacherCourseList = baseManager.listObject(queryStrSel, paramMapSel);
//        if (teacherCourseList != null && teacherCourseList.size() > 0) {
//            StringBuilder ids = new StringBuilder();
//            for (TeacherCourse teacherCourse : teacherCourseList) {
//                ids.append(teacherCourse.getId()).append(",");
//            }
//            baseManager.batchDelete(TeacherCourse.class.getName(), ids.toString().substring(0, ids.length() - 1).split(","));
//        }
//
//        String courseIds = request.getParameter("courseIds");
//        if (courseIds != null && !courseIds.equals("")) {
//            for (String courseId : courseIds.split(",")) {
//                TeacherCourse teacherCourse = new TeacherCourse();
//                teacherCourse.setCourse((SmallCourse) baseManager.getObject(SmallCourse.class.getName(), courseId));
//                User user = new User();
//                user.setId(bigUser.getId());
//                teacherCourse.setUser(user);
//                baseManager.saveOrUpdate(TeacherCourse.class.getName(), teacherCourse);
//            }
//        }*/
//
//
////        String theType = request.getParameter("qm");
//
//        String url = "redirect:/basic/xm.do?qm=viewBigUser&id=" + bigUser.getId();
//        /*if (theType != null && "bigUser".equals(theType)) {
//            url = "redirect:/basic/xm.do?qm=plistHuman_default&mrb=success";
//        } else if (theType != null && theType.equals("teacher")) {
//            url = "redirect:/basic/xm.do?qm=plistHumanTeacher_default&mrb=success";
//        } else {
//            url = "redirect:/basic/xm.do?qm=plistBigUser_default&mrb=success";
//        }*/
//
//        return new ModelAndView(url);
//    }
//
//    @RequestMapping(value = "/listUserByJson.do")
//    @ResponseBody
//    public List listUserByJson(HttpServletRequest request) {
//        Integer[] theStatuses = null;
//        Integer theStatus = Integer.parseInt(request.getParameter("theStatus"));
//        if (theStatus.intValue() == OrganizationConst.USER_THE_STATUS_USERANDSTAFF) {
//            theStatuses = new Integer[]{OrganizationConst.USER_THE_STATUS_USERANDSTAFF, OrganizationConst.USER_THE_STATUS_STAFF, OrganizationConst.USER_THE_STATUS_USER};
//        } else if (theStatus.intValue() == OrganizationConst.USER_THE_STATUS_STAFF) {
//            theStatuses = new Integer[]{OrganizationConst.USER_THE_STATUS_USERANDSTAFF, OrganizationConst.USER_THE_STATUS_STAFF};
//        } else if (theStatus.intValue() == OrganizationConst.USER_THE_STATUS_USER) {
//            theStatuses = new Integer[]{OrganizationConst.USER_THE_STATUS_USERANDSTAFF, OrganizationConst.USER_THE_STATUS_USER};
//        }
//
//        String teachAreaId = request.getParameter("teachAreaId");
//        String queryStr = "from BigUser bu where bu.theStatus in(:theStatuses) and bu.department.id = :teachAreaId";
//        LinkedHashMap<String, Object> queryParamMap = new LinkedHashMap<>();
//        queryParamMap.put("theStatuses", theStatuses);
//        queryParamMap.put("teachAreaId", teachAreaId);
//        return baseManager.listObject(queryStr, queryParamMap);
//    }
//
//    @RequestMapping(value = "/searchUserByJson.do")
//    @ResponseBody
//    public List searchUserByJson(HttpServletRequest request) {
//        Integer[] theStatuses = null;
//        Integer theStatus = Integer.parseInt(request.getParameter("theStatus"));
//        if (theStatus.intValue() == OrganizationConst.USER_THE_STATUS_USERANDSTAFF) {
//            theStatuses = new Integer[]{OrganizationConst.USER_THE_STATUS_USERANDSTAFF, OrganizationConst.USER_THE_STATUS_STAFF, OrganizationConst.USER_THE_STATUS_USER};
//        } else if (theStatus.intValue() == OrganizationConst.USER_THE_STATUS_STAFF) {
//            theStatuses = new Integer[]{OrganizationConst.USER_THE_STATUS_USERANDSTAFF, OrganizationConst.USER_THE_STATUS_STAFF};
//        } else if (theStatus.intValue() == OrganizationConst.USER_THE_STATUS_USER) {
//            theStatuses = new Integer[]{OrganizationConst.USER_THE_STATUS_USERANDSTAFF, OrganizationConst.USER_THE_STATUS_USER};
//        }
//        String searchName = request.getParameter("searchName");
//        String queryStr = "from User u where u.theStatus in(:theStatuses) and u.name like :searchName ";
//        LinkedHashMap<String, Object> queryParamMap = new LinkedHashMap<>();
//        queryParamMap.put("theStatuses", theStatuses);
//        queryParamMap.put("searchName", "%" + searchName + "%");
//
//        return baseManager.listObject(queryStr, queryParamMap);
//    }
//
//    /**
//     * 检查旧密码输入是否正确 ,比较时需要进行加密处理
//     *
//     * @param oldPassword oldPassword
//     * @return boolean
//     */
//    @RequestMapping("/checkOldPassword.do")
//    @ResponseBody
//    public Boolean checkOldPassword(String oldPassword) {
//        BigUser bigUser = (BigUser) baseManager.getObject(BigUser.class.getName(), AuthorizationUtil.getMyUser().getId());
//        return bigUser.getPassword().equals(StringUtil.encodePassword(oldPassword, "SHA"));
//    }
//
//    /**
//     * 修改登录密码
//     *
//     * @param request password
//     * @return 修改成功跳转至view页面进行显示
//     */
//    @RequestMapping("/setBigUserPassWord")
//    public ModelAndView setBigUserPassWord(HttpServletRequest request, ModelMap modelMap) {
//        BigUser bigUser = null;
//        String url = "";
//        if (request.getParameter("bigUserId") != null && !"".equals(request.getParameter("bigUserId"))) {
//            bigUser = (BigUser) baseManager.getObject(BigUser.class.getName(), request.getParameter("bigUserId"));
//
//            /*String branchId = request.getParameter("branchId");
//            String currentBranchId = AuthorizationUtil.getMyBranch().getId();
//            if (branchId.equals(currentBranchId)) {
//                url = "redirect:/basic/xm.do?qm=plistBigUser_default";
//            } else {
//                url = "redirect:/basic/xm.do?qm=plistBigUserByBranch_default&conditions=branch.id:" + branchId;
//            }*/
//
//        } else {
//            bigUser = (BigUser) baseManager.getObject(BigUser.class.getName(), AuthorizationUtil.getMyUser().getId());
////            url = "/organization/user/userContactWaySetSuccessView";
//            modelMap.put("object", bigUser);
//        }
//
//        bigUser.setPassword(StringUtil.encodePassword(request.getParameter("password"), "SHA"));
//        baseManager.saveOrUpdate(BigUser.class.getName(), bigUser);
//
//        url = "redirect:/basic/xm.do?qm=viewBigUser&id=" + bigUser.getId();
//
//        return new ModelAndView(url, modelMap);
//    }
//
//    /**
//     * 修改联系方式
//     *
//     * @param request phone,email
//     * @return 修改成功跳转至view页面进行显示
//     */
//    @RequestMapping("/setUpUserContactWay.do")
//    public ModelAndView setUpUserContact(HttpServletRequest request) {
//        ModelMap modelMap = new ModelMap();
//        BigUser bigUser = (BigUser) baseManager.getObject(BigUser.class.getName(), AuthorizationUtil.getMyUser().getId());
//        bigUser.setPhone(request.getParameter("phone"));
//        bigUser.setEmail(request.getParameter("email"));
//        baseManager.saveOrUpdate(BigUser.class.getName(), bigUser);
//        modelMap.put("object", bigUser);
//        return new ModelAndView("/organization/user/userContactWaySetSuccessView", modelMap);
//    }
//
//}
