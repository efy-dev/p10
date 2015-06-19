package com.efeiyi.ec.system.organization.controller;

import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.service.DoHandler;
import com.ming800.core.util.ApplicationContextUtil;
import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by IntelliJ IDEA.
 * User: ming
 * Date: 12-10-30
 * Time: 上午10:30
 * To change this template use File | Settings | File Templates.
 */

public class BigUserHandler implements DoHandler {

    private BaseManager baseManager = (BaseManager) ApplicationContextUtil.getApplicationContext().getBean("baseManagerImpl");

    @Override
    public ModelMap handle(ModelMap modelMap, HttpServletRequest request) throws Exception {
        String userId = request.getParameter("id");
        /*if (userId != null && !userId.equals("")) {
            String queryStr = "select tc from TeacherCourse tc where tc.user.id='" + userId + "'";
            String courseIds = "";
            String courseNames = "";
            for (TeacherCourse teacherCourse:(List<TeacherCourse>)baseManager.listObject(queryStr)) {
                courseIds += teacherCourse.getCourse().getId() + ",";
                courseNames += teacherCourse.getCourse().getName() + ",";
            }
            if (courseIds.endsWith(",")) {
                courseIds = courseIds.substring(0, courseIds.length() - 1);
                courseNames = courseNames.substring(0, courseNames.length() - 1);
            }
            modelMap.put("courseIds", courseIds);
            modelMap.put("courseNames", courseNames);
        }*/

        return modelMap;  //To change body of implemented methods use File | Settings | File Templates.
    }
}
