package com.efeiyi.ec.website.organization.service.impl;

import com.efeiyi.ec.website.organization.OrganizationConst;
import com.efeiyi.ec.website.organization.model.BigUser;
import com.efeiyi.ec.website.organization.model.Permission;
import com.efeiyi.ec.website.organization.model.Role;
import com.efeiyi.ec.website.organization.service.InitializeManager;
import com.ming800.core.base.dao.XdoDao;
import com.ming800.core.util.ApplicationContextUtil;
import com.ming800.core.util.StringUtil;

import java.util.Date;

/**
 * Created with IntelliJ IDEA.
 * User: ming
 * Date: 13-3-18
 * Time: 下午6:05
 * To change this template use File | Settings | File Templates.
 */
public class InitializeManagerImpl implements InitializeManager {
    private XdoDao basicDao = (XdoDao) ApplicationContextUtil.getApplicationContext().getBean("xdoDaoSupport");

    @Override
    public void init(BigUser bigUser) throws Exception {

       /* Tenant branch = bigUser.getBranch();

        String serial = branch.generateSerial();
        M8idGenerator.setSerial(serial);

        if (branch == null || branch.getName() == null || branch.getName().equals("")) {
            branch.setName("t_" + serial);
        }
        branch.setSerial(serial);
        branch.setSchoolName("t_" + serial);
        branch.setVersion("edu");
        branch.setTheStatus(OrganizationConst.BRANCH_THE_STATUS_NORMAL);

        *//*许可加密*//*
        String tempLicense = "userLimit:3;teachAreaLimit:1";
        MD5Encode md5Encode = new MD5Encode();
        String mdeStr = md5Encode.MD5Encode(tempLicense + ";ming800");
        tempLicense += ";validate:" + mdeStr;
        branch.setLicense(tempLicense);

        branch.setCreateDate(new Date());
        basicDao.saveOrUpdateObject(Tenant.class.getName(), branch);
*/
        /*总部*/
//            TeachArea teachArea = new TeachArea();
//            teachArea.setTheStatus(OrganizationConst.TEACH_AREA_THE_STATUS_NORMAL);
//            teachArea.setTheType(OrganizationConst.TEACH_AREA_THE_TYPE_HEADQUARTERS);
//            teachArea.setName("总部");
//            teachArea.setBranch(branch);
//            basicDao.saveOrUpdateObject(TeachArea.class.getName(), teachArea);

        /*管理员角色*/
            /*Role roleManager = new Role();
            roleManager.setBranch(branch);
            roleManager.setName("普通用户");
            roleManager.setBasicType("1");
            roleManager.setSuperPermission(2);
            roleManager.setTheStatus(1);
            basicDao.saveOrUpdateObject(Role.class.getName(), roleManager);


            Permission permission_dish = generatePermission("Dish", "菜谱", "new, va, em, dm", roleManager);
            Permission permission_assessment_plan = generatePermission("AssessmentCustomerCateringPlan", "评估", "new, va, em, dm", roleManager);
            Permission permission_meal_plan = generatePermission("MealCustomerCateringPlan", "配餐", "new, va, em, dm", roleManager);
            Permission permission_plan = generatePermission("CustomerCateringPlan", "套餐", "new, va, em, dm", roleManager);
            Permission permission_person_customer = generatePermission("CustomerPersonInfo", "个人客户档案", "new, va, em, dm", roleManager);
            Permission permission_people_customer = generatePermission("CustomerPeopleInfo", "群体客户档案", "new, va, em, dm", roleManager);

            basicDao.saveOrUpdateObject(Permission.class.getName(), permission_dish);
            basicDao.saveOrUpdateObject(Permission.class.getName(), permission_assessment_plan);
            basicDao.saveOrUpdateObject(Permission.class.getName(), permission_meal_plan);
            basicDao.saveOrUpdateObject(Permission.class.getName(), permission_plan);
            basicDao.saveOrUpdateObject(Permission.class.getName(), permission_person_customer);
            basicDao.saveOrUpdateObject(Permission.class.getName(), permission_people_customer);*/

//        Role roleManager = new Role();
//        roleManager.setId("dr96hxprdg5m3z6j");

        /*管理员*/
        bigUser.setPassword(StringUtil.encodePassword(bigUser.getPassword(), "SHA"));
        /*bigUser.setRoleType(OrganizationConst.ROLE_THE_TYPE_AGENT);*/
        bigUser.setTheStatus(OrganizationConst.USER_THE_STATUS_USERANDSTAFF);
        bigUser.setEnabled(false);           //注册的时候 默认false  激活后才可以登录
        bigUser.setAccountExpired(false);
        bigUser.setAccountLocked(false);
        bigUser.setCredentialsExpired(false);

        /*bigUser.setRoleType("user");             //system,    admin,    user*/
//        bigUser.setRole(roleManager);                              //管理员权限
//        bigUser.setTeachArea(teachArea);
//        bigUser.setDepartment(teachArea);
        bigUser.setCreateDatetime(new Date());
        basicDao.saveOrUpdateObject(BigUser.class.getName(), bigUser);

    }

    @Override
    public void initNewUser(BigUser bigUser) throws Exception {

        /*管理员*/
        bigUser.setPassword(StringUtil.encodePassword(bigUser.getPassword(), "SHA"));
        /*bigUser.setRoleType(OrganizationConst.ROLE_THE_TYPE_AGENT);*/
        if (bigUser.getTheStatus() == null) {
            bigUser.setTheStatus(OrganizationConst.USER_THE_STATUS_USERANDSTAFF);
        }
        bigUser.setEnabled(true);           //注册的时候 默认false  激活后才可以登录
        bigUser.setAccountExpired(false);
        bigUser.setAccountLocked(false);
        bigUser.setCredentialsExpired(false);

       /* if ("photographer".equals(bigUser.getRole().getBasicType())) {
            ((Photographer) bigUser).setAverage(0);
            ((Photographer) bigUser).setBargainAmount(0);
//            ((Photographer) bigUser).setChoicenessAmount(0);
            ((Photographer) bigUser).setHpAmount(0);
            ((Photographer) bigUser).setOrderAmount(0);
            ((Photographer) bigUser).setPoor(0);
            ((Photographer) bigUser).setPraise(0);
            ((Photographer) bigUser).setScore(0);
            ((Photographer) bigUser).setVisitAmount(0);
        } else if ("consumer".equals(bigUser.getRole().getBasicType())) {
            ((Consumer) bigUser).setCredit(0);
            ((Consumer) bigUser).setYuepaibi(0);
        }*/

        /*bigUser.setRoleType("user");             //system,    admin,    user*/
        bigUser.setCreateDatetime(new Date());

        basicDao.saveOrUpdateObject(BigUser.class.getName(), bigUser);

    }

    private Permission generatePermission(String entityName, String entityLabel, String basic, Role role) {

        Permission permission = new Permission();

        permission.setEntityName(entityName);
        permission.setEntityLabel(entityLabel);
        if (basic != null) {
            permission.setAll(false);
            permission.setBasic(basic);
        } else {
            permission.setAll(true);
        }

        permission.setRole(role);

        return permission;
    }
}
