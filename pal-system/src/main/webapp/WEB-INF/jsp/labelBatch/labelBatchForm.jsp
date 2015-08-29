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
        <strong class="am-text-primary am-text-lg">标签批次信息</strong>
    </div>
</div>
<hr/>

<div class="am-g">
    <form action="<c:url value='/basic/xm.do'/>" method="post" class="am-form am-form-horizontal">
        <input type="hidden" name="qm" value="saveOrUpdateLabelBatch">
        <input type="hidden" name="id" value="${object.id}">
        <input type="hidden" name="status" value="${object.status}" />

        <div class="am-form-group">
            <label name="setting" for="setting" class="am-u-sm-3 am-form-label">标签批次 <small>*</small></label>
            <div class="am-u-sm-9">
                <input type="text" name="setting" id="setting" placeholder="标签批次" value="${object.setting}" required>
            </div>
        </div>
        <div class="am-form-group">
            <label name="amount" for="amount" class="am-u-sm-3 am-form-label">数量 <small>*</small></label>
            <div class="am-u-sm-9">
                <input type="number" name="amount" id="amount" placeholder="数量" value="${object.amount}" required>
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
