<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/29
  Time: 15:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="/layouts/public.jsp" %>
<html>
<head>
    <title></title>
</head>
<body>
<div class="am-cf am-padding">
    <div class="am-fl am-cf">
        <strong class="am-text-primary am-text-lg">用户信息</strong>
    </div>
</div>
<hr/>
<div class="am-g">
    <form action="<c:url value='/basic/xm.do'/>" method="post" class="am-form am-form-horizontal">
        <input type="hidden" name="qm" value="saveOrUpdateUser">
        <input type="hidden" name="id" value="${object.id}">
        <c:if test="${empty object || object.id == null || object.id==''}">
            <input type="hidden" name="status" value="1" />
        </c:if>
        <c:if test="${!empty object && object.id != null && object.id != '' }">
            <input type="hidden" name="status" value="${object.status}" />
        </c:if>
        <div class="am-form-group">
            <label name="name" for="name" class="am-u-sm-3 am-form-label">用户姓名 <small>*</small></label>
            <div class="am-u-sm-9">
                <input type="text" name="name" id="name" placeholder="姓名" value="${object.name}">
            </div>
        </div>
        <div class="am-form-group">
            <label name="password" for="password" class="am-u-sm-3 am-form-label">用户密码 <small>*</small></label>
            <div class="am-u-sm-9">
                <input type="password" name="password" id="password" placeholder="密码" value="${object.password}">
            </div>
        </div>
        <div class="am-form-group">
            <label name="tenant_id" for="tenant_idName" class="am-u-sm-3 am-form-label">商户名称 <small>*</small></label>
            <div class="am-u-sm-9">
                <input id="tenant_idName" placeholder="商户名称" onclick="m8uDialog.openDialog('tenant_id','tenant_idName','tenant', null,'<%=path%>')" value="${object.tenant.name}">
                <input type="hidden" id="tenant_id"  name="tenant.id" value="${object.tenant.id}">
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
