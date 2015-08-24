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
            <strong class="am-text-primary am-text-lg">新建认证信息</strong> / <small>New TenantCertification</small>
        </div>
    </c:if>
    <c:if test="${!empty object && object.id != null && object.id != '' }">
        <div class="am-fl am-cf">
            <strong class="am-text-primary am-text-lg">编辑认证信息</strong> / <small>Edit TenantCertification</small>
        </div>
    </c:if>
</div>
<hr/>

<div class="am-g">
    <form action="<c:url value='/tenantCertification/saveTenantCertification.do'/>" method="post" enctype="multipart/form-data" class="am-form am-form-horizontal">
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
            <label name="name" for="name" class="am-u-sm-3 am-form-label">认证证书 <small>*</small></label>
            <div class="am-u-sm-9">
                <input type="text" name="name" id="name" placeholder="认证证书" value="${object.name}">
            </div>
        </div>
        <div class="am-form-group">
            <label name="org" for="org" class="am-u-sm-3 am-form-label">认证机构 <small>*</small></label>
            <div class="am-u-sm-9">
                <input type="text" name="org" id="org" placeholder="认证机构" value="${object.org}">
            </div>
        </div>
        <div class="am-form-group">
            <label name="theDate" for="theDate" class="am-u-sm-3 am-form-label">认证时间 <small>*</small></label>
            <div class="am-input-group am-datepicker-date am-u-sm-9" data-am-datepicker="{format: 'yyyy-mm', viewMode: 'years', minViewMode: 'months'}">
                <input type="text" name="theDate" id="theDate" class="am-form-field" placeholder="认证时间" value="<fmt:formatDate value='${object.theDate}'  pattern='yyyy-MM'/>" readonly required/>
                <span class="am-input-group-btn am-datepicker-add-on">
                    <button class="am-btn am-btn-default" type="button"><span class="am-icon-calendar"></span> </button>
                </span>
            </div>
        </div>
        <div class="am-form-group">
            <label name="level" for="level" class="am-u-sm-3 am-form-label">认证结果 <small>*</small></label>
            <div class="am-u-sm-9">
                <ming800:status name="level" dataType="PCTenantCertification.level" checkedValue="${object.level}" type="select" />
            </div>
        </div>

        <%--<div class="am-form-group">--%>
            <%--<label for="img" class="am-u-sm-3 am-form-label">证书图片 <small>*</small></label>--%>
            <%--<div class="am-u-sm-9">--%>
                <%--<input type="file" id="img" name="img" placeholder="证书图片"--%>
                       <%--value="${object.imgUrl}">--%>
            <%--</div>--%>
            <%--<c:if test="${!empty object.imgUrl}">--%>
                <%--<img src="http://pal.efeiyi.com/${object.imgUrl}@!pal-img-form">--%>
            <%--</c:if>--%>
        <%--</div>--%>

        <div class="am-form-group">
            <div class="am-u-sm-9 am-u-sm-push-3">
                <input type="submit" class="am-btn am-btn-primary" value="保存"/>
            </div>
        </div>
    </form>
</div>
</body>
</html>
