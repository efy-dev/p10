package com.efeiyi.ec.wiki.organization;


public class OrganizationConst {

    //branch状态
    public static final Integer BRANCH_THE_STATUS_NORMAL = 1;  //正常
    public static final Integer BRANCH_THE_STATUS_FJG = 2;    //警告
    public static final Integer BRANCH_THE_STATUS_SJG = 3;    //警告
    public static final Integer BRANCH_THE_STATUS_STOP = 4;    //停止
    public static final Integer BRANCH_THE_STATUS_DELETE = 0;  //删除

    public static final String BRANCH_DEPOSIT_INIT = "0";


    //teachArea 类型
    public static final Integer TEACH_AREA_THE_TYPE_HEADQUARTERS = 1; //总部
    public static final Integer TEACH_AREA_THE_TYPE_TEACH_AREA = 3; //校区
    public static final Integer TEACH_AREA_THE_TYPE_DEPARTMENT = 9; //部门
    //teachArea状态
    public static final Integer TEACH_AREA_THE_STATUS_NORMAL = 1; //正常
    public static final Integer TEACH_AREA_THE_STATUS_DELETE = 0; //删除

    //用户状态
    public static final Integer USER_THE_STATUS_USERANDSTAFF = 1;  //1用户/人员
    public static final Integer USER_THE_STATUS_STAFF = 2;    //  员工
    public static final Integer USER_THE_STATUS_USER = 3;  // 用户
    public static final Integer USER_THE_STATUS_DELETE = 0;  //删除

    //用户类型
    public static final String ROLE_THE_TYPE_PHOTOGRAPHER = "1";  //摄影师
    public static final String ROLE_THE_TYPE_AGENT = "2";  //经纪人
    public static final String ROLE_THE_TYPE_DRESSER = "3";  //化妆师

    //角色
    public static final Integer ROLE_SUPER_PERMISSION_TRUE = 1; //具有超级权限
    public static final Integer ROLE_SUPER_PERMISSION_FALSE = 2; //不具有超级权限


}
