package com.ming800.core.p;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 12-11-24
 * Time: 下午4:08
 * To change this template use File | Settings | File Templates.
 */
public class PConst {

    public static Integer JMENU_TYPE_HEAD = 1;   //头菜单
    public static Integer JMENU_TYPE_LEFT = 2;  //左侧菜单

    public static Integer USER_DEFINED_PORTLET_NORMAL = 1;
    public static Integer USER_DEFINED_PORTLET_DEL = 0;

    public static String AUTO_SERIAL_SERIAL_INIT_NUM = "1";   //自增序列号的初始值

    public static String AUTO_SERIAL_MODEL_TEACH_BOOK_REPERTORY = "tbRepertory";   //教材库存
    public static String AUTO_SERIAL_MODEL_TEACH_BOOK_ORDER = "teachBookOrder";   //教材订单
    public static String AUTO_SERIAL_MODEL_BILL = "bill";   //账单编号
    public static String AUTO_SERIAL_MODEL_CLAZZ_INSTANCE = "clazzInstance";   //收费单编号
    public static String AUTO_SERIAL_MODEL_ACCOUNTING = "accounting";   //收费单编号
    public static String AUTO_SERIAL_MODEL_TEACHAREA = "teachArea";   //校区编号
    public static String AUTO_SERIAL_MODEL_EXPENSE = "expense";   //费用编号
    public static String AUTO_SERIAL_MODEL_STUDENT = "student";   //学员编号
    public static String AUTO_SERIAL_MODEL_COURSE = "course";   //收费单编号
    public static String AUTO_SERIAL_MODEL_ORDER = "order";   //订单编号
    public static String AUTO_SERIAL_MODEL_LEAD = "lead";   //线索编号
    public static String AUTO_SERIAL_MODEL_CUSTOMER = "customer";   //线索编号


    public static String ATTACHMENT_STORETYPE_DATABASE = "database";   //数据库
    public static String ATTACHMENT_STORETYPE_DISK = "disk";        //硬盘
    public static String ATTACHMENT_STORETYPE_ALI_CLOUD = "ali";       //云存储
    public static String ATTACHMENT_STORETYPE_URL = "url";     //外链接

    public static final String PRINT_TEMPLATE_CHARGE_ORDER_PATH = "/excel/printTemplateChargeOrder.xml";       //收费单初始化模板
    public static final String PRINT_TEMPLATE_CHARGE_ORDER_TD_PATH = "/excel/printTemplateChargeOrderTD.xml";  //收费单（套打）初始化模板
    public static final String PRINT_TEMPLATE_STUDENT_PAPER_PATH = "/excel/printTemplateStudentPaper.xml";
    public static final String PRINT_TEMPLATE_STUDENT_PAPER_ORDER_PATH = "/excel/printTemplateStudentPaperCharge.xml";//听课证初始化模板
    public static final String PRINT_TEMPLATE_STUDENT_PAPER_TD_PATH = "/excel/printTemplateStudentPaperTD.xml";   //听课证(套打)初始化模板
    public static final String PRINT_TEMPLATE_SALES_ORDER_PATH = "/excel/printTemplateSalesOrder.xml";           //销售单初始化模板
    public static final String PRINT_TEMPLATE_DEPOSIT_PAPER_PATH = "/excel/printTemplateDepositPaper.xml";        //充值单初始化模板
    public static final String PRINT_TEMPLATE_STUDENT_INFO_PATH = "/excel/printTemplateStudentInfo.xml";        //充值单初始化模板
    public static final String PRINT_TEMPLATE_CLAZZINSTANCE_STUDENTS_PATH = "/excel/printTemplateClazzInstanceStudents.xml";        //充值单初始化模板

    public static String PRINT_TEMPLATE_CHARGE_ORDER = "chargeOrder";//收费单
    public static String PRINT_TEMPLATE_LISTEN_COURSE_CARD = "listenCourseCard";//听课证
    public static String PRINT_TEMPLATE_LISTEN_COURSE_CHARGE_CARD = "listenCourseChargeCard";//带收费信息的听课证
    public static String PRINT_TEMPLATE_CHARGE_ORDER_CZ = "chargeOrderCZ";//充值单
    public static String PRINT_TEMPLATE_STUDENT_ROLL = "studentRoll";//花名冊

    public static String PRINT_TEMPLATE_COMMON_PAPER = "commonPaper";//普通合同
    public static String PRINT_TEMPLATE_TEACHER_PAPER = "teacherPaper";//教师合同
    public static String PRINT_TEMPLATE_STUDENT_PAPER = "studentPaper";//学生合同
    public static String PRINT_TEMPLATE_SPECIAL_PAPER = "specialPaper";//特殊合同


    public static final Integer SYSTEM_LOG_THE_TYPE_LOGIN = 1;//登录类型
    public static final Integer SYSTEM_LOG_THE_TYPE_IMPORT = 2;//导出类型
    public static final Integer SYSTEM_LOG_THE_TYPE_EXPORT = 3;//导入类型
    public static final Integer SYSTEM_LOG_THE_TYPE_SPEED = 11;//导入类型


    public static final String MESSAGE_ACOUNT_SID = "aaf98f89499d24b50149cb5e65c31922"; //短信平台主账号
    public static final String MESSAGE_AUTH_TOKEN = "b5c844359b73416d883e1eb2c7c63dae"; //短信平台主帐号的令牌
    public static final String MESSAGE_APP_ID = "aaf98f89499d24b50149cb5f64411924"; //短信平台中绑定的应用的id
    public static final String MESSAGE_SERVER_HOST = "sandboxapp.cloopen.com"; //短信平台服务器地址
    public static final String MESSAGE_SERVER_PORT = "8883"; //短信平台服务器端口号
    public static final String MESSAGE_TAMPLATE_ID = "1"; //使用的短信模板的id
    public static final String MESSAGE_RESULT_STATUS = "000000"; //发送短信的返回数据，如果返回数据等于该数据的话说明发送成功
    public static final String MESSAGE_SALE_APP_ID = "";


    public static final String DEFAULT_CITY_ID = "1236547891159753";


    public static final Integer YUNPIAN = 1;
    public static final Integer TIANYI = 2;


    public static final Integer DIYORDER = 1;
    public static final Integer CUSTOMIZATION = 3;
    public static final Integer PACKAGEORDER = 2;

    public static final String HOSTNAME = "http://www.efeiyi.com";

    public static final String WEBURL = "http://www2.efeiyi.com";//web电商测试地址(如需改成正式环境此处改为www.efeiyi.comn)
    public static final String TUANURL = "a.efeiyi.com";//团购正式地址
    public static final String PERSONALURL = "http://i.efeiyi.com";//个人中心正式地址

}
