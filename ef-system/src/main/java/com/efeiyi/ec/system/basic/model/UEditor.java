package com.efeiyi.ec.system.basic.model;

public class UEditor {

    private String callbackUrl;    //返回按钮的跳转路径
    private String title;          //页面的标题 例如 编辑专题内容
    private String action;         //表填提交的action（url地址）
    private String name;           //富文本编辑器所对应的服务端请求参数名称类似于<input name="name">的name属性
    private String uploadUrl;      //制定文件上传地址
    private String paramName;      //额外参数名
    private String paramValue;     //额外参数值
    private String objectId;       //保存服务本编辑器到哪个对象
    private String objectClassType;//目标对象的类型

    public UEditor() {
    }

    public UEditor(String callbackUrl, String title, String action, String name, String uploadUrl, String paramName, String paramValue, String objectId, String objectClassType) {
        this.callbackUrl = callbackUrl;
        this.title = title;
        this.action = action;
        this.name = name;
        this.uploadUrl = uploadUrl;
        this.paramName = paramName;
        this.paramValue = paramValue;
        this.objectId = objectId;
        this.objectClassType = objectClassType;
    }

    public String getObjectClassType() {
        return objectClassType;
    }

    public void setObjectClassType(String objectClassType) {
        this.objectClassType = objectClassType;
    }

    public String getObjectId() {
        return objectId;
    }

    public void setObjectId(String objectId) {
        this.objectId = objectId;
    }

    public String getCallbackUrl() {
        return callbackUrl;
    }

    public void setCallbackUrl(String callbackUrl) {
        this.callbackUrl = callbackUrl;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getAction() {
        return action;
    }

    public void setAction(String action) {
        this.action = action;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getUploadUrl() {
        return uploadUrl;
    }

    public void setUploadUrl(String uploadUrl) {
        this.uploadUrl = uploadUrl;
    }

    public String getParamName() {
        return paramName;
    }

    public void setParamName(String paramName) {
        this.paramName = paramName;
    }

    public String getParamValue() {
        return paramValue;
    }

    public void setParamValue(String paramValue) {
        this.paramValue = paramValue;
    }
}
