<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<html>
<head>

    <title>登录</title>

    <style type="text/css">
        .title {
            font-size: 16px;
            font-weight: bold;
            border-bottom: 2px solid #247ba0;
        }
    </style>
</head>
<body>
<%--<div class="am-g am-g-fixed">--%>
<%--<hr>--%>
<%--<div class="am-g" style="margin-top: 100px">--%>
<%--<div class="am-u-md-4" style="margin-top: 55px;">--%>
<%--<form class="am-form" method="post" id="loginForm" action="<c:url value="/j_spring_security_check" />">--%>
<%--&lt;%&ndash;<input type="hidden" name="dispatcher" value=""/>&ndash;%&gt;--%>
<%--&lt;%&ndash;<input type="hidden" name="." value="pc"/>&ndash;%&gt;--%>
<%--<div class="am-form-group">--%>
<%--<label for="username">用户</label>--%>
<%--<input type="text" id="username" name="username" value="${enrollUsername}"/>--%>
<%--</div>--%>
<%--<div class="am-form-group">--%>
<%--<label for="password">密码</label>--%>
<%--<input type="password" class="form-control" id="password" name="password"--%>
<%--value="${j_password}"/>--%>
<%--</div>--%>
<%--<div class="message">${message}</div>--%>
<%--<input id="login" type="submit" class="am-btn am-btn-default form-btn" value="登录"/>--%>
<%--&lt;%&ndash;<div style="text-align: right"><a class="ypl-a" href="/pc/forget.do">密码忘了？</a></div>&ndash;%&gt;--%>
<%--</form>--%>
<%--</div>--%>
<%--</div>--%>
<%--</div>--%>

<div class="hd login">
    <div class="login-wrap">
        <div class="banner"><img src="<c:url value="/scripts/images/login-1.jpg"/>" alt=""/></div>
        <div class="login-form">
            <form action="<c:url value="/j_spring_security_check" />" method="post" id="loginForm" class="am-form">
                <fieldset>
                    <div class="mt wh">
                        <h1>会员登录</h1>
                        <span class="link">
                            <a href="">没有账号? </a>
                            <a class="reg" href="<c:url value="/register"/>">注册</a>
                        </span>
                    </div>
                    <div class="am-form-group">
                        <i class="icon name"></i>
                        <input type="text" id="username" minlength="3" name="username" placeholder="已验证手机" required>
                        <c:if test="${!empty error}">
                            <label class="msg-tips">
                                <span class="msg">！您输入的密码错误，请核对后再输入或<a href="">找回密码</a></span>
                                <span class="tips1">！您输入的密码错误，请核对后再输入或<a href="">找回密码</a></span>
                            </label>
                        </c:if>
                    </div>
                    <div class="am-form-group">
                        <i class="icon pwd"></i>
                        <input type="password" id="password" placeholder="密码" name="password"
                               required=""
                               data-foolish-msg="把 IQ 卡密码交出来！">
                    </div>
                    <div class="am-form-group">
                        <%--<label><input class="checkbox" type="checkbox"/>自动登录</label>--%>
                        <a class="forgetpwd" href="<c:url value="/register"/>" title="忘记密码">忘记密码？</a>
                    </div>
                    <button class="am-btn am-btn-secondary" type="submit">登 录</button>
                    <%--<div class="coagent wh">--%>
                    <%--<h5>您还可以使用以下账号登录</h5>--%>
                    <%--<ul>--%>
                    <%--<li><a class="icon wechat" href=""></a></li>--%>
                    <%--</ul>--%>
                    <%--</div>--%>
                </fieldset>
            </form>
        </div>
    </div>
</div>

</body>
</html>
