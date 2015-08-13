<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/29
  Time: 15:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<html>
<head>
    <title></title>
</head>
<body>
<div class="am-cf am-padding">
    <c:if test="${empty object || object.id == null || object.id==''}">
        <div class="am-fl am-cf">
            <strong class="am-text-primary am-text-lg">新建商户</strong> / <small>New Tenant</small>
        </div>
    </c:if>
    <c:if test="${!empty object && object.id != null && object.id != '' }">
        <div class="am-fl am-cf">
            <strong class="am-text-primary am-text-lg">编辑商户信息</strong> / <small>Edit Tenant</small>
        </div>
    </c:if>
</div>
<hr/>

<div class="am-g">
    <form action="<c:url value='/basic/xm.do'/>" method="post" class="am-form am-form-horizontal">
        <input type="hidden" name="qm" value="saveOrUpdateTenant">
        <input type="hidden" name="id" value="${object.id}">
        <c:if test="${empty object || object.id == null || object.id==''}">
            <input type="hidden" name="status" value="1" />
        </c:if>
        <c:if test="${!empty object && object.id != null && object.id != '' }">
            <input type="hidden" name="status" value="${object.status}" />
        </c:if>

        <div class="am-form-group">
            <label name="name" for="name" class="am-u-sm-3 am-form-label">商户名称 <small style="color: red">*</small></label>
            <div class="am-u-sm-9">
                <input type="text" name="name" id="name" placeholder="商户名称" value="${object.name}" required>
            </div>
        </div>
        <%--<div class="am-form-group">--%>
            <%--<label name="province.id" for="province.id" class="am-u-sm-3 am-form-label">省份 <small>*</small></label>--%>
            <%--<div class="am-u-sm-9">--%>
                <%--<input type="text" name="province.id" id="province.id" placeholder="所在省" value="${object.province}">--%>
            <%--</div>--%>
        <%--</div>--%>
        <%--<div class="am-form-group">--%>
        <%--<label name="address.id" for="address.id" class="am-u-sm-3 am-form-label">街道 <small>*</small></label>--%>
        <%--<div class="am-u-sm-9">--%>
        <%--<input type="text" name="address.id" id="address.id" placeholder="详细地址" value="${object.address.id}">--%>
        <%--</div>--%>
        <%--</div>--%>
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
