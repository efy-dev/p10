<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/29
  Time: 15:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title></title>
</head>
<body>
<div class="am-cf am-padding">
    <div class="am-fl am-cf">
        <strong class="am-text-primary am-text-lg">商户信息</strong>
    </div>
</div>
<hr/>
<div class="am-g">
    <form action="<c:url value='/tenant/saveTenant.do'/>" method="post" class="am-form am-form-horizontal">
        <input type="hidden" name="id" value="${object.id}">
        <input type="hidden" name="status" value="${object.status}" />
        <div class="am-form-group">
            <label name="name" for="name" class="am-u-sm-3 am-form-label">商户名称 <small>*</small></label>
            <div class="am-u-sm-9">
                <input type="text" name="name" id="name" placeholder="商户名称" value="${object.name}" required>
            </div>
        </div>
        <div class="am-form-group">
            <label name="province" for="province" class="am-u-sm-3 am-form-label">省份 <small>*</small></label>
            <div class="am-u-sm-9">
                <input type="text" name="province" id="province" placeholder="所在省" value="${object.province}">
            </div>
        </div>
        <div class="am-form-group">
            <label name="city" for="city" class="am-u-sm-3 am-form-label">市 <small>*</small></label>
            <div class="am-u-sm-9">
                <input type="text" name="city" id="city" placeholder="所在市" value="${object.city}">
            </div>
        </div>
        <div class="am-form-group">
            <label name="address" for="address" class="am-u-sm-3 am-form-label">区/县 <small>*</small></label>
            <div class="am-u-sm-9">
                <input type="text" name="address" id="address" placeholder="所在区/县" value="${object.address}">
            </div>
        </div>
        <div class="am-form-group">
            <div class="am-u-sm-9 am-u-sm-push-3">
                <input type="submit" class="am-btn am-btn-primary" value="保存"/>
            </div>
        </div>
    </form>
</div>
</body>
</html>
