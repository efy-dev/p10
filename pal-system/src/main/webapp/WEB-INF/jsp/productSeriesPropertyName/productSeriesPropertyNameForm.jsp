<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/7/30
  Time: 17:17
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
            <strong class="am-text-primary am-text-lg">新建商品系列属性名</strong> / <small>New ProductSeries</small>
        </div>
    </c:if>
    <c:if test="${!empty object && object.id != null && object.id != '' }">
        <div class="am-fl am-cf">
            <strong class="am-text-primary am-text-lg">编辑商品系列属性名</strong> / <small>Edit ProductSeries</small>
        </div>
    </c:if>
</div>
<%--<div class="am-g">--%>
    <%--<form action="/basic/xm.do" method="post" class="am-form am-form-horizontal">--%>
        <%--<input type="hidden" name="qm" value="saveOrUpdateProductSeries">--%>
        <%--<input type="hidden" name="id" value="${object.id}">--%>
        <%--<c:if test="${empty object || object.id == null || object.id==''}">--%>
            <%--<input type="hidden" name="status" value="1" />--%>
        <%--</c:if>--%>
        <%--<c:if test="${!empty object && object.id != null && object.id != '' }">--%>
            <%--<input type="hidden" name="status" value="${object.status}" />--%>
        <%--</c:if>--%>

        <%--<div class="am-form-group">--%>
            <%--<label name="name" for="name" class="am-u-sm-3 am-form-label">商品系列 <small>*</small></label>--%>
            <%--<div class="am-u-sm-9">--%>
                <%--<input type="text" name="name" id="name" placeholder="商品系列名称" value="${object.name}">--%>
            <%--</div>--%>
        <%--</div>--%>
        <%--<div class="am-form-group">--%>
            <%--<label name="serial" for="serial" class="am-u-sm-3 am-form-label">序列号 <small>*</small></label>--%>
            <%--<div class="am-u-sm-9">--%>
                <%--<input type="text" name="serial" id="serial" placeholder="序列号" value="${object.serial}">--%>
            <%--</div>--%>
        <%--</div>--%>
        <%--<div class="am-form-group">--%>
            <%--<label name="tenant_id" for="tenant_idName" class="am-u-sm-3 am-form-label">商户名称 <small>*</small></label>--%>
            <%--<div class="am-u-sm-9">--%>
                <%--&lt;%&ndash;<input type="text" name="tenant.id" id="tenant.id" placeholder="商户名称" value="${object.tenant.id}">&ndash;%&gt;--%>
                <%--<input id="tenant_idName" placeholder="商户名称" onclick="m8uDialog.openDialog('tenant_id','tenant_idName','tenant')">--%>
                <%--<input type="hidden" id="tenant_id"  name="tenant.id">--%>
            <%--</div>--%>
        <%--</div>--%>
        <%--<div style="text-align: left;margin-left: 10px;" >--%>
            <%--<input onclick="window.location.href='<c:url value="/basic/xm.do?qm=formProductSeries"/>'"--%>
                   <%--type="button" class="am-btn am-btn-default am-btn-xs"--%>
                   <%--style="margin-top: 4px;margin-bottom: 6px;width: 100px;margin-left:2px;height: 35px;"--%>
                   <%--value="新商品系列" />--%>
        <%--</div>--%>
        <%--<div class="am-form-group">--%>
            <%--<div class="am-u-sm-9 am-u-sm-push-3">--%>
                <%--<input type="submit" class="am-btn am-btn-primary" value="保存"/>--%>
            <%--</div>--%>
        <%--</div>--%>
    <%--</form>--%>
<%--</div>--%>
</body>
</html>
