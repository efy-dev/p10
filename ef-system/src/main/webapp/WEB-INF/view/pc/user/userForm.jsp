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
<html>
<head>
    <title></title>
</head>
<body>
<div class="am-cf am-padding">
    <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">新建/编辑用户</strong> / <small>New/Edit Product</small></div>
</div>
<hr/>

<div class="am-g">
    <form action="/basic/xm.do" method="post"  class="am-form am-form-horizontal">
        <input type="hidden" name="qm" value="saveOrUpdateUser">
        <input type="hidden" name="id" value="${object.id}">
        <div class="am-form-group">
            <label name="username" for="user-name" class="am-u-sm-3 am-form-label">用户名</label>
            <div class="am-u-sm-9">
                <input type="text" name="username" id="user-name" placeholder="用户名" value="${object.username}">
                <small>必填项*</small>
            </div>
        </div>
        <div class="am-form-group">
            <label name="name" for="name" class="am-u-sm-3 am-form-label">真实姓名</label>
            <div class="am-u-sm-9">
                <input type="text" name="name" id="name" placeholder="真实姓名" value="${object.name}">
                <small>必填项*</small>
            </div>
        </div>
        <div class="am-form-group">
            <div class="am-u-sm-9 am-u-sm-push-3">
                <input type="submit" class="am-btn am-btn-primary" value="保存"/>
            </div>
        </div>
    </form>
</div>
<!-- content end -->
<hr/>


</body>
</html>
