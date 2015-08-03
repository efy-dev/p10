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
<div class="am-g am-g-fixed">
  <hr>
  <div class="am-g" style="margin-top: 100px">
    <div class="am-u-md-4" style="margin-top: 55px;">
      <form class="am-form" method="post" id="loginForm" action="<c:url value="/j_spring_security_check" />">
        <%--<input type="hidden" name="dispatcher" value=""/>--%>
        <%--<input type="hidden" name="requestType" value="pc"/>--%>
        <div class="am-form-group">
          <label for="username">用户</label>
          <input type="text" id="username" name="username" value="${enrollUsername}"/>
        </div>
        <div class="am-form-group">
          <label for="password">密码</label>
          <input type="password" class="form-control" id="password" name="password"
                 value="${j_password}"/>
        </div>
        <div class="message">${message}</div>
        <input id="login" type="submit" class="am-btn am-btn-default form-btn" value="登录"/>
        <%--<div style="text-align: right"><a class="ypl-a" href="/pc/forget.do">密码忘了？</a></div>--%>
      </form>
    </div>
  </div>
</div>
</body>
</html>
