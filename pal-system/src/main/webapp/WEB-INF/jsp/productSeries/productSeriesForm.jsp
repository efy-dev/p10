<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/8/19
  Time: 14:56
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
        <strong class="am-text-primary am-text-lg">非遗项目信息</strong>
    </div>
</div>
<hr/>
<div class="am-g">
    <form id="productSeriesForm" method="post" class="am-form am-form-horizontal">
    <%--<form action="<c:url value='/productSeries/saveProductSeries.do'/>" method="post" class="am-form am-form-horizontal">--%>
        <input type="hidden" name="qm" value="saveOrUpdateProductSeries">
        <input type="hidden" name="id" value="${object.id}">
        <input type="hidden" name="status" value="${object.status}" />
        <div class="am-form-group">
            <label name="name" for="name" class="am-u-sm-3 am-form-label">非遗项目名称 <small>*</small></label>
            <div class="am-u-sm-9">
                <input type="text" name="name" id="name" placeholder="非遗项目名称" value="${object.name}" title="非遗项目名称" required="true">
            </div>
        </div>
        <div class="am-form-group">
            <div class="am-u-sm-9 am-u-sm-push-3">
                <input type="button" onclick="testAjaxSubmitForm('productSeriesForm', '<c:url value="/productSeries/saveProductSeriesAjax.do"/>');" class="am-btn am-btn-primary" value="保存"/>
            </div>
        </div>
        <%--<div class="am-form-group">--%>
            <%--<div class="am-u-sm-9 am-u-sm-push-3">--%>
                <%--<input type="submit" class="am-btn am-btn-primary" value="保存"/>--%>
            <%--</div>--%>
        <%--</div>--%>
    </form>
</div>
</body>
</html>
