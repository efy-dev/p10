package com.efeiyi.ec.system.basic.model;

public class UEditor {

    private String callbackUrl;
    private String title;
    private String action;
    private String name;
    private String uploadUrl;
    private String paramName;
    private String paramValue;
    private String objectId;
    private String objectClassType;

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
