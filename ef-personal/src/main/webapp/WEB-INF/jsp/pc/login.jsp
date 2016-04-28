<%@ page import="com.ming800.core.p.PConst" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/7/14
  Time: 10:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="utf-8" language="java" %>
<%request.setCharacterEncoding("UTF-8"); %>
<html>
<head>
    <link type="text/css" rel="stylesheet" href="<c:url value="/scripts/css/amazeui.min.css?v=20150831"/>" />
    <link type="text/css" rel="stylesheet" href="<c:url value="/scripts/css/login.css"/>"/>
</head>
<body>
<div class="login hd">
    <div class="login-form">
        <form action="<c:url value="/j_spring_security_check"/>" method="post">
            <div class="mt wh">
                <h3>大师登录</h3><span class="link"><em>没有账号?</em><a class="reg" href="<c:url value="/sign/toRegister.do"/>">立即入驻</a></span>
            </div>
            <div class="am-form-group">
                <i class="icon name"></i>
                <input id="username" name="username" class="text1 textam" tabindex="1" placeholder="请输入用户名" type="text" value="${username}">
            </div>
            <div class="am-form-group">
                <i class="icon pwd"></i>
                <input id="password" name="password" class="text1 textam" tabindex="2" placeholder="密码" type="password" value="">
            </div>
            <input class="btn-submit " type="submit" tabindex="5" value="登 录 工 作 台">
        </form>
    </div>
</div>
<script type="text/javascript">
    $(function(){
        $('.btn-top-wechat').hover(function(){
            $(this).find('.top-wechat').stop(true).slideDown('fast');
        },function(){
            $(this).find('.top-wechat').stop(true).slideUp('fast');
        });
    })
</script>
</body>
</html>
