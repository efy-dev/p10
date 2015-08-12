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
            <strong class="am-text-primary am-text-lg">新建溯源信息</strong> / <small>New TenantSource</small>
        </div>
    </c:if>
    <c:if test="${!empty object && object.id != null && object.id != '' }">
        <div class="am-fl am-cf">
            <strong class="am-text-primary am-text-lg">编辑溯源信息</strong> / <small>Edit TenantSource</small>
        </div>
    </c:if>
</div>
<hr/>

<div class="am-g">
    <form action="<c:url value='/tenantSource/saveTenantSource.do'/>" method="post" class="am-form am-form-horizontal">
        <input type="hidden" name="qm" value="saveOrUpdateTenantSource">
        <input type="hidden" name="id" value="${object.id}">
        <c:if test="${empty object || object.id == null || object.id==''}">
            <input type="hidden" name="status" value="1" />
        </c:if>
        <c:if test="${!empty object && object.id != null && object.id != '' }">
            <input type="hidden" name="status" value="${object.status}" />
        </c:if>

        <div class="am-form-group">
            <label name="tenant.idName" for="tenant.idName" class="am-u-sm-3 am-form-label">商户名称 <small>*</small></label>
            <div class="am-u-sm-9">
                <c:if test="${empty object || object.id == null || object.id==''}">
                    <input type="text" name="tenant.idName" id="tenant.idName" placeholder="商户名称" value="${tenant.name}" readonly>
                    <input type="hidden" name="tenant.id" value="${tenant.id}" readonly>
                </c:if>
                <c:if test="${!empty object && object.id != null && object.id != '' }">
                    <input type="text" name="tenant.idName" id="tenant.idName" placeholder="商户名称" value="${object.tenant.name}" readonly>
                    <input type="hidden" name="tenant.id" value="${object.tenant.id}" readonly>
                </c:if>
            </div>
        </div>
        <div class="am-form-group">
            <label name="name" for="name" class="am-u-sm-3 am-form-label">制作工艺 <small>*</small></label>
            <div class="am-u-sm-9">
                <input type="text" name="name" id="name" placeholder="制作工艺" value="${object.name}">
            </div>
        </div>
        <div class="am-form-group">
            <label name="region" for="region" class="am-u-sm-3 am-form-label">创作地区 <small>*</small></label>
            <div class="am-u-sm-9">
                <input type="text" name="region" id="region" placeholder="创作地区" value="${object.region}">
            </div>
        </div>

        <div class="am-form-group">
            <label for="doc-ipt-file-1" class="am-u-sm-3 am-form-label">溯源图片 <small>*</small></label>
            <div class="am-u-sm-9">
                <input type="file" id="doc-ipt-file-1">
                <p class="am-form-help">请选择要上传的文件...</p>
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
