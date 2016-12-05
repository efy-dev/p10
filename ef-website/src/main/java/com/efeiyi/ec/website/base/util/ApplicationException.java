package com.efeiyi.ec.website.base.util;

import net.sf.json.JSONObject;

public class ApplicationException extends Exception {

    /**
     *
     */
    private static final long serialVersionUID = 1L;

    public static int INNER_ERROR = 0x01;
    public static int SQL_ERROR = 0x02;
    public static int IO_ERROR = 0x03;
    public static int NO_AUTHORITY_ERROR = 0x04;
    public static int FREEMARKER_TEMPLATE_ERROR = 0x05;
    public static int EMAIL_OCCUPIED = 0x06;
    public static int LOGIN_ERROR = 0x07;
    public static int VALIDATE_CODE_ERROR = 0x08;
    public static int OLD_PASSWORD_ERROR = 0x09;// 您输入的原密码不正确,修改密码时用到
    public static int NO_EMAIL = 0x0A;// 该邮箱没有注册
    public static int IS_EXIST_COMPANY = 0x0B;// 公司已经存在
    public static int PARAM_ERROR = 0x0C;// 参数错误
    public static int FORMART_ERROR = 0x0D;//该职位已经投递
    public static int REDIS_ERROR = 0x0E;//该职位已经投递

    private static final String[] ERROR_DESC_LIST = new String[]{"", "内部错误.",
            "数据库错误", "读取文件错误.", "用户没有登录或没有操作权限", "freemarker模板错误", "此邮箱已被注册",
            "邮箱或密码错误", "验证码错误", "您输入的原密码不正确", "该邮箱没有注册", "公司已经存在", "参数错误", "数据格式错误", "Redis 访问错误"};

    private int code;
    private String description;
    private String innerDescription;

    public ApplicationException(int code) {
        this.code = code;
        this.description = ERROR_DESC_LIST[code];
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setInnerDescription(String innerDescription) {
        this.innerDescription = innerDescription;
    }

    public String toJsonString() {
        JSONObject result = new JSONObject();
        result.put("code", this.code);
        result.put("description", this.description);
        result.put("innerDescription", innerDescription);
        return result.toString();
    }

    public JSONObject toJSONObject() {
        JSONObject result = new JSONObject();
        result.put("code", this.code);
        result.put("description", this.description);
        result.put("innerDescription", innerDescription);
        return result;
    }

}
