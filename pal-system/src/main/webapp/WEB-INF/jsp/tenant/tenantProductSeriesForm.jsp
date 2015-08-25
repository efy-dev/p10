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
<%@include file="/layouts/public.jsp" %>

<html>
<head>
    <title></title>
</head>
<body>
<div class="am-cf am-padding">
    <div class="am-fl am-cf">
        <strong class="am-text-primary am-text-lg">选择商品系列</strong>&nbsp;/&nbsp;&nbsp;<small style="color: red">** ${message} **</small>
    </div>
</div>
<hr/>

<div class="am-g">
    <form action="<c:url value='/tenant/saveTenantProductSeries.do'/>" method="post" class="am-form am-form-horizontal">
        <input type="hidden" name="tenant.id" value="${tenant.id}">

        <div class="am-form-group">
            <label name="productSeries_id" for="productSeries_idName" class="am-u-sm-3 am-form-label">商品系列 <small style="color: red">*</small></label>
            <div class="am-u-sm-9">
                <input id="productSeries_idName" placeholder="商品系列" onclick="m8uDialog.openDialog('productSeries_id','productSeries_idName','productSeries', null,'<%=path%>')" required>
                <input type="hidden" id="productSeries_id"  name="productSeries.id">
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
